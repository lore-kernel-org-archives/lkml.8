Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DE6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C03D206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKFX4CIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388400AbgEZPuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgEZPuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:50:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B8C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:50:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 185so2031314pgb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3s/pLD7nj21hdmawAnqZB1ca29MHptDmSGTKYK3W3E=;
        b=QKFX4CITtkj0CzudSzbINE+WsFl8jYzCH4/L49e7eTSLDSW8YU3cdeyr64P+uWfTez
         PzEGwsQydooBPeGb/KC/hNndMrssm5L26f66v3vzOSGwQOv8bs6NvpqhPBv5f5H56vfI
         dXZD7h5EVQnyoy2zzEjtHR78n1nMa0E97F8yfejzpD2Ytzgpj52QALvPLsSo/oOirLws
         lNP+bZ94PfDCHM2a6p/5RpobGWXYOdph5VZPC9X1t14NZpeXCvIyZD0wZzKbkzfQU554
         b1RToMXt+izSjJnSnDh6ODPmI1fCx+P9Lqf3W9+OjrdjydTd2vVMemNqfKzkf38UCm2J
         V0HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3s/pLD7nj21hdmawAnqZB1ca29MHptDmSGTKYK3W3E=;
        b=V7/2KnVqc8/Nlired+IAwuvJLC15q1sbg4Cf1JdUriSM1xddMtxXH3Qd5Kzsxfpkr3
         9quH+3og/vtcbXD3+NEV1tP/OTqq7Sil0SC/+T0WDomrrctt+iPnJhk+hBI/7zgQDj1A
         8VEsblHIiWv7md+xEbN84DFJwVk0Kq107h2jJu+pjvBd8PPmFqINsrFWgt7eRmx6bzrP
         O+9dmGOpZFIVALlaOiNTg4hk8D0Wn8iab8MJZel6khjVngjQAaw+3ZRnKl28T7kedr2k
         SbaHuh8NLc6qNX++acSqre47QwbtgdAmTpnHxkwdMevsU8j38bd3uQQnp+ohrGAoIzZP
         vz9Q==
X-Gm-Message-State: AOAM532VOlwQX3ZnyXq9+Zf9VrQFAypRCajiNpP+ayv5Hcfpod/V4sCj
        S7nXo8nace7kfJGmFUDt6x9Jcxhs5Gg8Uw==
X-Google-Smtp-Source: ABdhPJykFr2Mf58LTlQqpfXnm0pnNTayQT7pcse1ruLBQO76W+Fs+bE5UCQNS98JnMdlm+dnJSUHtA==
X-Received: by 2002:a63:1c1:: with SMTP id 184mr1688258pgb.203.1590508224497;
        Tue, 26 May 2020 08:50:24 -0700 (PDT)
Received: from gaurav-pc ([182.70.106.85])
        by smtp.gmail.com with ESMTPSA id m2sm16671pjk.52.2020.05.26.08.50.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 08:50:23 -0700 (PDT)
From:   gaurav <gauravpathak129@gmail.com>
X-Google-Original-From: "gaurav" <gaurav@gaurav-pc>
Received: by gaurav-pc (sSMTP sendmail emulation); Tue, 26 May 2020 21:20:18 +0530
To:     dan.carpenter@oracle.com
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: [PATCH v2] Staging: comedi: dt2814: remove unused assignments
Date:   Tue, 26 May 2020 21:20:16 +0530
Message-Id: <20200526155016.9146-1-gauravpathak129@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526150954.GA30374@kadam>
References: <20200526150954.GA30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence following compiler warning:
drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_interrupt’:
drivers/staging/comedi/drivers/dt2814.c:193:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
  int data;
      ^~~~
drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_attach’:
drivers/staging/comedi/drivers/dt2814.c:232:6: warning: variable ‘i’ set but not used [-Wunused-but-set-variable]
  int i;
      ^

Signed-off-by: Gaurav Pathak <gauravpathak129@gmail.com>
---
 v2: Update subject and commit message.
 drivers/staging/comedi/drivers/dt2814.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/comedi/drivers/dt2814.c b/drivers/staging/comedi/drivers/dt2814.c
index d2c715737361..eea587d63e18 100644
--- a/drivers/staging/comedi/drivers/dt2814.c
+++ b/drivers/staging/comedi/drivers/dt2814.c
@@ -186,22 +186,15 @@ static int dt2814_ai_cmd(struct comedi_device *dev, struct comedi_subdevice *s)
 
 static irqreturn_t dt2814_interrupt(int irq, void *d)
 {
-	int lo, hi;
 	struct comedi_device *dev = d;
 	struct dt2814_private *devpriv = dev->private;
 	struct comedi_subdevice *s = dev->read_subdev;
-	int data;
 
 	if (!dev->attached) {
 		dev_err(dev->class_dev, "spurious interrupt\n");
 		return IRQ_HANDLED;
 	}
 
-	hi = inb(dev->iobase + DT2814_DATA);
-	lo = inb(dev->iobase + DT2814_DATA);
-
-	data = (hi << 4) | (lo >> 4);
-
 	if (!(--devpriv->ntrig)) {
 		int i;
 
@@ -229,7 +222,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 	struct dt2814_private *devpriv;
 	struct comedi_subdevice *s;
 	int ret;
-	int i;
 
 	ret = comedi_request_region(dev, it->options[0], 0x2);
 	if (ret)
@@ -241,8 +233,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
 		dev_err(dev->class_dev, "reset error (fatal)\n");
 		return -EIO;
 	}
-	i = inb(dev->iobase + DT2814_DATA);
-	i = inb(dev->iobase + DT2814_DATA);
 
 	if (it->options[1]) {
 		ret = request_irq(it->options[1], dt2814_interrupt, 0,
-- 
2.17.1

