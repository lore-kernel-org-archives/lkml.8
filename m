Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6F3C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55820857
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758950;
	bh=oeSkHvhk+E5lKXj9sWZUu5MtAvGJsJpI7ik9znVotAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afimWPXjAFqVUGVzaUUu9rquL/Y28DN9XB67dqs+xVBVCGmZrOhRGyDxg+j8P/beR
	 diObnWe3lF22ml1+Ug4kK1GdSNyQlEURXsTQ1y6Emyn9Alfk4F79+y5LRWMkIwXb4Y
	 gs0qaehU+A0ZErLhFcpUjBV5o+Am7fCpigRiO4fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732889AbgDAQft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388773AbgDAQfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:35:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E067C20658;
        Wed,  1 Apr 2020 16:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758945;
        bh=oeSkHvhk+E5lKXj9sWZUu5MtAvGJsJpI7ik9znVotAw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y0QEVIW70+3HnMWC+m+oJuKnG3DQetVi1ta5oXHiO7TFxSerHtIQoQsL69UQ2Yb11
         vaumvQKTPoKX5vY64XNA0SOe8WhWkgjFHClW1e0Mcrp5c5pf6YE4rI52QRbXXFz9Pt
         lZxaQAleCJmDSltuY/EZWqwHjevZO+yJgJ37/ikw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anthony Mallet <anthony.mallet@laas.fr>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 028/102] USB: cdc-acm: fix close_delay and closing_wait units in TIOCSSERIAL
Date:   Wed,  1 Apr 2020 18:17:31 +0200
Message-Id: <20200401161538.481068160@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
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
index b2edbd4bf8c44..9fd1cd99aa977 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -828,10 +828,10 @@ static int get_serial_info(struct acm *acm, struct serial_struct __user *info)
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
@@ -849,9 +849,10 @@ static int set_serial_info(struct acm *acm,
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



