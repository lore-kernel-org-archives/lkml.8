Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9107BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5132245C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="crkZ/ujv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHFCTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHFCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:19:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D38C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=xofDKx+o3lfDCmu16wOwUA02EP86ThN0YOQmggCIzCs=; b=crkZ/ujvSIDdXY+v4hPfwRHs9q
        0+U0bSOKKrL8q+xXgaLa9xT24ax+PIYKAefYMJdT5kL2y1H6uHBuyd/ZQ4ietlku+km8OAAUyw4TW
        C1QWy2CSeGb/X7GDHpLzJvzwSyETOO6ymWM25xwqhieF67OoYz/q7uIMcec5jvBzuE/85xxuSuer+
        w+7xUYyR57O+iFKqDCoc4bEvUVa6vj0EOShLeqDX3SqNQ1K3OwxEKbsoG+05/3kHhwsDI9eQAFITh
        RVb0LOllnw0azwyoV26Dmu1lasO+PCNDIHsGV5+/PkLPkEfFslvWNYcMYRc+EHNYg6gDfpSspHJT4
        sQ5hzOKw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3VVC-0007us-2G; Thu, 06 Aug 2020 02:19:31 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] sound: pci: delete repeated words in comments
Date:   Wed,  5 Aug 2020 19:19:26 -0700
Message-Id: <20200806021926.32418-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop duplicated words in sound/pci/.
{and, the, at}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: Clemens Ladisch <clemens@ladisch.de>
---
 sound/pci/cs46xx/cs46xx_lib.c       |    2 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c |    2 +-
 sound/pci/hda/hda_codec.c           |    2 +-
 sound/pci/hda/hda_generic.c         |    2 +-
 sound/pci/hda/patch_sigmatel.c      |    2 +-
 sound/pci/ice1712/prodigy192.c      |    2 +-
 sound/pci/oxygen/xonar_dg.c         |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

--- linux-next-20200805.orig/sound/pci/cs46xx/cs46xx_lib.c
+++ linux-next-20200805/sound/pci/cs46xx/cs46xx_lib.c
@@ -766,7 +766,7 @@ static void snd_cs46xx_set_capture_sampl
 		rate = 48000 / 9;
 
 	/*
-	 *  We can not capture at at rate greater than the Input Rate (48000).
+	 *  We can not capture at a rate greater than the Input Rate (48000).
 	 *  Return an error if an attempt is made to stray outside that limit.
 	 */
 	if (rate > 48000)
--- linux-next-20200805.orig/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ linux-next-20200805/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -1716,7 +1716,7 @@ int cs46xx_iec958_pre_open (struct snd_c
 	struct dsp_spos_instance * ins = chip->dsp_spos_instance;
 
 	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_OUTPUT_ENABLED ) {
-		/* remove AsynchFGTxSCB and and PCMSerialInput_II */
+		/* remove AsynchFGTxSCB and PCMSerialInput_II */
 		cs46xx_dsp_disable_spdif_out (chip);
 
 		/* save state */
--- linux-next-20200805.orig/sound/pci/hda/hda_codec.c
+++ linux-next-20200805/sound/pci/hda/hda_codec.c
@@ -3428,7 +3428,7 @@ EXPORT_SYMBOL_GPL(snd_hda_set_power_save
  * @nid: NID to check / update
  *
  * Check whether the given NID is in the amp list.  If it's in the list,
- * check the current AMP status, and update the the power-status according
+ * check the current AMP status, and update the power-status according
  * to the mute status.
  *
  * This function is supposed to be set or called from the check_power_status
--- linux-next-20200805.orig/sound/pci/hda/hda_generic.c
+++ linux-next-20200805/sound/pci/hda/hda_generic.c
@@ -813,7 +813,7 @@ static void activate_amp_in(struct hda_c
 	}
 }
 
-/* sync power of each widget in the the given path */
+/* sync power of each widget in the given path */
 static hda_nid_t path_power_update(struct hda_codec *codec,
 				   struct nid_path *path,
 				   bool allow_powerdown)
--- linux-next-20200805.orig/sound/pci/hda/patch_sigmatel.c
+++ linux-next-20200805/sound/pci/hda/patch_sigmatel.c
@@ -838,7 +838,7 @@ static int stac_auto_create_beep_ctls(st
 	static const struct snd_kcontrol_new beep_vol_ctl =
 		HDA_CODEC_VOLUME(NULL, 0, 0, 0);
 
-	/* check for mute support for the the amp */
+	/* check for mute support for the amp */
 	if ((caps & AC_AMPCAP_MUTE) >> AC_AMPCAP_MUTE_SHIFT) {
 		const struct snd_kcontrol_new *temp;
 		if (spec->anabeep_nid == nid)
--- linux-next-20200805.orig/sound/pci/ice1712/prodigy192.c
+++ linux-next-20200805/sound/pci/ice1712/prodigy192.c
@@ -32,7 +32,7 @@
  *		  Experimentally I found out that only a combination of
  *		  OCKS0=1, OCKS1=1 (128fs, 64fs output) and ice1724 -
  *		  VT1724_MT_I2S_MCLK_128X=0 (256fs input) yields correct
- *		  sampling rate. That means the the FPGA doubles the
+ *		  sampling rate. That means that the FPGA doubles the
  *		  MCK01 rate.
  *
  *	Copyright (c) 2003 Takashi Iwai <tiwai@suse.de>
--- linux-next-20200805.orig/sound/pci/oxygen/xonar_dg.c
+++ linux-next-20200805/sound/pci/oxygen/xonar_dg.c
@@ -29,7 +29,7 @@
  *   GPIO 4 <- headphone detect
  *   GPIO 5 -> enable ADC analog circuit for the left channel
  *   GPIO 6 -> enable ADC analog circuit for the right channel
- *   GPIO 7 -> switch green rear output jack between CS4245 and and the first
+ *   GPIO 7 -> switch green rear output jack between CS4245 and the first
  *             channel of CS4361 (mechanical relay)
  *   GPIO 8 -> enable output to speakers
  *
