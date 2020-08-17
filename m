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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEAE1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E5C206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M37L93SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgHQI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgHQI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:58:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B9C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u10so7170561plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KccEtbXa6IlqeauaaaE7AIR0JNzfFLmA4P8zWKeg1Pc=;
        b=M37L93SCLVOuNTd2R9Itm92ayKxRQN2wHX1NMFvm06ygZB2w44PlvNXwkJzimpR6iB
         2lXAZrOUVBZYUTzHKKHB25qNW2hykUMYhRfnT7q8KV7f7t8YxEzhRmbvf4l81mXIx4dw
         EPs6ufn++tfqVIgFjil8lKLw0yMOuqogI6PkT+GeHwVipcgtTdeVKXuM1PzVWiWcrfyL
         6zWKzlQDXSZDv347qZKC4pSOvNznLe5RkWVehvvaP0bFYCd2H02PiYftk+J6+iY3wrEa
         vfgyjW7cXLAdOZUKrSj2k0LyCFiN4QXhoyxES3u+AwweLjEaKnkftQ99c8vxeyjYjdEK
         609w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KccEtbXa6IlqeauaaaE7AIR0JNzfFLmA4P8zWKeg1Pc=;
        b=GsFPKiQfTIXZe1nSzkVMJba7eB/kLBBtryuqn2tCM/StMmXKiDjsCgf9qyP72sW7SE
         yiao2uM98jnJBcGlQe7ztfIkxBgc+lEISLr4sJgoJ6rvUET9Fdstv6KlET0qlA4AbXN8
         04akKMPmqnXogrBdajygDv7cdlqkv4psJzaZmRuKquItqAXRauFyY7QOmvMLB8/u0ngx
         5LgHLFYyeQMQuDOIXypBVFvEtOaEpa3TpP8TavnGpLwm86pkmZNjmc6834pezyqFnYMp
         0SU+T7kDbuDZZY/bdEj06q0PuQwq4RWvl3b8ERsvQ07z7MtVEsIfIgd0D4Vf3ZZBpB50
         04Fg==
X-Gm-Message-State: AOAM530uNsEAJ5xKwOHxBcBpZZXvirbGnByvP3ELkh9Cydu7EdYFcvsB
        HgorrHg3NHXLXJ44NFcS/ec=
X-Google-Smtp-Source: ABdhPJzg9Sul/hHo2S3e13LeNtREGnuHKJS0d3HSemC0SzTDZO8mUsRC3gx5jqtsol6tC19JN8YCqA==
X-Received: by 2002:a17:90b:1949:: with SMTP id nk9mr11123870pjb.185.1597654687567;
        Mon, 17 Aug 2020 01:58:07 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:58:07 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 09/10] sound: midi: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:27:02 +0530
Message-Id: <20200817085703.25732-10-allen.cryptic@gmail.com>
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
 sound/usb/midi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index df639fe03118..e8287a05e36b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -344,10 +344,9 @@ static void snd_usbmidi_do_output(struct snd_usb_midi_out_endpoint *ep)
 	spin_unlock_irqrestore(&ep->buffer_lock, flags);
 }
 
-static void snd_usbmidi_out_tasklet(unsigned long data)
+static void snd_usbmidi_out_tasklet(struct tasklet_struct *t)
 {
-	struct snd_usb_midi_out_endpoint *ep =
-		(struct snd_usb_midi_out_endpoint *) data;
+	struct snd_usb_midi_out_endpoint *ep = from_tasklet(ep, t, tasklet);
 
 	snd_usbmidi_do_output(ep);
 }
@@ -1441,7 +1440,7 @@ static int snd_usbmidi_out_endpoint_create(struct snd_usb_midi *umidi,
 	}
 
 	spin_lock_init(&ep->buffer_lock);
-	tasklet_init(&ep->tasklet, snd_usbmidi_out_tasklet, (unsigned long)ep);
+	tasklet_setup(&ep->tasklet, snd_usbmidi_out_tasklet);
 	init_waitqueue_head(&ep->drain_wait);
 
 	for (i = 0; i < 0x10; ++i)
-- 
2.17.1

