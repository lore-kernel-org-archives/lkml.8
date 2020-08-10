Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4818C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA69A206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597063932;
	bh=DMNsDDH8LuR3yPNSQyUdP2gU3+aEqSGZzyZNhAqSFQE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=vXAs18nlEUCq/4KWiimUylR+IwbN4UrE7RizntECxBotzDpAZpZtFu1D9+z2JZ/Wr
	 IxtBKixF7IsU1Ew8uy9LeRkcSJDUwkzWwpTMi+oes5sGFYp4niEKg4eilRg6lSzRbv
	 WlyqEllsJ4KT16dGqMWS4SwOpF6/+PxYtdgQqjS8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHJMwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgHJMv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:51:59 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9851C061756;
        Mon, 10 Aug 2020 05:51:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so9389881ljg.13;
        Mon, 10 Aug 2020 05:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GvWA+cHcTusPc74H1ig/BeGEZu0OoSLz8DXc1wSfXHY=;
        b=f/IUyKHBm8Vv1crRgafPxQxKJwAKNHp7asa01zBYOW3yFNi2bCvl7H+Lj5/pEOp1Pc
         Sb+Cc6wU8PRSlBrnpcr2jQ3XrV4zzD0dk6hsceuGadY/6achgV0j0ZwFUZ14zNMV0/RX
         ZhMHY+83ujPYUj+j1czDiXvV8YkjNR+lp/fRd5PxmYnzFF+FuWUiOmLX8bS34vUatXmh
         cldC1N5yR6LP0BqjY9OEXLMt3KPi0/V1L3035AW8Te12ppL0PTA3JYGpqM5GP4h2dz5r
         5s/0AlsJSwt09kYZofyz0lYanwofNBUmx68gfnmIafnv9A/ttRhE7uOesWK6cRVruoT7
         A05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=GvWA+cHcTusPc74H1ig/BeGEZu0OoSLz8DXc1wSfXHY=;
        b=D4gIANRQlhAPnUlDRlcyU7vdon/Bl1wQW1dh2E1z1k3n0Q7K6DieTNFwwy3PF9yIjD
         gNHP/NL8xyQdrSX2V3YUXhdrdUxYuVemo4qPYxdwMZkeuWzv7y8jqx4AyFzBFTRqnYQ1
         d+mtLPKigmR+eqJXd5X1B9hJdtgl1696ooBJY0MQP9pwIW+iRVrbiDk1yemp3+5jeKIY
         1UjiZep1Sl5tciuZ5C3K3ApKkvozUyZGOd9S/0umfHlpb40m99DE31VQ1n3XIf3mhDoe
         t/h+k28hP5PWFbOCxN6WGpbP5rHWs1E9WDcBbHEymiC644AnAdIwEBoaj+/uj8pt1aNG
         Y7jg==
X-Gm-Message-State: AOAM530BNBrjCxN9bxne8Jgknc95NY8nTQ52grB+X8UUKXrWbcysDLp0
        c7Qav+GM6mG51F6QhF8VNVt2yUClK2Y=
X-Google-Smtp-Source: ABdhPJwFXbAjLj8UYUeq2//BnaEY3ybYVGLtp0rzkIBXkXH9x1z7wc3VCUCwOrimSp5BNS/sd8cDYw==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr452781ljp.373.1597063916939;
        Mon, 10 Aug 2020 05:51:56 -0700 (PDT)
Received: from saruman ([194.34.132.58])
        by smtp.gmail.com with ESMTPSA id 12sm9210870ljv.49.2020.08.10.05.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 05:51:56 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 09/41] usb: gadget: s3c-hsudc: remove platform header dependency
In-Reply-To: <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-9-krzk@kernel.org> <87v9hupnf7.fsf@kernel.org> <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
Date:   Mon, 10 Aug 2020 15:51:51 +0300
Message-ID: <87a6z2pst4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Arnd Bergmann <arnd@arndb.de> writes:

