Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEAE20888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=notmuch.email header.i=@notmuch.email header.b="kRfbURVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgE1LgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:36:06 -0400
Received: from mx.h4ck.space ([159.69.146.50]:33350 "EHLO mx.h4ck.space"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388326AbgE1LgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:36:04 -0400
Date:   Thu, 28 May 2020 13:36:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=notmuch.email;
        s=mail; t=1590665761;
        bh=kfSMeWv1tDa6JpUtOKsModDfCKY6+eHNJv6lWWzZ+z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kRfbURVxI6yeCflzKOErdME/nWFhpHzVTJ+vuOXKCcz8i8i7EA1pdToUC53v9BVGn
         BpNjXi3xWSSDT4BVtKwVa8hHP+hug0ksm7L90PCSvUtw/Cr2vZC4CQZN2BvmpQ/sMP
         1q0k+o1a+nTPYqJUZvJ2TdygAKYbupCKu6UgwhlY=
From:   Andreas Rammhold <andi@notmuch.email>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Brendan Shanks <bshanks@codeweavers.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
Message-ID: <20200528113600.napo64uaxxexlgxj@wrt>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
 <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
 <20200519194320.GA25138@ranerica-svr.sc.intel.com>
 <20200523021739.bbq5m6ze63ctouh6@wrt>
 <20200526133318.GA3796@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526133318.GA3796@ranerica-svr.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06:33 26.05.20, Ricardo Neri wrote:
> On Sat, May 23, 2020 at 04:17:39AM +0200, Andreas Rammhold wrote:
> > On 12:43 19.05.20, Ricardo Neri wrote:
> > > I have a patch for this already that I wrote for testing purposes:
> > > https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234b93be50
> > > Perhaps it can be used as a starting point? Not sure what the spoofing
> > > value should be, though. Perhaps 0?
> > 
> > I tried the above patch (in modified/rebased version; hope that didn't
> > kill it [0]). The results are negative, as without the patch.
> 
> Ah. My patch above is based on a rather old kernel. There is a check in
> fixup_umip_exception() for SLDT and STR. I think this causes the
> exception you see. Perhaps you can try by removing such check:
> 
> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
> @@ -383,10 +389,6 @@ bool fixup_umip_exception(struct pt_regs *regs)
>  	umip_pr_warn(regs, "%s instruction cannot be used by applications.\n",
>  			umip_insns[umip_inst]);
> 
> -	/* Do not emulate (spoof) SLDT or STR. */
> -	if (umip_inst == UMIP_INST_STR || umip_inst == UMIP_INST_SLDT)
> -		return false;
> -
> 	umip_pr_warn(regs, "For now, expensive software emulation returns the result.\n");
> 
> 	if (emulate_umip_insn(&insn, umip_inst, dummy_data, &dummy_data_size,
> 
> You would still need my old patch.

Thanks, that works for my application.

Regards,

Andi
