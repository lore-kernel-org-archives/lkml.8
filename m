Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DACCC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAAF2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgAPSse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:48:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52606 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389726AbgAPRJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:45 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is8e8-0006kl-62; Thu, 16 Jan 2020 18:09:28 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 9EA5C101226; Thu, 16 Jan 2020 18:09:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        pawan.kumar.gupta@linux.intel.com, peterz@infradead.org,
        fenghua.yu@intel.com, vineela.tummalapalli@intel.com,
        linux-kernel@vger.kernel.org
Cc:     DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from SPECTRE_V2
In-Reply-To: <1579146434-2668-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579146434-2668-1-git-send-email-TonyWWang-oc@zhaoxin.com>
Date:   Thu, 16 Jan 2020 18:09:27 +0100
Message-ID: <87r1zzuy48.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

Tony W Wang-oc <TonyWWang-oc@zhaoxin.com> writes:

> @@ -1023,6 +1023,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
>  #define MSBDS_ONLY		BIT(5)
>  #define NO_SWAPGS		BIT(6)
>  #define NO_ITLB_MULTIHIT	BIT(7)
> +#define NO_SPECTRE_V2		BIT(8)
>  
>  #define VULNWL(_vendor, _family, _model, _whitelist)	\
>  	{ X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
> @@ -1084,6 +1085,10 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
>  	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
>  	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
>  	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
> +
> +	/* Zhaoxin Family 7 */
> +	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
> +	VULNWL(ZHAOXIN,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
>  	{}
>  };
>  
> @@ -1116,7 +1121,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
>  		return;
>  
>  	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
> -	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
> +
> +	if (!cpu_matches(NO_SPECTRE_V2))
> +		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);

That's way better. But as you might have noticed yourself this conflicts
with the other patch which excludes these machines from the SWAPGS bug.

Granted it's a trivial conflict, but maintainers are not there to mop up
the mess others create. So the right thing here is to resend both
patches as a patch series with the conflict properly resolved.

Thanks,

        tglx
