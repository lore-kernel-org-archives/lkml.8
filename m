Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1396C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C4A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNLeaYTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgHYULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgHYULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9738EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so10044590qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7joicHzwupdYBnuFsGJaO4mRul/OCWauur3CmqWFnlc=;
        b=gNLeaYTRkbkiGNwcpJ/dLe+Nu+nCW7Kp//N3Eue87gEpNJNAmbBPDmVTQZh0mxzkZa
         sb/8GQ41ja4dRa6OLkCHFGRpYljQdQR4ksG5DAvvUrweW+mDtA0T6jczrWZNTK1iV4/F
         GMyZwOIHhNB4lOonbVb6s499AFHFJfwyPsRsu0jH95zI5rvR1oJ6zxxnxjuqN9UcAmVe
         FqKCQMGcr34ZW2Quxzg6NFSnWZihVtXOjN2ug91xQ7Onr+ZZEuMUlsrqPASuKbcd3smW
         G48NEGaKR2PpfouzbIp8tSXfoJi/W2Zu7QquqcX8gRT2l0jqimI8vIH99bSGKJkivS5a
         KfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7joicHzwupdYBnuFsGJaO4mRul/OCWauur3CmqWFnlc=;
        b=Vr+6kk8eS6NJnNj6oRDbrO2tsHDnuTSqshW39vBzOvRUAq6zzzIIkrx0F0vTTYYvW1
         CYv/qzH6CaOAtUqisXuo5BcV/mnv38FPXjbaSxM7R6W7zgj2uRfgbdrLdGV6X04+LeP9
         CmLK9Wk+Ir70qEChd4tKJshTAsUQboU4vAVwjJmGXk0Z1VtyyjbnrQB95c8R6MGcy6y0
         wrPe1ax7TfljZha1BFJRdT8YRi6ZRdR1g8sMZLEcUCoWT8UdoMvCRHkHrft6vxWaYyE6
         cGwKKOvItFZPsCpVcoVi3Toh4NKVxPFHVdgLJF0xFpumhiM8qf9mZ9Ke8tPJoU2k8lBI
         ZlFg==
X-Gm-Message-State: AOAM5302EWLXoeH+fFlkElwBO6xIIL/OchbiJiitaOjl+T4mvSmEYKvc
        y2gqiqPenwnZgVCqw/Dqe1U=
X-Google-Smtp-Source: ABdhPJwPdoVRrJGRGUCyc1XJ80M70LBeUzfXqDK2XWbHzhrVHb5ZRn3WvirC2StImSW8jmoBgNxKmw==
X-Received: by 2002:ac8:7774:: with SMTP id h20mr10585454qtu.331.1598386278755;
        Tue, 25 Aug 2020 13:11:18 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:18 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/20] ALSA: hda/ca0132 - Add new quirk ID for SoundBlaster AE-7.
Date:   Tue, 25 Aug 2020 16:10:29 -0400
Message-Id: <20200825201040.30339-11-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825201040.30339-1-conmanx360@gmail.com>
References: <20200825201040.30339-1-conmanx360@gmail.com>
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
index 138403fd1639..284f63dc2749 100644
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

