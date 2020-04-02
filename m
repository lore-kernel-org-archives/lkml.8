Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FB0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A997420737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389846AbgDBQUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:20:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:43103 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389728AbgDBQUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:20:14 -0400
IronPort-SDR: 9P8R+hlwhoqEGzg1wCCDdpnWel0AUfixlTxmTqeG9rs1sJXymi3U4VaeKmaP2cJGwiWcpAbpyS
 fGNJpdTjsp9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:20:12 -0700
IronPort-SDR: usaSS/O5T4KgS61v6ciVkUDHm6BELViYxt15gSpY8R+8JtWdcxJQ638mAOHITOwrw5RInu5SHS
 Sdvto8nk9dhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="273623551"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.249.169.179]) ([10.249.169.179])
  by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2020 09:20:09 -0700
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
To:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
Date:   Fri, 3 Apr 2020 00:20:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200402152340.GL20713@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/2020 11:23 PM, Peter Zijlstra wrote:
> 
> I picked VMXOFF (which also appears in vmmon.ko) instead of VMXON
> because that latter takes an argument is therefore more difficult to
> decode.
> 
> ---
> Subject: x86,module: Detect VMX modules and disable Split-Lock-Detect
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 02 Apr 2020 14:32:59 +0200
> 
> It turns out that with Split-Lock-Detect enabled (default) any VMX
> hypervisor needs at least a little modification in order to not blindly
> inject the #AC into the guest without the guest being ready for it.
> 
> Since there is no telling which module implements a hypervisor, scan the
> module text and look for the VMLAUNCH/VMXOFF instructions. If found, the
> module is assumed to be a hypervisor of some sort and SLD is disabled.
> 
> Hypervisors, which have been modified and are known to work correctly,
> can add:
> 
>    MODULE_INFO(sld_safe, "Y");
> 
> to explicitly tell the module loader they're good.
> 
> NOTE: it is unfortunate that struct load_info is not available to the
>        arch module code, this means CONFIG_CPU_SUP_INTEL gunk is needed
>        in generic code.
> 
> NOTE: while we can 'trivially' fix KVM, we're still stuck with stuff
>        like VMware and VirtualBox doing their own thing.
> 
> Reported-by: "Kenneth R. Crudup" <kenny@panix.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   arch/x86/include/asm/cpu.h  |    2 ++
>   arch/x86/kernel/cpu/intel.c |   41 ++++++++++++++++++++++++++++++++++++++++-
>   arch/x86/kernel/module.c    |    6 ++++++
>   include/linux/module.h      |    4 ++++
>   kernel/module.c             |    5 +++++
>   5 files changed, 57 insertions(+), 1 deletion(-)
> 
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -44,6 +44,7 @@ unsigned int x86_stepping(unsigned int s
>   extern void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c);
>   extern void switch_to_sld(unsigned long tifn);
>   extern bool handle_user_split_lock(struct pt_regs *regs, long error_code);
> +extern void split_lock_validate_module_text(struct module *me, void *text, void *text_end);
>   #else
>   static inline void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c) {}
>   static inline void switch_to_sld(unsigned long tifn) {}
> @@ -51,5 +52,6 @@ static inline bool handle_user_split_loc
>   {
>   	return false;
>   }
> +static inline void split_lock_validate_module_text(struct module *me, void *text, void *text_end) {}
>   #endif
>   #endif /* _ASM_X86_CPU_H */
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -9,6 +9,7 @@
>   #include <linux/thread_info.h>
>   #include <linux/init.h>
>   #include <linux/uaccess.h>
> +#include <linux/module.h>
>   
>   #include <asm/cpufeature.h>
>   #include <asm/pgtable.h>
> @@ -21,6 +22,7 @@
>   #include <asm/elf.h>
>   #include <asm/cpu_device_id.h>
>   #include <asm/cmdline.h>
> +#include <asm/insn.h>
>   
>   #ifdef CONFIG_X86_64
>   #include <linux/topology.h>
> @@ -1055,12 +1057,49 @@ static void sld_update_msr(bool on)
>   {
>   	u64 test_ctrl_val = msr_test_ctrl_cache;
>   
> -	if (on)
> +	if (on && (sld_state != sld_off))
>   		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>   
>   	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
>   }
>   
> +static void sld_remote_kill(void *arg)
> +{
> +	sld_update_msr(false);
> +}
> +
> +void split_lock_validate_module_text(struct module *me, void *text, void *text_end)
> +{
> +	u8 vmxoff[] = { 0x0f, 0x01, 0xc4 };
> +	u8 vmlaunch[] = { 0x0f, 0x01, 0xc2 };
> +	struct insn insn;
> +
> +	if (sld_state == sld_off)
> +		return;
> +
> +	while (text < text_end) {
> +		kernel_insn_init(&insn, text, text_end - text);
> +		insn_get_length(&insn);
> +
> +		if (WARN_ON_ONCE(!insn_complete(&insn)))
> +			break;
> +
> +		if (insn.length == 3 &&
> +		    (!memcmp(text, vmlaunch, sizeof(vmlaunch)) ||
> +		     !memcmp(text, vmxoff, sizeof(vmxoff))))
> +				goto bad_module;
> +
> +		text += insn.length;
> +	}
> +
> +	return;
> +
> +bad_module:
> +	pr_warn("disabled due to VMX in module: %s\n", me->name);
> +	sld_state = sld_off;

shouldn't we remove the __ro_after_init of sld_state?

And, shouldn't we clear X86_FEATURE_SPLIT_LOCK_DETECT flag?

> +	on_each_cpu(sld_remote_kill, NULL, 1);
> +}
> +
>   static void split_lock_init(void)
>   {
>   	split_lock_verify_msr(sld_state != sld_off);
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -24,6 +24,7 @@
>   #include <asm/pgtable.h>
>   #include <asm/setup.h>
>   #include <asm/unwind.h>
> +#include <asm/cpu.h>
>   
>   #if 0
>   #define DEBUGP(fmt, ...)				\
> @@ -253,6 +254,11 @@ int module_finalize(const Elf_Ehdr *hdr,
>   					    tseg, tseg + text->sh_size);
>   	}
>   
> +	if (text && !me->sld_safe) {
> +		void *tseg = (void *)text->sh_addr;
> +		split_lock_validate_module_text(me, tseg, tseg + text->sh_size);
> +	}
> +
>   	if (para) {
>   		void *pseg = (void *)para->sh_addr;
>   		apply_paravirt(pseg, pseg + para->sh_size);
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -407,6 +407,10 @@ struct module {
>   	bool sig_ok;
>   #endif
>   
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	bool sld_safe;
> +#endif
> +
>   	bool async_probe_requested;
>   
>   	/* symbols that will be GPL-only in the near future. */
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3096,6 +3096,11 @@ static int check_modinfo(struct module *
>   			"is unknown, you have been warned.\n", mod->name);
>   	}
>   
> +#ifdef CONFIG_CPU_SUP_INTEL
> +	if (get_modinfo(info, "sld_safe"))
> +		mod->sld_safe = true;
> +#endif
> +
>   	err = check_modinfo_livepatch(mod, info);
>   	if (err)
>   		return err;
> 

