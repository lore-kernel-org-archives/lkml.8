Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2310CC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF9C320888
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597855184;
	bh=YBQweXlYaqGhLcDScYSGPb42S6SBKpFxhlPfTH4uPqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mk39ustuGwaLGyTUEAK3Z+LbOU0ekWIGR4FJS4Ct6A/6uBwWAUMZSWvP9O3K6WHxT
	 sbx0B4VDEpp+IdcsEV+DvFzRlzXnK206gl5DRw5XKkkr9g4De1KDXJeME6VLdCTIbS
	 V3uSEg2We2IQ+EDBKEnrP6a7fNo+UVSrL576lFa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSQjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgHSQj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:39:26 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC2902177B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597855164;
        bh=YBQweXlYaqGhLcDScYSGPb42S6SBKpFxhlPfTH4uPqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oRhm6fqQ2WLuLWqiJJxFHA04YDf9kcIFyaB+Pn4tyNfap8ovWsoBCbbdci6MRexpv
         RBdf67VHkfbzoGCP+83KpxRDEo6YG3t+ZpyomrTZHkEoVQnuexEcVf/XcEr98ZCwKZ
         1vs1rBPfTR1r4HYkjDHvVfftHP6JRTvhhzdVgo04=
Received: by mail-wr1-f50.google.com with SMTP id y3so22189195wrl.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:39:23 -0700 (PDT)
X-Gm-Message-State: AOAM531IcdEWVge9bgRtsgQaMmVL0FYgTMOvtAszYk3Gl+Bu81vhkAYP
        VVy/PTi1PQ4Y6IFdaQklEL4rQrAAH39lw0iMAYESZg==
X-Google-Smtp-Source: ABdhPJyVDjVJbjdWY7LaBMzY59DmMkweYA6s0bUlh6pZYqljr1gOAS5O6rAAX4Q1E1daa0buos6BLQHObVgX35yOMIc=
X-Received: by 2002:a5d:400e:: with SMTP id n14mr25248054wrp.75.1597855162321;
 Wed, 19 Aug 2020 09:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
In-Reply-To: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 19 Aug 2020 09:39:10 -0700
X-Gmail-Original-Message-ID: <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com>
Message-ID: <CALCETrVUgHHW=q3R9jQxU4JTf2m493FhOa3L-iQnHMcH7dgQFg@mail.gmail.com>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess speculation
To:     Josh Poimboeuf <jpoimboe@redhat.com>
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
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 7:50 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> +/*
> + * Sanitize a uaccess pointer such that it becomes NULL if it's not a valid
> + * user pointer.  This blocks speculative dereferences of user-controlled
> + * pointers.
> + */
> +#define uaccess_mask_ptr(ptr) \
> +       (__typeof__(ptr)) array_index_nospec((__force unsigned long)ptr, user_addr_max())
> +

If I dug through all the macros correctly, this is generating a fairly
complex pile of math to account for the fact that user_addr_max() is
variable and that it's a nasty number.

But I don't think there's any particular need to use the real maximum
user address here.  Allowing a mis-speculated user access to a
non-canonical address or to the top guard page of the lower canonical
region is harmless.  With current kernels, a sequence like:

if (likely((long)addr > 0) {
  masked_addr = addr & 0x7FFFFFFFFFFFFFFFUL;
} else {
  if (kernel fs) {
    masked_addr = addr;
  } else {
    EFAULT;
  }
}

could plausibly be better.  But Christoph's series fixes this whole
mess, and I think that this should be:

#define uaccess_mask_ptr(ptr) ((__typeof___(ptr)) (__force unsigned
long)ptr & USER_ADDR_MASK))

where USER_ADDR_MASK is the appropriate value for 32-bit or 64-bit.
