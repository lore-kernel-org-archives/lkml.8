Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E3DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C687021919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf164iXI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgIIQnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:43:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730967AbgIIQnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599669810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z2tU+qSkg//p3QUUJru+1eyE4zumits1z47PmsvMV+I=;
        b=Yf164iXIqOJiK6bwQelGdpr3FbyN2FuuKRa+hJVVja1i7nPsEEehNtohIEVJ1SRBR9Ig47
        b/750mbnnOQJOnWCEAXIEnqPlPxUGMYD1qNJAOaY0gIaq4CymY5u+ZjHZDgp5ZuUslfZPJ
        AtBH8bOc8Aifw4rWqdXpFJU1dopTDhE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Gm9ohxF3PfCAXMxKd9isiA-1; Wed, 09 Sep 2020 12:43:28 -0400
X-MC-Unique: Gm9ohxF3PfCAXMxKd9isiA-1
Received: by mail-il1-f197.google.com with SMTP id f20so2501347ilg.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:43:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2tU+qSkg//p3QUUJru+1eyE4zumits1z47PmsvMV+I=;
        b=mvha0VtfC89LN5JQjPkTJsGvWDG7pal3pO81M2lXqWA+71PQ7RHqFhwV0LuCSthRw4
         hNuZik1YQa0qNzrRRSkZ5FbQEA7dOGUtr2NNeBwWGgfdpAoC1U0/F8024YtxOc2hWO5P
         ZJf5Zyb9ZQ15Sbwj7DflfgUIEbsTzsa5LxRD73lfet6jPg0WUi4EIuV9y8hDZACcu/dt
         n5AG+UYGomgx+LAuWAhFQztjyrY3DJwqju6aOq+31eBhRa0YBlzsOPVs7XvWFI1iP9mL
         K3Wor7oGtO1sbtxoFJ9PhXhtv81YRf/7INRAgJiwnY4PBr4pD+ccYRNO83dfYGzc9urQ
         4Tyg==
X-Gm-Message-State: AOAM530n1FnAgEwZuJAsZmES05KXySisO6MwGOe3mr+lcYwIbN1aRUcd
        /53vCuP5/5VOST7jP9/QQdkmUX69vum9hYB9pxsyISsGURkSxrtQn04+dQP6Wv1ts6QJWMEv+Be
        +EfCGGD7TDBh7DopCrVQFcGhIxacWhfsqWDaCjAg2
X-Received: by 2002:a05:6638:3ea:: with SMTP id s10mr4765105jaq.2.1599669807526;
        Wed, 09 Sep 2020 09:43:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPyoLRjK9qtZWv+ZlsNHBWd/SwUfOIB38VulKCabiJgAxyFKq3OA+JoQVEjsAHf4toENijNuL9TjDY+Oc9zOM=
X-Received: by 2002:a05:6638:3ea:: with SMTP id s10mr4765033jaq.2.1599669806457;
 Wed, 09 Sep 2020 09:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200909075016.104407-1-kasong@redhat.com> <87ft7r82sf.fsf@x220.int.ebiederm.org>
