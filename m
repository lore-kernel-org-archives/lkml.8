Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ECDC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF94E2177B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 01:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YChznlMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHHBWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 21:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgHHBWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 21:22:16 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10AAC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 18:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2Eey4zyvvBAtzwJbwbbfgGW0KZPfiiNUMcUuzDm1GX8=; b=YChznlMyJ0OeIA4y4fS8d7uUiY
        J+z7MmNjodYepNgfc7rxeBcXX4Nv2YvpOTcRQ0KC2lnb6ONsm8w6zm1SYiCAvr335FGHBYapfPGfB
        hlLZBnEUsXHaFSwQ5D/ELsLvOuVxDJIYR3R5+eXygs80s+5y8DFqaxdf1Djh9sa2xCDSju1xdW7TJ
        JzTlEOc3gVrIA5qdeF8t4gaanPY42EY204Q/drVsMGMLEluUzFAIvi22lsXKMaPil9CZXjPjlzkc9
        e+knS5lJL/cFipC1V9ST6urokfJmyJFE9c9CKLD3gXsq6TXPTM7R/+YmvD1ohelHCgfxo451b5T8C
        VkPy6NrA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4DYr-0001IK-I4; Sat, 08 Aug 2020 01:22:14 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: various vendors: delete repeated words in comments
Date:   Fri,  7 Aug 2020 18:22:09 -0700
Message-Id: <20200808012209.10880-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated words {related, we, is, the} in comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
---
 sound/soc/fsl/fsl_dma.c             |    2 +-
 sound/soc/intel/skylake/skl-sst.c   |    2 +-
 sound/soc/meson/axg-tdm-formatter.c |    2 +-
 sound/soc/sprd/sprd-pcm-compress.c  |    2 +-
 sound/soc/sunxi/sun4i-codec.c       |    2 +-
 sound/soc/ti/davinci-mcasp.c        |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200807.orig/sound/soc/fsl/fsl_dma.c
+++ linux-next-20200807/sound/soc/fsl/fsl_dma.c
@@ -154,7 +154,7 @@ static void fsl_dma_abort_stream(struct
 /**
  * fsl_dma_update_pointers - update LD pointers to point to the next period
  *
- * As each period is completed, this function changes the the link
+ * As each period is completed, this function changes the link
  * descriptor pointers for that period to point to the next period.
  */
 static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
--- linux-next-20200807.orig/sound/soc/intel/skylake/skl-sst.c
+++ linux-next-20200807/sound/soc/intel/skylake/skl-sst.c
@@ -354,7 +354,7 @@ static int skl_transfer_module(struct ss
 	/*
 	 * if bytes_left > 0 then wait for BDL complete interrupt and
 	 * copy the next chunk till bytes_left is 0. if bytes_left is
-	 * is zero, then wait for load module IPC reply
+	 * zero, then wait for load module IPC reply
 	 */
 	while (bytes_left > 0) {
 		curr_pos = size - bytes_left;
--- linux-next-20200807.orig/sound/soc/meson/axg-tdm-formatter.c
+++ linux-next-20200807/sound/soc/meson/axg-tdm-formatter.c
@@ -398,7 +398,7 @@ void axg_tdm_stream_free(struct axg_tdm_
 	/*
 	 * If the list is not empty, it would mean that one of the formatter
 	 * widget is still powered and attached to the interface while we
-	 * we are removing the TDM DAI. It should not be possible
+	 * are removing the TDM DAI. It should not be possible
 	 */
 	WARN_ON(!list_empty(&ts->formatter_list));
 	mutex_destroy(&ts->lock);
--- linux-next-20200807.orig/sound/soc/sprd/sprd-pcm-compress.c
+++ linux-next-20200807/sound/soc/sprd/sprd-pcm-compress.c
@@ -559,7 +559,7 @@ static int sprd_platform_compr_copy(stru
 		} else {
 			/*
 			 * If the data count is larger than the available spaces
-			 * of the the stage 0 IRAM buffer, we should copy one
+			 * of the stage 0 IRAM buffer, we should copy one
 			 * partial data to the stage 0 IRAM buffer, and copy
 			 * the left to the stage 1 DDR buffer.
 			 */
--- linux-next-20200807.orig/sound/soc/sunxi/sun4i-codec.c
+++ linux-next-20200807/sound/soc/sunxi/sun4i-codec.c
@@ -335,7 +335,7 @@ static int sun4i_codec_prepare_capture(s
 
 	/*
 	 * FIXME: Undocumented in the datasheet, but
-	 *        Allwinner's code mentions that it is related
+	 *        Allwinner's code mentions that it is
 	 *        related to microphone gain
 	 */
 	if (of_device_is_compatible(scodec->dev->of_node,
--- linux-next-20200807.orig/sound/soc/ti/davinci-mcasp.c
+++ linux-next-20200807/sound/soc/ti/davinci-mcasp.c
@@ -633,7 +633,7 @@ static int __davinci_mcasp_set_clkdiv(st
 		 * right channels), so it has to be divided by number
 		 * of tdm-slots (for I2S - divided by 2).
 		 * Instead of storing this ratio, we calculate a new
-		 * tdm_slot width by dividing the the ratio by the
+		 * tdm_slot width by dividing the ratio by the
 		 * number of configured tdm slots.
 		 */
 		mcasp->slot_width = div / mcasp->tdm_slots;
