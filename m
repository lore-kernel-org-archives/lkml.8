Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,PDS_BTC_ID,PDS_BTC_MSGID,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7611FC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C932207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578928657;
	bh=pBqkF+2clNHgXHi5BBUJRdT/rE3DzQ/PC+llPRp2Xrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUCDX3UzJUryDHbESxQlWJ/Uu57dTCXXk/i/LEJACS87dupHaF9zXKo6B5ruNcs3e
	 Ue5sGhHeXff/0IkIG1Cuue8AIu4Rxp/i6Zif21CItd8NiO8bb3y3Ni+B9xY3qbQhpD
	 6EfPeoCjtvrvjI/wvzUrANPAmP7luvi6wA7gi3pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgAMPRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:17:36 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41167 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:17:36 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so10500895ljc.8;
        Mon, 13 Jan 2020 07:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Jfe3t4kuIi+AgOuIFUoAfUNjc8/xGignIjZ7I0BmXV4=;
        b=B8b+8x6GSg6o+hWEXoStPFoV1PhVCwORKl3GtKrB6p+5cYtkclh90PRu0dKxYFDr1O
         oAfNaUaAW8dUa7ciKxYIJ9JfdxE88IL6z/daCT95lhd3zOgmJyRD+svxCKaPuFWVCF1q
         1Ld9X5M58pf+rI2Hv7vm7Cbrb64y0hHk/3MvF+cj1XlLNnkGgve3c8pj47Ja9KKqf76U
         3hLCJGaT3lVHrA554CW+xAKZOWPpFM0wc67CHWK2b6e1Kl5q4Rwqn9qkIv8tdPHw1NXx
         SnuKowPBThWDatNqXqi3cf0gn3V7pljzC7GdOo3HMimeNpGxhTWKhcfxHveIg/YKg2HD
         6x/g==
X-Gm-Message-State: APjAAAVpz1af5T89mFgdkVRxAVnu/+N6tSGOaVa3k+P2bxy8p2pvUI67
        oLJoaT/OOGrHgeo6RhOzcMk=
X-Google-Smtp-Source: APXvYqwBW142k8JnhwdWEPoZeKHxchCJiMWzJnPw3teNWcK8Rne1NsOLqcNwiGz9R4yRFANTTf7AWA==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr9077591ljc.271.1578928654031;
        Mon, 13 Jan 2020 07:17:34 -0800 (PST)
Received: from xi.terra (c-14b8e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.184.20])
        by smtp.gmail.com with ESMTPSA id g15sm6065992ljl.10.2020.01.13.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:17:32 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1ir1TA-0005lY-KP; Mon, 13 Jan 2020 16:17:32 +0100
Date:   Mon, 13 Jan 2020 16:17:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2 5/7] USB: serial: f81232: Set F81534A serial port with
 RS232 mode
Message-ID: <20200113151732.GC2301@localhost>
References: <20190923022449.10952-1-hpeter+linux_kernel@gmail.com>
 <20190923022449.10952-6-hpeter+linux_kernel@gmail.com>
 <20191023115300.GU24768@localhost>
 <f3a8b0bd-79f7-3bef-4d07-69774c87873a@gmail.com>
 <20200108143502.GJ30908@localhost>
 <3c79f786-de34-550e-3964-d7fb334f6d56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c79f786-de34-550e-3964-d7fb334f6d56@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:37:09AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi Johan,
> 
> Johan Hovold 於 2020/1/8 下午 10:35 寫道:
> >> Yes, when 1 F81534A connect to Host, it'll report device as following.
> >> 	virtual HUB
> >> 		GPIO Device.
> >> 		serial port 1
> >> 		...
> >> 		serial port n
> > 
> > Could you post lsusb -v output for this with a couple of UARTs enabled?
> 
> The following lsusb log is F81536 informations
> 2c42:1608 => HUB
> 2c42:16f8 => GPIO device
> 2c42:163x => UART (need driver enable)

> *after insmod driver and wait for complete

> Bus 001 Device 053: ID 2c42:1636
> Bus 001 Device 044: ID 2c42:16f8
> Bus 001 Device 043: ID 2c42:1608

Can you post verbose ("lsusb -v") output for the three device types for
completeness?

> >> The link are F81534A pin-out:
> >> 	https://imgur.com/a/AZHqQ1N
> > 
> > Do you have a datasheet for the device?
> > 
> > I think I'm starting to get an idea of how this work, but I really don't
> > like having to spend this much time on detective work just to understand
> > how the hw works.
> 
> The following link is F81536 spec:
> https://drive.google.com/drive/folders/1oA8DvpevFXoTLCDfPZHzaBWKr32ch5xc?usp=sharing

Thanks!

> >> So we can control F81534A series all GPIO pins via GPIO Device.
> >> Serial ports are also control MODE0_x,  MODE1_x,  MODE2_x
> >> (e.g. UART1 MODE0_1,  MODE1_1,  MODE2_1), but when Serial ports
> >> is h/w disabled (DTR pull low), the mode pin will change to GPIO pin.
> > 
> > So you tie a ports DTR pin, even though it's normally an output, and use
> > that at boot to determine whether the UART should be enabled or not?
> > 
> > And the GPIO device can only control a pin if the corresponding port is
> > disabled?
> > 
> > Can you read back the enable state of each port?
> 
> DTR pin of the F81534A series are strap pin on power on, when IC detect
> it pulled to low, the UART device can't enable and DTR change to input
> mode.

Can you read back the state of the DTR pin when pulled low? So that you
can determine which UARTs have been disabled in hardware?

> I can read the UART enable state from GPIO Device, so I can do when the
> GPIO is associated with UART enabled, change it as output only otherwise
> can be set to input/output. Is this OK ??

I'm leaning more towards not exporting this as a gpio device at all.
It's clear from the datasheet (and your implementation) that these pins
are supposed to be used with your own tranceivers. You can start with
only supporting RS232, and then we can discuss an interface for
switching modes later.

> > What about devices using a different tranceiver? Should the state of the
> > mode pins ultimately be tied to VID/PID (can your customers change
> > VID/PID)?
> > 
> 
> Our device VID/PID is changeable, but we assume don't change it.

Ok, then I guess we must assume that the MODE pins are only connected to
your tranceivers and hardcoding the various configurations is fine.

Johan
