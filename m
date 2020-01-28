Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCD4C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29C524683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222275;
	bh=OmakTc7+CEIwIVwgJvm2ptrnkn0uxJwn1MlkN69iRHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d+q1GbLMVkBDU8Ihi3WWHqqWHE7+5PC8XjnWEuEr5lRIT2aQtVm6IvB+FdUzF8ePk
	 6XCtYAvyDyo5moUIGJEoc3QoG01VdIDqjEzZNEFuo9nDM5Gy/ws/92EabNUfzUpWQB
	 j0wL0i2uF6wXqOfpk7o5vT9Ru6/XGjawDI9uWq7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgA1OT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730435AbgA1OTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC15D24698;
        Tue, 28 Jan 2020 14:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221164;
        bh=OmakTc7+CEIwIVwgJvm2ptrnkn0uxJwn1MlkN69iRHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRsQTOC0nxLIJRCP9ySevdqmGS4pFfNLtkO6zJJ5DeEbGCLjXcF8C4xRiBTbjgwPf
         0B1517Xebivv/llqB2Jj2MFDEatdJvvVEqiazzZ/fnW0iOdv206yXFzOryYA3IAR/r
         UrrI9AycXtqYKpKTSwQbQhoSGT48yUBmQSB9mEn8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 077/271] cdc-wdm: pass return value of recover_from_urb_loss
Date:   Tue, 28 Jan 2020 15:03:46 +0100
Message-Id: <20200128135858.291000386@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit 0742a338f5b3446a26de551ad8273fb41b2787f2 ]

'rv' is the correct return value, pass it upstream instead of 0

Fixes: 17d80d562fd7 ("USB: autosuspend for cdc-wdm")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 217a479165e03..09337a973335c 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1098,7 +1098,7 @@ static int wdm_post_reset(struct usb_interface *intf)
 	rv = recover_from_urb_loss(desc);
 	mutex_unlock(&desc->wlock);
 	mutex_unlock(&desc->rlock);
-	return 0;
+	return rv;
 }
 
 static struct usb_driver wdm_driver = {
-- 
2.20.1



