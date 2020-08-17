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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E35C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D1D206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnVY62Mm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHQI5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgHQI5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:57:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71EFC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so7800982pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UTSOhqNL5HstpQGSytQ69KLhEIvbIwMRL+50xoY/d1A=;
        b=tnVY62Mm3nYGST0oeSTRXyKqQJ1c+CoCCnUIazPPvCz2Zyx5i9VDNgtHhs66n21pZw
         P4WQK0kqDNCBQLWx79G6o67dpbwJPhWt+17dc0HsrLgkWerecLg4kU1AIkrwQFslBYBa
         lo6RK50/eqXjea5NQ6H/qmPJ5d/LhTJqcY5Wvpy4eRiJzPb6/1l1l/XqqBulYx6AA8Rn
         b4E5GwDvHlrlvoROyLH70MCyMvgwQ9Ma/CkCSLmwzyT1Lc4KAPigBb5KhVbbv3w22pje
         /GE4J6Iy8M24q00gdPEdDZwI0qp52uLP2AUdBjM2NmPmIQ7TYyAvbBumeE8H6Z/ojew0
         JD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UTSOhqNL5HstpQGSytQ69KLhEIvbIwMRL+50xoY/d1A=;
        b=RZh9GRz66COz4DaXJT9JkPkZfZFIWWYhQXpzRfyGwg6MMqYL74CvfpeFnqFJnJk7Cr
         muP/fmRMikK0TBZDYw5iTmQRRXy/rWJqTaN5kF2oQwVtr5EoQy+NT8Oxd+qXy+UMnZAD
         A4hzQGOadO6APoeW2KNYhURtq/cv8SexlxuIvjQY/GuSGSMXAgxyMEaIRFE3odtjS3YB
         gpiMtlxETIbcyHwQSWKq1qpr4akz9A4WWtiU+eQKY5V1vLaVJho1OJR0K5RlV5ZQKX6i
         +frnHrlqhp0Du+OxC8agIu/GL7YcokPo7LE79tEw9zaHVEBQ17I6ik8FPbb/6AU/Hbjq
         ZCqA==
X-Gm-Message-State: AOAM531Ckr8rSM3hNE6RuAME21Kub3XA/D8oG7kwipHynKsIbaBnNNnJ
        pd4/n9/wgB+7BgP9C1uQoO4=
X-Google-Smtp-Source: ABdhPJyfL9kjLJ5laRAS5+b9JXqWdLH4UWSLPWaVE24ZUuM9BF3zE8Ke4dRt9cpQCFIksdK7gJHV4w==
X-Received: by 2002:a62:c582:: with SMTP id j124mr10929426pfg.21.1597654668407;
        Mon, 17 Aug 2020 01:57:48 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id j5sm19057245pfg.80.2020.08.17.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:57:47 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, clemens@ladisch.de,
        o-takashi@sakamocchi.jp, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com
Cc:     keescook@chromium.org, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 05/10] sound: rm9652: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:26:58 +0530
Message-Id: <20200817085703.25732-6-allen.cryptic@gmail.com>
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
 sound/pci/rme9652/hdsp.c  | 6 +++---
 sound/pci/rme9652/hdspm.c | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 227aece17e39..dda56ecfd33b 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -3791,9 +3791,9 @@ static int snd_hdsp_set_defaults(struct hdsp *hdsp)
 	return 0;
 }
 
-static void hdsp_midi_tasklet(unsigned long arg)
+static void hdsp_midi_tasklet(struct tasklet_struct *t)
 {
-	struct hdsp *hdsp = (struct hdsp *)arg;
+	struct hdsp *hdsp = from_tasklet(hdsp, t, midi_tasklet);
 
 	if (hdsp->midi[0].pending)
 		snd_hdsp_midi_input_read (&hdsp->midi[0]);
@@ -5182,7 +5182,7 @@ static int snd_hdsp_create(struct snd_card *card,
 
 	spin_lock_init(&hdsp->lock);
 
-	tasklet_init(&hdsp->midi_tasklet, hdsp_midi_tasklet, (unsigned long)hdsp);
+	tasklet_setup(&hdsp->midi_tasklet, hdsp_midi_tasklet);
 
 	pci_read_config_word(hdsp->pci, PCI_CLASS_REVISION, &hdsp->firmware_rev);
 	hdsp->firmware_rev &= 0xff;
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 0fa49f4d15cf..572350aaf18d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2169,9 +2169,9 @@ static int snd_hdspm_create_midi(struct snd_card *card,
 }
 
 
-static void hdspm_midi_tasklet(unsigned long arg)
+static void hdspm_midi_tasklet(struct tasklet_struct *t)
 {
-	struct hdspm *hdspm = (struct hdspm *)arg;
+	struct hdspm *hdspm = from_tasklet(hdspm, t, midi_tasklet);
 	int i = 0;
 
 	while (i < hdspm->midiPorts) {
@@ -6836,8 +6836,7 @@ static int snd_hdspm_create(struct snd_card *card,
 
 	}
 
-	tasklet_init(&hdspm->midi_tasklet,
-			hdspm_midi_tasklet, (unsigned long) hdspm);
+	tasklet_setup(&hdspm->midi_tasklet, hdspm_midi_tasklet);
 
 
 	if (hdspm->io_type != MADIface) {
-- 
2.17.1

