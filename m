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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F89BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517E82070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 00:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhHemzLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHCA3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 20:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgHCA3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 20:29:36 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78554C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 17:29:36 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 6so27149295qtt.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 17:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6DcF2CQ32e+6T5/Eij0S3nNKEWsEJxFYAl3hAL1skHs=;
        b=UhHemzLkoLwi0a/DM7/+VsmtHjz3MNMEYycZRp61AOazxWaPvS9SmhweW3Pg5ViAU8
         2N/Yx5bfETvcDv7rlczF4Xoev+qzCy0eglCrf2VSh9p0HP9xrJSr/ycImcV9WWcmNo3b
         q7/ZuaPAkT+qQbcN7uLHlN2y+kv3ub/cXajqPwLVNik5USqtvmsfrilx+ZdGrIwUht/y
         oW9oXn2Rmy2UdIkyTZTSApuej4wi+0t8c93vNrB3PMk45TsxOnHJtGuE6mBrFXKCG7Jv
         9UmFXZqttvwCQF2cpHdmpSgZW2CuN4bEnbfoW3AAHaNXOsbHS3KJ7B7z/CnVD1FflgHe
         DjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6DcF2CQ32e+6T5/Eij0S3nNKEWsEJxFYAl3hAL1skHs=;
        b=fLLuZDhdjDOzhuAg8UBKQlXyV3os9YkRz1DnVbMFyr9wS7To8AxCg0Wqsf3m1XkL7F
         7OVx9CMkEkD3ebCxabrPcLZ06Tk30LSSRrI0RDJR8WplPArQge8xlEyH0ZGltxLrz39q
         iWk5iZ1lc59ox1VYrcuJ36+3leSaNY/+xtIM9kZOby4dZP2/Cl5XDF483RddZrz1W7Dx
         tVWXKRHNk3bcOEY3clU2k1ie69j3fyIF19fXexNSt0JOy3/zbpA9PG6W0IrepQvE4Qzl
         aYVQ5Ru3HzToSH2nMJLX1M2lEyyiURrP4JBaLSDbxVOZvFWhu8IejrDkEjC83jaDm7zZ
         0TJw==
X-Gm-Message-State: AOAM530wGwCVC8S+QN9VsJYda57hY0trKN0iEDA1a9qYg1vj63vWrF7J
        qbVAoVuc4WrQ3TrhdtWMrrk=
X-Google-Smtp-Source: ABdhPJxdbpufdzGT1QAY4uOYq5MtdXAGk9PrJwux/EjOnuLwxvNY6TW1aPj7cLO6DV4Lh8bggdUJBA==
X-Received: by 2002:ac8:678b:: with SMTP id b11mr14547229qtp.386.1596414575650;
        Sun, 02 Aug 2020 17:29:35 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id e23sm18261614qto.15.2020.08.02.17.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 17:29:35 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Geoffrey Allott <geoffrey@allott.email>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ALSA: hda/ca0132 - Fix ZxR Headphone gain control get value.
Date:   Sun,  2 Aug 2020 20:29:25 -0400
Message-Id: <20200803002928.8638-1-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ZxR headphone gain control was added, the ca0132_switch_get
function was not updated, which meant that the changes to the control
state were not saved when entering/exiting alsamixer.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 19c575fd28a1..2cbe01d59c16 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5748,6 +5748,11 @@ static int ca0132_switch_get(struct snd_kcontrol *kcontrol,
 		return 0;
 	}
 
+	if (nid == ZXR_HEADPHONE_GAIN) {
+		*valp = spec->zxr_gain_set;
+		return 0;
+	}
+
 	return 0;
 }
 
-- 
2.20.1

