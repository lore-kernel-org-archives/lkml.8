Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80475C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5371B2075F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 11:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWGtXYAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgEXLgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 07:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgEXLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 07:36:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 04:36:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so6387023plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 04:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=OzC1cpXNW9KBgR0mwrAtmdi+yItcgjZnfiOPXDFp23M=;
        b=mWGtXYAZgPloy/PcX8td9tpO0s+U5SlTnLflaLN82KZ0wteS3RypAvV/8X+/VOXbM8
         JCo8rJ5VHiuLk99CD3ElLAUvVfpaGbKXGL1s624kPOLx4+SFe4AlegguFYEM+7Za3HS8
         v0pZ7p9RZpqcW2GNjMFdoqqSLagW3fRtBApUdnjlJvlHmLeZHK17YxAYiPn3qgkw1KHI
         xc9HZ4vsakDxat0jkO5w1K7dLy+pV7Ew3wpazZHVpmMWUspVoXSsoSE/MleO1yZYh1W6
         UAf9VEIzr7asP6ZIN1Wsv6LBnsvlKvXJvjjkQ4ClHHed8JREfpIItOrtt93jcM3hrXvz
         58OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=OzC1cpXNW9KBgR0mwrAtmdi+yItcgjZnfiOPXDFp23M=;
        b=lPcYRyIZQvEZhewaw9/NCuDbzX/j6th1uXnTzauvCqZCGqU7CQ0z9KRjtKsEaz5OHO
         wCUyRIVIhZ4qY2dXBKw2+Qe1ln2jT4UhSgmdGRpECbFBrqyxBzrgEcPBvfJvGtPVhvY0
         HlBUqk0eASf6tLP5I6pVL3YnCV1zhp67aagETLwMPDHKlw4XTQr90W8+PX3hrfnzoml0
         I930K6uA6i0XBm3NtaJylqVUEkRrPDlXJtblmAJR6Pf9wBQhxhSWjaJs7B1p5zVbZhtw
         z/KRW3ACRf81fMY9Rvq4nTeKWziwteUJdk7qoIqM/BXwUT469yz3TJmYNtrI3n71g2+e
         ZqRg==
X-Gm-Message-State: AOAM5310/reoSi2AQwqIjFQYLladvyBAwGBymSYKup+AmyJTnGKryr43
        nfjhK2vnaqcQM2H3y61fTzfYvzlI2oQ=
X-Google-Smtp-Source: ABdhPJwZGEO+StBipy4P9Mw+5nSi+vbSv8EhI7Hhmu+ABSs//I9kMDy6Vq9YROqshYB085U/ukxdWA==
X-Received: by 2002:a17:90a:1aa3:: with SMTP id p32mr15642918pjp.4.1590320184145;
        Sun, 24 May 2020 04:36:24 -0700 (PDT)
Received: from xebrium.com ([182.70.106.85])
        by smtp.gmail.com with ESMTPSA id 62sm10871174pfc.204.2020.05.24.04.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 04:36:23 -0700 (PDT)
Date:   Sun, 24 May 2020 17:06:18 +0530
From:   Gaurav Pathak <gauravpathak129@gmail.com>
To:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200524113613.GA19734@xebrium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence following sparse warning:
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

