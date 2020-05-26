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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB6FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37DE2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ssorgqpx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbgEZSvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:51:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9601FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:51:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z26so10549412pfk.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psykMHDR6rP9kwTMPx/ucgHvqtZe3pI7rExatJDOE+w=;
        b=SsorgqpxhXuXWLSKvF7U5iYLs2ROtI8v74bVRGVatiJJSK30BvDyNrLtnnL5yyqKdG
         309QzyEQG0Mel3wEN6VpAWZ2Nwir4e157evFDGqT/CZ8ptvFg3VRznuHXsBkOym2ChMw
         xFeboYMIWISlFqB395MWonk3wRdhGwhqloCyAC0ZKBQGbE0QtGoFNxr7fP01vFcSTRcF
         JvO5oDDc2zDxZMB3YTwn0bd3E3LSjArn0PQGJSFSpuh917GVvMnQdb9oTfg3YKMIgM+V
         f3Zg/2akbJUIwI3yjq1GZNGu9TArqR/i/a6689Al+cb6VaOZIwVU2y9/5m0S/TWMuiUf
         1hlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psykMHDR6rP9kwTMPx/ucgHvqtZe3pI7rExatJDOE+w=;
        b=CgUXRdZ+6y/yNhxVIR6fWRZoIDbBM3+fehwN/YAZXEFwvQ2wEvMhCDHnKpnPLw83FT
         AMnELgWEQFdEzwcnImyFDb/Yf4vYwfjNzV1n4/VoHMTvvhoiesW5OjS9fIRC3B/rAND1
         Ioc9rIPNaVF4L0ARYQNNLZvQzKU3ph3ZWmmnY1gxv9qZMPpS6GxT2U8sY1678nkQk8Fg
         9cnvPKyxQIoRPgytECTDDgzFCh0TMAr1eA2CVvvAnpwrVq2cdlJZO+Ril3ZRnjWE8lHi
         VlB7DU1Qt5kn3aJF4JfpC3e4oJ+oL6agGnOiThnefibKnsnjE0Hxu/48VUfnRibt0/rg
         TXOg==
X-Gm-Message-State: AOAM530VjECRRoG3fD5oZenlJjcfOHPbkBY4LYDoa4rzb0L9k403dAV2
        oJuwYdjkI5iOrwFvwBWTTkU=
X-Google-Smtp-Source: ABdhPJwwaFdTZsDgGfzq2fx7nWo5rQ5M0Wo1T43Rf1cbjG718rmxz2Wdx3ATCmUsBNQmLpjctp1Z9A==
X-Received: by 2002:a63:497:: with SMTP id 145mr287904pge.356.1590519097155;
        Tue, 26 May 2020 11:51:37 -0700 (PDT)
Received: from localhost.localdomain ([182.70.106.85])
        by smtp.googlemail.com with ESMTPSA id v1sm209790pjn.9.2020.05.26.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:51:36 -0700 (PDT)
From:   Gaurav Pathak <gauravpathak129@gmail.com>
X-Google-Original-From: Gaurav Pathak
To:     dan.carpenter@oracle.com
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Gaurav Pathak <gauravpathak129@gmail.com>
Subject: [PATCH v3] Staging: comedi: dt2814: remove unused assignments
Date:   Wed, 27 May 2020 00:21:30 +0530
Message-Id: <20200526185130.7160-1-gauravpathak129@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526174813.GB30374@kadam>
References: <20200526174813.GB30374@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Pathak <gauravpathak129@gmail.com>

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
 v3: Update from email header.
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

