Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93EBF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8FgvlSJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgHRQ4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgHRQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:55:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B6BC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:55:28 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c10so9610175pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM0E5QyjmY6mhdm7T7L6Scw42Q774kfBG5y8gMakP3A=;
        b=J8FgvlSJpTnKuX73gqKANRbnHFn1NJv40M9yVBff5l4v7HvxtP7npN6hAC+ETOCRXc
         HZtSDQ6HTO5t+z3OW9L62L3dzP2US0v/i7AeXHZdFqkfFwTpm6OdR3sMe2qTGiMKj4L4
         1RMLaleS+QuETFH88cXc3tJljZyH9SuRRztmVmAjDXxwMlTFJqFbTUaHoonYPcOOULYI
         JEaNK8gGJkY1p2ttUWfr8q72KJhlqgvN170C2vJ2DWUiRpQupZfJo0kNaZXRC/tLaC0d
         PEhF37oiMiyxjqj1+GNsSuHizqmCGYQAUXFol6U7P6rIU/bNlDVlhtRQZZNiDcCNuc3Y
         yo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM0E5QyjmY6mhdm7T7L6Scw42Q774kfBG5y8gMakP3A=;
        b=Q0cdAHyy1tAPnuvGQTx2aVn0i/M3zs6RY5L56V9L3knU24opwkP3lpf984tbtS40Ok
         bu6Zl/tAx6ECXeywiJmd7Y32St60+riCcJwEbaSG9KRMQQKJIEujPBVr8NyQ4gO243w9
         2iwvpgKnD/gXL2+LmSJW7aOx3HQjSUD3nXZsNQF/mBbs0YczzOu0mJGjJi0MN3eGbr7r
         4i75sl5JtnKreQRS9sbUIbyRfzuxh35KY4eJ9MkWNP+ar0A9sFVpvmii6ywoaBR/kXcl
         4/TXKvsQYH03QZkLSNFOujj5sdfDz1uACJc/J2MiIbH4VS9XpqkFdbe0U5VfS9C7l4El
         5bJg==
X-Gm-Message-State: AOAM533fLwg5uwzz4RCVwjHOltbOpYmohaK+bKLaKFAl5yiPIML1iXUj
        PglHyh9mZkURAoigwGlv4qU=
X-Google-Smtp-Source: ABdhPJyGM9JIR4A46+mF5AcWltJMuj4HOIgEui/97UFWc6QuKFQN0whsClLPvqe7KPq03Ztv/oT3qA==
X-Received: by 2002:a17:902:c203:: with SMTP id 3mr16260039pll.121.1597769728372;
        Tue, 18 Aug 2020 09:55:28 -0700 (PDT)
Received: from localhost.localdomain (68-123-15-75.lightspeed.sntcca.sbcglobal.net. [68.123.15.75])
        by smtp.googlemail.com with ESMTPSA id m4sm24660484pfh.129.2020.08.18.09.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:55:27 -0700 (PDT)
From:   Mike Pozulp <pozulp.kernel@gmail.com>
Cc:     Mike Pozulp <pozulp.kernel@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Chris Chiu <chiu@endlessm.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Galaxy Book Ion
Date:   Tue, 18 Aug 2020 09:54:44 -0700
Message-Id: <20200818165446.499821-1-pozulp.kernel@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Galaxy Book Ion uses the same ALC298 codec as other Samsung laptops
which have the no headphone sound bug, like my Samsung Notebook. The
Galaxy Book owner confirmed that this patch fixes the bug.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 29f5878f0c50..72aa3da479c9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7612,6 +7612,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc18a, "Samsung Galaxy Book Ion (NT950XCJ-X716A)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x144d, 0xc740, "Samsung Ativ book 8 (NP870Z5G)", ALC269_FIXUP_ATIV_BOOK_8),
 	SND_PCI_QUIRK(0x144d, 0xc812, "Samsung Notebook Pen S (NT950SBE-X58)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 	SND_PCI_QUIRK(0x1458, 0xfa53, "Gigabyte BXBT-2807", ALC283_FIXUP_HEADSET_MIC),
-- 
2.28.0

