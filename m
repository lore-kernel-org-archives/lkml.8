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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE0206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6IDOwP5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgHQI6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgHQI6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:58:03 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA48EC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:03 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so7163658plz.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jl7zq958bvyphHRDKv4nNAmR0zSknfotUpyL6Tf/wt8=;
        b=P6IDOwP5JjvvGriwph12LdSiIuRxpIgAmAdMDNUOEdE3wlgtHweKJoc7ASfqWWFbOV
         1SCY05N0lES3ftWwuw0qEvw3kHzrei9IGR7fosnwng703pUgzzIvRYsyvraiJ/VaIpMA
         k71+8G+uSed3hr9W9FQlwtv/jvRlQi8TYx3lq5goJm6mW5TbZcyp5ew06Vj/0R+oHH0H
         wL3aGoRxbVBtWnNo0LqEQPeBeLQWUXCHOBaGbAtDhANFy802MUStNt5AsT9vr7qMCxWB
         rjEbhj3ixZnzZHJBpeZN7wkoHdNNxSDUNewjoQhY19JIehAGVzC27UkcvmMgIB59PGjG
         s35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jl7zq958bvyphHRDKv4nNAmR0zSknfotUpyL6Tf/wt8=;
        b=FANEE5RfKVK84qetvBXhh4v6ZBykimT8moYGnSlDTe8v2vjdmDQOH952CMupi3PiL6
         5L8IlbavUmt6My2uzzaXcvad7HCMHt9upvFSNRH5W9S0eKmJYYs+6fT8P+3DBw438+jq
         jsTzvBZ+fJM0CedDsNUcj/+Ex2h9lQuTsrzSToGTFczCFdeKVIPthdW32BgPEGtB9AHN
         //f+hTGHKhYbX+YARb6SEHJJ7W+8Yu//90GvSAPWq8ca67aoqirOhkovo4HB84o1p3Lj
         0sr5JpxCrV5MOqQM6Nl59YeGdN/fdSw0GJRPc51G8s8+Mp0yrYee0yw2oMc1Gk7zatXo
         ktOg==
X-Gm-Message-State: AOAM5309U3XRS7Cz/gX0uzKAmh2UF6gu9HQloaukcCTN7Vb1RQQA8hbw
        RZIXMOLsEcgfy0LpO9Ryk/s=
X-Google-Smtp-Source: ABdhPJzq+K7CR467KRQ31me/jHavVenQGpsdx8Y2B5GP1GWBoaBp3308lEe+K8lDR2l6eP6TZaJOjA==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr10509100pjs.137.1597654683313;
        Mon, 17 Aug 2020 01:58:03 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:58:02 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 08/10] sound/soc: txx9: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:27:01 +0530
Message-Id: <20200817085703.25732-9-allen.cryptic@gmail.com>
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
 sound/soc/txx9/txx9aclc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/txx9/txx9aclc.c b/sound/soc/txx9/txx9aclc.c
index 4b1cd4da3e36..939b33ec39f5 100644
--- a/sound/soc/txx9/txx9aclc.c
+++ b/sound/soc/txx9/txx9aclc.c
@@ -134,9 +134,9 @@ txx9aclc_dma_submit(struct txx9aclc_dmadata *dmadata, dma_addr_t buf_dma_addr)
 
 #define NR_DMA_CHAIN		2
 
-static void txx9aclc_dma_tasklet(unsigned long data)
+static void txx9aclc_dma_tasklet(struct tasklet_struct *t)
 {
-	struct txx9aclc_dmadata *dmadata = (struct txx9aclc_dmadata *)data;
+	struct txx9aclc_dmadata *dmadata = from_tasklet(dmadata, t, tasklet);
 	struct dma_chan *chan = dmadata->dma_chan;
 	struct dma_async_tx_descriptor *desc;
 	struct snd_pcm_substream *substream = dmadata->substream;
@@ -352,8 +352,7 @@ static int txx9aclc_dma_init(struct txx9aclc_soc_device *dev,
 			"playback" : "capture");
 		return -EBUSY;
 	}
-	tasklet_init(&dmadata->tasklet, txx9aclc_dma_tasklet,
-		     (unsigned long)dmadata);
+	tasklet_setup(&dmadata->tasklet, txx9aclc_dma_tasklet);
 	return 0;
 }
 
-- 
2.17.1

