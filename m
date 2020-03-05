Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C54C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70FBF20848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgCEP7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:59:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:42219 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgCEP7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:59:11 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 07:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352382578"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 07:59:10 -0800
Date:   Thu, 5 Mar 2020 07:59:09 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        DavidWang@zhaoxin.com, CooperYan@zhaoxin.com,
        QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com
Subject: Re: [PATCH] x86/Kconfig: Make X86_UMIP to cover Zhaoxin CPUs too
Message-ID: <20200305155909.GD11500@linux.intel.com>
References: <1583288285-2804-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <20200304171336.GD21662@linux.intel.com>
 <c3d9ad69-4a49-19de-1680-84f7d5afeb81@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3d9ad69-4a49-19de-1680-84f7d5afeb81@zhaoxin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:40:02AM +0800, Tony W Wang-oc wrote:
> 
> On 05/03/2020 01:13, Sean Christopherson wrote:
> > On Wed, Mar 04, 2020 at 10:18:05AM +0800, Tony W Wang-oc wrote:
> >> New Zhaoxin family 7 CPUs support the UMIP (User-Mode Instruction
> >> Prevention) feature. So, modify X86_UMIP depends on Zhaoxin CPUs too.
> >>
> >> Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
> >> ---
> >>  arch/x86/Kconfig | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index 16a4b39..ca4beb8 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -1877,7 +1877,7 @@ config X86_SMAP
> >>  
> >>  config X86_UMIP
> >>  	def_bool y
> >> -	depends on CPU_SUP_INTEL || CPU_SUP_AMD
> >> +	depends on CPU_SUP_INTEL || CPU_SUP_AMD || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
> > 
> > The changelog only mentions Zhaoxin, but this also adds Centaur...
> 
> Sorry for this. Some Centaur family 7 CPUs also support the UMIP
> feature, so will resend this patch as a patch series.

Oooh, can you point me at architectural documentation for Centaur family 7?
I've been trying to track down Centaur documentation for CPUID behavior.