In-Reply-To: <87ft7r82sf.fsf@x220.int.ebiederm.org>
From:   Kairui Song <kasong@redhat.com>
Date:   Thu, 10 Sep 2020 00:43:15 +0800
Message-ID: <CACPcB9f4k+MV2JeNRjo_vd5FCMkjOMdBCpC6zAn4Z3o8jy_eug@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Add writing support to vmcore for reusing oldmem
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 10:04 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Kairui Song <kasong@redhat.com> writes:
>
> > Currently vmcore only supports reading, this patch series is an RFC
> > to add writing support to vmcore. It's x86_64 only yet, I'll add other
> > architecture later if there is no problem with this idea.
> >
> > My purpose of adding writing support is to reuse the crashed kernel's
> > old memory in kdump kernel, reduce kdump memory pressure, and
> > allow kdump to run with a smaller crashkernel reservation.
> >
> > This is doable because in most cases, after kernel panic, user only
> > interested in the crashed kernel itself, and userspace/cache/free
> > memory pages are not dumped. `makedumpfile` is widely used to skip
> > these pages. Kernel pages usually only take a small part of
> > the whole old memory. So there will be many reusable pages.
> >
> > By adding writing support, userspace then can use these pages as a fast
> > and temporary storage. This helps reduce memory pressure in many ways.
> >
> > For example, I've written a POC program based on this, it will find
> > the reusable pages, and creates an NBD device which maps to these pages.
> > The NBD device can then be used as swap, or to hold some temp files
> > which previouly live in RAM.
> >
> > The link of the POC tool: https://github.com/ryncsn/kdumpd
>
> A couple of thoughts.
> 1) Unless I am completely mistaken treating this as a exercise in
>    memory hotplug would be much simpler.
>
>    AKA just plug in the memory that is not needed as part of the kdump.
>
>    I see below that you have problems doing this because
>    of fragmentation.  I still think hotplug is doable using some
>    kind of fragmented memory zone.
>
> 2) The purpose of the memory reservation is because hardware is
>    still potentially running agains the memory of the old kernel.
>
>    By the time we have brought up a new kernel enough of the hardware
>    may have been reinitialized that we don't have to worry about
>    hardware randomly dma'ing into the memory used by the old kernel.
>
>    With IOMMUs and care we may be able to guarantee for some machine
>    configurations it is impossible for DMA to come from some piece of
>    hardware that is present but the kernel does not have a driver
>    loaded for.\
>
> I really do not like this approach because it is fundamentlly doing the
> wrong thing.  Adding write support to read-only drivers.  I do not see
> anywhere that you even mentioned the hard problem and the reason we
> reserve memory in the first place.  Hardware spontaneously DMA'ing onto
> it.
>
That POC tool looks ugly for now as it only a draft to prove this
works, sorry about it.

For the patch, yes, it is expecting IOMMU to lower the chance of
potential DMA issue, and expecting DMA will not hit userspace/free
page, or at least won't override a massive amount of reusable old
memory. And I thought about some solutions for the potential DMA
issue.

As old memories are used as a block device, which is proxied by
userspace, so upon each IO, the userspace tool could do an integrity
check of the corresponding data stored in old mem, and keep multiple
copies of the data. (eg. use 512M of old memory to hold a 128M block
device). These copies will be kept far away from each other regarding
the physical memory location. The reusable old memories are sparse so
the actual memory containing the data should be also sparse.
So if some part is corrupted, it is still recoverable. Unless the DMA
went very wrong and wiped a large region of memory, but if such thing
happens, it's most likely kernel pages are also being wiped by DMA, so
the vmcore is already corrupted and kdump may not help. But at least
it won't fail silently, the userspace tool can still do something like
dump some available data to an easy to setup target.

And also that's one of the reasons not using old memory as kdump's
memory directly.

> > It's have been a long time issue that kdump suffers from OOM issue
> > with limited crashkernel memory. So reusing old memory could be very
> > helpful.
>
> There is a very fine line here between reusing existing code (aka
> drivers and userspace) and doing something that should work.
>
> It might make sense to figure out what is using so much memory
> that an OOM is triggered.
>
> Ages ago I did something that was essentially dumping the kernels printk
> buffer to the serial console in case of a crash and I had things down to
> something comparatively miniscule like 8M or less.
>
> My memory is that historically it has been high performance scsi raid
> drivers or something like that, that are behind the need to have such
> large memory reservations.
>
> Now that I think about it, you aren't by any chance doing something
> silly like running systemd in your initrd are you?  Are these OOMs by
> any chance a userspace problem rather than a problem with inefficient
> drivers?

The problem with the user space is that, kdump is expected to dump to
different kinds of dump targets, and there are some very memory
consuming ones, eg. the NFSv3 case. And there are many other labor
heavy jobs for the dump target setup, like network setup, lvm setup,
iscsi setup, multipath etc, etc, not to mention potential corner cases
with these dump targets. And it is not practical to reimplement them
again in a memory friendly way.

And the user space is growing, even if user only included "bash
makedumpfile ssh ip" and required libs in initramfs, which are
essential for dumping the vmcore over SSH (dump over SSH is commonly
used), the initramfs will take 20M after decompressed.

The kernel driver memory usage is trackable and I only encountered a
few of such issues, and many have applied workaround for kdump. And if
userspace memory pressure is reduced, kernel will also have more
memory.

And now in Fedora, it is using the existing tool Dracut to generate
the initramfs, which heavily depends on systemd indeed. Even with
these helpers, it has been taking quite some work to support all the
dump targets.

>
> In summary you either need to show that it is safe to reuse the
> memory of the old kernel, or do some work to reduce the memory footprint
> of the crashdump kernel, and the crashdump userspace.
>
> Eric
>


--
Best Regards,
Kairui Song

