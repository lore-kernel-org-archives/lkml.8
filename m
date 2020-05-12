Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F6BC54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0440207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="YSnUur22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgELGRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgELGRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:17:19 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB68C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:17:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so4947684plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPhdNQpmNdWMTH4ItY0n2wQhmbRZdFbnehkFaFShH6Q=;
        b=YSnUur22fR3d6DIb8DsRfVkB1mFWIES6U6mYkad1cZyYbCSIVC4QhoBNKT1q71A8/f
         VctpRiXXnzj/5KBa0r/X8VOSJ2OLOQsZ850kXKKeybtWitiFvEv02/iKAQV6pKVVwQph
         7MAmeAlfniwk2NdiFnPJPhXjyYZalGPoD5ULKOxLEw308RjuDi/26t+zxHn1jRi2Kv1+
         Tgf2fw1F2ethVvtYT2Bol/6WI/ogZP9SqSAIlQrdvbZzMQ9u1rs2f5M8ZwOI0xn463Vm
         1kbC4M+DDhT0kild8gIQGRMGDsjm3mTiqcqgeUyX67HfnPEvusM/bRAYHw/hnnnJ9wcs
         +raQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPhdNQpmNdWMTH4ItY0n2wQhmbRZdFbnehkFaFShH6Q=;
        b=kXCbKzL/ZmVjx1gmdtOX6iMuUJvWDqwgh2G1woQhfIEjBaFN+7FWNhbpHvtZhyBq/s
         aZMEV82vdZwDS4PGm6+QZGq57yzqTLggwV9qY6Z9UDCV+OKyKcjBXV9n3Z0llre0hk1H
         u51OrRVemSvtbjoENF6HkAkQGDkUgNngBI5uE4VFoKpwbCEyGqBE04vz9OkX6i71kVTZ
         hN6OLDpJj3YUqYDLVvZgrdKRdhH0t7JCayEN9nLbphq5ALHSU68D2o4NF64HdO3GZpdd
         1ODmc89wuwt6HBYVfXgzrH5AgMSnY0R8c2BOAsQ9ws6AZL95ZkOOm5wGRHmKoObQEG8H
         /dGw==
X-Gm-Message-State: AGi0PubkeKvpZEj2fBXnKFNItldVXiqOIRTH7bJrMyUQ3SxmlN8760IP
        mD4p4EOV/vzbdEWtoo5J51Z8drI1Asx0FKGS
X-Google-Smtp-Source: APiQypIwfoYwi1fH88HLIciOEZsXl0lOuoY0ylnOHLNtCKe5ewazcN2I9jXlqNbgs8DybvDDMV/4xg==
X-Received: by 2002:a17:90a:ad93:: with SMTP id s19mr26160781pjq.73.1589264238826;
        Mon, 11 May 2020 23:17:18 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id m14sm9660554pgk.56.2020.05.11.23.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:17:18 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 3/3] ALSA: hda/realtek: Enable headset mic of ASUS UX581LV with ALC295
Date:   Tue, 12 May 2020 14:15:28 +0800
Message-Id: <20200512061525.133985-3-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512061525.133985-1-jian-hong@endlessm.com>
References: <20200512061525.133985-1-jian-hong@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX581LV laptop's audio (1043:19e1) with ALC295 can't detect the
headset microphone until ALC295_FIXUP_ASUS_MIC_NO_PRESENCE quirk
applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dcb97b39be6e..36832645de78 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7393,6 +7393,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x18b1, "Asus MJ401TA", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
+	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
-- 
2.26.2

