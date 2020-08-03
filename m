Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AA8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AF42070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZnPYnbh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgHCA3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHCA3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:29:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD0EC06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 17:29:38 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b14so32107192qkn.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbEGrIvZnD3c5e9YLVsP9l3cXHWv/XnjtutRuXBXv2Y=;
        b=kZnPYnbhyn4b0RUOJvuHY816xQkFRnbusqzvbEsBIywM9J6tMQozU+auwAFsgXDvkW
         Z1wwjHkEnsQ+4AsmYEntMY5HsJOlgTr9m0ydGIyzN75pVl8+pb1vrEqS8UXVQ2Z1mylf
         ouYo5TDRvGc756JR+azL7yqDiducTqb09NP0iMusiEvjxXJiWULAqu0IUHlj9uPgvUvM
         4ydmKFZVIa7dx1Mjo1SUSaf60MlZr6XdsNGUmdDnKNaD5egsl4CFQHFBPA9XFzaK963j
         nD/hLuKov+eaD1QySN9G6TophreFTJYELd5bTMbwl3I0VrV0I8sxI1lsD0MSsvB+YXof
         hU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbEGrIvZnD3c5e9YLVsP9l3cXHWv/XnjtutRuXBXv2Y=;
        b=Hozmysz+TuGodDUKjTxuBxvyKb++68QOfVeLmJUVsIGjtRvuCy9bOl/dVSjxH1eoXv
         RAVzGvwem6DYla9RgCJaO1agTI3Ptwd04y+Ed3r8lR6XafIMiQxKKZqfR2pGC1dRXLO6
         FezOlIokFGefeJte/5NnMheAh8u6kMirENvpmrfNRkf+XSZHMHg4sYpFsGIhrMa9h9Sb
         jZc0tOMQKUUyWb0tf6Og3j9V22yw8627PZJ6MgASfAG8/S64booAWVgJXP7vobnYzcnc
         6PkpfizIEEMTGLtSGsLY5w0n7VdgXl+3fazkTxg3xP2f+GM4gdQIsirusqEQ7GwYS/fl
         ReOQ==
X-Gm-Message-State: AOAM5314ahDQPybVzwghOVoNj+Rohb3+j4NsZ4PB8wTP9vTifP+4HrNn
        HUy+8Hv6gMuLUI9mL4FnQRv4fRM7
X-Google-Smtp-Source: ABdhPJxT/YVhLXF97DW1ZpYjJmuQrmDDCsUH8rSWcK8mvU3A1R/Ju0jerejM4AM0S2Rt2IdmmQ8Mpw==
X-Received: by 2002:a05:620a:4d9:: with SMTP id 25mr13611430qks.411.1596414577758;
        Sun, 02 Aug 2020 17:29:37 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id e23sm18261614qto.15.2020.08.02.17.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 17:29:37 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Geoffrey Allott <geoffrey@allott.email>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ALSA: hda/ca0132 - Add new quirk ID for Recon3D.
Date:   Sun,  2 Aug 2020 20:29:26 -0400
Message-Id: <20200803002928.8638-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200803002928.8638-1-conmanx360@gmail.com>
References: <20200803002928.8638-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new quirk ID for the Recon3D, as tested by me.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 2cbe01d59c16..40fa9d82ef95 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1182,6 +1182,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x3842, 0x1038, "EVGA X99 Classified", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
+	SND_PCI_QUIRK(0x1102, 0x0018, "Recon3D", QUIRK_R3D),
 	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
 	{}
 };
-- 
2.20.1

