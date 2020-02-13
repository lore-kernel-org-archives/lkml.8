Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC18C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7992168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgBMIEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:04:51 -0500
Received: from mga01.intel.com ([192.55.52.88]:34611 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMIEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:04:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 00:04:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="252204791"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2020 00:04:50 -0800
Received: from [10.226.38.56] (unknown [10.226.38.56])
        by linux.intel.com (Postfix) with ESMTP id A91AE5802C1;
        Thu, 13 Feb 2020 00:04:47 -0800 (PST)
Subject: Re: [PATCH v4 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, qi-ming.wu@intel.com,
        yixin.zhu@linux.intel.com, cheol.yong.kim@intel.com,
        rtanwar <rahul.tanwar@intel.com>
References: <cover.1580374761.git.rahul.tanwar@linux.intel.com>
 <03edda37330a2b517b98afe0de99f082758a2219.1580374761.git.rahul.tanwar@linux.intel.com>
 <20200131022405.B98E72067C@mail.kernel.org>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <6b3e8322-40fa-0d79-3212-fae76d04de64@linux.intel.com>
Date:   Thu, 13 Feb 2020 16:04:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200131022405.B98E72067C@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Stephen,

Thanks a lot for taking time out to review and providing feedback. I have
tried to address all your review concerns except few below mentioned points
where i need more clarification.

On 31/1/2020 10:24 AM, Stephen Boyd wrote:
> Quoting Rahul Tanwar (2020-01-30 01:04:02)
>> From: rtanwar <rahul.tanwar@intel.com>
>>
>> Clock Generation Unit(CGU) is a new clock controller IP of a forthcoming

(...)

>> +               raw_spin_unlock_irqrestore(&ctx->lock, flags);
>> +       }
>> +
>> +       return clk_hw_register_fixed_rate(NULL, list->name,
>> +                                         list->parent_names[0],
>> +                                         list->flags, list->mux_flags);
> Can fixed rate clks come from DT? Or does this value change sometimes?

Fixed rate clks may need enable/disable clk ops. That's the only reason
for making it visible to clock driver.

>> +lgm_clk_ddiv_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                     unsigned long prate)
>> +{
>> +       struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
>> +       u32 div, ddiv1, ddiv2;
>> +       unsigned long flags;
>> +
>> +       div = DIV_ROUND_CLOSEST_ULL((u64)prate, rate);
>> +
>> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
>> +       if (lgm_get_clk_val(ddiv->membase, ddiv->reg, ddiv->shift2, 1)) {
>> +               div = DIV_ROUND_CLOSEST_ULL((u64)div, 5);
>> +               div = div * 2;
>> +       }
>> +       raw_spin_unlock_irqrestore(&ddiv->lock, flags);
> Does the math need to be inside the spinlock? Should probably not have
> any spinlock at all and just read it with lgm_get_clk_val() and trust
> that the hardware will return us something sane?
>
>> +
>> +       if (div <= 0)
>> +               return -EINVAL;
>> +
>> +       if (lgm_clk_get_ddiv_val(div, &ddiv1, &ddiv2))
>> +               return -EINVAL;
>> +
>> +       raw_spin_lock_irqsave(&ddiv->lock, flags);
>> +       lgm_set_clk_val(ddiv->membase, ddiv->reg, ddiv->shift0, ddiv->width0,
>> +                       ddiv1 - 1);
>> +
>> +       lgm_set_clk_val(ddiv->membase, ddiv->reg,  ddiv->shift1, ddiv->width1,
>> +                       ddiv2 - 1);
> Can this not be combined? lgm_set_clk_val is sort of obfuscating the
> code. Please consider inlining it and then holding the spinlock across
> this entire function while doing the read/modify/write.

These two set_clk_val's can not be combined because they have different
non-contiguous bitmaps (shifts) and lgm_set_clk_val() is defined to handle
only one shift. However, i have addressed your other comment i.e. inline it
and hold spinlock across the function during read/modify/write.

>> +struct lgm_clk_mux {
>> +       struct clk_hw hw;
>> +       struct device *dev;
>> +       void __iomem *membase;
>> +       unsigned int reg;
>> +       u8 shift;
>> +       u8 width;
>> +       unsigned long flags;
>> +       raw_spinlock_t lock;
>> +};
>> +
>> +struct lgm_clk_divider {
>> +       struct clk_hw hw;
>> +       struct device *dev;
>> +       void __iomem *membase;
>> +       unsigned int reg;
>> +       u8 shift;
>> +       u8 width;
>> +       u8 shift_gate;
>> +       u8 width_gate;
>> +       unsigned long flags;
>> +       const struct clk_div_table *table;
>> +       raw_spinlock_t lock;
>> +};
>> +
>> +struct lgm_clk_ddiv {
>> +       struct clk_hw hw;
>> +       struct device *dev;
>> +       void __iomem *membase;
>> +       unsigned int reg;
>> +       u8 shift0;
>> +       u8 width0;
>> +       u8 shift1;
>> +       u8 width1;
>> +       u8 shift2;
>> +       u8 width2;
>> +       u8 shift_gate;
>> +       u8 width_gate;
>> +       unsigned int mult;
>> +       unsigned int div;
>> +       unsigned long flags;
>> +       raw_spinlock_t lock;
>> +};
>> +
>> +struct lgm_clk_gate {
>> +       struct clk_hw hw;
>> +       struct device *dev;
> These all have dev pointers, is it necessary? In theory we can have a
> clk_hw API that gets the dev pointer out for you if you want it, now
> that we store the dev pointer when a clk registers

We needed dev pointers just for dev_err() in clk_ops when they are called
back from core. I have now removed dev_err() calls from the driver clk_ops
as i believe the error info was not that useful. And so i have removed dev
pointers from above structures.

However, i think it would be good to have a clk_hw API which returns dev
pointer for drivers. Presently, dev pointer is stored inside clk_hw->clk_core
and clk_core is private to core, inaccessible from clk drivers.

>> +enum pll_type {
>> +       TYPE_ROPLL,
>> +       TYPE_LJPLL,
>> +       TYPE_NONE,
> Is this used? Remove it if not.

It is actually used.

>> +struct lgm_pll_clk_data {
>> +       unsigned int id;
>> +       const char *name;
>> +       const char *const *parent_names;
> Can you use the new way of specifying clk parents instead of using plain
> strings? Reminder to self, write that document.

I have changed it to new way i.e. by using fw_name. Only exception is where we
use clk API's clk_hw_register_fixed_rate() & clk_hw_register_fixed_factor().
In these API's, i am, for now, passing parent_data[0].name as parent_name.

>> +/* clock flags definition */
>> +#define CLOCK_FLAG_VAL_INIT    BIT(16)
>> +#define GATE_CLK_HW            BIT(17)
>> +#define GATE_CLK_SW            BIT(18)
>> +#define MUX_CLK_SW             GATE_CLK_SW
> Why do these bits start at 16? 

To avoid the conflict with clk_flags used across common struct clk
defined in clk-provider.h. Bits 0~13 are already used there. So
we keep some gap and start with 16 :). We don't maintain a separate
pure driver only flags bitmask as that would make it confusing.

> What does _HW and _SW mean? Is there
> hardware control of clks?

GATE_CLK_HW & GATE_CLK_SW is no longer needed for this SoC. So i have
removed it. MUX_CLK_SW is still needed. It is more of a workaround for
one particular combophy module for which get_parent/set_parent does not
apply (no hardware translation to select/query input clk source).
However, other MUX clks in this clk group have valid hardware translation
for parent clock sources.

>> +static const struct clk_div_table dcl_div[] = {
>> +       { .val = 0, .div = 6  },
>> +       { .val = 1, .div = 12 },
>> +       { .val = 2, .div = 24 },
>> +       { .val = 3, .div = 32 },
>> +       { .val = 4, .div = 48 },
>> +       { .val = 5, .div = 96 },
>> +       {}
> I guess 'div' being equal to 0 is the terminator?

Yes, but i am missing your point. Can you please elaborate more ?

>> +       ctx->np = np;
>> +       ctx->dev = dev;
>> +       raw_spin_lock_init(&ctx->lock);
> Why is it a raw spinlock?

Agree. We use CONFIG_SMP with no PREEMPT_RT. So i think it is same.
Have switched to normal spinlocks.

Regards,
Rahul
