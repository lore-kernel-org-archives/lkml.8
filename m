Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D5BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF2D21556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859423;
	bh=37rXhZGNRoB2mPBAkMrE4GN7tlMk7RX9B6XaAhF4PWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e0kgVMwaWU3N4Uq1ieSSnrNh0Qo5GY0pRyJtXXIOiU/Rt8yYUqMdCwdcPRaN1JS7m
	 wIoFDjZp9felcHWVh/Y/ZinPtvzV6/K7/TnW8NkhmS9hpcY2gQ0NEJvJlBY4jrOk57
	 MztM+oUdW7xKweOepvOqZgQwqQx2LzYOD5tdLmK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387936AbgAXJuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:51012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbgAXJuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:50:17 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 417B421556;
        Fri, 24 Jan 2020 09:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859417;
        bh=37rXhZGNRoB2mPBAkMrE4GN7tlMk7RX9B6XaAhF4PWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fE/6ukgysRynJaSsx55tcnV4mrMcXF2ts9C/2u5Cq3rZ9hbM1y3FTMLyMgkmi9FU7
         WeCONYKqn2e5ayh6yRRPOCrWhBnrn095wG0j0cCfAlOp6314v3rxMjHUqu5ejoCMWD
         lGk/UYacsnpdroVDcLJkxPQhlu0EhqGCwhVQ8hAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 113/343] cdc-wdm: pass return value of recover_from_urb_loss
Date:   Fri, 24 Jan 2020 10:28:51 +0100
Message-Id: <20200124092934.895015110@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
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
index a593cdfc897fd..d5d42dccda10a 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1085,7 +1085,7 @@ static int wdm_post_reset(struct usb_interface *intf)
 	rv = recover_from_urb_loss(desc);
 	mutex_unlock(&desc->wlock);
 	mutex_unlock(&desc->rlock);
-	return 0;
+	return rv;
 }
 
 static struct usb_driver wdm_driver = {
-- 
2.20.1



