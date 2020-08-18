Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5719AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FCA206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597757788;
	bh=dhCRpjDpcp8vSuReLz/7iaxyclVQ56ycG3BZ+rHLZ0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RdRrdGcZ09bOYt9W7fe9Ajq3LwqEtcdNPMFHLCc02MNh01GEAZ6rBt6nPt3Ffr49f
	 kiAhEsKLCExfGSDN6vhnTy23C+xydQJcA4rXAEGkk6UE4a4ZT3kIb+N5cDTJsHZvBa
	 mRBxl045o8m2A00oK+7eJHeCPBqasJu/WUhsWBVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHRNg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgHRNgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:36:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F412076D;
        Tue, 18 Aug 2020 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597757761;
        bh=dhCRpjDpcp8vSuReLz/7iaxyclVQ56ycG3BZ+rHLZ0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4Ox0pkinZT/tOpaC00heBvjiZsqnezii+S5f3arYfqjTtG6HI4mqOk7df+SOlLSP
         MWX4VK4aXGdk/9VMzRczfSnzH1SSTJdW7LlIprp2rEQyY09RZMS/SjfWjaXC4ug9i4
         VBkzV7WqmV0n9ZbxWF0qB9qOycCphrqlUjE12Qxg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-media@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minghsiu Tsai <minghsiu.tsai@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] media: mtk-vpu: no need to check return value of debugfs_create functions
Date:   Tue, 18 Aug 2020 15:36:05 +0200
Message-Id: <20200818133608.462514-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818133608.462514-1-gregkh@linuxfoundation.org>
References: <20200818133608.462514-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Cc: Houlong Wei <houlong.wei@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-media@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index d30c08983f56..36cb9b6131f7 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -849,10 +849,6 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	vpu_debugfs = debugfs_create_file("mtk_vpu", S_IRUGO, NULL, (void *)dev,
 					  &vpu_debug_fops);
-	if (!vpu_debugfs) {
-		ret = -ENOMEM;
-		goto cleanup_ipi;
-	}
 #endif
 
 	/* Set PTCM to 96K and DTCM to 32K */
@@ -910,7 +906,6 @@ static int mtk_vpu_probe(struct platform_device *pdev)
 	of_reserved_mem_device_release(dev);
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
-cleanup_ipi:
 #endif
 	memset(vpu->ipi_desc, 0, sizeof(struct vpu_ipi_desc) * IPI_MAX);
 vpu_mutex_destroy:
-- 
2.28.0

