Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A17FC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE6520639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599063383;
	bh=b420j7CBfw+D7BCOVF5+bODRBG1RaeqpINVSfggl6cE=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=Jjt6BozUVOHr/TtQ8eBrCiE77H6crp3yfW9VMe9EUDVOfGbK6YnflEfIaKkQ7Od2C
	 LfF6cB/BHKK2qi7ZNqBrRlXOyZcbYjc5A80z8iAx2t9hpyj13ukWqG3b9s6t7YYoIQ
	 WSyUxczy7CFd+ynpZZDDTiCGCvWu1dqergezFays=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgIBQQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728298AbgIBQK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:10:56 -0400
Received: from mail.kernel.org (ip5f5ad5c3.dynamic.kabel-deutschland.de [95.90.213.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01CC121655;
        Wed,  2 Sep 2020 16:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599063046;
        bh=b420j7CBfw+D7BCOVF5+bODRBG1RaeqpINVSfggl6cE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPXDst8O/wmDHu+mZOBICcXK6SsLeS4lRAFzqVEjNvhkxaSPDWpQK5psdnjLg83uC
         YLbpql3wJ8xPR3VGyuVWxIayNGl0w0PgSCzn/CrzkYHQVfaO/jjT4qjWo7DI+7nvo2
         kzRYXviFdwBL/aozuC3oVeBV9lmVTvIwalEd33P0=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kDVLQ-000tAZ-5s; Wed, 02 Sep 2020 18:10:44 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/38] media: saa7134-alsa.c: number of pages should be unsigned long
Date:   Wed,  2 Sep 2020 18:10:23 +0200
Message-Id: <7e9ce5335675f4e81fd28e2e57451c58d2ebb5bb.1599062230.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599062230.git.mchehab+huawei@kernel.org>
References: <cover.1599062230.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by smatch:

	drivers/media/pci/saa7134/saa7134-alsa.c:267 saa7134_alsa_dma_init() warn: should 'nr_pages << 12' be a 64 bit type?

the number of patches should be unsigned long.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/media/pci/saa7134/saa7134-alsa.c | 7 ++++---
 drivers/media/pci/saa7134/saa7134.h      | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-alsa.c b/drivers/media/pci/saa7134/saa7134-alsa.c
index 544ca57eee75..347ecb0bab2f 100644
--- a/drivers/media/pci/saa7134/saa7134-alsa.c
+++ b/drivers/media/pci/saa7134/saa7134-alsa.c
@@ -252,7 +252,8 @@ static int snd_card_saa7134_capture_trigger(struct snd_pcm_substream * substream
 	return err;
 }
 
-static int saa7134_alsa_dma_init(struct saa7134_dev *dev, int nr_pages)
+static int saa7134_alsa_dma_init(struct saa7134_dev *dev,
+				 unsigned long nr_pages)
 {
 	struct saa7134_dmasound *dma = &dev->dmasound;
 	struct page *pg;
@@ -260,11 +261,11 @@ static int saa7134_alsa_dma_init(struct saa7134_dev *dev, int nr_pages)
 
 	dma->vaddr = vmalloc_32(nr_pages << PAGE_SHIFT);
 	if (NULL == dma->vaddr) {
-		pr_debug("vmalloc_32(%d pages) failed\n", nr_pages);
+		pr_debug("vmalloc_32(%lu pages) failed\n", nr_pages);
 		return -ENOMEM;
 	}
 
-	pr_debug("vmalloc is at addr %p, size=%d\n",
+	pr_debug("vmalloc is at addr %p, size=%lu\n",
 		 dma->vaddr, nr_pages << PAGE_SHIFT);
 
 	memset(dma->vaddr, 0, nr_pages << PAGE_SHIFT);
diff --git a/drivers/media/pci/saa7134/saa7134.h b/drivers/media/pci/saa7134/saa7134.h
index 77c325e64a97..d29499cd7370 100644
--- a/drivers/media/pci/saa7134/saa7134.h
+++ b/drivers/media/pci/saa7134/saa7134.h
@@ -509,7 +509,7 @@ struct saa7134_dmasound {
 	void			   *vaddr;
 	struct scatterlist	   *sglist;
 	int                        sglen;
-	int                        nr_pages;
+	unsigned long              nr_pages;
 	unsigned int               dma_blk;
 	unsigned int               read_offset;
 	unsigned int               read_count;
-- 
2.26.2

