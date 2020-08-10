Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AB6C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB272075F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgHJM3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJM3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:29:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0462C061756;
        Mon, 10 Aug 2020 05:29:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 3839228F8D9
Subject: Re: [PATCH 3/3] ARM: exynos: use DT prefetch attributes rather than
 l2c_aux_val
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
 <5e41140ddb1afe42699715cca59c44fa2fa29e60.1596028601.git.guillaume.tucker@collabora.com>
 <20200803131147.GA476@kozik-lap>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <5a68730d-f082-a096-38eb-eaadbbc462b2@collabora.com>
Date:   Mon, 10 Aug 2020 13:29:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803131147.GA476@kozik-lap>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2020 14:13, Krzysztof Kozlowski wrote:
> On Wed, Jul 29, 2020 at 02:47:33PM +0100, Guillaume Tucker wrote:
>> Use the standard l2c2x0 device tree bindings to enable data and
>> instruction prefetch on exynos4210 and exynos4412 and clear the
>> respective bits in the default l2c_aux_val.  No other Exynos platform
>> relying on this default register value appears to be using the l2x0
>> cache.
>>
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  arch/arm/boot/dts/exynos4210.dtsi | 2 ++
>>  arch/arm/boot/dts/exynos4412.dtsi | 2 ++
>>  arch/arm/mach-exynos/exynos.c     | 4 ++--
> 
> I will need these split between DTS and mach changes.

Of course, sorry.  Fixed in v2.

Thanks,
Guillaume
