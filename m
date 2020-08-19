Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA85C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44732067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iyYZ/UQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHSRCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:02:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgHSRCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597856557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHu72fh1fFkkjp/hOIC1Y0NnDw8ZT+1uUdQ3/2I1wFY=;
        b=iyYZ/UQdDjPSUnaA2pwumpmuLdEGFU0JeGYEcJcXDKnA5wG0cx3fFRarvA+fR+kMjHJRNv
        FWvQzVJIhI8gSbRHCtn9BUem+AgkkYWJKZE+F7jW7eF+1D73DW3n+EhnCCrBifzceuV1WV
        YHK+wT3LZXIosoM5N5ZjlPhj+4Y226s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-BzVCQt0pN7qIorN9J_YkMw-1; Wed, 19 Aug 2020 13:02:33 -0400
X-MC-Unique: BzVCQt0pN7qIorN9J_YkMw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8084910054FF;
        Wed, 19 Aug 2020 17:02:31 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C39F5D9E8;
        Wed, 19 Aug 2020 17:02:25 +0000 (UTC)
Date:   Wed, 19 Aug 2020 12:02:23 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200819170223.nmv7dekvpc5yk4rm@treble>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:39:10AM -0700, Andy Lutomirski wrote:
> On Wed, Aug 19, 2020 at 7:50 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > +/*
> > + * Sanitize a uaccess pointer such that it becomes NULL if it's not a valid
> > + * user pointer.  This blocks speculative dereferences of user-controlled
> > + * pointers.
> > + */
> > +#define uaccess_mask_ptr(ptr) \
> > +       (__typeof__(ptr)) array_index_nospec((__force unsigned long)ptr, user_addr_max())
> > +
> 
> If I dug through all the macros correctly, this is generating a fairly
> complex pile of math to account for the fact that user_addr_max() is
> variable and that it's a nasty number.

The math is actually pretty simple.  It's identical to what getuser.S is
doing:

	cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
	sbb %_ASM_DX, %_ASM_DX
	and %_ASM_DX, %_ASM_AX

> But I don't think there's any particular need to use the real maximum
> user address here.  Allowing a mis-speculated user access to a
> non-canonical address or to the top guard page of the lower canonical
> region is harmless.  With current kernels, a sequence like:
> 
> if (likely((long)addr > 0) {
>   masked_addr = addr & 0x7FFFFFFFFFFFFFFFUL;
> } else {
>   if (kernel fs) {
>     masked_addr = addr;
>   } else {
>     EFAULT;
>   }
> }

The masking has to be done without conditional branches, otherwise it
defeats the point.

> could plausibly be better.  But Christoph's series fixes this whole
> mess, and I think that this should be:
> 
> #define uaccess_mask_ptr(ptr) ((__typeof___(ptr)) (__force unsigned
> long)ptr & USER_ADDR_MASK))
> 
> where USER_ADDR_MASK is the appropriate value for 32-bit or 64-bit.

Yeah, we could do that.  Though in the meantime, the simple merge
conflict resolution with Christoph's patches would be
s/user_addr_max/TASK_SIZE_MAX/ in my uaccess_mask_ptr() macro.

-- 
Josh

