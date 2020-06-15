Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D3CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AD12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtYbf5T/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbgFOVEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOVEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:04:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:04:06 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b27so17167379qka.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 14:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=c3CcV+Eqa52WujImAF4meTvGkOC9cvtsKvotjvbz2f0=;
        b=KtYbf5T/cb5Ryx7y9SBsiANN5FWhanrodOgrnGLo1Z/fjEfDD28weByG3vEOKELAEZ
         vsYpGPRd7MjqR5s+TDWjJBVcIFlIfcSm/UAemCnjm+gD58gbO0qPa1RPC/FlqQyUt7Uf
         Ns0p9mcPSmoNCKEp7r4ecW8KIGGAFYdWbRJXrHSpfPYLOKM3UfgJpiPyoADkAek6qDxL
         lLffTKJLOnRQyrzIPfSCsJpScjeMXMjH/7864MSluBjaN7r8ltZnJZ7gm0IYdJSHMW4Q
         lk//rbUFxqF2sMYR7tuqMjYLdSTJB7c/Hd5AtEPgQhLXNaIzmRclmbep3IhMVyMG5UMG
         SFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=c3CcV+Eqa52WujImAF4meTvGkOC9cvtsKvotjvbz2f0=;
        b=XO4uox2Up4IIdoT12Cyaas/Ffi7Di7gEa+PUzqLO9w4m6/Y7DZp3nvG6Zn2s99BYKx
         MIGm2HZv82RjgIa+znYpwXEDPK4N5NleoeoHQDMgdSfVyAHhj76cDr+7i3FvdDEO66BJ
         9T+o0ZnzigTcofRH5lIHUjNEMOqkEH+7LSJf3plLieQ9uvDn6W/1gB7tKGvgj08Yrrgo
         S9enr59t1XdwoF1GHadspbffGi/iOqc9Vk6jC0DCUE4MA+J3ZMyQr535pgInU1iTuMmO
         tH1BAHzPS+pRvIKKA6Zve3suM6IyHgQQMmRo4fR/PQ0/UUayT7Q5OZGmyYtuV3Wj8M4T
         Jezg==
X-Gm-Message-State: AOAM533RHUsucRl4WtHgyANTGWAr3/JE+8ZuwrUv7+V8V8aQum7Ha9PF
        ZfBF50ZxOz7/QFAuYxdwCqNeHqgVnN8=
X-Google-Smtp-Source: ABdhPJxm4LxnHr3trK46lRfSXaMcE1m0MTQu7lTK/5zm53taHdW4x9QvF20Al3clChYRF3o29eNxow==
X-Received: by 2002:a37:38c:: with SMTP id 134mr17616150qkd.434.1592255045366;
        Mon, 15 Jun 2020 14:04:05 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n13sm14405725qtb.20.2020.06.15.14.04.03
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 15 Jun 2020 14:04:04 -0700 (PDT)
Date:   Mon, 15 Jun 2020 14:03:50 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Li Wang <liwang@redhat.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, page_alloc: capture page in task context only
In-Reply-To: <01287865-153d-42e7-afd8-1178ec6bc5b9@suse.cz>
Message-ID: <alpine.LSU.2.11.2006151337150.11413@eggly.anvils>
References: <alpine.LSU.2.11.2006101342250.4607@eggly.anvils> <01287865-153d-42e7-afd8-1178ec6bc5b9@suse.cz>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020, Vlastimil Babka wrote:
> On 6/10/20 10:48 PM, Hugh Dickins wrote:
> > While stressing compaction, one run oopsed on NULL capc->cc in
> > __free_one_page()'s task_capc(zone): compact_zone_order() had been
> > interrupted, and a page was being freed in the return from interrupt.
> > 
> > Though you would not expect it from the source, both gccs I was using
> > (a 4.8.1 and a 7.5.0) had chosen to compile compact_zone_order() with
> > the ".cc = &cc" implemented by mov %rbx,-0xb0(%rbp) immediately before
> > callq compact_zone - long after the "current->capture_control = &capc".
> > An interrupt in between those finds capc->cc NULL (zeroed by an earlier
> > rep stos).
> 
> Ugh, nasty. Same here with gcc 10.

Thanks for checking, nice to know that I'm in good company :)

> 
> > This could presumably be fixed by a barrier() before setting
> > current->capture_control in compact_zone_order(); but would also need
> > more care on return from compact_zone(), in order not to risk leaking
> > a page captured by interrupt just before capture_control is reset.
> 
> I was hoping a WRITE_ONCE(current->capture_control) would be enough,
> but apparently it's not (I tried).

Right, I don't think volatiles themselves actually constitute barriers;
but I'd better keep quiet, I notice the READ_ONCE/WRITE_ONCE/data_race
industry has been busy recently, and I'm likely out-of-date and mistaken.

> 
> > Maybe that is the preferable fix, but I felt safer for task_capc() to
> > exclude the rather surprising possibility of capture at interrupt time.
> 
> > Fixes: 5e1f0f098b46 ("mm, compaction: capture a page under direct compaction")
> > Cc: stable@vger.kernel.org # 5.1+
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Thanks, and to Mel for his.

> 
> But perhaps I would also make sure that we don't expose the half initialized
> capture_control and run into this problem again later. It's not like this is a
> fast path where barriers hurt. Something like this then? (with added comments)

Would it be very rude if I leave that to you and to Mel? to add, or
to replace mine if you wish - go ahead.  I can easily see that more
sophistication at the compact_zone_order() end may be preferable to
another test and branch inside __free_one_page() (and would task_capc()
be better with an "unlikely" in it?).

But it seems unnecessary to have a fix at both ends, and I'm rather too
wound up in other things at the moment, to want to read up on the current
state of such barriers, and sign off on the Vlastipatch below myself (but
I do notice that READ_ONCE seems to have more in it today than I remember,
which probably accounts for why you did not put the barrier() I expected
to see on the way out).

Hugh

> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index fd988b7e5f2b..c89e26817278 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2316,15 +2316,17 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
>  		.page = NULL,
>  	};
>  
> -	current->capture_control = &capc;
> +	barrier();
> +
> +	WRITE_ONCE(current->capture_control, &capc);
>  
>  	ret = compact_zone(&cc, &capc);
>  
>  	VM_BUG_ON(!list_empty(&cc.freepages));
>  	VM_BUG_ON(!list_empty(&cc.migratepages));
>  
> -	*capture = capc.page;
> -	current->capture_control = NULL;
> +	WRITE_ONCE(current->capture_control, NULL);
> +	*capture = READ_ONCE(capc.page);
>  
>  	return ret;
>  }
