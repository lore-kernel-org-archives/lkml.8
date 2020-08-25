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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38297C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19C8D20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ou1n83iI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHYUM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHYULY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:24 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4DEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:23 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so10020770qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6KCEXxjjMuztLh2ZKBk7fpQJO49EcBKsDSWHrcA1YjE=;
        b=ou1n83iINZVayZF+5/4NQ8fWcmYn+puyxhECrLBGA/9Pi6AeRazxDZUiLeIKBxV1xA
         W2ifKzkJIm0ZGrAzcZXGusOPXC2wpIPQF5tmAH2DYQ0LD9bWrsgRiDgmDfuCBJZtqupk
         5yS80YeXeOy1AetQnD6SAkmZeAeIjQ2BMcaG+4r/bWxLuyWsnl2VhszcJqhpaMpeNBPN
         FzEwnjyQOLb8Vx5165Dg8xGRxfR1MHE4l9On4VtUx1ZbTemuYEEXycZue40zUZycPPE8
         xQZJDf7DzIvAPAVPcmpnu90r4RmHEwV5WUZni3DHTeqgg1E/Slx6jy7bdFeEcuyh/ANh
         wpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6KCEXxjjMuztLh2ZKBk7fpQJO49EcBKsDSWHrcA1YjE=;
        b=iEHCeHbqEQ1f0PXLDCSEW7fy/9JWPfJcZhlhDmSwd837mnVml2K403fUTwRHUrAiwW
         S1FdbeppQj1zyJ5ttXNkX/l4vRdeFz+NzoqEGTWw5YQmmx4aBsDtmw7QFhNd2UDybCn8
         OFABVgBUCHjxDiBtWZq7Rfo8fCvHYp6imzp7NmrwT9OJV/B8/rb79TyBsXE1oR0XWtg7
         T2Z49myJOHimgcc9LDeVA4MIsuoNyv1mJ3d5vjTzKsy0+wSCAr7IQqRSGBEJcGHaHaw8
         tP0Jrh91yc1QiLviggg6ME1j/AqZ/fylZsrI9UaglHd80W+HJbz3ymYQJalQ8u1ka8pU
         G1wg==
X-Gm-Message-State: AOAM530Pep/2qrOMcG2VIxGnSneQ/zg+E15TgilnePMDYN5cG3bWYQgn
        HPw5SWq+9JPiPID4X3hXlqY=
X-Google-Smtp-Source: ABdhPJzxu5DKXVBCbp+1pCgWNh4/59iIAiqMthDfWcscPTmjm+6JuAQU4ZlvrVlesFetNCi9rol2Tw==
X-Received: by 2002:ac8:6c55:: with SMTP id z21mr10889848qtu.68.1598386282746;
        Tue, 25 Aug 2020 13:11:22 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:22 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/20] ALSA: hda/ca0132 - Set AE-7 bools and select mixer.
Date:   Tue, 25 Aug 2020 16:10:31 -0400
Message-Id: <20200825201040.30339-13-conmanx360@gmail.com>
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

Set the boolean values used for desktop cards, and select the desktop
mixer.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6791aaf18e63..bd5d4f0bd6f5 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -9403,6 +9403,10 @@ static int patch_ca0132(struct hda_codec *codec)
 		spec->mixers[0] = desktop_mixer;
 		snd_hda_codec_set_name(codec, "Sound BlasterX AE-5");
 		break;
+	case QUIRK_AE7:
+		spec->mixers[0] = desktop_mixer;
+		snd_hda_codec_set_name(codec, "Sound Blaster AE-7");
+		break;
 	default:
 		spec->mixers[0] = ca0132_mixer;
 		break;
@@ -9413,6 +9417,7 @@ static int patch_ca0132(struct hda_codec *codec)
 	case QUIRK_SBZ:
 	case QUIRK_R3D:
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 	case QUIRK_ZXR:
 		spec->use_alt_controls = true;
 		spec->use_alt_functions = true;
-- 
2.20.1

