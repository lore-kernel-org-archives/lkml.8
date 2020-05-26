Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6E4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F64C20776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHCFTnpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgEZOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:54:57 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C876C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:54:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p30so10165000pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 07:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XE/CNhhJZ18cnKkSu4xYjD7OM6uQ6hC9Q7Mh/l738ac=;
        b=kHCFTnpgCMomfimXGCA9ItSqWhoC1ov5r+BDSPv0URd2YpxNoB1NYRxa6CtwSIz5xu
         z4VpFD/mpodIRVxTiMNNgTyCuxYLQcBoRK44h0olRpwjoTLbmUyNBoDKRkswDUiz3M4i
         +AQdZiwFfaIGZP+uL+meN59fOGHu8ujIn1KkDFv7uLw+WY0c9pD8Ll6dEKymlzf6vTMQ
         PQpxs6CStX85QxmqNlHCg3kFsEmkWP6K5B675trepdjvpMMsZ8T3rSPOtV9YC13VZ3AH
         51U1HprsjXRv/9HDqeYqPfaDbs0JxUkgy1Xt5QniJ1MjIdOGGydSvGDDiA+tGsVD8er0
         5xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XE/CNhhJZ18cnKkSu4xYjD7OM6uQ6hC9Q7Mh/l738ac=;
        b=Ej1na2/L3H1LlWMZQagvKDkhjyQyANWPpnQEQfBSZOk/L9s1iFxnJ7BHDKkJXfNvMm
         P6pwlTSG0cUfARsCKLgIN+AgO69/lc9h/3lWGqgWRqGfZB5/AL+5xIZkcPcGqRQZJUxq
         ZXOVAEDEwi4WfS0l8jZCbQ0e1jnIZbGSMhbsnEY/nOhZEld+gH3ZVUivLMkpsmNGn0+u
         jtfqkrpV1VrXLBmolx+mDIPOp2pecmhX3GpcPWY+cV670YhWYF6MUtAZ8Yp+Z2durLrM
         O00o/LOy88dPKLxqqfw+nSkG4frQlP9tMEo8IW6vAQz3+y1RadVsMNE0cI1Z+cVb4j+x
         kHlg==
X-Gm-Message-State: AOAM532Tki4sGxuLAROfYZR7GSYmd26EFwqahqYSanZNnojS4YbgW5FB
        GDDB0uIf+Jf8yDwBMo61sRw5Jr2DO9FyFg==
X-Google-Smtp-Source: ABdhPJxxsHZBvl7G7kCeInH6BrgLM53zZR8RziNuMv3wLr+sR7WKLvO5noKUkkS9J/HEpsf10JJ67A==
X-Received: by 2002:a65:6459:: with SMTP id s25mr1395320pgv.329.1590504896843;
        Tue, 26 May 2020 07:54:56 -0700 (PDT)
Received: from xebrium.com ([182.70.106.85])
        by smtp.gmail.com with ESMTPSA id q100sm84732pjc.11.2020.05.26.07.54.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 May 2020 07:54:56 -0700 (PDT)
Date:   Tue, 26 May 2020 20:24:50 +0530
From:   GAURAV PATHAK <gauravpathak129@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200526145448.GA5197@xebrium.com>
References: <20200524113613.GA19734@xebrium.com>
 <20200526141346.GV30374@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200526141346.GV30374@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2020 at 05:13:46PM +0300, Dan Carpenter wrote:
> Your subject doesn't use the correct patch prefix please use.
> 
> [PATCH] Staging: comedi: dt2814: remove unused assignments
> 
> Please resend a v2.
> 
> Correct the references to Sparse as well like Luc said.
> 
> regards,
> dan carpenter
> 

Hello Dan,
Thank you for reviewing and suggesting changes. I have modified the
patch and attached it with the e-mail to keep this thread conversation.
I hope I have made the changes correctly.

Thanks,
Gaurav

--mYCpIKhGyMATD0i+
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="0001-Staging-comedi-dt2814-remove-unused-assignments.patch"
Content-Transfer-Encoding: 8bit

From ef4a63e66fc09052c4cad808755d1142a9af7011 Mon Sep 17 00:00:00 2001
From: Gaurav Pathak <gauravpathak129@gmail.com>
Date: Sun, 24 May 2020 17:06:16 +0530
Subject: [PATCH v2] Staging: comedi: dt2814: remove unused assignments
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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


--mYCpIKhGyMATD0i+--
