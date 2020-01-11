Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A64BC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353DD2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppTqZL0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbgAKQbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:31:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45048 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgAKQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 11:31:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so2669700pfw.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 08:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f1vRmHhrV08XFgVnUDwocso32DPdXB96AAdJZ+4F8qM=;
        b=ppTqZL0kzWaBSg6qpBFaHk1o9lIXhnNlrcYC+nmG75Ay95+W/DGgXe+6spz5sj3n+R
         CcwFdOpG/Bd0mZrgYn+M+cj95xnecldiD943L5eyPwx3Oq60xqdhJO8Xyu9khyN0dLNQ
         ZJR4mvMJljAKDVZo+zTcGhhsourgZBxuByW0gJwV14P3k6kUOkmyie4IYbw8qR2czVXU
         VFbUNcnZKQ+3r0fgDO/x9IekbuiwP9tFtqQUfS47CzErUCPL1t0dcpG7M/o0s+nvhP90
         01HyYpaHxnvh/h2RBBuc8l34v2t9KFNOrPXk5FvunhaLJrI0JwVfP3OXUXhIZdf8LLie
         BQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f1vRmHhrV08XFgVnUDwocso32DPdXB96AAdJZ+4F8qM=;
        b=a1ZFs4Tsv5f2M52foVQezW03fW2TgGaY+tDPK8bA1qFd1+HmhJNJ57edWNjfEOrjC2
         6C5+bRRMHMI5fYmhVnMV0mN41N8u2c6cKFSG2HL6M7AKewRYIBVMA8iVnr7QD0m236gy
         89wgsveiEITJXmLjogqrsBtf8XtOJUIbBkIvptH12tm8AVstvXUCYmVxF7WGPsq/NuSi
         VbFySW0f+EzCm0jBM1S2KvUC+TfB2d3gjKquBVn80mGlJHny3ySr6GRbNZdRTN9BMiwK
         TSmTkettWsEEiPTLB6nrpblitS5MHZ/xbCH4lq1iJsQEjgh/dPiOW0KKoo2HUI+7grf4
         ZrQA==
X-Gm-Message-State: APjAAAXd4vVwVTJMXJbYEAcuX9XWkNYsHDu5qmuJNXslR60gKqDErClI
        aWCQnIRxma87ry7WbSXVNpY=
X-Google-Smtp-Source: APXvYqyvooAPj6DJQGAiHR9lnZWvJc3ZiAu4Zkp5EWGFQLtiGlZu7YHmVbXWUscLpX6sSiTaH67AIw==
X-Received: by 2002:a63:6ac1:: with SMTP id f184mr11698153pgc.133.1578760301054;
        Sat, 11 Jan 2020 08:31:41 -0800 (PST)
Received: from oslab.tsinghua.edu.cn ([166.111.139.172])
        by smtp.gmail.com with ESMTPSA id b65sm7347072pgc.18.2020.01.11.08.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2020 08:31:40 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, rfontana@redhat.com,
        tglx@linutronix.de, allison@lohutok.net
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] ALSA: cmipci: Fix possible a data race in snd_cmipci_interrupt()
Date:   Sun, 12 Jan 2020 00:30:27 +0800
Message-Id: <20200111163027.27135-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions snd_cmipci_interrupt() and snd_cmipci_capture_trigger()
may be concurrently executed.

The function snd_cmipci_capture_trigger() calls
snd_cmipci_pcm_trigger(). In snd_cmipci_pcm_trigger(), the variable
rec->running is written with holding a spinlock cm->reg_lock. But in
snd_cmipci_interrupt(), the identical variable cm->channel[0].running
or cm->channel[1].running is read without holding this spinlock. Thus,
a possible data race may occur.

To fix this data race, in snd_cmipci_interrupt(), the variables
cm->channel[0].running and cm->channel[1].running are read with holding 
the spinlock cm->reg_lock.

This data race is found by the runtime testing of our tool DILP-2.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/pci/cmipci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index dd9d62e2b633..f791152ec48f 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -1430,7 +1430,7 @@ static int snd_cmipci_capture_spdif_hw_free(struct snd_pcm_substream *subs)
 static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 {
 	struct cmipci *cm = dev_id;
-	unsigned int status, mask = 0;
+	unsigned int run_flag0, run_flag1, status, mask = 0;
 	
 	/* fastpath out, to ease interrupt sharing */
 	status = snd_cmipci_read(cm, CM_REG_INT_STATUS);
@@ -1445,15 +1445,17 @@ static irqreturn_t snd_cmipci_interrupt(int irq, void *dev_id)
 		mask |= CM_CH1_INT_EN;
 	snd_cmipci_clear_bit(cm, CM_REG_INT_HLDCLR, mask);
 	snd_cmipci_set_bit(cm, CM_REG_INT_HLDCLR, mask);
+	run_flag0 = cm->channel[0].running;
+	run_flag1 = cm->channel[1].running;
 	spin_unlock(&cm->reg_lock);
 
 	if (cm->rmidi && (status & CM_UARTINT))
 		snd_mpu401_uart_interrupt(irq, cm->rmidi->private_data);
 
 	if (cm->pcm) {
-		if ((status & CM_CHINT0) && cm->channel[0].running)
+		if ((status & CM_CHINT0) && run_flag0)
 			snd_pcm_period_elapsed(cm->channel[0].substream);
-		if ((status & CM_CHINT1) && cm->channel[1].running)
+		if ((status & CM_CHINT1) && run_flag1)
 			snd_pcm_period_elapsed(cm->channel[1].substream);
 	}
 	return IRQ_HANDLED;
-- 
2.17.1

