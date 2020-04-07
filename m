Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65976C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D052206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHsjYgQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgDGQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:28:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43322 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgDGQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586276926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8fuLk3L8ELTxwTSKiP3T5dmiYkZPR3qzEibGwB0sRWY=;
        b=KHsjYgQUQQPufUN3cQL/d6YVE4QVr9o6ycNfW7zPEuJwMaAvlxtdtIzMSmAs4BskNA3nCa
        4YFKfPM8qLerbwTNCsIAfC1i+nbxAR7mA3e34E5LsJZSesskB6On7vcGCmRwbIcjvJ4Qdg
        DV5X0OtLS1hrS/jITWLVOA8M03P7hHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-TEwEXIKEN1i_4ybstAbp-w-1; Tue, 07 Apr 2020 12:28:43 -0400
X-MC-Unique: TEwEXIKEN1i_4ybstAbp-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35920800D50;
        Tue,  7 Apr 2020 16:28:42 +0000 (UTC)
Received: from treble (ovpn-116-24.rdu2.redhat.com [10.10.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C549E60BF7;
        Tue,  7 Apr 2020 16:28:40 +0000 (UTC)
Date:   Tue, 7 Apr 2020 11:28:38 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407162838.5hlh6oom4oa45ugt@treble>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:18:51PM +0200, Alexandre Chartre wrote:
> 
> On 4/7/20 4:32 PM, Alexandre Chartre wrote:
> > 
> > On 4/7/20 3:34 PM, Josh Poimboeuf wrote:
> > > On Tue, Apr 07, 2020 at 03:28:37PM +0200, Peter Zijlstra wrote:
> > > > Josh, we should probably have objtool verify it doesn't emit ORC entries
> > > > in alternative ranges.
> > > 
> > > Agreed, it might be as simple as checking for insn->alt_group in the
> > > INSN_STACK check or in update_insn_state().
> > > 
> > 
> > We could do that only for the "objtool orc generate" command. That way
> > "objtool check" would still check the alternative, but "objtool orc generate"
> > will just use the first half of the alternative (like it does today with
> > ANNOTATE_NOSPEC_ALTERNATIVE). We can even keep all ANNOTATE_NOSPEC_ALTERNATIVE
> > but only use them for "objtool orc generate".
> > 
> 
> I have checked and objtool doesn't emit ORC entries for alternative:
> decode_instructions() doesn't mark such section with sec->text = true
> so create_orc_sections() doesn't emit corresponding ORC entries.
> 
> So I think we can remove the ANNOTATE_NOSPEC_ALTERNATIVE directives,
> this will allow objtool to check the instructions but it still won't
> emit ORC entries (same behavior as today). In the future, if ORC
> eventually supports alternative we will be ready to have objtool emit
> ORC entries.

What's the benefit of removing ANNOTATE_NOSPEC_ALTERNATIVE if there's no
ORC support to go along with it?

Also I want to avoid adding "ORC alternatives".  ORC is nice and simple
and we should keep it that way as much as possible.

Again, we should warn on stack changes inside alternatives, and then
look at converting RSB and retpolines to use static branches so they
have deterministic stacks.

-- 
Josh

