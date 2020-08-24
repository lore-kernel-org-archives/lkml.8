Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAE920838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTcNzDrl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHXMQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgHXMQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:16:37 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:16:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so4219614pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I81TrQIlLLJRVVinDOxjbOmcQCTQyJqY7KYEl8xpvEM=;
        b=fTcNzDrl8kfLjwHdkCMdbczkh+KWqbexfro8OnEnfFmyMT8H88j8lunKyr2nCY42IE
         qr0xHOxX/r0EUEc91u2I5XCUJ68oIF/OwPlHhyGxIlg6BDfnZriWOUx2nChlrVVFgjtM
         12UR8j4H/Bwr96Lv1O0ur3R0+EkVJvTMbwP+JsRTwkMziQ6SpL1v+qVvIZ4UyENOPo9o
         l5Sk2eMkbNtQ5TPPZ5UBrfssJN88XJP1zj5rZIsJfVdhj/Ydpe/gxJi7jbrtZXoJzTTA
         G6f25vpDU6ECDRoPkrS/vBWHvJoiiyGJSQDoAdQ7nSvP5zhOtTZJRzQDXHkl95b+ZU6t
         SX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I81TrQIlLLJRVVinDOxjbOmcQCTQyJqY7KYEl8xpvEM=;
        b=h8xmc3Z7jyb4y33QoA2MOmIUe+QOkK5+1HRI+aO+IxE58Qyl+x2H8QEgoBDNqi2i7J
         WYTbb6UVC3rwRnvEQWR31GVjaxxRNBSu+yhHgSaL16lyseawFzWE0tborbL8Rm1/EYjt
         IFGbcR0ES7u6DIZz+6ggMZOtj7yJuMN6MMRSMYQIQbzel9dW4fLVheb5l6p8gEeG5pB4
         dAd5MRYfTFOJI+AX9VNg3NGORx7lZLxopIMvAqP0DtESBx4PxqbNv34X2QI1PP4WbaJe
         aRnpjRwJUC1SXmhhlClAWz2RghLu68z34DXOZnpY0FfzAwUTjajhnb5/INICUoNDjTNI
         FWzQ==
X-Gm-Message-State: AOAM530ngo4r9g0ldVUaln5Rg8nYKuPhTwgg1Ll2Skn6qSf8V+y2aHJP
        DMuwPMieTgKddNnYDCUGuDY=
X-Google-Smtp-Source: ABdhPJz3VGjcaREhiRJXYcgbj4i0IEOF7ornuO6w7LX5m2XEB/4NztqaV6m5y2MksmNQpIag5bWmFw==
X-Received: by 2002:a17:902:fe0f:: with SMTP id g15mr1445494plj.204.1598271395782;
        Mon, 24 Aug 2020 05:16:35 -0700 (PDT)
Received: from localhost.localdomain ([112.214.139.41])
        by smtp.googlemail.com with ESMTPSA id j5sm11656610pfg.80.2020.08.24.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 05:16:35 -0700 (PDT)
From:   Adrien Crivelli <adrien.crivelli@gmail.com>
Cc:     Adrien Crivelli <adrien.crivelli@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion 15 inches
Date:   Mon, 24 Aug 2020 21:15:54 +0900
Message-Id: <20200824121554.73933-1-adrien.crivelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Galaxy Book Ion 15 inches uses the same ALC298 codec as other Samsung
laptops which have the no headphone sound bug. I confirmed on my own
hardware that this fixes the bug.

Commit e17f02d05 mixed up 13 inches and 15 inches models. This clarifies
the situation with the correct model names.

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

