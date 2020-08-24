Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A67C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F152D2078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:12:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgHXQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:12:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CE6EAC79;
        Mon, 24 Aug 2020 16:13:06 +0000 (UTC)
Date:   Mon, 24 Aug 2020 18:12:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200824161238.GI4794@zn.tnic>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
 <20200824151425.GF4794@zn.tnic>
 <20200824153300.GA56944@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200824153300.GA56944@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:33:00PM +0800, Feng Tang wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 43b1519..2c020ef 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -95,7 +95,7 @@ struct mca_config mca_cfg __read_mostly = {
>  	.monarch_timeout = -1
>  };
>  
> -static DEFINE_PER_CPU(struct mce, mces_seen);
> +static DEFINE_PER_CPU_ALIGNED(struct mce, mces_seen);
>  static unsigned long mce_need_notify;
>  static int cpu_missing;
>  
> @@ -148,7 +148,7 @@ void mce_setup(struct mce *m)
>  	m->microcode = boot_cpu_data.microcode;
>  }
>  
> -DEFINE_PER_CPU(struct mce, injectm);
> +DEFINE_PER_CPU_ALIGNED(struct mce, injectm);
>  EXPORT_PER_CPU_SYMBOL_GPL(injectm);

I don't think this is the right fix. Lemme quote Tony from a previous
email:

"The answer isn't to tinker with "struct mce". Other changes could
trigger this same change in alignment. Anything that is this perfomance
sensitive needs to have some "__attribute__((aligned(64)))" (or
whatever) to make sure arbitrary changes elsewhere don't do this."

And yes, your diff is not tinkering with struct mce but it is tinkering
with percpu vars which are of type struct mce.

However, the proper fix is...

> :)  Right, this is what I'm doing right now. Some test job is queued on
> the test box, and it may needs some iterations of new patch. Hopefully we
> can isolate some specific variable given some luck.

... yes, exactly, you need to identify the contention where this
happens, causing a cacheline to bounce or a variable straddles across a
cacheline boundary, causing the read to fetch two cachelines and thus
causes that slowdown. And then align that var to the beginning of a
cacheline.

Also, maybe I missed this but, do you trigger this only on Xeon Phi or
on "normal" x86 too?

Because if it is Xeon Phi only, then that might explain the size of the
slowdown and that it happens only there because it is a, well, "strange"
machine. :-)

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
