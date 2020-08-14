Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA49C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1BEF20674
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUtZYnKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgHNE4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgHNE4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 00:56:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078F1C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 21:56:32 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so3830654pjr.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 21:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nbug31lN9jTiy04cDRYxBAFaW8MOaMvF7G1bnEdzpf4=;
        b=fUtZYnKTR5F5TSTQrQ1ymVxVV/pdp4XiWx4hFYmpNGCizfHWjGczqxUFJS/fCoCOEc
         iRFU7psHMyltWgLQbh1apal0ImbIKnJm5m/iM/lPaxx3NRfuvhg265i1FdyYihTm+XVr
         16CLK0WVr0IdJKpdMEBGR6apEcCR7xodi8oqJTWF1b7Z0Q4A12OQ2Xwe5sWwM66j5Lz1
         jPW+cY9xzIwzKnhyKkENCTlF0K4Rad3/7ObGy7FbLnQE9NG0TULsU9wIyi1rn+BI7p3T
         9wvFF9oV8QS/O1GtPJ8RLEMnOk5x2tc2BTLRBAgdHNrpzb+o3teE5dadZ5GGpWYuVvZ0
         5P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nbug31lN9jTiy04cDRYxBAFaW8MOaMvF7G1bnEdzpf4=;
        b=NGHk7C2LC9oXoGeE3dZ4ISWPrl2XlVkQGP9Faaoo0QVDAmXoaXQctd6qjGDAK/0K9E
         wX5Y1zMxniQpDYpvWyljeHeyeIkSw+aqJAiC4o7tdPVoFpwtsxASg42cf2odvmO2WWnS
         BS8bPcPo1pVmZzFz0SjK6zanI+jIPaH19tPfK9ygXOJl+fW9v3D64AlRmiC7JVhTBnWl
         POusB+HWwUkhJGGx5CFsUulAx8JMYohrx6kDtBSInzkR/WVsm7bZ1rYd8ScN9N4J4x5c
         8FrBXlwCkW1KkhMY266fjdNjkjstNFHex7ZAUJnh2ieXIKdLae1BxdJ9rhXNwx9SuVHa
         gbgA==
X-Gm-Message-State: AOAM530VuG1n/vdoqV0E1XJr/Oi15M61WKDQmVQLW0qFpPQ3z12jq/iS
        T290XtZWbYMhF9ztumg3QZg=
X-Google-Smtp-Source: ABdhPJyl4/Kw7t3X4OfxBWCLaueJJNizRweNvCNuKWlWS7F/ol7wjGBr6qJQT3Bt12aEFakzbS4/Rg==
X-Received: by 2002:a17:90b:4c46:: with SMTP id np6mr862057pjb.201.1597380992467;
        Thu, 13 Aug 2020 21:56:32 -0700 (PDT)
Received: from localhost.localdomain (68-123-15-75.lightspeed.sntcca.sbcglobal.net. [68.123.15.75])
        by smtp.googlemail.com with ESMTPSA id gl9sm6886790pjb.41.2020.08.13.21.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 21:56:31 -0700 (PDT)
From:   Mike Pozulp <pozulp.kernel@gmail.com>
Cc:     Mike Pozulp <pozulp.kernel@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Huacai Chen <chenhc@lemote.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Flex Book
Date:   Thu, 13 Aug 2020 21:53:44 -0700
Message-Id: <20200814045346.645367-1-pozulp.kernel@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Flex Book uses the same ALC298 codec as other Samsung laptops which
have the no headphone sound bug, like my Samsung Notebook. The Flex Book
owner used Early Patching to confirm that this quirk fixes the bug.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 2477f3ed7237..449ea64919ec 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7688,6 +7688,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc189, "Samsung Galaxy Flex Book (NT950QCG-X716)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
-- 
2.26.2