> On Fri, Aug 7, 2020 at 3:59 PM Felipe Balbi <balbi@kernel.org> wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>
>> > +#include <linux/delay.h>
>> > +
>> >  #define S3C2443_CLKREG(x)            ((x) + S3C24XX_VA_CLKPWR)
>> >
>> >  #define S3C2443_PLLCON_MDIVSHIFT     16
>> > @@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned in=
t baseclk)
>> >       return (unsigned int)fvco;
>> >  }
>> >
>> > +static inline void s3c_hsudc_init_phy(void)
>>
>> This should, really, be a PHY driver under drivers/phy, since the goal
>> is to make this platform-independent, might as well take the opportunity
>> to introduce a proper driver, no?
>
> In theory, this is absolutely correct. I fear it will be hard to find any=
one
> to make a larger scale cleanup of the file however. As my old changelog
> text says, there is only one board (smdk2416) in the kernel that registers
> the device. My change was the minimum to keep it working during the
> move to a multiplatform configuration, but if there is someone who has
> the hardware and volunteers to make a proper phy driver, that would also
> work.
>
> As the board only exists as a reference for other boards, but none of tho=
se
> made it into the kernel, we could alternatively just decide to drop the
> driver. There is also a .dts file for the board, which is lacking a devic=
e node
> for the udc (and the driver lacks DT support), so that board file could a=
lso
> be dropped then, leaving only the DT version as a reference for the SoC.

I don't mind deleting the entire thing if nobody is using it. The entire
history of the driver consists of only 65 commits and if you look at the
actual commits, there has been no real maintenance work on it for a long
time, most commits are regular janitorial work and updates due to
framework changes:

6e1591947304 udc: s3c-hsudc: Silence warning about supplies during deferred=
 probe
