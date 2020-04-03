Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4056C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8430720675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRWpWQ9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391091AbgDCOod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:44:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727431AbgDCOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585925071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dzD7eus7lBjgG30NcNG/sOIuLevArnMNUmhmE93sGjg=;
        b=NRWpWQ9VFzHP3rcwbGp4n+rHcnljAYu1nn8M1xbs8O00vFFoveh/cYNW3hko+LtyblCx3X
        ld86gbrXqHKOpS3BD8bLg2pz1vuyNtTw/QdF+KHjs+xqW4oOH9szwAfbCDGMnhVWQ5+vm+
        +cUkWxRaA4WOA97UjqP2DbZ1tqdw2PA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-NcL3yS1iMNaO6R2a5WJWIg-1; Fri, 03 Apr 2020 10:44:27 -0400
X-MC-Unique: NcL3yS1iMNaO6R2a5WJWIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BD488017F5;
        Fri,  3 Apr 2020 14:44:26 +0000 (UTC)
Received: from treble (ovpn-118-100.rdu2.redhat.com [10.10.118.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C0D75C1D6;
        Fri,  3 Apr 2020 14:44:25 +0000 (UTC)
Date:   Fri, 3 Apr 2020 09:44:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     Alexandre Chartre <alexandre.chartre@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de
Subject: Re: [PATCH 3/7] objtool: Add support for intra-function calls
Message-ID: <20200403144423.lqcvdhi54cl3btvj@treble>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
 <20200402082220.808-4-alexandre.chartre@oracle.com>
 <db508586-258a-0616-d649-e76e95df9611@redhat.com>
 <20200402154919.2c6shw4hfreagchg@treble>
 <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d075cb2-8d99-5ab7-4842-efef1964247d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 09:01:38AM +0100, Julien Thierry wrote:
> 
> 
> On 4/2/20 4:49 PM, Josh Poimboeuf wrote:
> > On Thu, Apr 02, 2020 at 01:53:49PM +0100, Julien Thierry wrote:
> > > Hi Alexandre,
> > > 
> > > I ran into the limitation of intra-function call for the arm64 support but
> > > didn't take the time to make a clean patch to support them properly.
> > 
> > Can you give an example of where arm64 uses intra-function calls?  It
> > sounds sketchy to me :-)  Is it really needed/useful?
> > 
> 
> So the most notable/necessary one(s) is the one in tramp_ventry [1]. This
> macro is used as the begining of exception handlers for exceptions coming
> from userland. It was added as part of the mitigations of spectre (v1???).
> 
> To give some context, x30 is the register that "ret" instruction will use as
> return address, "bl" is the equivalent of x86 "call" and sets x30 before
> jumping to the target address. (However, it doesn't have a special semantic
> for exception returns)
> 
> Note: I believe the comment about the return "stack" is about processor
> internal state (speculative thingies and all) rather than the actual stack,
> since the stack is untouched by that code. But I don't know the actual
> details.

Ok.  So another Spectre special case.

> There are also some in arch/arm64/crypto/crct10dif-ce-core.o , which is
> probably full of fast, smart and optimized code I don't understand :) . So I
> wouldn't feel confident commenting on whether those intra-function calls are
> needed or not.

Glancing at that code, there's a macro which has bl to
.L__pmull_p8_core, which, because it has a local label prefix, doesn't
have an ELF symbol associated with it.  I bet changing that branch to
"bl __pmull_p8_core" (and removing the unnecessary .L__pmull_p8_core
label) would fix the warnings.

So IIUC, this is actually a case where the warning found a cleanup,
albeit a trivial one.

> Last I found is in qcom_link_stack_sanitization() [2], but that's just a
> workaround for a very specific hardware. In my local tree I just put the
> function as STACK_FRAME_NON_STANDARD. But the code just saves the return
> address, has 16 call instructions that just call the instruction after them,
> restores the return address and lets the C-function return normally (and it
> somehow fixes something for that hardware).

Yeah, like Peter said this sounds like x86 RSB stuffing.  More Spectre
nastiness.

So it sounds like the only valid use case for intra-function calls is
Spectre BS...

So, at the risk of possibly contradicting the past version of myself, my
current feeling is that we should annotate such cases, and then warn on
non-annotated cases like the crypto example above.  There's nothing
normal about these Spectre mitigations, so it's ok to add annotations to
such craziness.

-- 
Josh

