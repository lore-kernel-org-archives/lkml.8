Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8889C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE6E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHbWJG4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHYULf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgHYULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664ADC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 92so4610370qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vCrVUPubKOzmsdqyXoYpMT9N+gSsM1Nu0aoYNMzgvlk=;
        b=jHbWJG4QHgXXcAfc7xHWIpHF5DVgvMiRVC9da6Kgd0NdObYx3HZPrpSUbIFVds0IFv
         uTZjNDebfKRN1wxj33CQyZgnWfnKt8qg4dnkOGFNskezVTwEXMbHqXm7A2g2eP6kAsbU
         SS6OgGODKIeRna7UwfxWP3/ivBp1VQBqDOH3lyIE2K5IDXiaLeGBqhY2XtLXkLaupHO8
         2NoAKnKLlTzzgR6SsVc+3C0363ROxHjUX/sT6U05sfOIN7zIGlHRMo9azRe84LBmDwJc
         Wfz5TXOiHzPclnpmbB7nPjAjUdnDYLGS1vHUkIro+cM9PrGy9hHmKvTWLIOsSkTLJRpK
         AzPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vCrVUPubKOzmsdqyXoYpMT9N+gSsM1Nu0aoYNMzgvlk=;
        b=IhHXjHrOu+xYESCXH9LwgMjURWnZUUB9uP5QeuqBMVUPk8Wnp7yI7zvgplNzRpVXNn
         1a5vCS8Els1ujAOY1R49cOoeNpVS8VW1A5hTadpI5vGRawVDhsT6opYm06iixxCc/Hhc
         HbWViNFoWWxMPN7qd9LrxWnM+goeO1efVDaQ0zcuk2wMO7wVCaQL9Q7fFHFtlu47y4PX
         HXjaprsdJKWHV4Opte8VuBq1/qV3OsHu6keFrOaLQF3MTidaUg0N7ba0La4hEcphAIfp
         nyGkouE8lo11GJPkxIWdoqQeCY9UnQsy6cLasrxb3XSSGw08lgLy1wkXd19jgGFfmgjn
         myXA==
X-Gm-Message-State: AOAM533SABvMXtZHEX9CAFwbGz5ggDP6IccP+Hn+JfyXyltBHWcBvb0s
        ncUJtWrS7PEZODDipJNsYHVq5mv6dy8=
X-Google-Smtp-Source: ABdhPJwTUl2JA8SbH+g9Zk3uvbAxTLrc+xHotqnRzH0Qvz8Iq23zz+uGyVNCLWJzuJMUTBlFBSUlzQ==
X-Received: by 2002:ac8:4f02:: with SMTP id b2mr2658390qte.44.1598386276821;
        Tue, 25 Aug 2020 13:11:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:16 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/20] ALSA: hda/ca0132 - Fix Recon3D Center/LFE output.
Date:   Tue, 25 Aug 2020 16:10:28 -0400
Message-Id: <20200825201040.30339-10-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825201040.30339-1-conmanx360@gmail.com>
References: <20200825201040.30339-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly set the GPIO pin to un-mute the Center/LFE channel on the
Recon3D.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ab84ea397552..138403fd1639 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7819,6 +7819,12 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	if (ca0132_quirk(spec) == QUIRK_R3DI)
 		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
 
+	/* Disable mute on Center/LFE. */
+	if (ca0132_quirk(spec) == QUIRK_R3D) {
+		ca0113_mmio_gpio_set(codec, 2, false);
+		ca0113_mmio_gpio_set(codec, 4, true);
+	}
+
 	/* Setup effect defaults */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
 	for (idx = 0; idx < num_fx; idx++) {
-- 
2.20.1

