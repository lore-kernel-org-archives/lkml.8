Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B3C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E049E206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591191418;
	bh=pTef5jDnf7eunpul9qYTCCupPFOSEBYwOAk7kfSFje0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pOG1wsMD/HCOsoWEi29Rm9wM+FYu8V9BiXrU/XpxeLAhnVpfrWHowtzbIUj7sq38R
	 7f9dSbpPIqjQep5aAil45LM/VzrMsjBgH5H+mtoAbDI11XMT2tWbNF4Se5NlOuJVc/
	 l69cXhng7pNUFO4e3KEKfZ122GSSqOLTLAfYf3K0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgFCNg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:36:58 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:43450 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCNg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:36:57 -0400
Received: by mail-ej1-f67.google.com with SMTP id a2so2173321ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 06:36:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6yqRVuEDuzSqKLfvX5Cc+QIaoGkvX6hmBAeSVv3eG5E=;
        b=pGUW92vR5FTWY6wsQakwG9G86phlccsuf2JDzOGyZ1P2eomEIdX2efWBBum0U/dzrT
         0mlEVWhfCYWn5OnH/FmyNlUGR/TaZm1v4inoPwwpkuzFVqVngrvoA2/cP4k1RsOI1e3J
         I6FqLejzI9y39clnUHvd0NAdtBxk+qJ1lr3p0Mpq8huJiVY4kWUEyfll0UGQcLL0F8gR
         UmQe7GXY6WvOr1oNm3twvABIIPSN7/0vZ1mbCw1vq57Zla/w/kEWZO0kqOkivGwmANxC
         AbBKd8Cna2bdQG5bAPAAkTIlqLnFiwrAqO/8OC+GA2gUkX9kT8Xa5mfSy3pFZtCyMGFc
         kHHQ==
X-Gm-Message-State: AOAM531n92irPxdgBY6cG/lv03grSlNFaKUpYUiaih/LqXA5471nDDRm
        QH063NAr+sdLjlIFC0MhCws=
X-Google-Smtp-Source: ABdhPJwxA219niUYoUS9z/ZrX6vb2oQZ1sB888+BP123jY+dnj0HiojUPWEyuNvIxWcgC6zadzZbOw==
X-Received: by 2002:a17:906:b79a:: with SMTP id dt26mr6352256ejb.422.1591191415668;
        Wed, 03 Jun 2020 06:36:55 -0700 (PDT)
Received: from localhost (ip-37-188-178-109.eurotel.cz. [37.188.178.109])
        by smtp.gmail.com with ESMTPSA id w13sm1124390eju.124.2020.06.03.06.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 06:36:54 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:36:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for
 vm_committed_as underflow check
Message-ID: <20200603133653.GK7533@dhcp22.suse.cz>
References: <E1703973-38C1-4AFB-94D1-E79DDC6853EE@lca.pw>
 <20200603094804.GB89848@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603094804.GB89848@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-06-20 17:48:04, Feng Tang wrote:
> On Tue, Jun 02, 2020 at 12:02:22AM -0400, Qian Cai wrote:
> > 
> > 
> > > On Jun 1, 2020, at 11:37 PM, Feng Tang <feng.tang@intel.com> wrote:
> > > 
> > > I re-run the same benchmark with v5.7 and 5.7+remove_warning kernels,
> > > the overall performance change is trivial (which is expected)
> > > 
> > >   1330147            +0.1%    1331032        will-it-scale.72.processes
> > > 
> > > But the perf stats of "self" shows big change for __vm_enough_memory() 
> > > 
> > >      0.27            -0.3        0.00        pp.self.__vm_enough_memory
> > > 
> > > I post the full compare result in the end.
> > 
> > I don’t really see what that means exactly, but I suppose the warning is there for so long and no one seems notice much trouble (or benefit) because of it, so I think you will probably need to come up with a proper justification to explain why it is a trouble now, and how your patchset suddenly start to trigger the warning as well as why it is no better way but to suffer this debuggability regression (probably tiny but still).
> 
> Thanks for the suggestion, and I updated the commit log.
> 
> 
> >From 1633da8228bd3d0dcbbd8df982977ad4594962a1 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Fri, 29 May 2020 08:48:48 +0800
> Subject: [PATCH] mm/util.c: remove the VM_WARN_ONCE for vm_committed_as
>  underflow check
> 
> This check was added by 82f71ae4a2b8 ("mm: catch memory commitment underflow")
> in 2014 to have a safety check for issues which have been fixed.
> And there has been few report caught by it, as described in its
> commit log:
> 
> : This shouldn't happen any more - the previous two patches fixed
> : the committed_as underflow issues.
> 
> But it was really found by Qian Cai when he used the LTP memory
> stress suite to test a RFC patchset, which tries to improve scalability
> of per-cpu counter 'vm_committed_as', by chosing a bigger 'batch' number
> for loose overcommit policies (OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS),
> while keeping current number for OVERCOMMIT_NEVER.
> 
> With that patchset, when system firstly uses a loose policy, the
> 'vm_committed_as' count could be a big negative value, as its big 'batch'
> number allows a big deviation, then when the policy is changed to
> OVERCOMMIT_NEVER, the 'batch' will be decreased to a much smaller value,
> thus hits this WARN check.
> 
> To mitigate this, one proposed solution is to queue work on all online
> CPUs to do a local sync for 'vm_committed_as' when changing policy to
> OVERCOMMIT_NEVER, plus some global syncing to garante the case won't
> be hit.
> 
> But this solution is costy and slow, given this check hasn't shown real
> trouble or benefit, simply drop it from one hot path of MM. And perf
> stats does show some tiny saving for removing it.
> 
> Reported-by: Qian Cai <cai@lca.pw> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Cc: Konstantin Khlebnikov <koct9i@gmail.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andi Kleen <andi.kleen@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/util.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 9b3be03..c63c8e4 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -814,14 +814,6 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
>  
> -	/*
> -	 * A transient decrease in the value is unlikely, so no need
> -	 * READ_ONCE() for vm_committed_as.count.
> -	 */
> -	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
> -			-(s64)vm_committed_as_batch * num_online_cpus()),
> -			"memory commitment underflow");
> -
>  	vm_acct_memory(pages);
>  
>  	/*
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
