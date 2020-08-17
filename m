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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD64C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F190420758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihyd3IRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgHQI6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgHQI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:58:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E6DC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so7494516pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82iyXT6DzTJGk80q+wM5oW6Nfvht/wMpYLWFiVAtXjo=;
        b=ihyd3IRTDQ2sNWvyGa48ej4ZTH5YFMTLLhjYx2kl5gFT+X/RNcDRvczG7Fv0Yt5XHd
         UhXaxJXJB3ZwAtjFDicTsBpasCmOZ4lxSVTDx42l2+qz4bLXhj8i3joztKz0oOR7nMox
         ZKMKH5IooVM1s0wcKgvBIiLNW+5PCSTlFwDhhO1fU2kc/1q9iYoK5H7FXvoRYquf1U+Q
         4csT4c+hEqMna877Fuo9FwQk6fO63aqWNuqPBXv4TFMQKMcz9MGV193UZpnv6g74OuMd
         5Nl1Pp/E0yAr9yIJzUVzt01sDnj3BXgxXNZ+wrNOqUqNixAAvQdzJBCNNwvDcg9e4s24
         qB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82iyXT6DzTJGk80q+wM5oW6Nfvht/wMpYLWFiVAtXjo=;
        b=VWeRpkUqPHVMpA0+vzdqfM6D4II3vlyZYMZ3JgkgtN6veFg2/5jcDLRXg57xfmBsmb
         V1W8K4I4idZMM1+3dgjoiO9HPXrhfU8O2kF7IhbTKJhUrMq6OWVmcC8EfOCCff0RIq/3
         h9cv19gCEMNok+rvrynPmO9il3aQfHHUEfmTXMj8Wr0LZKrAm1WMmAHGYRqfqf1guBeN
         gxUgyKCnaEbJb4HxxTDTpef+J2Clj4+hAfM79nzyvYUlO3O+iyrYCrUiIBFEMZU+89Xe
         zD8LxvCseHtusI21fsr6s+vVFQZx8VcgphD3U77sdr/wFb1fO1Jp1doQ89qpGX6/r1y1
         W7Fg==
X-Gm-Message-State: AOAM533cvuFGkfPx7OQwwRpaeaZIfccn5BtmkfnOOSQPaMJG16jCEMQ1
        es6yY9kdVxhnLEQNEBmPl8s=
X-Google-Smtp-Source: ABdhPJwmOQdDa+LVIgCsVYsGqUOJh7huV7BDongW+Nmhyb70or57kdsFY11/0oKkwXHZEeyX/z3a4g==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr8357466pjt.124.1597654692036;
        Mon, 17 Aug 2020 01:58:12 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:58:11 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 10/10] sound: ua101: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:27:03 +0530
Message-Id: <20200817085703.25732-11-allen.cryptic@gmail.com>
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
 sound/usb/misc/ua101.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/misc/ua101.c b/sound/usb/misc/ua101.c
index 884e740a785c..3b2dce1043f5 100644
--- a/sound/usb/misc/ua101.c
+++ b/sound/usb/misc/ua101.c
@@ -247,9 +247,9 @@ static inline void add_with_wraparound(struct ua101 *ua,
 		*value -= ua->playback.queue_length;
 }
 
-static void playback_tasklet(unsigned long data)
+static void playback_tasklet(struct tasklet_struct *t)
 {
-	struct ua101 *ua = (void *)data;
+	struct ua101 *ua = from_tasklet(ua, t, playback_tasklet);
 	unsigned long flags;
 	unsigned int frames;
 	struct ua101_urb *urb;
@@ -1218,8 +1218,7 @@ static int ua101_probe(struct usb_interface *interface,
 	spin_lock_init(&ua->lock);
 	mutex_init(&ua->mutex);
 	INIT_LIST_HEAD(&ua->ready_playback_urbs);
-	tasklet_init(&ua->playback_tasklet,
-		     playback_tasklet, (unsigned long)ua);
+	tasklet_setup(&ua->playback_tasklet, playback_tasklet);
 	init_waitqueue_head(&ua->alsa_capture_wait);
 	init_waitqueue_head(&ua->rate_feedback_wait);
 	init_waitqueue_head(&ua->alsa_playback_wait);
-- 
2.17.1