237b668c1c5d usb: gadget: s3c-hsudc: use devm_platform_ioremap_resource() t=
o simplify code
b33f37064b74 usb: Remove dev_err() usage after platform_get_irq()
229e3682393c USB: gadget: udc: Remove redundant license text
5fd54ace4721 USB: add SPDX identifiers to all remaining files in drivers/us=
b/
977ac789507a usb: gadget: udc: constify usb_ep_ops structures
ca0709946023 usb: gadget: s3c-hsudc: remove redundant condition
bc1b9f300ae0 usb: gadget: s3c-hsudc: add ep capabilities support
22835b807e7c usb: gadget: remove unnecessary 'driver' argument
6ce372fed2cb usb: gadget: udc: s3c-hsudc: remove bind/unbind messages
82891b959cbb usb: gadget: udc: s3c-hsudc: do not rely on 'driver' argument
3dc3b4e15e09 usb: gadget: s3c-hsudc: delete unnecessary 'out of memory' mes=
sages
6d3f5f2d895b usb: gadget: udc: drop owner assignment from platform_drivers
304f7e5e1d08 usb: gadget: Refactor request completion
90fccb529d24 usb: gadget: Gadget directory cleanup - group UDC drivers
236064c25358 usb: gadget: s3c-hsudc: remove unused label
e117e742d310 usb: gadget: add "maxpacket_limit" field to struct usb_ep
e01ee9f509a9 usb: gadget: use dev_get_platdata()
38678f25689c usb: gadget: s3c-hsudc: delete outdated comment
492a39022ad5 usb: gadget: s3c-hsudc: don't touch gadget.dev.driver
4c422049bd0f usb: gadget: s3c-hsudc: remove unnecessary initializations
7bce401cc6db usb: gadget: drop now unnecessary flag
40ed30cff595 usb: gadget: s3c-hsudc: let udc-core manage gadget->dev
eeef45876631 (tag: gadget-for-v3.9) usb: gadget: constify all struct usb_ga=
dget_ops
148e11349b0c usb: Convert to devm_ioremap_resource()
32b8666589d5 usb: gadget: remove u32 castings of address passed to readl()
924d2532ab18 usb: gadget: s3c-hsudc: Use devm_regulator_bulk_get
41ac7b3ab7fe usb: remove use of __devinit
dc2cdcaf4caa usb: gadget: s3c-hsudc: Replace 0 with NULL for pointers
affaab4c58d8 usb: gadget: s3c-hsudc: Add missing braces around sizeof
78f0c53ef856 usb: gadget: s3c-hsudc: Use devm_* functions
ded017ee6c7b usb: phy: fix return value check of usb_get_phy
662dca54ca67 usb: otg: support for multiple transceivers by a single contro=
ller
721002ec1dd5 usb: otg: utils: rename function name in OTG utils
109f0f718375 usb: gadget: s3c-hsudc.c: Remove unneeded condition
955846a60a9d usb: gadget: Update s3c-hsudc to use usb_endpoint_descriptor i=
nside the struct usb_ep
6e13c6505cdf (tag: xceiv-for-v3.4) usb: otg: Convert all users to pass stru=
ct usb_otg for OTG functions
b96d3b08365f usb: Convert all users to new usb_phy
f9c56cdd3905 usb: gadget: Clear usb_endpoint_descriptor inside the struct u=
sb_ep on disable
8675381109b0 usb: otg: Rename otg_transceiver to usb_phy
294f78ec493e usb: s3c-hsudc: add basic runtime_pm calls
2d4172c93874 usb: s3c-hsudc: Use helper functions instead of generic contai=
ner_of
922be95a3f26 usb: gadget: s3c-hsudc: remove the_controller global
dee19be7d8ed usb: gadget: s3c-hsudc: use release_mem_region instead of rele=
ase_resource
bab7d037c84f usb: gadget: s3c-hsudc: Add regulator handling
d93e2600d80f usb: gadget: s3c-hsudc: use udc_start and udc_stop functions
103495aaf0e7 usb: gadget: s3c-hsudc: move device registration to probe
e9bcb9e5feb0 usb: gadget: s3c-hsudc: add missing otg_put_transceiver in pro=
be
a1977562718f usb: gadget: s3c-hsudc: add __devinit to probe function
715a3e41e78a usb: gadget: s3c-hsudc: move platform_data struct to global he=
ader
7177aed44f51 usb: gadget: rename usb_gadget_driver::speed to max_speed
d327ab5b6d66 usb: gadget: replace usb_gadget::is_dualspeed with max_speed
bfe0658b402d usb: udc: Fix gadget driver's speed check in various UDC drive=
rs
cc27c96c2bee usb: convert drivers/usb/* to use module_platform_driver()
fba9e546eac9 s3c-hsudc: implement vbus_draw hook
29cc88979a88 USB: use usb_endpoint_maxp() instead of le16_to_cpu()
938fbe54f33e s3c-hsudc: Add basic otg transceiver handling
da4fc14c9955 s3c-hsudc: Fix possible nullpointer dereference during probe
86081d7be34e usb: gadget: add platform module alias where it is missing
0f91349b89f3 usb: gadget: convert all users to the new udc infrastructure
6bc129532176 usb/s3c-hsudc: fix error path
b38b03b363a5 usb: gadget: include <linux/prefetch.h> to fix compiling error
d6167660b284 USB: s3c-hsudc: fix checkpatch error and warning
004c127ef071 USB: s3c-hsudc: use IS_ERR() instead of NULL check
a9df304cf78d USB: Gadget: Add Samsung S3C24XX USB High-Speed controller dri=
ver

If there are no objections, I'm okay deleting the driver.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8xQucACgkQzL64meEa
mQaidhAAoUNz9ltGIIdWbogdhbcTeY1faFBBnzQ7GvTWW18xSMD2+DfqptDwACc6
W2og6/Q8mdfLFvN29S3TcxzCp6ZclWrHsX55SHyJeUYVwyS6aAvlMmUPmy9WJZco
57sNMY4CjJ/BK+ZIvvWt8kyJE3ckpsweyhkSx8Z77PJOW1RIYC1GtgYepsvC+e6I
DsxSVTxmg/gfxRxObCK0F0DOX/gSGKMImPGoGRM3IYLLF8hPJGQGZ+1SSv2tKb8n
XZpGIKb/9mNylmAQu2hmNOQfaYZBFvZJHvt+bz+aWpkLB7unVYrLVGY5tfPFGvyC
wqROr3PiIUqCVrf46suH1Xm1ajN9FjXAJFn1EzScxZxge9CtWW9RIcxdq32dyyMG
Thkk3Xle4h6ELR4bOPSqONJFwIOGr8lMyQVFE2nwlm3MbErFv3S3szxNNQ4qqwWh
jqPS4Rdjz23Df6iUIy1EAfDU5bEx9YpUL/63BT+JAz0YvOowfR/wnWSVIoZAdN70
YhI8Zxe7UAUZeBuRi1uEAA7BgQB7zKpeY7QCBqHQfQaujXrNy0CLrWH22/tK+yej
pGR2ta4FZg0bwrUbZPIPuzRxjHXceh+QKCqMgrW8son53WZn9cKgZT4cLM3vsz8p
GHYPyKe6e3EK2Ll0diPPQybnACDB1135xVUOfEeLK/j076uQfjU=
=RjT4
-----END PGP SIGNATURE-----
--=-=-=--
