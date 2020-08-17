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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56569C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A0820758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1cZQ4ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgHQI5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728562AbgHQI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:31 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF06C061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:31 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g15so3273298plj.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GYPUX223cEk7sfseKTxO6Wl2a86PZnTF5NOlEuFwhHI=;
        b=e1cZQ4ubmOyb/7m500QwlXNssWIHPs/Q6N0IXUiEuPicA0waQPM4rXDUgS7oGR1Qi5
         SxkjfKNWKAdDGf6wQs8A5OntcwIGD6wJ5R4FQSDrNtT46ITVL+EnIO0dBjRhPZ31NI+9
         xcBpGocniVNBTR3H6kqL1Om6YbYXsebwlyln067CWz+8PoKojJEszmQQbUKxcEP459M2
         iBXIB5ZyzBj56xcaODPTZYpADcPDMshAIby+J/sslm3j9yQN7gB6mhZ2XsW+ifVENTAz
         BLGumgFxMoG1PEiJKxXhZH7jwu32FIbUgdIGMW2GH6TsGWDQB5JTr1WO/Xy+NbOkTUR5
         mxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GYPUX223cEk7sfseKTxO6Wl2a86PZnTF5NOlEuFwhHI=;
        b=WgX8QRA4eFlkmTMm8SguDFyAhh0tw4qXbodj+YlzFtdHPp1XwOEYorR/sI6SmoS/6s
         IUxm/Y6XG7O4sK8Q5AjLgGjinU0NoQwyUvndq2kGRxQqIb3o+53I+rPeLf8QLsiSecct
         iT7tuxC/FLVhAT6wnU7RmpgDH/s+JPqTIFYDKhpy9DpsyuBdoWdFMfjdGIV1ZX956nyi
         dsJf60ofrjgw+ILJ9JEmNC0J93OGpD8M7EspD+i5GOO5pNrwLBeFbiP8NPrUfZignppx
         e+ooMVk+C7v5zhHUnX8fAavSnz3jnhrHEyGXXUrPBckogsYBsk4bARcEbYlxQynlOuBP
         brow==
X-Gm-Message-State: AOAM531NE8xt1f6ngUNz2ZDg87e8Uz5e/6lTX/ig4HqqGRTILtmRfoBi
        NnNiscDaIY66LoolieY+ovw=
X-Google-Smtp-Source: ABdhPJwIJG3YXsNl5fJt9BlQ6Vtf6Rc8gfiB60iBmkaUop2zKiVr9jOHcWia3jkqjMEsJzNj8Bm4+w==
X-Received: by 2002:a17:902:9e04:: with SMTP id d4mr10015126plq.296.1597654650775;
        Mon, 17 Aug 2020 01:57:30 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:30 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 03/10] sound: asihpi: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:56 +0530
Message-Id: <20200817085703.25732-4-allen.cryptic@gmail.com>
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
 sound/pci/asihpi/asihpi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 023c35a2a951..35e76480306e 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -921,10 +921,10 @@ static void snd_card_asihpi_timer_function(struct timer_list *t)
 		add_timer(&dpcm->timer);
 }
 
-static void snd_card_asihpi_int_task(unsigned long data)
+static void snd_card_asihpi_int_task(struct tasklet_struct *t)
 {
-	struct hpi_adapter *a = (struct hpi_adapter *)data;
-	struct snd_card_asihpi *asihpi;
+	struct snd_card_asihpi *asihpi = from_tasklet(asihpi, t, t);
+	struct hpi_adapter *a = asihpi->hpi;
 
 	WARN_ON(!a || !a->snd_card || !a->snd_card->private_data);
 	asihpi = (struct snd_card_asihpi *)a->snd_card->private_data;
@@ -2871,8 +2871,7 @@ static int snd_asihpi_probe(struct pci_dev *pci_dev,
 	if (hpi->interrupt_mode) {
 		asihpi->pcm_start = snd_card_asihpi_pcm_int_start;
 		asihpi->pcm_stop = snd_card_asihpi_pcm_int_stop;
-		tasklet_init(&asihpi->t, snd_card_asihpi_int_task,
-			(unsigned long)hpi);
+		tasklet_setup(&asihpi->t, snd_card_asihpi_int_task);
 		hpi->interrupt_callback = snd_card_asihpi_isr;
 	} else {
 		asihpi->pcm_start = snd_card_asihpi_pcm_timer_start;
-- 
2.17.1

