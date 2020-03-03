Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1BD20842
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs2wtgU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgCCPg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:36:28 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34194 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgCCPg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:36:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so4951428wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
        b=Bs2wtgU4jAt7IUITsVgTBY7+8x2xD+/U/WMFNrYZFcY02kP+w9oNOdjHGH9UULECMv
         hfd9shjggWI4MdljtDCJb+XF9MUOAeazms2kde3BvIf+3CtBkLv2x4LSM0jo+x4wCkxx
         HekAOmTg4SPnwa3S4T8RcGWa4p/RHr8ojje0UjGFnrI4EBaUEG30yMy78zlnBj6huwgV
         a+jAgvYa3SfgvCyaEoT6XvdHSGlAzbc5oV4klsYLVyHcjn2g0Rua2AS7wr/Vni8B8laS
         mJUUGzY6JCNqWvi2kTEDQAV6y5sT6ZX78jtxQ7Aevm8XBRkLByqM2Te9kznXqSCk+FJE
         UpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
        b=ooc2/OZ3y70i0byQN7T9K3+MsFDb+fkm8plkcDorqO4LYlndZ9NFj7Ry2pNEy2ALZ7
         U3Ca0mA/a5bsKuGv2E1sl+6iVKELPmT55QZBLlQ4X/DPI3N3uwA1UpnvlpOOL/I8U2gm
         cmgpc1HSL6bBfoQNuIo2lCOjagiaA3zOcQHZlBKheMmwHsub2MeiRB23drjUMBL1NQzw
         giZOXjv6pLAGTMIOmSNExe6a9FvkwXmAQwiqcVQhittFa61wOqK7grnTFCcuBgOPrt3R
         XtOjT3+lBob91IVYSRK4kgLpe9IaxPdEqs0d6vJC4gONauCKc7wyw62Lg0e4/LfL40UU
         LSaA==
X-Gm-Message-State: ANhLgQ2x7oP6j2lCa0X5Ap1mE58KF/Mp6FnPmXMTfiw0IMI7Dj6fRI2c
        jCSHHqlcPTiI8m9NkQAu2Rs=
X-Google-Smtp-Source: ADFU+vtGoI/mzPs0ynrsF7uDds5DfI6X5RtIeDU79XDyRUfO5NXsknUOwCjbB2kpWpbc0tQQ2LFkmA==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr5729401wru.136.1583249785571;
        Tue, 03 Mar 2020 07:36:25 -0800 (PST)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id n8sm32836331wrm.46.2020.03.03.07.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:36:25 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Christian Lachner <gladiac@gmail.com>
Subject: [PATCH v2 1/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
Date:   Tue,  3 Mar 2020 16:36:19 +0100
Message-Id: <20200303153619.24720-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303153619.24720-1-gladiac@gmail.com>
References: <20200303153619.24720-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gigabyte X570 Aorus Master motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. Set up a quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 477589e7ec1d..8722616c6cc6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2447,6 +2447,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
+	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
-- 
2.25.1

