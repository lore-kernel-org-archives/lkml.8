Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BEAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5145206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBHDfwYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404169AbgDCPWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:22:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56991 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404088AbgDCPWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585927340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f40ZvcSFesg6WkXpe37yjNDHPlvg5D7KyMxjtTJXaso=;
        b=GBHDfwYpOLrzn8UeMBoQ11zAISNPvjMx/iS/vIzFfbJz/IgsEUA6J/MJZIWb/wemhHY3SV
        5QII9XLCKe3WIFlgxhZxpH1VM59H/YuCp1N0KZkctS4sM/2WNiSlu05ruMRpT78DiBzWAg
        e27HZczmvY1jWDpmw5ks/i7bINcsoYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-YVNTUG_5PbSd6BB-jvKTCw-1; Fri, 03 Apr 2020 11:22:19 -0400
X-MC-Unique: YVNTUG_5PbSd6BB-jvKTCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB67710CE7A1;
        Fri,  3 Apr 2020 15:22:17 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF46F10027A3;
        Fri,  3 Apr 2020 15:22:16 +0000 (UTC)
Date:   Fri, 3 Apr 2020 10:22:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/7] objtool: Add support for return trampoline call
Message-ID: <20200403152214.3frjrlhxvodffghg@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-5-alexandre.chartre@oracle.com>
 <c0f265ed-c86b-d3f1-3894-941c25e42d0e@redhat.com>
 <fc224792-bd1c-08ff-072f-e584740521b4@oracle.com>
 <a250f29d-969a-b704-6dd6-c6cc7b84f526@redhat.com>
 <20200402154022.GG20730@hirez.programming.kicks-ass.net>
 <bc3a31dc-9d59-5756-aad3-187533f05654@redhat.com>
 <20200403151757.lhhia7pzqptvlqz5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403151757.lhhia7pzqptvlqz5@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 10:17:57AM -0500, Josh Poimboeuf wrote:
> On Fri, Apr 03, 2020 at 09:11:55AM +0100, Julien Thierry wrote:
> > 
> > 
> > On 4/2/20 4:40 PM, Peter Zijlstra wrote:
> > > On Thu, Apr 02, 2020 at 04:31:05PM +0100, Julien Thierry wrote:
> > > > My understanding is that once you find an intra-function call, either you
> > > > hit a return, ending the branch, so the return should undo the modification
> > > > the intra-function call did (whether is it a retpoline return or not).
> > > > Otherwise, the intra-function call branch will need to reach an end in some
> > > > way (e.g. hitting a CONTEXT_SWITCH instruction, calling a
> > > > dead_end_function).
> > > > 
> > > > Am I missing something?
> > > 
> > > The thing is basically doing:
> > > 
> > > 	mov  $n, cx
> > > 1:	call 2f
> > > 2:	dec  cx
> > > 	jnz  1b
> > > 	add  8*n, sp
> > > 
> > > So it does N calls to self, then subtracts N words from the stack.
> > > 
> > > The reason being that the CPU has a return-stack-buffer for predicting
> > > returns, and call/ret being naturally paired, that works. The above
> > > is a software flush of the RSB.
> > > 
> > 
> > Ah, lovely... Maybe that's where SAVE/RESTORE unwind hints could be nice ;)
> > .
> > 
> > Otherwise, I don't really have a good suggestion for this...
> 
> Peter, I think my previous idea for UNWIND_HINT_ADJUST stack_add=8 would
> work here?

And if we're going to need that hint anyway, maybe we could get rid of
the nasty arch_exception_frame_size for the IRET thing and just use a
hint there after all ;-)

-- 
Josh

