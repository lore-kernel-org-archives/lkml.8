Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8564AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 544B5207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 13:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoGMH3vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgEXNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 09:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgEXNc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 09:32:27 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:32:27 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id e11so6699416pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 06:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8P08CbbNlN5WCUXv/BNCisqhSof+4zFGpgMMgUbe9tk=;
        b=uoGMH3vBZ3swLnuwlu3/5/GyoIknUx5d+ckVHEY3ko2ITGEnYhSadgqrIsBZxW4L6G
         IYE5PaIeqfA6x5OrGMRwSUGrYk9WZ0giut/IaFPU5lW400L0v+greFtRajf3miCsAHAy
         pdgTcwOueZFN3p01ysE+YtJlNy/30kBUUeWM0TAIzEn4R0bNvk4rqsDKXRXdKedRTj3V
         bDrbroQfnmQEPNuA6qIfE0W6TPSgimKAd7fGfFqLQn5CbrSxX/9RGtUPNc/3Wa7B9sLE
         zCEmnI4U/w9pwvty2SRoojomqBJBcRJ4xgkyQ4AqJ5EJHc2xOJ4KqOxxCHZ3HaUeJN7j
         d1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8P08CbbNlN5WCUXv/BNCisqhSof+4zFGpgMMgUbe9tk=;
        b=KBe7mIeiC7kDwfQjE3BUa6EiNV0wFyZtK2ui7XJ2X/cw3rGmw0wLLWnSBY87fgaDg9
         R8FzNShFTZIX5PMjBvLQ3DF4+KUml2pJptG++AUHkJJfavcls1fs5a0DRq1m4qUclrse
         mT2KPjouzcwIDbWMiRApwdf1GN2d1SKT8tFiz5kxek4y+73SzJ/u8PN5DK/kWZtVZ3wI
         MoRsJF5eNt85QFWiebqhFsf6ZWMGYeljydAmMV8BdArZG3yUTCWsL2C5AkzB61Ak873u
         2LPq0Po84DsImpX5aKJRBJ3cZYrxBIfkJpMHLcjC4pdZomqcQiy2xqaxHZ1L58exnIhr
         MtDg==
X-Gm-Message-State: AOAM531p2fJVfVbkhqzkSO2RnbTGwePLj+99bSdq/DL9wzGhZGZcATFM
        4SobpGLVRFjNqj/dgJXej2w=
X-Google-Smtp-Source: ABdhPJwpQGJWBf/p9NEJobAQPYUJvU5mJ6qqZMBpqRI+5DZyR4qrOIz0gc7juI3mglQYcN1dj/V4yQ==
X-Received: by 2002:a63:4c1f:: with SMTP id z31mr21909272pga.143.1590327147004;
        Sun, 24 May 2020 06:32:27 -0700 (PDT)
Received: from xebrium.com ([182.70.106.85])
        by smtp.gmail.com with ESMTPSA id k2sm11305483pfd.108.2020.05.24.06.32.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 06:32:26 -0700 (PDT)
Date:   Sun, 24 May 2020 19:02:20 +0530
From:   GAURAV PATHAK <gauravpathak129@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200524133218.GA1391@xebrium.com>
References: <20200524113613.GA19734@xebrium.com>
 <20200524121044.fzpm6hkqrrpa2yhc@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200524121044.fzpm6hkqrrpa2yhc@ltop.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nevermind, my sparse version was broken. Installed sparse 0.6.1, but
still no warnings from sparse in any of the directories in drivers staging.

E.g.:

make C=2 M=drivers/staging/sm750fb
  CHECK   drivers/staging/sm750fb/sm750.c
  CHECK   drivers/staging/sm750fb/sm750_hw.c
  CHECK   drivers/staging/sm750fb/sm750_accel.c
  CHECK   drivers/staging/sm750fb/sm750_cursor.c
  CHECK   drivers/staging/sm750fb/ddk750_chip.c
  CHECK   drivers/staging/sm750fb/ddk750_power.c
  CHECK   drivers/staging/sm750fb/ddk750_mode.c
  CHECK   drivers/staging/sm750fb/ddk750_display.c
  CHECK   drivers/staging/sm750fb/ddk750_swi2c.c
  CHECK   drivers/staging/sm750fb/ddk750_sii164.c
  CHECK   drivers/staging/sm750fb/ddk750_dvi.c
  CHECK   drivers/staging/sm750fb/ddk750_hwi2c.c
  MODPOST 1 modules


For few drivers, I am getting:

CC [M]  drivers/staging/vt6656/key.o
  CHECK   drivers/staging/vt6656/rf.c
/usr/lib/gcc/x86_64-linux-gnu/7/include/stddef.h:417:9: warning: preprocessor token offsetof redefined
./include/linux/stddef.h:17:9: this was the original definition

but I guess these are false positive, as #undef offsetof is already present in ./include/linux/stddef.h.

On Sun, May 24, 2020 at 02:10:44PM +0200, Luc Van Oostenryck wrote:
> Hi,
> 
> On Sun, May 24, 2020 at 05:06:18PM +0530, Gaurav Pathak wrote:
> > Silence following sparse warning:
> > drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_interrupt’:
> > drivers/staging/comedi/drivers/dt2814.c:193:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
> >   int data;
> >       ^~~~
> > drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_attach’:
> > drivers/staging/comedi/drivers/dt2814.c:232:6: warning: variable ‘i’ set but not used [-Wunused-but-set-variable]
> >   int i;
> >       ^
> 
> These warnings are not from sparse but simply from the compiler.
>  
> >  static irqreturn_t dt2814_interrupt(int irq, void *d)
> >  {
> > -	int lo, hi;
> >  	struct comedi_device *dev = d;
> >  	struct dt2814_private *devpriv = dev->private;
> >  	struct comedi_subdevice *s = dev->read_subdev;
> > -	int data;
> >  
> >  	if (!dev->attached) {
> >  		dev_err(dev->class_dev, "spurious interrupt\n");
> >  		return IRQ_HANDLED;
> >  	}
> >  
> > -	hi = inb(dev->iobase + DT2814_DATA);
> > -	lo = inb(dev->iobase + DT2814_DATA);
> > -
> > -	data = (hi << 4) | (lo >> 4);
> 
> OK, 'data' is unused but are these 2 'inb(dev->iobase + DT2814_DATA)'
> needed or not? I would guess that they're needed but I don't know
> this hardware.
> 
> > @@ -241,8 +233,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
> >  		dev_err(dev->class_dev, "reset error (fatal)\n");
> >  		return -EIO;
> >  	}
> > -	i = inb(dev->iobase + DT2814_DATA);
> > -	i = inb(dev->iobase + DT2814_DATA);
> 
> Same here.
> 
> -- Luc
