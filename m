Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBEFC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04302137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758759;
	bh=27tOJ/fqaKJz1WNpw0k9xBEiOTjwYrhPMg+mkJLaie4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1mHpG0WGUHn7oAiMVl+Mq8uP1Et45VB9YHHTj48b8p2tETxdSy/9mMK/RyexMAYa2
	 t0DjHgpYTckoYjUXf6Sisegl/pii3oRTnV1b6lnv9aNbd7g8/jtON+80j7UokhymAj
	 zRQ5nIJtsr8lhg1uJTZQSC0dfajGjC7bU2DEhyHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388173AbgDAQci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388431AbgDAQcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:32:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BF7E2137B;
        Wed,  1 Apr 2020 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758751;
        bh=27tOJ/fqaKJz1WNpw0k9xBEiOTjwYrhPMg+mkJLaie4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uvJYlnLZRn1ztY6YLOiD7GwsmHo1/AfEvhVNklzouoXkFGaybnD11ytInpvyKeqr9
         0oSiZf4qkNDy6P4zv16y9O0XUT8T4LIdwnRjSSCeysasydRowV0yWREExfRrJgo9mD
         yYH4eNdpmpId2l3b5dlYKdKoOGYeYcvI+S6IT6+k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Mallet <anthony.mallet@laas.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 26/91] USB: cdc-acm: fix close_delay and closing_wait units in TIOCSSERIAL
Date:   Wed,  1 Apr 2020 18:17:22 +0200
Message-Id: <20200401161521.999221772@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anthony Mallet <anthony.mallet@laas.fr>

[ Upstream commit 633e2b2ded739a34bd0fb1d8b5b871f7e489ea29 ]

close_delay and closing_wait are specified in hundredth of a second but stored
internally in jiffies. Use the jiffies_to_msecs() and msecs_to_jiffies()
functions to convert from each other.

Signed-off-by: Anthony Mallet <anthony.mallet@laas.fr>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200312133101.7096-1-anthony.mallet@laas.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-acm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 1930a8ec4b67d..3cb7a23e1253f 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -841,10 +841,10 @@ static int get_serial_info(struct acm *acm, struct serial_struct __user *info)
 	tmp.flags = ASYNC_LOW_LATENCY;
 	tmp.xmit_fifo_size = acm->writesize;
 	tmp.baud_base = le32_to_cpu(acm->line.dwDTERate);
-	tmp.close_delay	= acm->port.close_delay / 10;
+	tmp.close_delay	= jiffies_to_msecs(acm->port.close_delay) / 10;
 	tmp.closing_wait = acm->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 				ASYNC_CLOSING_WAIT_NONE :
-				acm->port.closing_wait / 10;
+				jiffies_to_msecs(acm->port.closing_wait) / 10;
 
 	if (copy_to_user(info, &tmp, sizeof(tmp)))
 		return -EFAULT;
@@ -862,9 +862,10 @@ static int set_serial_info(struct acm *acm,
 	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
 		return -EFAULT;
 
-	close_delay = new_serial.close_delay * 10;
+	close_delay = msecs_to_jiffies(new_serial.close_delay * 10);
 	closing_wait = new_serial.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
-			ASYNC_CLOSING_WAIT_NONE : new_serial.closing_wait * 10;
+			ASYNC_CLOSING_WAIT_NONE :
+			msecs_to_jiffies(new_serial.closing_wait * 10);
 
 	mutex_lock(&acm->port.mutex);
 
-- 
2.20.1



