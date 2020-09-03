Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C21C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56760206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 07:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgICHRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 03:17:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:32218 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICHRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 03:17:23 -0400
IronPort-SDR: A1o+nKr2BHx/UTJ5PkoSOFji2JZEjHqgumMg6GjA6vDKdGJTF7n2hJYJqV+DtAHY9PjtEHqvkg
 HVziJcneNlwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="137583210"
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="137583210"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 00:17:22 -0700
IronPort-SDR: 1T7PYoVl7BzHFy0DF8eHTDf0EwdIyhkAeAk4LqQBHtk6JsYeTacA7HatEGk997dHG/ZEOk2407
 IfLMB1lZV92g==
X-IronPort-AV: E=Sophos;i="5.76,385,1592895600"; 
   d="scan'208";a="477945715"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 00:17:20 -0700
Date:   Thu, 3 Sep 2020 15:17:18 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200903071718.GE61340@shbuild999.sh.intel.com>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902154018.GA21537@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902154018.GA21537@zn.tnic>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:40:18PM +0200, Borislav Petkov wrote:
> On Thu, Aug 27, 2020 at 03:49:03PM +0800, Feng Tang wrote:
> > output of the tool
> > ------------------
> > 
> > 	CPUID leafs total: 28
> > 
> > 	cpu family	: 6
> > 	model		: 13
> > 	stepping	: 7
> 
> Yeah, this should dump model etc and those numbers should be in hex and
> additionally in dec if people prefer them.

Ok

> > 	CPU features
> > 	------------
> > 	 sse3
> > 	 pclmlqdq
> > 	 dtes64
> > 	 mwait
> > 	 ds_cpl
> > 	 vmx
> > 	 smx
> > 	 fpu
> > 	 ...
> 
> I guess that's good for grepping. With a lot of leafs, leaf output
> should probably be controlled by cmdline opts.

Will add input option for specific leafs or all.

> >  tools/arch/x86/tools/kcpuid/Makefile |  21 ++
> >  tools/arch/x86/tools/kcpuid/kcpuid.c | 422 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 443 insertions(+)
> >  create mode 100644 tools/arch/x86/tools/kcpuid/Makefile
> >  create mode 100644 tools/arch/x86/tools/kcpuid/kcpuid.c
> 
> Let's drop the second "tools" from the path:
> 
> tools/arch/x86/kcpuid/Makefile
> tools/arch/x86/kcpuid/kcpuid.c

Will do.

> > +struct reg_01_a {
> > +	u32 stepping: 4;	/* bit 0 */
> > +	u32 model: 4;
> > +	u32 family: 4;
> > +	u32 type: 2;
> > +	u32 pad1: 2;
> > +	u32 model_ext: 4;	/* bit 16 */
> > +	u32 family_ext: 8;
> > +};
> 
> Yeah, instead of defining a separate struct for each leaf I think it
> would be smarter/better to have a text file in a machine parseable
> format which defines your leafs.
> 
> When you need to add a new leaf, you simply extend the text file and the
> tool parses it anew and has its all CPUID info uptodate. This way you
> won't even have to recompile it. Adding new CPUID leafs would be adding new
> lines to the file.
> 
> For example:
> 
> LEAF<num>,SUBLEAF<num>,[EAX,EBX,ECX,EDX]{[width]<Mnemonic>|<Long text>,...}
> 
> LEAF07,SUBLEAF00,EAX{[31:0]max_value|Max input value for supported subleafs}
> LEAF07,SUBLEAF00,EBX{[0]FSGSBASE|RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE if 1.,
> 		     [1]TSC_ADJUST|IA32_TSC_ADJUST MSR is supported if 1.,
> 		     [2]SGX|Supports Intel® Software Guard Extensions (Intel® SGX Extensions) if 1.,
> 		     ...
> }
> LEAF07,SUBLEAF00,ECX{[0]PREFETCHWT1|(Intel® Xeon PhiTM only.),
> 		     [1]AVX512_VBMI|,
> 		     ...
> 
> This is just a dumb attempt but I hope it comes across where I'm getting
> with this.

Will check this, and further study the different bits you, Peter and Dave
have mentioned in the discussion.

Thank you all for the review and suggestions!

- Feng
