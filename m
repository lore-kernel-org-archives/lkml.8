Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC5AC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16042208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588338628;
	bh=mcU/IikkRge5NkNieidxRKyqEH7XEBPM8EXLuSoAJOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I137I87Yx8a4DGd1c9zMFLIF9/QuPGt5GPC15OmzdKf2ZCPFYamGrAVfgf9DcThM1
	 kpxXw16wlXHPU1fYBpGK2E+1sCJ2iLAPhTR3qFeal2aAKVENkwhl8PmDZGNr92wc/7
	 Y+C78GjjPwyXJzAiHmVPDaxEVZzR5YARIih78bVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgEANK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:10:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45397 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgEANK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:10:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id f12so7189402edn.12;
        Fri, 01 May 2020 06:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Yg1SL1X0Nyl9McRXFdcaYuSFdnUnZQ7o/sDqSIRDtA=;
        b=swIBo6iceVbnPPKxuTHSunypi9QzoL1Itv2BrT7IZ3iwbIlIf08qZ6xeNmTY/mWMBa
         6AD5BIULb7N9p9ap/f1O/09mvJGKNCzkw3JymiLvgYa+47JEZKOgsqgvea4HCmXwi8Bl
         sED5GAENwqy0p4VeXXnze6pd/y7Z86o6BnichqBQjgQqzb1y1SuRDfoVmolEaaqChVpT
         1Qy2D6u4lVuSK7cGOx8e5YMUKYlyWg408kn1/UxMTaWpTwX4cpsMDmVMyzKCZmTEj6lj
         meu6CEBp7fnvmzpvTOZXJqIxo1frazeAVVNdq2Oo4UiGVIUr+Y8RvKP3BRa/Sej7Mkne
         7l0Q==
X-Gm-Message-State: AGi0PuZHQc1z0hlCWiWmZ643+fuVZ2z6OaoCl9cI4xUSKxDmLqqDPYyc
        /RDM2SXT2xyps34PBXOlPPg=
X-Google-Smtp-Source: APiQypIi4/og4/HNrNIMTQ1xvfHSFwknvjONOuAhvP17Fjm8GXDXhsQF1IJtEimfQoCgQEfjxvh/+g==
X-Received: by 2002:aa7:cf16:: with SMTP id a22mr3390029edy.77.1588338621396;
        Fri, 01 May 2020 06:10:21 -0700 (PDT)
Received: from kozik-lap ([194.230.155.237])
        by smtp.googlemail.com with ESMTPSA id b13sm402093eje.13.2020.05.01.06.10.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 06:10:20 -0700 (PDT)
Date:   Fri, 1 May 2020 15:10:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     kgene@kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] arm: dts: s5pv210: fascinate4g: Add sleep GPIO
 configuration
Message-ID: <20200501131018.GA5154@kozik-lap>
References: <20200426183604.28494-1-xc-racer2@live.ca>
 <BN6PR04MB0660532FF97089208CCEEB2AA3AE0@BN6PR04MB0660.namprd04.prod.outlook.com>
 <20200428100244.GA23963@kozik-lap>
 <BN6PR04MB06605BE9E1559751E083B4E4A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BN6PR04MB06605BE9E1559751E083B4E4A3AC0@BN6PR04MB0660.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:49:36PM -0700, Jonathan Bakker wrote:
