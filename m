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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6489C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9439A207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eU8dWmKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgHQI50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHQI5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:22 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE3C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:22 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so7162874plz.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t7X4N8pkN3GNmV8aMvjwf42XjKAkvV3xHvRmpPGyZyk=;
        b=eU8dWmKLLv5YTw4tvFvIiBL3Y1IkcJaBGGLUE54vTrcpDfTbismq7GDbmVP1OSDwSu
         TaGr1/B/34snw/Aqar9BeYatdu4L0OFKOM+gpH5kJ7Yq1EJ9pKbAQ0RV0RcwFfJldm+V
         g1PkmbwNpM0cfFbKTQLWgqStuCuhmGLakGOMCuSQURnwSI+d6iQFwg0NIhaOCqxtc43A
         jaZrSY4rFCFm6a1mUQpcNzrtnwO/ZhFTwEG9P9iMcrHKSfjgrG1g183hajzTP4gOHtjc
         XJraSp0qqdj5OPlXXp/hZre3PcGFgLS0V/5pIUsQ0BC7wfLM7uQqZoRi59mBhkpcs+b0
         5hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t7X4N8pkN3GNmV8aMvjwf42XjKAkvV3xHvRmpPGyZyk=;
        b=As9htKETuM4qb3os/Uhl+ovqYOZX4O5vrcrhIU+DJBgU2croLiFvu9qu5M67UpG9aH
         5vpWC3Ui2oh2wSB3I/JHbgu2cGXNTwnfp+plcNCDcNsJ6zwz1qam/j33wv1cgJeVTvdj
         YhJ25hfFfhAeG7rQx7wVGXruKD0YpMF+dMTRbiNzpBayEygUNrVRIaUHClUGb3djJ52x
         E676ji7VE/+wTHuDro0Cj3MoioX1xvNHrpsAAAvVD3K9h8WK+KjORjmDJbDJHiK1UXB9
         IexZs0+cwoof/cmiumXrGpL7YunEzYYpqO2PBDlYBk53cfxcHRUvmjlT/avoCX1XZftz
         i0mQ==
X-Gm-Message-State: AOAM533yj/jsPSIOyhdf+VxKilBZqj/UZdan5rBRRoZXqFD8EC8p/3V6
        Gqp/ZNVI0+jcQSKhcuSEgpc=
X-Google-Smtp-Source: ABdhPJwP/IQJZ8mysCiHhZ16IDovHskbje8iA1sUnZbb8zig7yuonzpg7I5LA8g+e5ygnIfnJT9yUg==
X-Received: by 2002:a17:90a:6d26:: with SMTP id z35mr11434456pjj.164.1597654642315;
        Mon, 17 Aug 2020 01:57:22 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:21 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 01/10] sound: core: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:54 +0530
Message-Id: <20200817085703.25732-2-allen.cryptic@gmail.com>
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
 sound/core/timer.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index d9f85f2d66a3..6e27d87b18ed 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -816,9 +816,9 @@ static void snd_timer_clear_callbacks(struct snd_timer *timer,
  * timer tasklet
  *
  */
-static void snd_timer_tasklet(unsigned long arg)
+static void snd_timer_tasklet(struct tasklet_struct *t)
 {
-	struct snd_timer *timer = (struct snd_timer *) arg;
+	struct snd_timer *timer = from_tasklet(timer, t, task_queue);
 	unsigned long flags;
 
 	if (timer->card && timer->card->shutdown) {
@@ -967,8 +967,7 @@ int snd_timer_new(struct snd_card *card, char *id, struct snd_timer_id *tid,
 	INIT_LIST_HEAD(&timer->ack_list_head);
 	INIT_LIST_HEAD(&timer->sack_list_head);
 	spin_lock_init(&timer->lock);
-	tasklet_init(&timer->task_queue, snd_timer_tasklet,
-		     (unsigned long)timer);
+	tasklet_setup(&timer->task_queue, snd_timer_tasklet);
 	timer->max_instances = 1000; /* default limit per timer */
 	if (card != NULL) {
 		timer->module = card->module;
-- 
2.17.1

