Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8907F20823
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 12:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPIfkKpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387416AbgEXMKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgEXMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 08:10:49 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF6C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:10:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id d7so17871314eja.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4ayDjmnV9wYd0v9NacT19DJlRfTJRH5YTbcBXU3gcpg=;
        b=aPIfkKpO7kigQPfEldp9Xws0ZD44QpI5CbSuno2Jca4LXIIp+n0/f7AKbL9CjdhuRR
         EzMgwu0yPikRRw6m2RMdUC6uQKGp4TlFQrbBtczR7/J9rIpILcE1ZEWALfX60c0O1sua
         KbOfTdHYw0NPvBLbbXJcJVad8iXpIiaojfXBpMM18IV+hjNmzXZpzb8tk2q0PJ21B11K
         S1kBs42mXCVj19BUxPfedpwxvPL5H6MNaImrg2gcA4BvjtiUxCOCaDEsm2pbQ0cYIgiQ
         AWxeLmZTUClGwlkmMj+iniZ65kIWFAY7LGC5b3Ger6MI9lhoSmeDka7MUanxBMnrTp8P
         Mnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4ayDjmnV9wYd0v9NacT19DJlRfTJRH5YTbcBXU3gcpg=;
        b=PEHRNcsuLSSIPrRbHTU3eNnXH2rwHHnQ1WE0M3Q6IRJT7CvaAI9twg5kXMj7pAXSBb
         Dyn8keG70guzgOpRC5Kd5riIZH+L7TCwr3+Ws727i4De6TUfz8Wt4dJBhQ53JQBI1Rwf
         CGqGE9wgifej1P7ZpNMJnD6c4BOJAC15E65pRI31uzJlZ+1gYQjSfDfLG156hCWRziOd
         jiAkn4ykzLJ1SPk2t2cDs0xL+cAF3fVYs24OkYL/vKSVaFKxo0+xmdgPONlUa+5f3f1G
         2oe71uQA57DOahn6s/3y1WL5T1lZL3NttKntzHvvt8cDN7zARLAeZD+IZPEuLkjfmGyd
         Whsg==
X-Gm-Message-State: AOAM531mtJkgtoDiElJPpHoYUTVWDA45tHlC/dEieOJwuIiAwDz3V+sl
        UIKpnhnfNhYwl9c28tU7HlWVRovn
X-Google-Smtp-Source: ABdhPJxus4k2TWfmkR+MhNp0m0+uKtAUJMXn0B7J20VT2yeL+yFHvii6wVFBe9hCcOfoFqosNXVdKQ==
X-Received: by 2002:a17:906:7684:: with SMTP id o4mr15832306ejm.449.1590322247701;
        Sun, 24 May 2020 05:10:47 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:ed3c:ef0e:6f3d:f78f])
        by smtp.gmail.com with ESMTPSA id cq10sm12766130edb.48.2020.05.24.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 05:10:46 -0700 (PDT)
Date:   Sun, 24 May 2020 14:10:44 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Gaurav Pathak <gauravpathak129@gmail.com>
Cc:     abbotti@mev.co.uk, gregkh@linuxfoundation.org,
        hsweeten@visionengravers.com, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: Re: [PATCH] Removing ununsed variable int lo, hi, int data and int i
 from comedi/drivers/dt2814.c.
Message-ID: <20200524121044.fzpm6hkqrrpa2yhc@ltop.local>
References: <20200524113613.GA19734@xebrium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200524113613.GA19734@xebrium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, May 24, 2020 at 05:06:18PM +0530, Gaurav Pathak wrote:
> Silence following sparse warning:
> drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_interrupt’:
> drivers/staging/comedi/drivers/dt2814.c:193:6: warning: variable ‘data’ set but not used [-Wunused-but-set-variable]
>   int data;
>       ^~~~
> drivers/staging/comedi/drivers/dt2814.c: In function ‘dt2814_attach’:
> drivers/staging/comedi/drivers/dt2814.c:232:6: warning: variable ‘i’ set but not used [-Wunused-but-set-variable]
>   int i;
>       ^

These warnings are not from sparse but simply from the compiler.
 
>  static irqreturn_t dt2814_interrupt(int irq, void *d)
>  {
> -	int lo, hi;
>  	struct comedi_device *dev = d;
>  	struct dt2814_private *devpriv = dev->private;
>  	struct comedi_subdevice *s = dev->read_subdev;
> -	int data;
>  
>  	if (!dev->attached) {
>  		dev_err(dev->class_dev, "spurious interrupt\n");
>  		return IRQ_HANDLED;
>  	}
>  
> -	hi = inb(dev->iobase + DT2814_DATA);
> -	lo = inb(dev->iobase + DT2814_DATA);
> -
> -	data = (hi << 4) | (lo >> 4);

OK, 'data' is unused but are these 2 'inb(dev->iobase + DT2814_DATA)'
needed or not? I would guess that they're needed but I don't know
this hardware.

> @@ -241,8 +233,6 @@ static int dt2814_attach(struct comedi_device *dev, struct comedi_devconfig *it)
>  		dev_err(dev->class_dev, "reset error (fatal)\n");
>  		return -EIO;
>  	}
> -	i = inb(dev->iobase + DT2814_DATA);
> -	i = inb(dev->iobase + DT2814_DATA);

Same here.

-- Luc
