Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEC4C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ABF20575
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9ac1r/E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504236AbgDNSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504208AbgDNSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:42:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409C4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rIV7Tc0uXVh+eJ6y+fStjQcH1El3n85jcYIkYBCjgyc=; b=r9ac1r/EsQKIdOrBiHWUM6Ofs1
        E0sTjiwSIndZtvieDBNXVhBUNPyXhoA7bpdX5Tiodw5H7sC5FmgA8mdH+oL7WHx5nDjhzvQFJdsvp
        pb8ROtCIMUHenzJ4/BAbetUwdOx3HbKFxkXK4QZYhDe02H17+rLCdtHeq1uWgaxAC+7avqml3l85V
        6dYA49N3e/44fD1i4w7bqPQmNDu6UlWNmZK6Z8ZIH1oPAcg0hyodyZBo0fPm4w+E8k7rjtpF15yAo
        N8INC4MNcgR3beeMfpV00FLQ+0ZTMZQ4GzwNZzO00n/YIkXZD0Dy7mUtPPARKMgTJU5ZoyDwHjfTP
        45pp9cPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOQW3-00081G-Hn; Tue, 14 Apr 2020 18:42:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8A627981086; Tue, 14 Apr 2020 20:42:33 +0200 (CEST)
Date:   Tue, 14 Apr 2020 20:42:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 5/9] objtool: Add return address unwind hints
Message-ID: <20200414184233.GG2483@worktop.programming.kicks-ass.net>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-6-alexandre.chartre@oracle.com>
 <20200414161636.GP20713@hirez.programming.kicks-ass.net>
 <546b2d81-39ca-00e1-4df2-d4eaa18496a4@oracle.com>
 <20200414175604.GD2483@worktop.programming.kicks-ass.net>
 <e9e1c4cd-193f-fd5e-65c4-cc9fb159d861@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9e1c4cd-193f-fd5e-65c4-cc9fb159d861@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:31:23PM +0200, Alexandre Chartre wrote:
> On 4/14/20 7:56 PM, Peter Zijlstra wrote:

> > So what actual problem is it solving?
> > 
> 
> The return stack stuff is here to correctly handle intra-function call so that
> we can figure out where the ret of an intra-function call should return. We
> don't have this challenge with regular functions because we know that a ret
> inside such function just indicates the end of the function.
> 
> But when there's an intra-function call, a ret instruction can either:
>   - continue after the intra-function call (if the stack was unchanged)
>   - jump somewhere else (if the return address was changed) and eventually
>     return to the next return address
>   - indicate the end of the function (if the return address was removed).
> 
> So, all this is needed to correctly follow the flow of the code and properly
> record stack changes.

But which intra-function calls are you worried about here? The RSB
stuffing ones we have to explicitly forget and the retpoline ones we
can't follow because they're indirect calls.

So again, who cares about that stack?
