Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6FEC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AD920838
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 02:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO5xF9C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgH2CuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 22:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgH2CuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 22:50:15 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB36BC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 19:50:14 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so929077ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 19:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXF1rOFuCr3upnhNqTnjSrFjSuVCSRU/UPn3kL/3JLM=;
        b=GO5xF9C/82hbVlcWwH7u8XM1zbiWqZnbLEEO/zkuR58wfbviBVgMGdG+HP47S9CQRE
         HYPhM81j3VGo3Ya8I/pqRaMsmxyQAlTCMokvA42f0Wj1Em33siYrKhEwuL49FDbExgMh
         NIeRu7NfzbRXLUnITTXW3e05ywpp4oGmhX3rK9z6u8rxCmMsQTA8WYnCTxvLXmaLc4Py
         Sla8s92HaYvfiAABoZMhWRxovWZmRSZsRrWH0Oa5yi0RiYwP1uN3/0ibGE2XlOpYh6+D
         ba93Yjym83rg1YwRdVeJNWsSEcKX4PiBri+iXKE32Gtt/nlVoJCGnFD/KCm4pFA1zjIz
         kubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eXF1rOFuCr3upnhNqTnjSrFjSuVCSRU/UPn3kL/3JLM=;
        b=FLrPWL5y3xtEe4F8n3RJX9pkflHhr+XBKvu2IPnHcl3k+4JfFQ3LPPz/bgLqLs78LH
         9JKE9EinCI4a/VxZUucbwqlFWRRA1w2d6145mPtxnlyHuL67u/fNiNuuST2bRC7zThC7
         aqCZzZeA2omzdu1tm4NKcysf5OjzZT3o5DIB+w+vsOrGgxuu8+gLdtz8H6vFYPh4NpEc
         EjaQc6xJOk2EJRwC7JspC5hbwzdi/Ho8VHEZ+65lDxAVh2vwOqzZCyWzKykYFh6sTVem
         G4TjW99uHbHPyhvYx4Nz45Tw2yql5mlUHS4x5rtF8nFMpuYBIrcP3C6YAdWX74QrggMf
         3UNw==
X-Gm-Message-State: AOAM531CABdCCuqRjeO3AFRGiQKCATGQr4AbzuTrhp/OL71cDIERRsCc
        rrqHTLTP26dOb7fFM+S/G/c=
X-Google-Smtp-Source: ABdhPJx9M52yBfWstyboe2DL1nMa9c7HTffEByyRLokHMLfNrhdwIshhk5FIaUbaTjla0ovxm+yQHg==
X-Received: by 2002:a2e:730f:: with SMTP id o15mr637875ljc.297.1598669413163;
        Fri, 28 Aug 2020 19:50:13 -0700 (PDT)
Received: from localhost.localdomain ([178.73.195.107])
        by smtp.googlemail.com with ESMTPSA id i20sm217069ljb.90.2020.08.28.19.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 19:50:12 -0700 (PDT)
From:   Dan Crawford <dnlcrwfrd@gmail.com>
X-Google-Original-From: Dan Crawford <dnlcrwfrd@gmail>
To:     tiwai@suse.com, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Dan Crawford <dnlcrwfrd@gmail.com>
Subject: [PATCH 1/1] Fix silent audio output and corrupted input on MSI X570-A PRO
Date:   Sat, 29 Aug 2020 12:49:46 +1000
Message-Id: <20200829024946.5691-1-dnlcrwfrd@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Crawford <dnlcrwfrd@gmail.com>

Following Christian Lachner's patch for Gigabyte X570-based motherboards,
also patch the MSI X570-A PRO motherboard; the ALC1220 codec requires the
same workaround for Clevo laptops to enforce the DAC/mixer connection
path. Set up a quirk entry for that.

I suspect most if all X570 motherboards will require similar patches.

Related buglink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Dan Crawford <dnlcrwfrd@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a1fa983d2..a52d8640e 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2474,6 +2474,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1293, "MSI-GP65", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1462, 0x9c37, "MSI X570-A PRO", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x7350, "MSI-7350", ALC889_FIXUP_CD),
 	SND_PCI_QUIRK(0x1462, 0xda57, "MSI Z270-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
-- 
2.28.0

