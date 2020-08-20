Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F634C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 778C0207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882717;
	bh=YZpMpqzQbr2IvWkTmf8PhaAX8U2jACxI9onk8Go7xCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XApmHcG0QnjdR8Lc4YsV1NDmqLZhwkvsxRZ+IWWqWhQf6SklLmjwXoqnW3wkOlgE2
	 3MiyLPQwU654sT3Pi8Gg/PpWZohkqnSgRQa9gXnadYdVmlYORKtUOfIabk1k/hb0uQ
	 u6izmSnhAB1Svtmmy8sF0DT/7oWIGE1+zQBV99Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHTASd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbgHTASc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:18:32 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D5ED21775
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597882712;
        bh=YZpMpqzQbr2IvWkTmf8PhaAX8U2jACxI9onk8Go7xCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bvzN53Gd9Fxe4ubeT5Bkxnhwg6EF/5NK7r8kVzUoDR4j9NBW5ykvCUfiNhZmfnLdV
         TapqYM0Tmq9++ozG65Ns4NcsaLO4u7zAF3osoTSCaGbZKP5YTH00y9t4KgNMAyei0A
         fn8ePt/T5CEz6yLM9GtlL/1H249IYgpYYkX1mXZ0=
Received: by mail-wr1-f49.google.com with SMTP id a15so411769wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:18:32 -0700 (PDT)
X-Gm-Message-State: AOAM532uMkuIxzRvtKhzOAMYbQr6ezJ8RuWLWM7OjC40nBL0n2RLt3Xx
        8yrdkrmxZTUjBSAQbYG0Eb6bpjUzWcqDaxQC5kTGog==
X-Google-Smtp-Source: ABdhPJw2/o9xv2vNO2UPdZwGB+vSRdTg3W3G0f7KfGoSmhU5HbFkBRCRa6ncvDBjDuR8eyDApjf9t6N29HPBeHnZ6S4=
X-Received: by 2002:adf:e90f:: with SMTP id f15mr520654wrm.18.1597882710887;
 Wed, 19 Aug 2020 17:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
 <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com> <20200819170223.nmv7dekvpc5yk4rm@treble>
In-Reply-To: <20200819170223.nmv7dekvpc5yk4rm@treble>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 17:18:19 -0700
X-Gmail-Original-Message-ID: <CALCETrXeTqkGry=Rbccn9EP1=YAqkYBt7wywrFohUyG-6A_udA@mail.gmail.com>
Message-ID: <CALCETrXeTqkGry=Rbccn9EP1=YAqkYBt7wywrFohUyG-6A_udA@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:02 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 09:39:10AM -0700, Andy Lutomirski wrote:
> > On Wed, Aug 19, 2020 at 7:50 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > +/*
> > > + * Sanitize a uaccess pointer such that it becomes NULL if it's not a valid
> > > + * user pointer.  This blocks speculative dereferences of user-controlled
> > > + * pointers.
> > > + */
> > > +#define uaccess_mask_ptr(ptr) \
> > > +       (__typeof__(ptr)) array_index_nospec((__force unsigned long)ptr, user_addr_max())
> > > +
> >
> > If I dug through all the macros correctly, this is generating a fairly
> > complex pile of math to account for the fact that user_addr_max() is
> > variable and that it's a nasty number.
>
> The math is actually pretty simple.  It's identical to what getuser.S is
> doing:
>
>         cmp TASK_addr_limit(%_ASM_DX),%_ASM_AX
>         sbb %_ASM_DX, %_ASM_DX
>         and %_ASM_DX, %_ASM_AX
>
> > But I don't think there's any particular need to use the real maximum
> > user address here.  Allowing a mis-speculated user access to a
> > non-canonical address or to the top guard page of the lower canonical
> > region is harmless.  With current kernels, a sequence like:
> >
> > if (likely((long)addr > 0) {
> >   masked_addr = addr & 0x7FFFFFFFFFFFFFFFUL;
> > } else {
> >   if (kernel fs) {
> >     masked_addr = addr;
> >   } else {
> >     EFAULT;
> >   }
> > }
>
> The masking has to be done without conditional branches, otherwise it
> defeats the point.

Ugh.  Fair enough.

> Yeah, we could do that.  Though in the meantime, the simple merge
> conflict resolution with Christoph's patches would be
> s/user_addr_max/TASK_SIZE_MAX/ in my uaccess_mask_ptr() macro.

Okay.  I will try to help remember :)

--Andy
