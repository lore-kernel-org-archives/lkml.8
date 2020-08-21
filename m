Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B254C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F37DF2075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gvt1t/tE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgHUSyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:04 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9BBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:04 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o22so1919661qtt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tJ06fkRleY+SL3Oh74bnTOPqPdvqktxwc9J8GvyZTHI=;
        b=Gvt1t/tEEo8kVHshJM0OYplg3/jyHvdrGwdXg76Ibf0aQGPsBxxZHSPDH55kU5b3/a
         BAt8jvQmIb5s2exn+dWAQ6pYp9zB3NYULZPzHeLTAZ0Ix5zq6wT9Ee4ptugayl9TsEVX
         MlQXHViqh7zA5S8ZpEkxQ02vn1dXl8Kq1/Bw6qq7AdbhxFK61TUY73ZDiTnH4fu0rVjI
         jXMxQJ0i7Dqcva/azZnWVb9JBM34s/Q+PHjLT15iId+Zrfy5nuSLxBke7SjN1hWFIC4V
         cV1sCQYbaMJGN0lUwfwUU26HNfPl8aroMb68WwMfctHCHpyXKou8HumVv+6RBY5GiZYi
         3ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tJ06fkRleY+SL3Oh74bnTOPqPdvqktxwc9J8GvyZTHI=;
        b=qCcnmNhK97y/7THj5kUdBCCziAThgoq4eCHffzLdffU1SNHhOFFC95Wc3zQ0xeCZQT
         xGjKxZUU7FrcKG37iTEne5N+FNssiQTEDOv7lp6obefpH8JaigQ/ApMTgXrLKh25jPwP
         n2PEw42fA4kOlI1hejn1gxO9qTvHX0KQBD/6zUL3lxrsfhalN0spmXr6jyEQRhbn5Y96
         QkjxQ4q9SHGNuHvwLeqTH6eMBCTEYCY4QPX6NPvzpCPLYO0m/EtoZzBmN/nocKxwEHSW
         gCAOSB0hpSWj1n1kteI/qIS8oC9jJYkSdpMqweShoDSV1/x0HMs+lNBA8R/agKbSSXhI
         KkFA==
X-Gm-Message-State: AOAM531SKblgf8UP96vf4G7W/Kz4n++6f9dhcClhZmvYKwuu1sQnkycA
        5txsfJdm8jMr5OhxSp2FkbAOSpOX5Mg=
X-Google-Smtp-Source: ABdhPJwuz93YvbO2QpRm/1xw+1T6qzxMVwkeceZBDu3c34hBTa2MYmtlNmoVP0dNeDLPMME9UhX4dw==
X-Received: by 2002:ac8:ec7:: with SMTP id w7mr4107132qti.118.1598036043706;
        Fri, 21 Aug 2020 11:54:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:03 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/20] ALSA: hda/ca0132 - Set AE-7 bools and select mixer.
Date:   Fri, 21 Aug 2020 14:52:29 -0400
Message-Id: <20200821185239.26133-13-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
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
index 5aad9d8ee5e4..ffad29ac7290 100644
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

