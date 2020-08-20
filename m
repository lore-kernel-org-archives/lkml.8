Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645EFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371C522D03
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597915501;
	bh=gH6ZWWhpXfkRGKnL4proMvWVQJYS9zSHuJPaoWuUJqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ns6GOwJ5zWcvI4mYQJLxIJPX3uweUn5ztJ6ZIuhMcHGbRgW3L4OcqOVzmWPL3zR6X
	 x5LiQHN3neG4pCVg37sgTIqSVZptYDCrcvsCJOjk3GHQysBdOz7UVW27KLcFvCCGbS
	 hFYtvMREgae1aoZqrrENZRPoI6dxF38R1F2nqHS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHTJY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgHTJYp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:24:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33F0022CA1;
        Thu, 20 Aug 2020 09:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915484;
        bh=gH6ZWWhpXfkRGKnL4proMvWVQJYS9zSHuJPaoWuUJqg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VNmyo/FkcuQN6KrEpoV7b7i3jK73qtu+vogLVhM+TfodxNwTPdzySEKBCgXmDAD04
         w4ONZwVg0n9vR2sYzXv2rLl399dX7DpPHS6B3ZL/siDWYkikAKHQfl+Jtx9YMjs8IS
         yf0VMAwm3PGf+KQDL+aj4X3eMdKEZ0l0VGpPGzjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.8 005/232] genirq: Unlock irq descriptor after errors
Date:   Thu, 20 Aug 2020 11:17:36 +0200
Message-Id: <20200820091612.970077562@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

commit f107cee94ba4d2c7357fde59a1d84346c73d4958 upstream.

In irq_set_irqchip_state(), the irq descriptor is not unlocked after an
error is encountered. While that should never happen in practice, a buggy
driver may trigger it. This would result in a lockup, so fix it.

Fixes: 1d0326f352bb ("genirq: Check irq_data_get_irq_chip() return value before use")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200811180012.80269-1-linux@roeck-us.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/irq/manage.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2735,8 +2735,10 @@ int irq_set_irqchip_state(unsigned int i
 
 	do {
 		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip))
-			return -ENODEV;
+		if (WARN_ON_ONCE(!chip)) {
+			err = -ENODEV;
+			goto out_unlock;
+		}
 		if (chip->irq_set_irqchip_state)
 			break;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -2749,6 +2751,7 @@ int irq_set_irqchip_state(unsigned int i
 	if (data)
 		err = chip->irq_set_irqchip_state(data, which, val);
 
+out_unlock:
 	irq_put_desc_busunlock(desc, flags);
 	return err;
 }


