Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B51CC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F49208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVhplQiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgCYOjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:39:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:42432 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgCYOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585147162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m2AO/S+07mA3ueoNWjFPnrXCdCJ5lsCZjgj8/xbBoqc=;
        b=EVhplQiAstNgHBVjfYINeUtPiUflh2BiGQsPBTTMwYLg3Z/p1U0sRSxSewvLXeRtgCiKJI
        gA8efhzXzvAjBIKNawSOUc2w77dXcFTL02sUVM7++72+5HMZgNCnEG2Ei61qA0dUgkKs7h
        sEFHwleiqkBVeZSpaKSk2usde3sVFxI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-DYU2GKhZPZynm3qV-4x2YQ-1; Wed, 25 Mar 2020 10:39:20 -0400
X-MC-Unique: DYU2GKhZPZynm3qV-4x2YQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E11DB101FC85;
        Wed, 25 Mar 2020 14:39:18 +0000 (UTC)
Received: from treble (unknown [10.10.119.253])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B0A5C3F8;
        Wed, 25 Mar 2020 14:39:17 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:39:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v3 18/26] objtool: Fix !CFI insn_state propagation
Message-ID: <20200325143915.kwxsy6dcvx6qa4ip@treble>
References: <20200324153113.098167666@infradead.org>
 <20200324160924.987489248@infradead.org>
 <20200324214006.tlanaff5q6gkgk2a@treble>
 <20200324221109.GU2452@worktop.programming.kicks-ass.net>
 <20200324230010.GW2452@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324230010.GW2452@worktop.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 12:00:10AM +0100, Peter Zijlstra wrote:
> On Tue, Mar 24, 2020 at 11:11:09PM +0100, Peter Zijlstra wrote:
> > On Tue, Mar 24, 2020 at 04:40:06PM -0500, Josh Poimboeuf wrote:
> > > On Tue, Mar 24, 2020 at 04:31:31PM +0100, Peter Zijlstra wrote:
> > 
> > > > +		if (!save_insn->visited) {
> > > > +			/*
> > > > +			 * Oops, no state to copy yet.
> > > > +			 * Hopefully we can reach this
> > > > +			 * instruction from another branch
> > > > +			 * after the save insn has been
> > > > +			 * visited.
> > > > +			 */
> > > > +			if (insn == first)
> > > > +				return 0; // XXX
> > > 
> > > Yeah, moving this code out to apply_insn_hint() seems like a nice idea,
> > > but it wouldn't be worth it if it breaks this case.  TBH I don't
> > > remember if this check was for a real-world case.  Might be worth
> > > looking at...  If this case doesn't exist in reality then we could just
> > > remove this check altogether.
> > 
> > I'll go run a bunch of builds with a print on it, that should tell us I
> > suppose.
> 
> I can a bunch of builds, including an allmodconfig with the below on top
> and it 'works'.
> 
> So I suppose we can remove this special case.
> 
> ---
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2134,11 +2134,13 @@ static int apply_insn_hint(struct objtoo
>  			 * after the save insn has been
>  			 * visited.
>  			 */
> -			if (insn == first)
> -				return 0; // XXX
> 
>  			WARN_FUNC("objtool isn't smart enough to handle this CFI save/restore combo",
>  					sec, insn->offset);
> +
> +			if (insn == first)
> +				return -1;
> +

I think all the validate_branch() callers aren't prepared to handle a -1
return code.

We can just be lazy and remove this 'insn == first' check and consider
it a non-fatal warning.

-- 
Josh

