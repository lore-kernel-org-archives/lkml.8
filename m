Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3E8C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AF952075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIJGak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:30:40 -0400
Received: from mga18.intel.com ([134.134.136.126]:17717 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgIJGaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:30:39 -0400
IronPort-SDR: 2IfyOgCIjaY2IxGhSlaisomYhAGWDbZjscqYNcrVr6BaAZjLR0s9+h0i36P6pe9EMB91TbCkrn
 uRi+n/NvvppQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9739"; a="146197074"
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="146197074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 23:30:38 -0700
IronPort-SDR: 2SHvKZI52W59UxXnsyvreedC99fKtuEdJuAxlKNpWlJrk1m+lUcI8uM0z7CuYb3m9q1Nk6u5j/
 IlxShIQtMKTg==
X-IronPort-AV: E=Sophos;i="5.76,412,1592895600"; 
   d="scan'208";a="480766765"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 23:30:34 -0700
Date:   Thu, 10 Sep 2020 14:30:32 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v3 02/17] x86/acrn: Introduce acrn_{setup,
 remove}_intr_handler()
Message-ID: <20200910063032.GJ13723@shuo-intel.sh.intel.com>
References: <20200909090836.46762-1-shuo.a.liu@intel.com>
 <20200909090836.46762-3-shuo.a.liu@intel.com>
 <20200909093609.GA607744@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200909093609.GA607744@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed  9.Sep'20 at 11:36:09 +0200, Greg Kroah-Hartman wrote:
>On Wed, Sep 09, 2020 at 05:08:21PM +0800, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> The ACRN Hypervisor builds an I/O request when a trapped I/O access
>> happens in User VM. Then, ACRN Hypervisor issues an upcall by sending
>> a notification interrupt to the Service VM. HSM in the Service VM needs
>> to hook the notification interrupt to handle I/O requests.
>>
>> Notification interrupts from ACRN Hypervisor are already supported and
>> a, currently uninitialized, callback called.
>>
>> Export two APIs for HSM to setup/remove its callback.
>>
>> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Fengwei Yin <fengwei.yin@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> ---
>>  arch/x86/include/asm/acrn.h |  8 ++++++++
>>  arch/x86/kernel/cpu/acrn.c  | 19 +++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>  create mode 100644 arch/x86/include/asm/acrn.h
>>
>> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
>> new file mode 100644
>> index 000000000000..ff259b69cde7
>> --- /dev/null
>> +++ b/arch/x86/include/asm/acrn.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_X86_ACRN_H
>> +#define _ASM_X86_ACRN_H
>> +
>> +void acrn_setup_intr_handler(void (*handler)(void));
>> +void acrn_remove_intr_handler(void);
>> +
>> +#endif /* _ASM_X86_ACRN_H */
>> diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
>> index 0b2c03943ac6..bd1d7e759a0f 100644
>> --- a/arch/x86/kernel/cpu/acrn.c
>> +++ b/arch/x86/kernel/cpu/acrn.c
>> @@ -9,7 +9,11 @@
>>   *
>>   */
>>
>> +#define pr_fmt(fmt) "acrn: " fmt
>> +
>>  #include <linux/interrupt.h>
>> +
>> +#include <asm/acrn.h>
>>  #include <asm/apic.h>
>>  #include <asm/cpufeatures.h>
>>  #include <asm/desc.h>
>> @@ -55,6 +59,21 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_acrn_hv_callback)
>>  	set_irq_regs(old_regs);
>>  }
>>
>> +void acrn_setup_intr_handler(void (*handler)(void))
>> +{
>> +	if (acrn_intr_handler)
>> +		pr_warn("Overwrite the acrn_intr_handler.\n");
>
>What can someone do with this warning?  If it's really an "error", why
>not prevent this from happening?

It cannot happen if there are not new user of it. The current user is
HSM hsm_init()/hsm_exit() in the later patches of this series.

I can remove the warn.

>
>Don't scare users with things they can do nothing about.

OK. Got it. Thanks.

Thanks
shuo
