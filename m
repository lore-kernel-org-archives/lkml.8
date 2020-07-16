Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F34720787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 19:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgGPTxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:53:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:57147 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgGPTxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:53:08 -0400
IronPort-SDR: keQhUiUwTMkw51NsmGPnCPJNCvj6gygX4ia4uMJyXf/L3Rc0O1cc8XXPRbvW+o4OKbArEdMzDF
 cMwZo6SCz3mQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148643267"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="148643267"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 12:53:08 -0700
IronPort-SDR: OS3wmLkgzc4vKwOP0I8IINnOk9wof0sgRXDguNHzBbKjfeZvPZpllpTdlODDWsMNyGtIKNfycK
 9zdOlchtNY0Q==
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="430609713"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 12:53:07 -0700
Date:   Thu, 16 Jul 2020 12:53:06 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/split_lock: Enumerate split lock feature on Sapphire
 Rapids
Message-ID: <20200716195306.GA8660@agluck-desk2.amr.corp.intel.com>
References: <1593208534-33721-1-git-send-email-fenghua.yu@intel.com>
 <20200716193659.GA66451@romley-ivt3.sc.intel.com>
 <20200716195010.GV10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716195010.GV10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 09:50:10PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 16, 2020 at 12:37:00PM -0700, Fenghua Yu wrote:
> > Hi, Thomas, Boris, Ingo,
> > 
> > On Fri, Jun 26, 2020 at 02:55:34PM -0700, Fenghua Yu wrote:
> > > Add Sapphire Rapids processor to CPU list to enumerate split lock
> > > feature.
> > > 
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > > ---
> > >  arch/x86/kernel/cpu/intel.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> > > index c25a67a34bd3..dca069ad6671 100644
> > > --- a/arch/x86/kernel/cpu/intel.c
> > > +++ b/arch/x86/kernel/cpu/intel.c
> > > @@ -1148,6 +1148,7 @@ static const struct x86_cpu_id split_lock_cpu_ids[] __initconst = {
> > >  	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_L,	1),
> > >  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		1),
> > >  	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		1),
> > > +	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	1),
> > >  	{}
> > >  };
> > 
> > Any comment on this patch?
> 
> The only comment I have is that us needing it is ludicrous :/ What's the
> bloody point of having it 'enumerated' if you then still have to use FMS
> lists.
> 
> There's nowhere near enough cursing in the comment that goes with that
> list.

Code of conduct suggests that we avoid such language :-)

-Tony
