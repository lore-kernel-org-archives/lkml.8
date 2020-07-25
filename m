Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4170AC433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AAF4206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 19:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="AYL24dWC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WlszfhUb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbgGYTSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 15:18:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:34397 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726381AbgGYTSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 15:18:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0443B5C00CA;
        Sat, 25 Jul 2020 15:18:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 25 Jul 2020 15:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=r
        WYFqMi0Bc4yD9F0ulehRfAQBdRpLQU+sbOfDtxKETM=; b=AYL24dWCsNSJoR3J7
        49Z604uXy1bARXjeh+9TIP23BVdgIBBs/7KsJ5zdlayVP110mLvMNtIAQqggsAT7
        5LIr4f2P1hS+dKF5IJUjIeXMADBxH1p5wO10AV+3JbwQT6x5Ezp7Wxqtz0LvFa9c
        AfnllR5TOI4Erx3Y6OibtgZJonHkGF9gnwh447n4pwJr/25sfH8AGO/oEz5X26m8
        l0F90yjTA4nlDGlFcc+46bfIYYuWri+ytwbuSJ5HV7Scnde+j5Nigl+Zv++z6Rnp
        ndG3v61EcxaYw+nZmTVXF+Imk5WYCmddhPi090btGtnIZT6y9MdfWS4CAGMN0pxn
        shTDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=rWYFqMi0Bc4yD9F0ulehRfAQBdRpLQU+sbOfDtxKE
        TM=; b=WlszfhUbL/eAqIxpSEN+45puRzOzyhq7lKG/ppk62McHtQ+U4dPV2mi+L
        uQfsLNWIpx2s0rtxHl614oyePRGj1C+vwbCRiqW5AcTMYOmUdaUBrPeQkpHRX/YY
        BBO0W8hmnfdvhR0X3HEPqMNYW2HgMfG4uOd4ysyF9+W1PEfymdRk7Vt5dFFHrId6
        1vqe4Z3CDNreFV5JttQbR31WN0u/SszWGN0pHkny3dXucqLlQ0gkng/dcY5nL78i
        lyNQa4wZwRkRMVgBi5GTQ2FFVTZWBgZIqnwiUFU8XNcPPoknUejJQGLeNdtN6o6k
        AmhtU+C5moPYl1hKpJQHIkz43n05Q==
X-ME-Sender: <xms:kIUcX_j718I3fRag_OLmiodGDTbF-7Kj_qxAEkDlKLlq8EPcLXJv5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrheehgddufeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:kIUcX8A07aJoVhbI5fnJbcab5Ew8DFOMY1ouuVh0gm-f5KRFYdHo9w>
    <xmx:kIUcX_FNxJTuGDkpwEWlVX67SFrCyOkpYPT9h_w4SpZxjm79YqETBw>
    <xmx:kIUcX8Qhq9L5tofcNWTI4_gi4XlYoB2qdnoIOBobyy4tnmTbu5ExTA>
    <xmx:kYUcX2sqoZX4tKW10J1Gt0dRF1_Hq4YGTZldnHgBQbjJr3VtP9qF2w>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0B20530600A3;
        Sat, 25 Jul 2020 15:18:40 -0400 (EDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_1/3=5d_dt-bindings=3a_gpio=3a_sunxi?=
 =?UTF-8?Q?=ef=bc=9acreate_a_DT_header_for_Allwinner_pin_controller?=
To:     Maxime Ripard <maxime@cerno.tech>,
        Frank Lee <frank@allwinnertech.com>
Cc:     robh+dt@kernel.org, wens@csie.org, tiny.windzz@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200715115412.2544-1-frank@allwinnertech.com>
 <20200717160727.e6y5htg4sjd7bezi@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <db1908ae-817c-f30d-7b88-f4afa593b258@sholland.org>
Date:   Sat, 25 Jul 2020 14:18:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200717160727.e6y5htg4sjd7bezi@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime,

On 7/17/20 11:07 AM, Maxime Ripard wrote:
> Hi!
> 
> On Wed, Jul 15, 2020 at 07:54:12PM +0800, Frank Lee wrote:
>> From: Yangtao Li <frank@allwinnertech.com>
>>
>> The sunxi gpio binding defines a few custom cells for its gpio specifier.
>> Provide bank name for those.
>>
>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> 
> Thanks for working on this, I wanted to do it at some point but it kept
> getting pushed further into my todo list.
> 
>> ---
>>  include/dt-bindings/gpio/sunxi-gpio.h | 29 +++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>  create mode 100644 include/dt-bindings/gpio/sunxi-gpio.h
>>
>> diff --git a/include/dt-bindings/gpio/sunxi-gpio.h b/include/dt-bindings/gpio/sunxi-gpio.h
>> new file mode 100644
>> index 000000000000..c692b4360da6
>> --- /dev/null
>> +++ b/include/dt-bindings/gpio/sunxi-gpio.h
> 
> So generally we've been using the compatible name as the file name. You
> should follow that convention too, and since it was added with the A10,
> using the A10 compatible.
> 
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * GPIO definitions for Allwinner SoCs
>> + *
>> + * Copyright (C) 2020 Yangtao Li <frank@allwinnertech.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_SUNXI_GPIO_H
>> +#define _DT_BINDINGS_SUNXI_GPIO_H
>> +
>> +#include <dt-bindings/gpio/gpio.h>
>> +
>> +/* pio */
>> +#define PA	0
>> +#define PB	1
>> +#define PC	2
>> +#define PD	3
>> +#define PE	4
>> +#define PF	5
>> +#define PG	6
>> +#define PH	7
>> +#define PI	8
>> +
>> +/* r-pio */
>> +#define PL	0
>> +#define PM	1
>> +#define PN	2
>> +
>> +#endif /* _DT_BINDINGS_SUNXI_GPIO_H */
> 
> Maybe we can go one step further and use a macro to have something like
> PIN(A, 12) ?

Since we have separate cells for the bank and pin, I don't think it would be
appropriate to have a single macro generating both. And I'm not sure what the
benefit of the macro would be, if all it does is forward its arguments. Are you
concerned that P[A-M] could conflict with something else in the device tree?

Cheers,
Samuel
