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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAFFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D4220748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD6hD8LM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgHUSyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHUSyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBBBC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id v1so1086865qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9IeHB9lDAArlqZqVF3RpujPXGqkuFDtD8SXfEd8xABI=;
        b=GD6hD8LMYN5mgdIAELCXVSnSM884fmkvhr5QqlZoeJpeb+L1ZV9uxSoOV7b0prEDCN
         nAFH6njIFhR2pI1yMQw2XmHNcDq3yQbtD6o7xi50IQrQV1++zULuBD4C71Eeh5jksjeV
         f5AoLe6an5/xr+k4QzibPZI18Z2L7VHdPP5pAyKsm/2lyzaERsEJhT+gCoOLQ32ZKokj
         A+/VYocRBPXO2FhE90r6bFFbF1PoQCyMtpqvchi8nLIgQjybnWa7Y9/yODsOQEtU8v/1
         puI+7D5DqqArmZRFaYVc8wT7UGqAbh9A08hAg7ycrQUFNpml0JkqNDmgfRV8c4pE1d78
         Ivtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9IeHB9lDAArlqZqVF3RpujPXGqkuFDtD8SXfEd8xABI=;
        b=XWQztbCgNtQyb8vPnUbYyKOj7TimeTgdsOMf9jGpznx5e83A7LwkHHshmVt+cYOlTE
         Ei46GfD8TfO4rL0MvElF13FW3xfOOkAy6/pWCOKZm0GJ/MsMTYVovQkeBGp9xvveds/Z
         QDD4r5k6GsXxdj3AXuSfi2visohl3ifnPicQ1JfXlESgjqnTh2jP/qfb4sIjUB3xfrtq
         /Z+/Q2gnlxxcl3aM0ZyT0qjAMOUQeQxZtk6kZbug6y82MPvbKWoFBt3ziy66Mve8j6zE
         F9p90JxlT+LP3arWo8lgAQ3PP0N6uIgQheDxR/hoCbNKw5DjXZpsZiDzjLarMhYxlV+u
         VXyg==
X-Gm-Message-State: AOAM531ZwDWZESmsRkd9qGW44YJd1O7c3woEgDlwE2rxXVqTRz0BFPtv
        yG+VfswXdLBgzwq7eg8j9DQ=
X-Google-Smtp-Source: ABdhPJw/p/aSkmV5jyryhckZjVlGcJD7wF9+/GM74z1Nf/6LQvha53fa74/Vf278dTIRUtlJXKMSIw==
X-Received: by 2002:a05:6214:1742:: with SMTP id dc2mr3813584qvb.90.1598036039800;
        Fri, 21 Aug 2020 11:53:59 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:59 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/20] ALSA: hda/ca0132 - Add new quirk ID for SoundBlaster AE-7.
Date:   Fri, 21 Aug 2020 14:52:27 -0400
Message-Id: <20200821185239.26133-11-conmanx360@gmail.com>
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

Add a new PCI subsystem ID for the SoundBlaster AE-7 card.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 9c61a10114aa..57cb63ea88e6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1134,6 +1134,7 @@ enum {
 	QUIRK_R3DI,
 	QUIRK_R3D,
 	QUIRK_AE5,
+	QUIRK_AE7,
 };
 
 #ifdef CONFIG_PCI
@@ -1253,6 +1254,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
+	SND_PCI_QUIRK(0x1102, 0x0081, "Sound Blaster AE-7", QUIRK_AE7),
 	{}
 };
 
-- 
2.20.1

