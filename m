Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B2AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392F42076E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgCWRGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:06:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgCWRGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:06:21 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGQWc-0002xf-JV; Mon, 23 Mar 2020 18:06:06 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A41851040AA; Mon, 23 Mar 2020 18:06:04 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 2/9] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
In-Reply-To: <20200315050517.127446-3-xiaoyao.li@intel.com>
References: <20200315050517.127446-1-xiaoyao.li@intel.com> <20200315050517.127446-3-xiaoyao.li@intel.com>
Date:   Mon, 23 Mar 2020 18:06:04 +0100
Message-ID: <87wo7bovb7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:
> +/*
> + * Soft copy of MSR_TEST_CTRL initialized when we first read the
> + * MSR. Used at runtime to avoid using rdmsr again just to collect
> + * the reserved bits in the MSR. We assume reserved bits are the
> + * same on all CPUs.
> + */
> +static u64 test_ctrl_val;
> +
>  /*
>   * Locking is not required at the moment because only bit 29 of this
>   * MSR is implemented and locking would not prevent that the operation
> @@ -1027,16 +1035,14 @@ static void __init split_lock_setup(void)
>   */
>  static void __sld_msr_set(bool on)
>  {
> -	u64 test_ctrl_val;
> -
> -	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
> +	u64 val = test_ctrl_val;
>  
>  	if (on)
> -		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +		val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>  	else
> -		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
> +		val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
>  
> -	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
> +	wrmsrl(MSR_TEST_CTRL, val);
>  }
>  
>  /*
> @@ -1048,11 +1054,13 @@ static void __sld_msr_set(bool on)
>   */
>  static void split_lock_init(struct cpuinfo_x86 *c)
>  {
> -	u64 test_ctrl_val;
> +	u64 val;
>  
> -	if (rdmsrl_safe(MSR_TEST_CTRL, &test_ctrl_val))
> +	if (rdmsrl_safe(MSR_TEST_CTRL, &val))
>  		goto msr_broken;
>  
> +	test_ctrl_val = val;
> +
>  	switch (sld_state) {
>  	case sld_off:
>  		if (wrmsrl_safe(MSR_TEST_CTRL, test_ctrl_val & ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT))

That's just broken. Simply because

       case sld_warn:
       case sld_fatal:

set the split lock detect bit, but the cache variable has it cleared
unless it was set at boot time already.

Thanks,

        tglx
