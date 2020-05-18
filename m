Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E4DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A2F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 05:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeJwIO+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgERFke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 01:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERFke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 01:40:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C9CC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:40:32 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so10208135wra.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 22:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TUHyhh6MJuOq2jR9036y/hLL4Ej0HV3joFyYzx/cxo4=;
        b=IeJwIO+2G5Ycxw3ocwT3vCOhV+gDLcAUFQtq7g0kbVRUDAkLaBSH6FETH99/QqMHRW
         y+DYPgwkuViiHW5Ez8P+a8mwehTgKACMSmUedAJfG9D4UXCJXVt+o0/fiWGLSZ07mG6l
         ZBRs3RXbtwY8Cy7XAcLj1pgs27TEn22NmG+QAlcWjzUkR3MjAqoftAKknh0YNzPQUQPH
         VRLjPqKqVhVP27ubw+mVTstBwobfSqXUrxGKdjOaRMA2uI2FcRhs9XMbWYfCtiB7bVEB
         CrGAlCjFQ/ZNY0YpddSwwIT9exk6QeXb63mG3LqNhQDu1Ewf45sCx42L02vAshikeP0x
         qyFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUHyhh6MJuOq2jR9036y/hLL4Ej0HV3joFyYzx/cxo4=;
        b=UtYDbcFAQ/2GnaVXp3a0URY9RPiOBYsauYMENUy8w12LgF2lPvHahf1ZVYsYonOqIH
         NkahD479naep6WoMZcO9QSkZu6lUxpd/EC8mLby0HN6HOBu5hAz9ilm3DsZY43cIizzg
         u6WTwuEyEWdysUBIZIypt/e3V/kJoZrifOqlaFWYx5usQlIrJSFQ/5DH8gtV/up+3JY4
         jzeKjcNfeImVoGXangrYXzK78WfdHTW7zrwdPppVrx5j/im7wQ/JA3m6QXq4rcgtbdRc
         gg5oQQsMYz3g6gbrCZ+fvW/RPQPvdDW0gdfuWlK27EWlfPs22qn9nyhIv/HBYiOzN9Qt
         p0Jg==
X-Gm-Message-State: AOAM530DtE8r+N9mgMGeryFY6IpxnQ21ssw0vHHPPIYTsfZ1ngAYvH8O
        ZB1dkxsE0Ij4Ljzu1mIXXjo=
X-Google-Smtp-Source: ABdhPJzBrQMwY1/Ws5eGRxhrvXX9+vORDuCq6nY8qwiugbRjyTWPFS5eh8J0ERXIw2REI5mbJBnL2g==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr17121635wrv.209.1589780431096;
        Sun, 17 May 2020 22:40:31 -0700 (PDT)
Received: from cosmos.lan (84-114-134-91.cable.dynamic.surfer.at. [84.114.134.91])
        by smtp.gmail.com with ESMTPSA id q14sm15410069wrc.66.2020.05.17.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 22:40:30 -0700 (PDT)
From:   Christian Lachner <gladiac@gmail.com>
To:     patch@alsa-project.org
Cc:     alsa-devel@alsa-project.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, Christian Lachner <gladiac@gmail.com>
Subject: [PATCH 1/1] ALSA: hda/realtek - Fix silent output on Gigabyte X570 Aorus Xtreme
Date:   Mon, 18 May 2020 07:38:44 +0200
Message-Id: <20200518053844.42743-2-gladiac@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518053844.42743-1-gladiac@gmail.com>
References: <20200518053844.42743-1-gladiac@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Gigabyte X570 Aorus Xtreme motherboard with ALC1220 codec
requires a similar workaround for Clevo laptops to enforce the
DAC/mixer connection path. Set up a quirk entry for that.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205275
Signed-off-by: Christian Lachner <gladiac@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index dc2302171a71..23315b69ac38 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2457,6 +2457,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
 	SND_PCI_QUIRK(0x1458, 0xa0cd, "Gigabyte X570 Aorus Master", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1458, 0xa0ce, "Gigabyte X570 Aorus Xtreme", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1228, "MSI-GP63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1275, "MSI-GL63", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK(0x1462, 0x1276, "MSI-GL73", ALC1220_FIXUP_CLEVO_P950),
-- 
2.26.2

