Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE902C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4C520758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTaQvUr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgHQI5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHQI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:27 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E209EC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id c6so7495631pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Th97jQWizU+MR3H8KsmSgYMMcn/Wb6U+3t12llCRyTA=;
        b=MTaQvUr+9I4xHzCOKxRhJIanXnw2ADB+kr39T+fF3C6zzpdo9HLs+qL1IBLzK3SWKB
         kFHMeMi42mIMhCMgjlyKh1EueKFLpcVlc8KJaH9AsB2CgfbL8z1QOikA4G/51O3uLe77
         DBNBkRaC4c9aHaiHeJRkntRZzD6pcFUC4LRM0rBw9zBPm9uYhdb+O+8U/f3j32qtI0ni
         jvm1avJSfp92oDURGAVXZ7Ca2+81BpCwthDzlFy+8XwoIPTqoj0wjs9XosDd8C3xwMjg
         Hl1KkmqbTOv/c8leI+BpaR/Yf26jJfnLHHYd9+Vvmj7bzbmoK6NGqZopyx27BtqEJESx
         Z2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Th97jQWizU+MR3H8KsmSgYMMcn/Wb6U+3t12llCRyTA=;
        b=mme1b8nV6bLqxqkD7F/bkwOreOsa/XqUhzrVMFfU6nrm4/CE5q2W2KLEDf6pHNMLMF
         pGq3MIvuJHB1Y4tmcFab2sSaM/R7rHAMW6FyS9ku+cP80pSTiy6OZUrBWE4vumsNznQM
         PSA8dQTaP7EkfCRYKs+yvBTZ9/lsonT6wVzctGZ+vXebIvXjGAeMztB7HjHDhmPo+NcM
         kADBi2isHs24m6H1joODy3gsFg1qEYruB7dlULpZ8DvNT9wMMZO9ztcryZFzBWwIgn40
         8cK1we8eqW32fVhiXQjBfi5hsCxTcySPLXJDWawzsHkZMkZh+cFJ9vJvgL3USsidwVTZ
         jgGg==
X-Gm-Message-State: AOAM531HX+jJ7DEKcCdO1YummiQ1G0uFMmn26LG0Zqcao/eLDYYsZpIY
        yK1eSk9E5PBLLOA8CwzaD7c=
X-Google-Smtp-Source: ABdhPJw65ZcmjWOmkFF4uogzLH35eLQ8onzgQaFSgowQsSRLWB/e35uC7LQ7y1Dc63+SWTav/W5nlA==
X-Received: by 2002:a17:902:323:: with SMTP id 32mr2946718pld.59.1597654646463;
        Mon, 17 Aug 2020 01:57:26 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:25 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 02/10] sound: firewire: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:55 +0530
Message-Id: <20200817085703.25732-3-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817085703.25732-1-allen.cryptic@gmail.com>
References: <20200817085703.25732-1-allen.cryptic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 sound/firewire/amdtp-stream.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/firewire/amdtp-stream.c b/sound/firewire/amdtp-stream.c
index f8586f75441d..ee1c428b1fd3 100644
--- a/sound/firewire/amdtp-stream.c
+++ b/sound/firewire/amdtp-stream.c
@@ -64,7 +64,7 @@
 #define IT_PKT_HEADER_SIZE_CIP		8 // For 2 CIP header.
 #define IT_PKT_HEADER_SIZE_NO_CIP	0 // Nothing.
 
-static void pcm_period_tasklet(unsigned long data);
+static void pcm_period_tasklet(struct tasklet_struct *t);
 
 /**
  * amdtp_stream_init - initialize an AMDTP stream structure
@@ -94,7 +94,7 @@ int amdtp_stream_init(struct amdtp_stream *s, struct fw_unit *unit,
 	s->flags = flags;
 	s->context = ERR_PTR(-1);
 	mutex_init(&s->mutex);
-	tasklet_init(&s->period_tasklet, pcm_period_tasklet, (unsigned long)s);
+	tasklet_setup(&s->period_tasklet, pcm_period_tasklet);
 	s->packet_index = 0;
 
 	init_waitqueue_head(&s->callback_wait);
@@ -441,9 +441,9 @@ static void update_pcm_pointers(struct amdtp_stream *s,
 	}
 }
 
-static void pcm_period_tasklet(unsigned long data)
+static void pcm_period_tasklet(struct tasklet_struct *t)
 {
-	struct amdtp_stream *s = (void *)data;
+	struct amdtp_stream *s = from_tasklet(s, t, period_tasklet);
 	struct snd_pcm_substream *pcm = READ_ONCE(s->pcm);
 
 	if (pcm)
-- 
2.17.1

