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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F0FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B0620758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAqvBoa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHQI5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHQI5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:35 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897C1C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s15so7796915pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ir2EUoXSC9UiT6j30BKzwTi2avjOse2gHmZ0bVuRLw=;
        b=QAqvBoa/dd6F4tETAI6u/nDKz/8vA4EoePLKL2jn8cWNCqTVZrYl40CYqJxWTcf+eH
         ruK1J6R7QGdhsuqcJisS4p1gaDyPL/E5YLmfLh4tTdGhUmDWoUx+iH0koSkUGUQXliO7
         2JCpmXvCn5GzZPEKehV89mhI9YhIgsKxPYCzx0sEZdZFgiJvmspJz6zSMpHviaIGekwJ
         1z8BTY5fdbhG0uMJgtP8lqMAWPG/KEBRDetYK87jDM6OGa5X6bN2ruy4ecHjDY2vFviz
         XLsP4x+jKhVxq0vODvOPtstM1fIX6fFJxk0zucKQXdSgLhefDyQlIGj7mM8phP46n4ur
         aMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ir2EUoXSC9UiT6j30BKzwTi2avjOse2gHmZ0bVuRLw=;
        b=jA/fXmUbsgH2jm6IlqdbwnokJsLTCTHHzsyRn0Im+2OZyNzi7lvSwpAXzHdH2ZixHq
         3SSxLkb4h7T1qGv4wuOgOuQiMp58yeLBOMDnFNAUL8gsrxIhwXA1t/ARsFcO1iVu85gH
         +wtba84NTxgTkCuhi7zj39wP2HSVLOEfxw3OtX4+WpcH9LmlYijeS1Ynt3Dfuo5caDCR
         7kW1CX/zGJdPIMP/sOrxsvaTYDLCWsqapx0FY7bIDkuZ+g4Nb+3T2p0VjTc7E6dymkRW
         UAZudcrNe1p9lfZCdlIvNE/WH4gzZPqQgaSwzQIaPU4O5LaenR0zP+CIUSu/eDTqjhnN
         g0uA==
X-Gm-Message-State: AOAM531DZDn69tTxkBK84lJ29ayMaKlBOW+22b/HrsHUgyfSsdwfffSy
        wYu24KJGdqLD+iD/5nGel1I=
X-Google-Smtp-Source: ABdhPJzGb3DXb0HExdoQilfc10prLDt115mewJJXkDS4HvxKOzPFoSgMOQt2dPqyE+lXYYhpi5FbKw==
X-Received: by 2002:a63:6dc2:: with SMTP id i185mr9441882pgc.190.1597654654967;
        Mon, 17 Aug 2020 01:57:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:34 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 04/10] sound: riptide: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:57 +0530
Message-Id: <20200817085703.25732-5-allen.cryptic@gmail.com>
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
 sound/pci/riptide/riptide.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index b4f300281822..098c69b3b7aa 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -1070,9 +1070,9 @@ getmixer(struct cmdif *cif, short num, unsigned short *rval,
 	return 0;
 }
 
-static void riptide_handleirq(unsigned long dev_id)
+static void riptide_handleirq(struct tasklet_struct *t)
 {
-	struct snd_riptide *chip = (void *)dev_id;
+	struct snd_riptide *chip = from_tasklet(chip, t, riptide_tq);
 	struct cmdif *cif = chip->cif;
 	struct snd_pcm_substream *substream[PLAYBACK_SUBSTREAMS + 1];
 	struct snd_pcm_runtime *runtime;
@@ -1843,7 +1843,7 @@ snd_riptide_create(struct snd_card *card, struct pci_dev *pci,
 	chip->received_irqs = 0;
 	chip->handled_irqs = 0;
 	chip->cif = NULL;
-	tasklet_init(&chip->riptide_tq, riptide_handleirq, (unsigned long)chip);
+	tasklet_setup(&chip->riptide_tq, riptide_handleirq);
 
 	if ((chip->res_port =
 	     request_region(chip->port, 64, "RIPTIDE")) == NULL) {
-- 
2.17.1

