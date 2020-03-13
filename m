Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3453AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B83D206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZ2kJbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCMOhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:37:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46447 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgCMOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:37:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id t13so7608192qtn.13;
        Fri, 13 Mar 2020 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IWiLFXJoL3qzIWPZA+/ObRS+WhWUeKdoLxXVkW4bKYs=;
        b=brZ2kJbjo1lXXEUpoExW2a/8G0/kWb1PeWR+PPjo6qWE07rGKGJJJfKSYDBWaEOBfb
         HY2Zuz1UULlojcdDUKrOG4Mgy1PsVmYAIQdf31LXqqWJMM2Ty+twX9y8qAArRwNuopbS
         hbvBiStgtszXEpjHoeNm4f/jTFXWmNGbx9Hb/HZYh2krtxLnDdKp8slf8rMDcDMdeVes
         KreGLJHoT4ZlcBvE2unTECFt8JW2/OE4AWozICObqdK80uWYqvALjqzAaJI/ymPGI6wQ
         ptUYbezk4AEjWaXlSmzvkjiSbmhUVQCbzfDkXTBRv32wB1TfzHnOAbh5pi1SJoQzPbRW
         be9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IWiLFXJoL3qzIWPZA+/ObRS+WhWUeKdoLxXVkW4bKYs=;
        b=aTS+AYlBm6nHQtv/mdsDNYeNW36nInAGOH5v9d7jtWmTvUSDHMh7zjyIy2zIMFjRL7
         WZijX4dOlIKOck/aVgicZxSjP4bmJnqqZPKT2zzcDq4JjvgtBGXTbSUciM10cXKQz9kE
         RI1R/sD3f/eblBVOK6K9HcpUmzKJxeTts/8U4MnmuiW076riMERLNUXvRP0o1hxxChkZ
         OWNG/tyzehJ7NMWtkcMBurkQq6lv8OcHq1KherxAsa6JjZ4XDc/9mjbz5hCeajFHMTvS
         6NeF1rg8YU9bWJ/aIw4AIVR17x4nAi1+yc71WzsjxTUpKops3VHAGiPS709j0mdSMoSS
         9KLA==
X-Gm-Message-State: ANhLgQ2eAcKQFgG3SO2KKE5mFmJY2LsPPzw/2KuiidOmZ3vUDLRQRgMG
        a2egovvcPVcuVAsvkMZ8xnA=
X-Google-Smtp-Source: ADFU+vvlub9/e063qHJY4ONDofRHLu3BpPYkMPUk0Qd2gV0L32YCNySXCwj+Bj5/yZrupMY4cVTAkg==
X-Received: by 2002:ac8:ac1:: with SMTP id g1mr12820614qti.287.1584110266692;
        Fri, 13 Mar 2020 07:37:46 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id w30sm5476313qtw.21.2020.03.13.07.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:37:45 -0700 (PDT)
Date:   Fri, 13 Mar 2020 10:37:43 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add Hugsun X99 IR receiver and
 power led
Message-ID: <20200313143743.GA92675@ubuntu>
References: <20200313000112.19419-1-npcomplete13@gmail.com>
 <7f294dd5-3188-e2d6-dd49-4b2afb04455a@gmail.com>
 <20200313142005.GA25349@ubuntu>
 <4deb154d-3095-7d18-fbf9-85b60f57765f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4deb154d-3095-7d18-fbf9-85b60f57765f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:29:59PM +0100, Johan Jonker wrote:
> Hi Vivek,
> 
> On 3/13/20 3:20 PM, Vivek Unune wrote:
> > On Fri, Mar 13, 2020 at 09:32:27AM +0100, Johan Jonker wrote:
> >> Hi Vivek,
> >>
> >> The 'power-led' need some changes.
> >>
> >> From leds-gpio.yaml:
> >>
> >> patternProperties:
> >>   # The first form is preferred, but fall back to just 'led' anywhere in the
> >>   # node name to at least catch some child nodes.
> >>   "(^led-[0-9a-f]$|led)":
> >>     type: object
> >>
> >> Test with:
> >> make -k ARCH=arm64 dtbs_check
> >>
> >> arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: leds:
> >> power-led:linux,default-trigger:0: 'none' is not one of ['backlight',
> >> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> >>
> >> On 3/13/20 1:01 AM, Vivek Unune wrote:
> >>>  - Add Hugsun X99 IR receiver and power led
> >>>  - Remove pwm0 node as it interferes with pwer LED gpio
> >>
> >> pwer => power
> >>
> > 
> > Hi Johan,
> > 
> > I'll fix those in my next version. Here's what I intended to to:
> > 
> 
> > 1. Rename 'power-led' node to 'led-power'
> 
> The first form is preferred.
> Put 'led-power' in a regex tester with ^led-[0-9a-f]$
> https://regex101.com/
> Your regular expression does not match the subject string.
> 
> Test 'led-0'
> Full match
> 

Hi Johan,

Thanks for quick reply. 

Indeed led-power won't work. Although I'm trying to figure out the dtbs_check
Currently, make compains that it's missing.
I'll verify this properly without having you to verify it next time.

Thanks,

Vivek


> >>>  		regulator-max-microvolt = <5000000>;
> >>>  	};
> >>>  
> >>> +	leds {
> >>> +		compatible = "gpio-leds";
> >>> +		pinctrl-names = "default";
> >>> +		pinctrl-0 = <&power_led_gpio>;
> >>> +
> >>> +		power-led {
> >>> +			label = "blue:power";
> >>> +			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> >>> +			default-state = "on";
> >>> +			linux,default-trigger = "none";
> >>> +		};
> >>> +	};
> >>> +
> 
