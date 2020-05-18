Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77948C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D0F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589809077;
	bh=qWLypqUxpjq+PWGqvdA08FUoyMUiPmK0wN1hOQJH8Kw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtMLUICLuOFemKVLNUMPTs71GHtnDvr4UqsAOvT9YdX8uMU5gyCtPt+K3QWjAiXdg
	 Kxl+di9vrL0ewYelYA3yapKwNBPheT6PqijBxR8mHUWvtdYfGcgRl+dv6OBb6DXCYr
	 fGotmBPCL3sRg+uMHpkAMh6YqQkEV7v9EfpMp8QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgERNh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERNh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:37:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4079206D4;
        Mon, 18 May 2020 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589809075;
        bh=qWLypqUxpjq+PWGqvdA08FUoyMUiPmK0wN1hOQJH8Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B9UkcbY2jDAacUffVg4mgBVmOKNJgjBIi9QGO696HJhKqFVyxDCAnTe5VWZVmqFQA
         6j/W5aBaup71jjp72bsEitt3GUeKjV7zBGm4M0D5NoERvarSIdTMvuih9Et4m+G9DE
         pNf9ckZXrxfozI/DNEFAo41VOq8rV7P52/nvKMkg=
Date:   Mon, 18 May 2020 14:37:50 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 1/6] arm64: scs: Store absolute SCS stack pointer value
 in thread_info
Message-ID: <20200518133750.GF32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-2-will@kernel.org>
 <20200518113710.GA1957@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518113710.GA1957@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:37:10PM +0100, Mark Rutland wrote:
> On Fri, May 15, 2020 at 06:27:51PM +0100, Will Deacon wrote:
> > Storing the SCS information in thread_info as a {base,offset} pair
> > introduces an additional load instruction on the ret-to-user path,
> > since the SCS stack pointer in x18 has to be converted back to an offset
> > by subtracting the base.
> > 
> > Replace the offset with the absolute SCS stack pointer value instead
> > and avoid the redundant load.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> One trivial nit below, but regardless this looks sound to me, and I
> certainly prefer having the absolute address rather than an offset, so:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> > diff --git a/kernel/scs.c b/kernel/scs.c
> > index 9389c28f0853..5ff8663e4a67 100644
> > --- a/kernel/scs.c
> > +++ b/kernel/scs.c
> > @@ -60,8 +60,7 @@ int scs_prepare(struct task_struct *tsk, int node)
> >  	if (!s)
> >  		return -ENOMEM;
> >  
> > -	task_scs(tsk) = s;
> > -	task_scs_offset(tsk) = 0;
> > +	task_scs(tsk) = task_scs_sp(tsk) = s;
> 
> I think this would be more legible as two statements:
> 
> |	task_sys(tsk) = s;
> |	task_scs_sp(tsk) = s;

I think it's nice to be able to say:

	task_scs(tsk) = task_scs_sp(tsk);

because it makes it very clear that they are initialised to the same thing.
Having it as two statements means somebody will update one and forget to
update the other one.

> ... as we usually save `foo = bar = baz` stuff for the start of a
> function or within loop conditions.

Hmm, I can't really find anything consistent in that regard, to be honest
with you. Did I miss something in the coding style doc?

I'll leave it as-is for now.

Will
