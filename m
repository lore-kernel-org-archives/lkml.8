Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C1C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9D29207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="siWYpvKy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgAML5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:57:54 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33138 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgAML5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:57:54 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00DBuknD091396;
        Mon, 13 Jan 2020 05:56:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578916606;
        bh=9n718e+eW2JIWIXzt3IYQ2kWyec/YziAStfyqoDrUzE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=siWYpvKyiSQIfqjGzS0WEV/lPdV1/JWIqcXlTspERLmvuoirkRmAsIGRqOljYMpda
         HuuZI8ZdS3/VCiQPQNeZ+35gBgjpipAEZXs67tt95BpR8su2hJeWyMDXYM14FcJHMF
         wEGshRhaA+gEc3Ryioh7I3U+ZCEOAMDp23Il6stg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00DBuk1M070641
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jan 2020 05:56:46 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 13
 Jan 2020 05:56:45 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 13 Jan 2020 05:56:45 -0600
Received: from [172.24.145.246] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00DBugXg122482;
        Mon, 13 Jan 2020 05:56:43 -0600
Subject: Re: [PATCH v3 1/3] clocksource: davinci: only enable clockevents once
 tim34 is initialized
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20200110171643.18578-1-brgl@bgdev.pl>
 <20200110171643.18578-2-brgl@bgdev.pl>
 <7be95251-7e26-6090-4770-6e4dbebfadd2@linaro.org>
 <CAMRc=McesmYcJv7iqE3rLHFyeTJtnW4Gq1TjMjHGSkpcHNPahw@mail.gmail.com>
 <CAKnoXLygqQ5eSfp+bwixtGVKEFnzw0h7XSPV4qXaGjUg_KtJYQ@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <d0897001-5290-b81d-d480-1c2d92db486c@ti.com>
Date:   Mon, 13 Jan 2020 17:26:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAKnoXLygqQ5eSfp+bwixtGVKEFnzw0h7XSPV4qXaGjUg_KtJYQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel, Bart,

On 11/01/20 3:59 PM, Daniel Lezcano wrote:
> 
> 
> On Sat, 11 Jan 2020 at 11:20, Bartosz Golaszewski <brgl@bgdev.pl
> <mailto:brgl@bgdev.pl>> wrote:
> 
>     pt., 10 sty 2020 o 18:56 Daniel Lezcano <daniel.lezcano@linaro.org
>     <mailto:daniel.lezcano@linaro.org>> napisał(a):
>     >
>     > On 10/01/2020 18:16, Bartosz Golaszewski wrote:
>     > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com
>     <mailto:bgolaszewski@baylibre.com>>
>     > >
>     > > The DM365 platform has a strange quirk (only present when using
>     ancient
>     > > u-boot - mainline u-boot v2013.01 and later works fine) where if we
>     > > enable the second half of the timer in periodic mode before we
>     do its
>     > > initialization - the time won't start flowing and we can't boot.
>     > >
>     > > When using more recent u-boot, we can enable the timer, then
>     reinitialize
>     > > it and all works fine.
>     > >
>     > > To work around this issue only enable clockevents once tim34 is
>     > > initialized i.e. move clockevents_config_and_register() below tim34
>     > > initialization.
>     > >
>     > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com
>     <mailto:bgolaszewski@baylibre.com>>
>     >
>     > Shall I take it through my tree?
>     >
> 
>     Not sure, I'd say Sekhar should take it through arm-soc together with
>     the latter two patches if he's ok with this. Let's wait for him to
>     respond.
> 
> 
> Just in case:
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org
> <mailto:daniel.lezcano@linaro.org>>

I was able to test the series on all 6 DaVinci SoCs. I will send this
upstream with Daniel's ack.

Thanks,
Sekhar
