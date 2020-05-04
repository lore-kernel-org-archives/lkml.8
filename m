Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B89C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1C220658
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HFz4z/6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEDVbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726453AbgEDVbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:31:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2324C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:31:06 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id k22so16550eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S6K9rzdvWscNG4wZPQ1rJpU9QAUIGngtAWX+SWcl3dk=;
        b=HFz4z/6vNebp8NseCgqhAEQfo5KWVIcyjrxldQaD5QkV0Qfculhk7762n62lN/0bGY
         EE5bkJGb69yHfC2fRhWCC/qXBf0gqZ5OdDpol202tw5MCCGK1ss2EAsqOa++mVG1KjiN
         SurKrYicx486IwQfZJdRs1K1Cwxb2R+dhl5qBJGNKhdfs6IztdFeg4HM3b4kHaSWRylb
         R/CI15wL0O7F4WhglJR6q+k5Lj11gnXFenkR/PqnxmqL7/PGOCFnvYrgLsL6QN1xnOTD
         eX2JK0UM7l00ntGZVtUsQc6pmed40z1McRpthk7/QXnBlGQ+Fa7IOG1WRA1dOIO2eX1k
         5Yag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S6K9rzdvWscNG4wZPQ1rJpU9QAUIGngtAWX+SWcl3dk=;
        b=PmfdUgNsumxd8zB9YPheYLA5sdRTIc2/eQyO/w07/Jm0U9stoio4hC5CjNiqyk5ziU
         ORL5n5YLnumi9wvxF9lD4o8uqZ7Fp1HNq5gt/KEOlTZQwKjlUnTU/V85zM4s/4miuFHM
         mSjsZBuV4/Gk8ak0FC/SojHGAeV1qDuwrEwkqHCxwIlY8t1jz/npd7rl3D6FXyq+FUdQ
         LzfE3QxCNHOceK1n75zJgCgd7hcQTn6zwPdSnyen6tjmifPPl3ZkURd7Y1V4JrisKWfB
         DAJfatg7+5nMr1DuPArJqErMlUFhdl8wCSCWI4F9byEcv2niBs+qwJIkfRvkw5Yemu02
         WLcQ==
X-Gm-Message-State: AGi0PuYufnxk7dCCaatMu2awJXiuirD2SihmFfGsCODjX+I18YC5gsBe
        VZutyb09pVNmlwA+xGuiCFpv5VrP9vlH/TExcwDWiw==
X-Google-Smtp-Source: APiQypLsUbY4xwta6nK8zdFY4PM1aXzxNUct4mV5ijnB2SRzlqauiInU9dEyyDSrj2cbNV1Gqc9iBqjU95LVtXcZorM=
X-Received: by 2002:a50:bb6b:: with SMTP id y98mr42475ede.296.1588627865384;
 Mon, 04 May 2020 14:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiMs=A90np0Hv5WjHY8HXQWpgtuq-xrrJvyk7_pNB4meg@mail.gmail.com>
 <1962EE67-8AD1-409D-963A-4F1E1AB3B865@amacapital.net> <3908561D78D1C84285E8C5FCA982C28F7F60EBB6@ORSMSX115.amr.corp.intel.com>
 <CALCETrW5zNLOrhOS69xeb3ANa0HVAW5+xaHvG2CA8iFy1ByHKQ@mail.gmail.com>
 <3908561D78D1C84285E8C5FCA982C28F7F612DF4@ORSMSX115.amr.corp.intel.com> <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
In-Reply-To: <CALCETrVAsppM5kRz0HicAQ8o_x06=7Nd0q64sEre3MEShWPaLw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 May 2020 14:30:54 -0700
Message-ID: <CAPcyv4g9nTLTMjhQOJdu+v8n-Sc9L566KfnSjcz+0TS_Ge15Fw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Tsaur, Erwin" <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 1:26 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, May 4, 2020 at 1:05 PM Luck, Tony <tony.luck@intel.com> wrote:
> >
> > > When a copy function hits a bad page and the page is not yet known to
> > > be bad, what does it do?  (I.e. the page was believed to be fine but
> > > the copy function gets #MC.)  Does it unmap it right away?  What does
> > > it return?
> >
> > I suspect that we will only ever find a handful of situations where the
> > kernel can recover from memory that has gone bad that are worth fixing
> > (got to be some code path that touches a meaningful fraction of memory,
> > otherwise we get code complexity without any meaningful payoff).
> >
> > I don't think we'd want different actions for the cases of "we just found out
> > now that this page is bad" and "we got a notification an hour ago that this
> > page had gone bad". Currently we treat those the same for application
> > errors ... SIGBUS either way[1].
>
> Oh, I agree that the end result should be the same.  I'm thinking more
> about the mechanism and the internal API.  As a somewhat silly example
> of why there's a difference, the first time we try to read from bad
> memory, we can expect #MC (I assume, on a sensibly functioning
> platform).  But, once we get the #MC, I imagine that the #MC handler
> will want to unmap the page to prevent a storm of additional #MC
> events on the same page -- given the awful x86 #MC design, too many
> all at once is fatal.  So the next time we copy_mc_to_user() or
> whatever from the memory, we'll get #PF instead.  Or maybe that #MC
> will defer the unmap?

After the consumption the PMEM driver arranges for the page to never
be mapped again via its "badblocks" list.

>
> So the point of my questions is that the overall design should be at
> least somewhat settled before anyone tries to review just the copy
> functions.

I would say that DAX / PMEM stretches the Linux memory error handling
model beyond what it was originally designed. The primary concepts
that bend the assumptions of mm/memory-failure.c are:

1/ DAX pages can not be offlined via the page allocator.

2/ DAX pages (well cachelines in those pages) can be asynchronously
marked poisoned by a platform or device patrol scrub facility.

3/ DAX pages might be repaired by writes.

Currently 1/ and 2/ are managed by a per-block-device "badblocks" list
that is populated by scrub results and also amended when #MC is raised
(see nfit_handle_mce()). When fs/dax.c services faults it will decline
to map the page if the physical file extent intersects a bad block.

There is also support for sending SIGBUS if userspace races the
scrubber to consume the badblock. However, that uses the standard
'struct page' error model and assumes that a file backed page is 1:1
mapped to a file. This requirement prevents filesystems from enabling
reflink. That collision and the desire to enable reflink is why we are
now investigating supplanting the mm/memory-failure.c model. When the
page is "owned" by a filesystem invoke the filesystem to handle the
memory error across all impacted files.

The presence of 3/ means that any action error handling takes to
disable access to the page needs to be capable of being undone, which
runs counter to the mm/memory-failure.c assumption that offlining is a
one-way trip.
