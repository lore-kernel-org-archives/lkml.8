Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4042C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFE0F207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgH1Wr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:47:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:4547 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbgH1Wr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:47:56 -0400
IronPort-SDR: ohzq7vGgH232ujCclk6D1j43KgwHaW07+IPmeknRpP4LyC0tXvBSA+80vE+vqwWKvV0uteaInR
 32YObZ1cz81Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="136299717"
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="136299717"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 15:47:56 -0700
IronPort-SDR: P4Izg3dto0XnG4uIr4agX2cSAZRNN85gAiWta7dXNinVKXN9yIEtSrEce9gnHDDIx4orBElAls
 RG+LfsxwTFFQ==
X-IronPort-AV: E=Sophos;i="5.76,365,1592895600"; 
   d="scan'208";a="501192277"
Received: from km-skylake-client-platform.sc.intel.com ([10.3.52.153])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 15:47:56 -0700
Message-ID: <b171209faab7e141a9988ecf47fa55bf855cb664.camel@intel.com>
Subject: Re: [PATCH v2] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
From:   Kyung Min Park <kyung.min.park@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, dave.hansen@intel.com, ricardo.neri@intel.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ak@linux.intel.com,
        ravi.v.shankar@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date:   Fri, 28 Aug 2020 15:30:32 -0700
In-Reply-To: <20200828184209.GC19342@zn.tnic>
References: <20200824180412.9440-1-kyung.min.park@intel.com>
         <20200828184209.GC19342@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, 2020-08-28 at 20:42 +0200, Borislav Petkov wrote:
> On Mon, Aug 24, 2020 at 11:04:12AM -0700, Kyung Min Park wrote:
> > +If the expected flag does not appear in /proc/cpuinfo, things are
> > murkier.
> > +Users need to find out the reason why the flag is missing and find
> > the way
> > +how to enable it, which is not always easy. There are several
> > factors that
> > +can explain missing flags: the expected feature failed to enable,
> > the feature
> > +is missing in hardware, platform firmware did not enable it, the
> > feature is
> > +disabled at build or run time, an old kernel is in use, or the
> > kernel does
> > +not support the feature and thus has not enabled it. In general,
> > /proc/cpuinfo
> > +shows features which the kernel supports.
> > +
> > +For a full list of CPUID flags which the CPU supports, the users
> > may use
> > +tools like http://www.etallen.com/cpuid.html (which is not updated
> > with
> > +kernel releases) or other custom tools that read CPUID.
> 
> I guess this should talk only about our own kcpuid tool since we
> wanna
> do that now, right?

Should I mention the tool specifically although the tool is WIP? As you
commented previously, should I use tools/arch/x86/tools/cpuid/cpuid as
the future tool and its location?

Or do you want it to be mentioned in the future tense without
specifying the tool name and location?

> 
> ...
> 
> > +c: The kernel disabled support for it at compile-time.
> > +------------------------------------------------------
> > +For example, if 5-level-paging is not enabled when building (i.e.,
> > +CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show
> > up [#f1]_.
> > +Even though the feature will still be detected via CPUID, the
> > kernel disables
> > +it via cleared by setup_clear_cpu_cap(X86_FEATURE_LA57).
> 
> "... disables it by clearing... "

Sure, let me fix it.

> 
> > +d: The feature is disabled at boot-time.
> > +----------------------------------------
> > +A feature can be disabled either using a command-line parameter or
> > because
> > +it failed to be enabled. The command-line parameter clearcpuid=
> > can be used
> > +to disable features using the feature number as defined in
> > +/arch/x86/include/asm/cpufeatures.h. For instance, User Mode
> > Instruction
> > +Protection can be disabled using clearcpuid=514. The number 514 is
> > calculated
> > +from #define X86_FEATURE_UMIP (16*32 + 2).
> > +
> > +In addition, there exists a variety of custom command-line
> > parameters that
> > +disable specific features. The list of parameters includes, but is
> > not limited
> > +to, no5lvl, nosmap, and nosmep.
> 
> You already give the separate example for "no5lvl" below so use
> something else
> above, say, "nofsgsbase", for example.

You're right. Let me change it.

> 
> > 5-level paging can also be disabled using
> > +"no5lvl". SMAP and SMEP are disabled with the aforementioned
> > parameters,
> > +respectively.
> > +
> > +e: The feature was known to be non-functional.
> > +----------------------------------------------
> > +The feature was known to be non-functional because a dependency
> > was
> > +missing at runtime. For example, AVX flags will not show up if
> > XSAVE feature
> > +is disabled since they depend on XSAVE feature.
> 
> Another example would be: broken CPUs and them missing microcode
> patches
> and due to that the kernel deciding not to enable a feature.

Thank you for the comment. I'll add that too.

> 
> But yap, all in all looks like a good idea. I'll take the next
> version
> after you've fixed those nitpicks.
> 
> Thx.

Thanks Boris!

