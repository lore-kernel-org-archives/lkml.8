Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0606CC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD964208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 09:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVe+S1N5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgBWJ1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 04:27:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54386 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgBWJ1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 04:27:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id z12so2842892wmi.4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 01:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
        b=aVe+S1N5sJ8aolhiRjVJT5soFjhhNR2YydoV8MFWfhsSBFhTuv+JOcMwgVdi6XGZOS
         flGEhmOzQQp/fiGTAUAu+83/ACA5ojAc4PqyA3cH/oMt8YZQh/twDoNLawTTiTONYuSm
         0wPaiBTI5guz/X7uqe5vH9aHLuBhJ9+GpcICXX0oJ4SAh9+0kveicPLCdp6V5kaGWLyO
         yD3G2cc5pMp8XKt+Fdt2YQNaD2gL5nbpB9M7UoR0dn4usPZoeRN8pPjA1dMqBoOpR+oU
         VMvP/M5Zhr7FP1nt5tjbW/ohk2WiNAvnyugqUprjSsypV66fSIcN5Rih0TmjHeL00nu6
         yyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JcrMrcr18C9BvF7z9tdmIPfuQXb50JBD+U+5ocXJjHw=;
        b=fva5ve8gaA5wHTQcairXaw1ROl7IVHddDime/+CFmNTQOFfLk/GRL+6pEQ7HHDSiEx
         mPmIVMbDoA08H868xXrWeSjVUzL+PwuXVQE+s6RJrtIbA7oOJd9PiqyO90R6nBCuYYY+
         XkGriEdyvhlFMpKBLD6dUgpa7lxRZQFKVInMzrkYvsztpHaM4qXhBLTV2eSJpLpL0YdX
         5t8QCOFQdLTbzqlu/wFerr7GJreMGwCjlW9HjwTKIUeWRSfK70RYvLyMyPFzFszLRq4H
         kuDrDlSI/pcQi+k4QJEVQ5wB/PA3QgMKRLnwJQWbtQF2QveenJSlATYo5SXkaX07U9zn
         8BHQ==
X-Gm-Message-State: APjAAAVXc/v6MvuFuiB1jdiic73USvQpuzV7EI5GQG24ql5fTC20jMIu
        KJf2vJ1mdXmtUWTPXgRG6cCo972dyDSlQA==
X-Google-Smtp-Source: APXvYqzrsyVitzgqHWAbDjLs/one4v8JQ9MbmEB3VVgrerb5OyTDiZRGa4A/5JVqnVd1hSpiVVsrDg==
X-Received: by 2002:a1c:8151:: with SMTP id c78mr14397067wmd.29.1582450025415;
        Sun, 23 Feb 2020 01:27:05 -0800 (PST)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id w7sm11849276wmi.9.2020.02.23.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 01:27:04 -0800 (PST)
From:   Christian Lachner <gladiac@gmail.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 1/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Master
Date:   Sun, 23 Feb 2020 10:24:16 +0100
Message-Id: <20200223092416.15016-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200223092416.15016-1-gladiac@gmail.com>
References: <20200223092416.15016-1-gladiac@gmail.com>
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

