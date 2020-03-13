Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412F8C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18690206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEkeXok9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCMOUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:20:11 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42922 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:20:10 -0400
Received: by mail-qt1-f193.google.com with SMTP id g16so7568971qtp.9;
        Fri, 13 Mar 2020 07:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w7SDY5/fpOjOmdh4X9ZXg63Zr2hkjByLSGBRaJDpBEA=;
        b=AEkeXok98OUd++fJAFsQzgZI2Rx8lH6Bi9saeiY1p9H0oX1jYZLJl1sH0mNOKnYTU9
         njtVRtqSPxM3Dg6HM2jr0isPpzBTGdjgzTP6e3fkijeAIvbiHbuZCnvfqckuxn1TxCyn
         5ptAPXcE8oWNWjC2bYN+BvoRRbXPEKy87cayb7b5HLMbjvpMxOXVb2VOK5ZpoXGjlisM
         UqkPV5nkySCedyoBdpoe4Yq8Z88pVB/+5DluVDdcK7J7HlWVGgWiIVebk41x7FZtJAKn
         ILly808MHtTAwsXCx/0G9F7BgLpyhc0iOCrk1f9HW+sCgfnKIipfV3oKbdW6aF1h9wE5
         fYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w7SDY5/fpOjOmdh4X9ZXg63Zr2hkjByLSGBRaJDpBEA=;
        b=nbWQzXfdZu4T9kWKoraaO+Gv6iFIv1byAgFkUgxhdk4iqgtnAFcyeQbs1EM8TesIc+
         R23cWBatHcTDxBHSs6LnNn52RMjhrXmQ9raRj+ywpY9h97rlimHJXSfm4FEukX2Swb/4
         E9cu0XY2/M3XWLed/YBe2Zvc/waPjO3qRWvbpu1RQ/MAzPkz/G65ZKgLSqjXQn4hQyQH
         PRTXhX4q+WloSHfv97QPbSR9yzE1pXDY/KPlsxaLfhyALVPcn5PWBRsH8Lp3lome/Q9B
         m297dOihwBZyNveJTtgRSdfsCUHlLlfahwerJlWt0xdNrnFXziIEIe9vNGX2bZC0NPEq
         OH8g==
X-Gm-Message-State: ANhLgQ3HU1oNgHC6rfhRt9UKBoRy1S1oXo5SIYLYG6SF8AuChgSvmkiM
        DzZmWUNUIgfyE0KpGS8GaKY7QD7n
X-Google-Smtp-Source: ADFU+vv44sZ1pQy3T+J2li3c8ABbUHHJlzuJSLbRGaJg931Ig1LRAWuHc9eLbkCwWLxwovm62Xo6tA==
X-Received: by 2002:ac8:385b:: with SMTP id r27mr5330556qtb.145.1584109209322;
        Fri, 13 Mar 2020 07:20:09 -0700 (PDT)
Received: from ubuntu (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.gmail.com with ESMTPSA id 68sm12623853qkh.75.2020.03.13.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:20:07 -0700 (PDT)
Date:   Fri, 13 Mar 2020 10:20:05 -0400
From:   Vivek Unune <npcomplete13@gmail.com>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        ezequiel@collabora.com, akash@openedev.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add Hugsun X99 IR receiver and
 power led
Message-ID: <20200313142005.GA25349@ubuntu>
References: <20200313000112.19419-1-npcomplete13@gmail.com>
 <7f294dd5-3188-e2d6-dd49-4b2afb04455a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f294dd5-3188-e2d6-dd49-4b2afb04455a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 09:32:27AM +0100, Johan Jonker wrote:
> Hi Vivek,
> 
> The 'power-led' need some changes.
> 
> From leds-gpio.yaml:
> 
> patternProperties:
>   # The first form is preferred, but fall back to just 'led' anywhere in the
>   # node name to at least catch some child nodes.
>   "(^led-[0-9a-f]$|led)":
>     type: object
> 
> Test with:
> make -k ARCH=arm64 dtbs_check
> 
> arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: leds:
> power-led:linux,default-trigger:0: 'none' is not one of ['backlight',
> 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
> 
> On 3/13/20 1:01 AM, Vivek Unune wrote:
> >  - Add Hugsun X99 IR receiver and power led
> >  - Remove pwm0 node as it interferes with pwer LED gpio
> 
> pwer => power
> 

Hi Johan,

I'll fix those in my next version. Here's what I intended to to:

1. Rename 'power-led' node to 'led-power'
2. Remove 'linux,default-trigger' entirely since this led is always on

Thanks,

Vivek 

> > index d69a613fb65a..df425e164a2e 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
> > @@ -29,6 +29,26 @@
> >  		regulator-max-microvolt = <5000000>;
> >  	};
> >  
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&power_led_gpio>;
> > +
> > +		power-led {
> > +			label = "blue:power";
> > +			gpios = <&gpio4 RK_PC2 GPIO_ACTIVE_HIGH>;
> > +			default-state = "on";
> > +			linux,default-trigger = "none";
> > +		};
> > +	};
> > +
