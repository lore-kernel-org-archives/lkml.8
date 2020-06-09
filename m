Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E469EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA60520774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725142;
	bh=kHbF7dQB4zmuZlfQj/yZ2VSfYpejGVU5Sw80Gp28Tec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ClIXDVQO0uKm7fjpUWKns/yigoze0oYUaXJ5bPLi8OnEy+rPjknypSJQ+37FVZoGX
	 B9W5ziX7hp1UNNQtEQEUdhHfglnOS8XmvjC47hidsWcakPgU7UWJmx802GJte8Mivv
	 RWOokK4Nzm+PuXRd+pTvFblaT5g1qbRChUQuO9Uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgFIRwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732806AbgFIRvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:51:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B593F20734;
        Tue,  9 Jun 2020 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725082;
        bh=kHbF7dQB4zmuZlfQj/yZ2VSfYpejGVU5Sw80Gp28Tec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zXrBZ3w5LBWbNArhzQ9bBo5yEc5qnDOgKBK7tC/Ps4bPXer+P/xpCCA2edYuR1Bbl
         JZLYcfSJ47gA7u2DUgsvT6VZT+QhJ6F2CStRWJLU2NwJnptqHMpBHXD/rJFKZao2Mz
         Bz6HTxBA7AfKBYR1sk1F5t5QONGG1MOjVz9tyDAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
        Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Subject: [PATCH 4.19 17/25] CDC-ACM: heed quirk also in error handling
Date:   Tue,  9 Jun 2020 19:45:07 +0200
Message-Id: <20200609174050.594824583@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174048.576094775@linuxfoundation.org>
References: <20200609174048.576094775@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Neukum <oneukum@suse.com>

commit 97fe809934dd2b0b37dfef3a2fc70417f485d7af upstream.

If buffers are iterated over in the error case, the lower limits
for quirky devices must be heeded.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Reported-by: Jean Rene Dawin <jdawin@math.uni-bielefeld.de>
Fixes: a4e7279cd1d19 ("cdc-acm: introduce a cool down")
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200526124420.22160-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/class/cdc-acm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -590,7 +590,7 @@ static void acm_softint(struct work_stru
 	}
 
 	if (test_and_clear_bit(ACM_ERROR_DELAY, &acm->flags)) {
-		for (i = 0; i < ACM_NR; i++)
+		for (i = 0; i < acm->rx_buflimit; i++)
 			if (test_and_clear_bit(i, &acm->urbs_in_error_delay))
 					acm_submit_read_urb(acm, i, GFP_NOIO);
 	}


