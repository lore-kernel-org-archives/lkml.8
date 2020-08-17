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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B351FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E511206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyNFTefB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHQI6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgHQI57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:59 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B691C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:59 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so7489544pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=upmEUnhhDdxgVkgtOGQcHXFVgTj9nyWc06FqARMGISM=;
        b=OyNFTefB9dsBDrJk4+b3/O9xDgCkBGYAZEtl8e1sFe8eqB+0z37g1bXuaGh5Rz/mOV
         Vu9xGEY1MYjz55jhlzbwsAahCtRbdTz3TmGBn7sQxztPqM7rTG+RzjI3Oiny8RejrZuR
         CcmoL/IjRiGZ+ssZ2n0xgb+pW4Z6Lea77AxG5cveoSTlnxxqUI7fbOJagqytds6FoNFo
         1itqsHARb9BlloVmjtqZv2KTHfwoy66YYWvv6YpBzgnvUwBIky4PzzfF4Ms719j3PL/i
         QUcVdpfYvYncsl7g9tvyZcNhfOVL8zhRmQ4Bm1y4PBi86/ARuEB3MdIQHbhmEwr5gUVt
         g9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=upmEUnhhDdxgVkgtOGQcHXFVgTj9nyWc06FqARMGISM=;
        b=qnehKiFfIWF4quC9zSmYW0fOSRbnG3OjXu456OnzuYn33PK0VndwF/7CPuAvV8+F6y
         j8pbH4BeaZp3iBo26ofppcjWs1Bhqwcf4bfN4YlkdPGQ32+awbnwlUSJmaZuPXVnLf4Y
         bWCNZ9TaivPDmjPUOH46Mf6hK3bCcCG65a4rJQNvjWIhLXN0x1R5LBnXkQG+i599ung5
         OZJ4UNLSIW66PbCmIG7o3T/hpMrR2wJbFwgSLk6GBH9AgCW5+XmcxLsW6LVvju4aZOOl
         X7lcGz35ZEXO/+pS66EFXDkhtxpwZdvfuS02op0KCZyhOiWIfP8dVs4fpq1Oz5Au8+aC
         JmvA==
X-Gm-Message-State: AOAM531jx7yuX4ZCwDqOZbOAIa4xToOpa5hDcPkiEfMA2OziArsdN7v6
        cpXU6WMjjGcOVYOjNHI/fnE=
X-Google-Smtp-Source: ABdhPJy7woL4CHSE/M6HLZYby07kKJL7B6uvdb2M5oCEkFLXCvckJ3TLTnOJ9pzsBst4THF5+GoOoQ==
X-Received: by 2002:a17:902:ee02:: with SMTP id z2mr10362445plb.291.1597654679016;
        Mon, 17 Aug 2020 01:57:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:58 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 07/10] sound/soc: sh: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:27:00 +0530
Message-Id: <20200817085703.25732-8-allen.cryptic@gmail.com>
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
 sound/soc/sh/siu_pcm.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index bd9de77c35f3..50fc7810723e 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -198,9 +198,9 @@ static int siu_pcm_rd_set(struct siu_port *port_info,
 	return 0;
 }
 
-static void siu_io_tasklet(unsigned long data)
+static void siu_io_tasklet(struct tasklet_struct *t)
 {
-	struct siu_stream *siu_stream = (struct siu_stream *)data;
+	struct siu_stream *siu_stream = from_tasklet(siu_stream, t, tasklet);
 	struct snd_pcm_substream *substream = siu_stream->substream;
 	struct device *dev = substream->pcm->card->dev;
 	struct snd_pcm_runtime *rt = substream->runtime;
@@ -520,10 +520,8 @@ static int siu_pcm_new(struct snd_soc_component *component,
 		(*port_info)->pcm = pcm;
 
 		/* IO tasklets */
-		tasklet_init(&(*port_info)->playback.tasklet, siu_io_tasklet,
-			     (unsigned long)&(*port_info)->playback);
-		tasklet_init(&(*port_info)->capture.tasklet, siu_io_tasklet,
-			     (unsigned long)&(*port_info)->capture);
+		tasklet_setup(&(*port_info)->playback.tasklet, siu_io_tasklet);
+		tasklet_setup(&(*port_info)->capture.tasklet, siu_io_tasklet);
 	}
 
 	dev_info(card->dev, "SuperH SIU driver initialized.\n");
-- 
2.17.1

