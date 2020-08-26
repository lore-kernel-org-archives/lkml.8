Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B5EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E42782071E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQq/z3XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHZIlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgHZIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:41:19 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF045C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:41:18 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so564207plk.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 01:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSB2W5Pv/3jJUL2eOsemL7QFgNmO3p3U0SiP4IFkLZM=;
        b=PQq/z3XLXfqrcYlzOat94mH5VVN2P4F5ppN9gEsqYf03TAqcgj7Wji62URYcH5PZsG
         Awy4gf2qQvrbT0pYqG9c83OyG7RGlC8GWsgoUQHpfdJFMPNrnamAI2UtyNCeJ0Xmp1Jp
         MJBZZMG29YN2xcOARSHGvkzJdbbPbV6IVu7w4PDy2K9+rDZ761OmMTH0F6u5JVIg0CUO
         gRq8WSvFU68AjQdWdasGMfRJ7SMJl0rlYPpRL6J59J6nDopXQ+RXzOQR3fNHQL6+Tyfb
         mwkhFXtOP8+zE6W9+TLBIrLzfR14ftavvEv9LB4W1h+7UTJqqtwm3cSVu+Tn9GRbRJbm
         V1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSB2W5Pv/3jJUL2eOsemL7QFgNmO3p3U0SiP4IFkLZM=;
        b=OnJMtr3nJD+ZvkjSAqRKmW8IV5IF624OHleU08gwBxa1WZbbtMv6ILVc09VW91eZmu
         LCerCHW8f5exyGZ6SeqxmggZs2iDp0p+wMuNzf+54J6m9h0xwg9IIFlq5F0YwXTPzt9x
         1cx6oaN4958qweM0bXsZwlFiA17xj1E9IH20Ux0V71oEC8OVHem/h0qAzPI7sHkQEgv+
         gGbuzT3/saq6ST/hsUBu/4hnV8BKcsyuQ3BP6obWX930MniBnBkGziIk6eud993wRnZ0
         ZmBmGafTt52cUtQPCRlZDS/oh2YOoFx2j7RFvNO3pP2+ypaaTDg51WBSiViiOAfLUkAc
         EQiw==
X-Gm-Message-State: AOAM533JakmydPpTIqHAMzDBdeIo8hBbWZFhiJGdPXePcBL8Rn4/vTOL
        oL4z1HPYzi5+AXqcvxB/2FIT6SgMtpkLNA==
X-Google-Smtp-Source: ABdhPJy9APVzxgOYOZiHI0TdEJ/seh1vsiahqNDOJJu/WZXmE5WovhWYnhQHA5qolszt/3+VG4nxPg==
X-Received: by 2002:a17:90b:1984:: with SMTP id mv4mr5165533pjb.32.1598431278282;
        Wed, 26 Aug 2020 01:41:18 -0700 (PDT)
Received: from localhost.localdomain ([112.214.139.41])
        by smtp.googlemail.com with ESMTPSA id e12sm1462284pjl.9.2020.08.26.01.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 01:41:17 -0700 (PDT)
From:   Adrien Crivelli <adrien.crivelli@gmail.com>
Cc:     Adrien Crivelli <adrien.crivelli@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion NT950XCJ-X716A
Date:   Wed, 26 Aug 2020 17:40:14 +0900
Message-Id: <20200826084014.211217-1-adrien.crivelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Galaxy Book Ion NT950XCJ-X716A (15 inches) uses the same ALC298
codec as other Samsung laptops which have the no headphone sound bug. I
confirmed on my own hardware that this fixes the bug.

This also correct the model name for the 13 inches version. It was
incorrectly referenced as NT950XCJ-X716A in commit e17f02d05. But it
should have been NP930XCJ-K01US.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Adrien Crivelli <adrien.crivelli@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1fa983d2..98789691a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7695,7 +7695,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
-	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NP930XCJ-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc830, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
-- 
2.25.1

