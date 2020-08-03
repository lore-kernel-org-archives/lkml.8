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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF77FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC54222B42
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvp68Air"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgHCA3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgHCA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:29:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62629C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 17:29:40 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so27126750qto.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 17:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oDXkHoga8CFpulGMHnQLHOpWkVkfgMDqur7ds2Dqg4=;
        b=fvp68AirKtIE2WPpmkrtNexNU0pqxp2MffHcgMRI2XMXiRkKwQuYw5unr3UXL4EHdy
         2mBFPAmQQkAo/IMKfKApD45Kayh0IVhwnAwyC7AaIYQnOAq9TtC17Zhdqicb8W52s3i3
         HGLs/GAmEeF5bOnj6X+McPcRSFrC4ava+Gqxw+NAt7igHx4q8IQvHbC2KypKeHGD/2LS
         xUcwBA83h/BlOWgtwae/LTeQTARl1/psQenlzhBqjthYQybprxzAKIpKx3haniNZkzRl
         V2jxUKrn8ciygpJ8NVenRQM2aOsjrQpcHgqOU7n5TT0GE+4GlcjLzPK5W/+gX5r9yla7
         L+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oDXkHoga8CFpulGMHnQLHOpWkVkfgMDqur7ds2Dqg4=;
        b=BQXbN9CXAIJrkNEXrbR5Aj1kobx4nwzRQbU+skxE6YMBcXTnobrrvry1qZEwmemiYf
         3xT5rNmFTd5X88JNUPISG+mun5QFl29PVJl19goxyxmGOpRXsH3nb+mnDtX9W9QJsvH0
         6kLC5Oq6h+hS1scHA+fCf8LHDDO+wpGLMm9coxsyiX73ya36utH10cxfQpJYZHO0uKMs
         aiNPGLh+yuFjSITQd+cdkHIx6E65JK8Q3dvvKWz/Mn8nYUytJIIaZpv1XteKIe2AgFgz
         UPDtsmptg/lLsChKwjDs9y5kvZk5fY79AKX44PPhhzfLoQBgGk6hjfspnmjNJras9UOe
         F0Jw==
X-Gm-Message-State: AOAM532VlubecZIckg+Vkovyf79FLQyhzCejzFzyb1+fEsip/ZHxwLD2
        dnLcnodpn+QuUOyCr+ou7pU=
X-Google-Smtp-Source: ABdhPJxwQn2dfQG1/MTaE6hRKRGHByyI7Dm6Ezh9RHnplL0UjufYiCFtdY0ZUgze0SuKx7ueRLZssQ==
X-Received: by 2002:ac8:710b:: with SMTP id z11mr14331167qto.64.1596414579713;
        Sun, 02 Aug 2020 17:29:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id e23sm18261614qto.15.2020.08.02.17.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 17:29:39 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ALSA: hda/ca0132 - Fix AE-5 microphone selection commands.
Date:   Sun,  2 Aug 2020 20:29:27 -0400
Message-Id: <20200803002928.8638-3-conmanx360@gmail.com>
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

The ca0113 command had the wrong group_id, 0x48 when it should've been
0x30. The front microphone selection should now work.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 40fa9d82ef95..b7dbf2e7f77a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4672,7 +4672,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			tmp = FLOAT_THREE;
 			break;
 		default:
@@ -4718,7 +4718,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			r3di_gpio_mic_set(codec, R3DI_REAR_MIC);
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x00);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
 			break;
 		default:
 			break;
@@ -4757,7 +4757,7 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 			tmp = FLOAT_ONE;
 			break;
 		case QUIRK_AE5:
-			ca0113_mmio_command_set(codec, 0x48, 0x28, 0x3f);
+			ca0113_mmio_command_set(codec, 0x30, 0x28, 0x3f);
 			tmp = FLOAT_THREE;
 			break;
 		default:
-- 
2.20.1

