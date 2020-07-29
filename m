Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91163C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 797BA2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgG2QWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgG2QWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:22:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1678C061794;
        Wed, 29 Jul 2020 09:22:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id 7291A298404
Subject: Re: [PATCH 2/3] ARM: l2c: update prefetch bits in L2X0_AUX_CTRL using
 DT value
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <860eb8a1eed879e55daf960c96acdac514cbda93.1596028601.git.guillaume.tucker@collabora.com>
 <79a628daef56c2d542e379f550de21da4fe3c901.1596028601.git.guillaume.tucker@collabora.com>
 <20200729141801.GB1551@shell.armlinux.org.uk>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <a85d7b4e-abfd-268a-01a5-f78068d7e30c@collabora.com>
Date:   Wed, 29 Jul 2020 17:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729141801.GB1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/2020 15:18, Russell King - ARM Linux admin wrote:
> On Wed, Jul 29, 2020 at 02:47:32PM +0100, Guillaume Tucker wrote:
>> The L310_PREFETCH_CTRL register bits 28 and 29 to enable data and
>> instruction prefetch respectively can also be accessed via the
>> L2X0_AUX_CTRL register.  They appear to be actually wired together in
>> hardware between the registers.  Changing them in the prefetch
>> register only will get undone when restoring the aux control register
>> later on.  For this reason, set these bits in both registers during
>> initialisation according to the DT attributes.
> 
> How will that happen?
> 
> We write the auxiliary control register before the prefetch control
> register, so the prefetch control register will take precedence.  See
> l2c310_configure() - l2c_configure() writes the auxiliary control
> register, and the function writes the prefetch control register later.

What I'm seeing is that outer_cache.configure() gets called, at
least on exynos4412-odroidx2.  See l2c_enable():

	if (outer_cache.configure)
		outer_cache.configure(&l2x0_saved_regs);
	else
		l2x0_data->configure(base);

Then instead of l2c310_configure(), exynos_l2_configure() gets
called and writes prefetch_ctrl right before aux_ctrl.  Should
exynos_l2_configure() be changed to swap the register writes?


> I think the real issue is that Exynos has been modifying the prefetch
> settings via its machine .aux_mask / .aux_val configuration, and the
> opposite is actually true: the prefetch control register values will
> overwrite the attempt to modify the auxiliary control values set through
> the machine .aux_mask/.aux_val.

Yes with l2c310_configure() but not with exynos_l2_configure().

To be clear, this is what I've found to be happening, if you
switch to using the device tree prefetch attributes and clear
the bits in the default l2c_aux_val (see PATCH 3/3):

1. l2x0_of_init() first gets called with the default aux_val

2. l2c310_of_parse() sets the bits in l2x0_saved_regs.prefetch_ctrl
   but not in aux_val (unless you apply this patch 2/3)

3. l2c_enable() calls exynos_l2_configure() which writes
   prefetch_ctrl and then aux_ctrl - thus setting the prefetch bits
   and then clearing them just after

4. l2c310_enable() reads back aux_ctrl and prefetch, both of which
   now have the bits cleared (the pr_info() message about prefetch
   enabled gets skipped)


That's why I thought it would be safer to set the prefetch bits
in both registers so it should work regardless if the
initialisation sequence.  Also, if we want these bits to be
changed, we should clear them in the aux_mask value to not get
another error message about register corruption - so I'm doing
that too.

Thanks,
Guillaume


>> Fixes: ec3bd0e68a67 ("ARM: 8391/1: l2c: add options to overwrite prefetching behavior")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  arch/arm/mm/cache-l2x0.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index 12c26eb88afb..43d91bfd2360 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -1249,20 +1249,28 @@ static void __init l2c310_of_parse(const struct device_node *np,
>>  
>>  	ret = of_property_read_u32(np, "prefetch-data", &val);
>>  	if (ret == 0) {
>> -		if (val)
>> +		if (val) {
>>  			prefetch |= L310_PREFETCH_CTRL_DATA_PREFETCH;
>> -		else
>> +			*aux_val |= L310_PREFETCH_CTRL_DATA_PREFETCH;
>> +		} else {
>>  			prefetch &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>> +			*aux_val &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>> +		}
>> +		*aux_mask &= ~L310_PREFETCH_CTRL_DATA_PREFETCH;
>>  	} else if (ret != -EINVAL) {
>>  		pr_err("L2C-310 OF prefetch-data property value is missing\n");
>>  	}
>>  
>>  	ret = of_property_read_u32(np, "prefetch-instr", &val);
>>  	if (ret == 0) {
>> -		if (val)
>> +		if (val) {
>>  			prefetch |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
>> -		else
>> +			*aux_val |= L310_PREFETCH_CTRL_INSTR_PREFETCH;
>> +		} else {
>>  			prefetch &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
>> +			*aux_val &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
>> +		}
>> +		*aux_mask &= ~L310_PREFETCH_CTRL_INSTR_PREFETCH;
>>  	} else if (ret != -EINVAL) {
>>  		pr_err("L2C-310 OF prefetch-instr property value is missing\n");
>>  	}
>> -- 
>> 2.20.1
>>
>>
> 

