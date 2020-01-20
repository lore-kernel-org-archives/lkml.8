Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4811C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D20207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 03:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVXdAKWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgATDmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 22:42:00 -0500
Received: from mail-pf1-f171.google.com ([209.85.210.171]:40204 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgATDmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 22:42:00 -0500
Received: by mail-pf1-f171.google.com with SMTP id q8so15105315pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 19:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZSuENgj57EJKhDmrfo9UwbHjaQk00c2fnA9ZQ7sTuQY=;
        b=PVXdAKWOv/6CJv7DJIkonwpRHjwNWN9U1j2HnbQnfUKvJVYLi2I0AHxah/DMJbjYAB
         15pnV9iy/ntluqy5wyfXsoz84xPIQaXlMk66HygM/cxUzzt8RB8Z7SoLdHHfxQdO1z5A
         LwmVO+q7oqnuRmutB129elUk5Xdvr3+MaXmB7y0Gqzusz28BYmPNKn4yvx4P4br8w1Gk
         RI4zd+Po+aQEEbPIuJA2GInS3HBLbi4MPyuZ90Tmgcy7Gv0nmo95L2j4fB0yrGwM6VHf
         qIBSKEMpPeB/Q5Yd0MALAtVCv9+loTzbHnE7kd1syTI+DmfWXvDlc2wnA0xc7sjdEDHo
         JLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZSuENgj57EJKhDmrfo9UwbHjaQk00c2fnA9ZQ7sTuQY=;
        b=AbYlo6mis40+EcOty4cRdR5l9W13HTBMSHVqwZUmXmexdd/Ze5Fve6T3YgEjd9P0FR
         RsfcG5B0UJqQ1Yy30Vxss2rbQ7ajfctnBIA9WoGe6SLWKBuzXaBl4k8dEGXr3G1yH2EG
         EoA12FIfaHwo3O24JAbL0kXqCAyVkKWXfVKO3eET+2bqbVROnrw522c8jOSCAjXrT4hj
         OzVAFFnuJXC6UDLAbsuKDIOg0NkZ8bg44Ce5V5RD63k01Pj4Oh9fuV6A4w5HcKdp0Ntl
         wjyhpgZcm9GbSyHzWL/t6O7vVtLdA5IH1CDZTNfpmpi2S1ZLi60H2jNkaYNLG6wHHtRu
         U9GA==
X-Gm-Message-State: APjAAAUMVf3XtA5/zyEePDbblZeNGVUQwEuSIIBE6LrTE8H8LqNAGjoC
        zGvBxYkiDMsknxgekj47ajo=
X-Google-Smtp-Source: APXvYqx9SFiP+HJHo5vJ9WNDDRJqY9FfJU2DKgJp/f5tUP2r6Sg8iGBBo13UVak42TonbSh0tPg8Ng==
X-Received: by 2002:aa7:961b:: with SMTP id q27mr15327820pfg.23.1579491719639;
        Sun, 19 Jan 2020 19:41:59 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id e2sm37158327pfh.84.2020.01.19.19.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 19:41:59 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] zram: move backing_dev under macro CONFIG_ZRAM_WRITEBACK
Date:   Mon, 20 Jan 2020 11:41:55 +0800
Message-Id: <20200120034155.6048-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

backing_dev is never used when not enable CONFIG_ZRAM_WRITEBACK and
it's introduced from writeback feature. So it's needless also affect
readability in that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 drivers/block/zram/zram_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f2fd46d..1cb3b9a 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -112,8 +112,8 @@ struct zram {
 	 * zram is claimed so open request will be failed
 	 */
 	bool claim; /* Protected by bdev->bd_mutex */
-	struct file *backing_dev;
 #ifdef CONFIG_ZRAM_WRITEBACK
+	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
 	u64 bd_wb_limit;
-- 
1.9.1