> Hi Krzysztof,
> 
> On 2020-04-28 3:02 a.m., Krzysztof Kozlowski wrote:
> > On Sun, Apr 26, 2020 at 11:35:53AM -0700, Jonathan Bakker wrote:
> >> In order to minimize leakage current during sleep, set a config
> >> for sleep GPIOs.
> >>
> >> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> >> ---
> >>  arch/arm/boot/dts/s5pv210-fascinate4g.dts | 242 ++++++++++++++++++++++
> >>  1 file changed, 242 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/s5pv210-fascinate4g.dts b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> >> index 07a8d9bbe5b8..94dcb9b64b9a 100644
> >> --- a/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> >> +++ b/arch/arm/boot/dts/s5pv210-fascinate4g.dts
> >> @@ -36,3 +36,245 @@
> >>  		};
> >>  	};
> >>  };
> >> +
> >> +&pinctrl0 {
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&sleep_cfg>;
> >> +
> >> +	sleep_cfg: sleep-cfg {
> >> +		PIN_SLP(gpa0-0, PREV, NONE);
> >> +		PIN_SLP(gpa0-1, PREV, NONE);
> >> +		PIN_SLP(gpa0-2, PREV, NONE);
> >> +		PIN_SLP(gpa0-3, OUT1, NONE);
> > 
> > I would be happy to see some reasoning why certain pins have disabled
> > pull down (e.g. they are not connected or you use the same configuration
> > as running one) and why you set them as output.
> > 
> 
> Mostly it's copied from the vendor kernel configuration.  Without schematics, I can
> only guess what's actually there.  I can go through and note what each pin appears
> to be used for if you'd like.

Then please mention that it is based on vendor kernel vx.y for product
ABC.  In such case it will be enough.

> 
> >> +		PIN_SLP(gpa0-4, PREV, NONE);
> >> +		PIN_SLP(gpa0-5, PREV, NONE);
> >> +		PIN_SLP(gpa0-6, PREV, NONE);
> >> +		PIN_SLP(gpa0-7, PREV, NONE);
> >> +
> >> +		PIN_SLP(gpa1-0, INPUT, DOWN);
> >> +		PIN_SLP(gpa1-1, OUT0, NONE);
> >> +		PIN_SLP(gpa1-2, INPUT, DOWN);
> >> +		PIN_SLP(gpa1-3, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpb-0, OUT0, NONE);
> >> +		PIN_SLP(gpb-1, OUT1, NONE);
> >> +		PIN_SLP(gpb-2, OUT0, NONE);
> >> +		PIN_SLP(gpb-3, PREV, NONE);
> >> +		PIN_SLP(gpb-4, INPUT, NONE);
> >> +		PIN_SLP(gpb-5, PREV, NONE);
> >> +		PIN_SLP(gpb-6, INPUT, DOWN);
> >> +		PIN_SLP(gpb-7, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpc0-0, OUT0, NONE);
> >> +		PIN_SLP(gpc0-1, INPUT, DOWN);
> >> +		PIN_SLP(gpc0-2, OUT0, NONE);
> >> +		PIN_SLP(gpc0-3, INPUT, DOWN);
> >> +		PIN_SLP(gpc0-4, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpc1-0, INPUT, DOWN);
> >> +		PIN_SLP(gpc1-1, INPUT, DOWN);
> >> +		PIN_SLP(gpc1-2, INPUT, DOWN);
> >> +		PIN_SLP(gpc1-3, INPUT, DOWN);
> >> +		PIN_SLP(gpc1-4, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpd0-0, INPUT, DOWN);
> >> +		PIN_SLP(gpd0-1, OUT0, NONE);
> >> +		PIN_SLP(gpd0-2, INPUT, DOWN);
> >> +		PIN_SLP(gpd0-3, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpd1-0, INPUT, NONE);
> >> +		PIN_SLP(gpd1-1, INPUT, NONE);
> >> +		PIN_SLP(gpd1-2, INPUT, DOWN);
> >> +		PIN_SLP(gpd1-3, INPUT, DOWN);
> >> +		PIN_SLP(gpd1-4, INPUT, DOWN);
> >> +		PIN_SLP(gpd1-5, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpe0-0, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-1, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-2, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-3, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-4, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-5, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-6, INPUT, DOWN);
> >> +		PIN_SLP(gpe0-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpe1-0, INPUT, DOWN);
> >> +		PIN_SLP(gpe1-1, INPUT, DOWN);
> >> +		PIN_SLP(gpe1-2, INPUT, DOWN);
> >> +		PIN_SLP(gpe1-3, OUT0, NONE);
> >> +		PIN_SLP(gpe1-4, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpf0-0, OUT0, NONE);
> >> +		PIN_SLP(gpf0-1, OUT0, NONE);
> >> +		PIN_SLP(gpf0-2, OUT0, NONE);
> >> +		PIN_SLP(gpf0-3, OUT0, NONE);
> >> +		PIN_SLP(gpf0-4, OUT0, NONE);
> >> +		PIN_SLP(gpf0-5, OUT0, NONE);
> >> +		PIN_SLP(gpf0-6, OUT0, NONE);
> >> +		PIN_SLP(gpf0-7, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpf1-0, OUT0, NONE);
> >> +		PIN_SLP(gpf1-1, OUT0, NONE);
> >> +		PIN_SLP(gpf1-2, OUT0, NONE);
> >> +		PIN_SLP(gpf1-3, OUT0, NONE);
> >> +		PIN_SLP(gpf1-4, OUT0, NONE);
> >> +		PIN_SLP(gpf1-5, OUT0, NONE);
> >> +		PIN_SLP(gpf1-6, OUT0, NONE);
> >> +		PIN_SLP(gpf1-7, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpf2-0, OUT0, NONE);
> >> +		PIN_SLP(gpf2-1, OUT0, NONE);
> >> +		PIN_SLP(gpf2-2, OUT0, NONE);
> >> +		PIN_SLP(gpf2-3, OUT0, NONE);
> >> +		PIN_SLP(gpf2-4, OUT0, NONE);
> >> +		PIN_SLP(gpf2-5, OUT0, NONE);
> >> +		PIN_SLP(gpf2-6, OUT0, NONE);
> >> +		PIN_SLP(gpf2-7, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpf3-0, OUT0, NONE);
> >> +		PIN_SLP(gpf3-1, OUT0, NONE);
> >> +		PIN_SLP(gpf3-2, OUT0, NONE);
> >> +		PIN_SLP(gpf3-3, OUT0, NONE);
> >> +		PIN_SLP(gpf3-4, PREV, NONE);
> >> +		PIN_SLP(gpf3-5, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpg0-0, INPUT, DOWN);
> >> +		PIN_SLP(gpg0-1, INPUT, DOWN);
> >> +		PIN_SLP(gpg0-2, INPUT, NONE);
> >> +		PIN_SLP(gpg0-3, INPUT, DOWN);
> >> +		PIN_SLP(gpg0-4, INPUT, DOWN);
> >> +		PIN_SLP(gpg0-5, INPUT, DOWN);
> >> +		PIN_SLP(gpg0-6, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpg1-0, OUT0, NONE);
> >> +		PIN_SLP(gpg1-1, OUT1, NONE);
> >> +		PIN_SLP(gpg1-2, PREV, NONE);
> >> +		PIN_SLP(gpg1-3, OUT1, NONE);
> >> +		PIN_SLP(gpg1-4, OUT1, NONE);
> >> +		PIN_SLP(gpg1-5, OUT1, NONE);
> >> +		PIN_SLP(gpg1-6, OUT1, NONE);
> >> +
> >> +		PIN_SLP(gpg2-0, OUT0, NONE);
> >> +		PIN_SLP(gpg2-1, OUT0, NONE);
> >> +		PIN_SLP(gpg2-2, INPUT, NONE);
> >> +		PIN_SLP(gpg2-3, OUT0, NONE);
> >> +		PIN_SLP(gpg2-4, OUT0, NONE);
> >> +		PIN_SLP(gpg2-5, OUT0, NONE);
> >> +		PIN_SLP(gpg2-6, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpg3-0, PREV, UP);
> >> +		PIN_SLP(gpg3-1, PREV, UP);
> >> +		PIN_SLP(gpg3-2, INPUT, NONE);
> >> +		PIN_SLP(gpg3-3, INPUT, DOWN);
> >> +		PIN_SLP(gpg3-4, OUT0, NONE);
> >> +		PIN_SLP(gpg3-5, OUT0, NONE);
> >> +		PIN_SLP(gpg3-6, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpi-0, PREV, NONE);
> > 
> > No such name. Did you mean gpgi?
> > 
> > 
> 
> The node in s5pv210-pinctrl.dtsi is called "gpgi", but the i2s0_bus config
> in that file uses just "gpi".  drivers/pinctrl/samsung/pinctrl-exynos-arm.c also
> notes it just as "gpi".  I think the node should probably be renamed.
> 

Good point. Will you send a fix for gpgi->gpi?

> >> +		PIN_SLP(gpi-1, INPUT, DOWN);
> >> +		PIN_SLP(gpi-2, PREV, NONE);
> >> +		PIN_SLP(gpi-3, PREV, NONE);
> >> +		PIN_SLP(gpi-4, PREV, NONE);
> >> +		PIN_SLP(gpi-5, INPUT, DOWN);
> >> +		PIN_SLP(gpi-6, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpj0-0, INPUT, NONE);
> >> +		PIN_SLP(gpj0-1, INPUT, NONE);
> >> +		PIN_SLP(gpj0-2, INPUT, NONE);
> >> +		PIN_SLP(gpj0-3, INPUT, NONE);
> >> +		PIN_SLP(gpj0-4, INPUT, NONE);
> >> +		PIN_SLP(gpj0-5, INPUT, DOWN);
> >> +		PIN_SLP(gpj0-6, OUT0, NONE);
> >> +		PIN_SLP(gpj0-7, INPUT, NONE);
> >> +
> >> +		PIN_SLP(gpj1-0, OUT1, NONE);
> >> +		PIN_SLP(gpj1-1, OUT0, NONE);
> >> +		PIN_SLP(gpj1-2, INPUT, DOWN);
> >> +		PIN_SLP(gpj1-3, PREV, NONE);
> >> +		PIN_SLP(gpj1-4, PREV, NONE);
> >> +		PIN_SLP(gpj1-5, OUT0, NONE);
> >> +
> >> +		PIN_SLP(gpj2-0, INPUT, DOWN);
> >> +		PIN_SLP(gpj2-1, INPUT, DOWN);
> >> +		PIN_SLP(gpj2-2, OUT0, NONE);
> >> +		PIN_SLP(gpj2-3, INPUT, DOWN);
> >> +		PIN_SLP(gpj2-4, INPUT, DOWN);
> >> +		PIN_SLP(gpj2-5, PREV, NONE);
> >> +		PIN_SLP(gpj2-6, PREV, NONE);
> >> +		PIN_SLP(gpj2-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(gpj3-0, INPUT, NONE);
> >> +		PIN_SLP(gpj3-1, INPUT, NONE);
> >> +		PIN_SLP(gpj3-2, OUT0, NONE);
> >> +		PIN_SLP(gpj3-3, INPUT, DOWN);
> >> +		PIN_SLP(gpj3-4, INPUT, NONE);
> >> +		PIN_SLP(gpj3-5, INPUT, NONE);
> >> +		PIN_SLP(gpj3-6, INPUT, NONE);
> >> +		PIN_SLP(gpj3-7, INPUT, NONE);
> >> +
> >> +		PIN_SLP(gpj4-0, INPUT, NONE);
> >> +		PIN_SLP(gpj4-1, INPUT, DOWN);
> >> +		PIN_SLP(gpj4-2, PREV, NONE);
> >> +		PIN_SLP(gpj4-3, INPUT, NONE);
> >> +		PIN_SLP(gpj4-4, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp01-0, OUT1, NONE);
> >> +		PIN_SLP(mp01-1, OUT0, NONE);
> >> +		PIN_SLP(mp01-2, INPUT, DOWN);
> >> +		PIN_SLP(mp01-3, INPUT, DOWN);
> >> +		PIN_SLP(mp01-4, OUT1, NONE);
> >> +		PIN_SLP(mp01-5, INPUT, DOWN);
> >> +		PIN_SLP(mp01-6, INPUT, DOWN);
> >> +		PIN_SLP(mp01-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp02-0, INPUT, DOWN);
> >> +		PIN_SLP(mp02-1, INPUT, DOWN);
> >> +		PIN_SLP(mp02-2, INPUT, NONE);
> >> +		PIN_SLP(mp02-3, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp03-0, INPUT, DOWN);
> >> +		PIN_SLP(mp03-1, INPUT, DOWN);
> >> +		PIN_SLP(mp03-2, OUT1, NONE);
> >> +		PIN_SLP(mp03-3, OUT0, NONE);
> >> +		PIN_SLP(mp03-4, INPUT, NONE);
> >> +		PIN_SLP(mp03-5, OUT0, NONE);
> >> +		PIN_SLP(mp03-6, INPUT, DOWN);
> >> +		PIN_SLP(mp03-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp04-0, INPUT, DOWN);
> >> +		PIN_SLP(mp04-1, OUT0, NONE);
> >> +		PIN_SLP(mp04-2, INPUT, DOWN);
> >> +		PIN_SLP(mp04-3, OUT0, NONE);
> >> +		PIN_SLP(mp04-4, INPUT, DOWN);
> >> +		PIN_SLP(mp04-5, INPUT, DOWN);
> >> +		PIN_SLP(mp04-6, OUT0, NONE);
> >> +		PIN_SLP(mp04-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp05-0, INPUT, NONE);
> >> +		PIN_SLP(mp05-1, INPUT, NONE);
> >> +		PIN_SLP(mp05-2, INPUT, NONE);
> >> +		PIN_SLP(mp05-3, INPUT, NONE);
> >> +		PIN_SLP(mp05-4, INPUT, DOWN);
> >> +		PIN_SLP(mp05-5, OUT0, NONE);
> >> +		PIN_SLP(mp05-6, INPUT, DOWN);
> >> +		PIN_SLP(mp05-7, PREV, NONE);
> >> +
> >> +		PIN_SLP(mp06-0, INPUT, DOWN);
> >> +		PIN_SLP(mp06-1, INPUT, DOWN);
> >> +		PIN_SLP(mp06-2, INPUT, DOWN);
> >> +		PIN_SLP(mp06-3, INPUT, DOWN);
> >> +		PIN_SLP(mp06-4, INPUT, DOWN);
> >> +		PIN_SLP(mp06-5, INPUT, DOWN);
> >> +		PIN_SLP(mp06-6, INPUT, DOWN);
> >> +		PIN_SLP(mp06-7, INPUT, DOWN);
> >> +
> >> +		PIN_SLP(mp07-0, INPUT, DOWN);
> >> +		PIN_SLP(mp07-1, INPUT, DOWN);
> >> +		PIN_SLP(mp07-2, INPUT, DOWN);
> >> +		PIN_SLP(mp07-3, INPUT, DOWN);
> >> +		PIN_SLP(mp07-4, INPUT, DOWN);
> >> +		PIN_SLP(mp07-5, INPUT, DOWN);
> >> +		PIN_SLP(mp07-6, INPUT, DOWN);
> >> +		PIN_SLP(mp07-7, INPUT, DOWN);
> >> +	};
> > 
> > What about gphX?
> 
> The gphX pins are in the alive area and don't have power down configs, they retain their
> state over suspend.  Therefore the samsung,pin-con-pdn and samsung,pin-pud-pdn properties
> have no effect (they're analogous to the gpxX pins in later Samsung SoCs).

Ah, good, thanks.

Best regards,
Krzysztof

