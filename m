Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4FC42077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="p+44Z+4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbgGUXmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGUXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:42:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:36:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so223781pfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4/y9Kml4kEgPy1nuHtQbnnn9hcon0j83gAhPQ/a7NVI=;
        b=p+44Z+4/ckHHF+GAQ4A2skbeyMPVgmukHh3fOKGwTQemnwSJ6GxWjmD7CZ9Tw+uoJe
         GrUYmrFsqB+Hxkn7XtjCnb3UIrgRDrYn351sxhMdvuu4nXXNBn+qXFhFVl67IbZhW/Uu
         pRFAxMYa06+em/bBZD0yxobDqZsaNeeyw2g4ArOeEsHrhQN0KddMoF7MB2BKEIGtTJcy
         Jn+T+wIhbtgRqr8e1vInERFXLi6qwBfiacu3vAtXQ5F2bwo26NHVG0utrKaT49FR+mls
         iSrY01VlGtHRpaIjgBftwYPk40xsrwfXm20K9WwRb/Y4HrOgsQjLMe7fxj5f3vvq/s3T
         WLag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4/y9Kml4kEgPy1nuHtQbnnn9hcon0j83gAhPQ/a7NVI=;
        b=KncDtiXwqKTSRo7mTzEnSdsPx0HCZ1nVfPUFfKOds5aiMmkek1xwWOjlzPFrIFr9Q5
         Loo9wnhL/b3bAvW97Ok9cQKFOJW7thu1Q7h80I7YodaFtLCKR/VvAy+rjyFrbPZGbrdO
         4ldGoolDJOjNs01v2L9Q4HvYoCqtDYuIL5SYdOEwAQVKyFU5mr2a4RqVIv1G13HOquJ+
         FXVmOuHY7JiNdjeUoQ4Tx0cgz0z0tQNwuGamT0/aUt+RYrIijnsDC78T9S31T1QMXV7x
         aodFXnNC44jvQGwMn6FRY2fbARqf2v1rVzmhgPZhxo62Ni4ibFjG2allGes5QMW6vknD
         3ATg==
X-Gm-Message-State: AOAM532DXKYxJhpJLKbwC3zy6P9hAPRceY5cmHPL5U2bD6C2N2gVIqa9
        DhDWVQ+EPsGuKAkmN24OgpMUxw==
X-Google-Smtp-Source: ABdhPJzB67n3W2mkqzOSwKaM1AJtP/MeBDuysfieMDV8LWATOje0NdcZ9GK0r2Z3+Gk+qzhNM2jtKw==
X-Received: by 2002:a62:8782:: with SMTP id i124mr26134197pfe.267.1595374587183;
        Tue, 21 Jul 2020 16:36:27 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d24sm4115944pjx.36.2020.07.21.16.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 16:36:26 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:36:26 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 16:36:24 PDT (-0700)
Subject:     Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
In-Reply-To: <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
CC:     alex@ghiti.fr, mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     benh@kernel.crashing.org
Message-ID: <mhng-4b49d09a-0267-4879-849f-30c24f26e2c3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 16:11:02 PDT (-0700), benh@kernel.crashing.org wrote:
> On Tue, 2020-07-21 at 14:36 -0400, Alex Ghiti wrote:
>> > > I guess I don't understand why this is necessary at all.
>> > > Specifically: why
>> > > can't we just relocate the kernel within the linear map?  That would
>> > > let the
>> > > bootloader put the kernel wherever it wants, modulo the physical
>> > > memory size we
>> > > support.  We'd need to handle the regions that are coupled to the
>> > > kernel's
>> > > execution address, but we could just put them in an explicit memory
>> > > region
>> > > which is what we should probably be doing anyway.
>> >
>> > Virtual relocation in the linear mapping requires to move the kernel
>> > physically too. Zong implemented this physical move in its KASLR RFC
>> > patchset, which is cumbersome since finding an available physical spot
>> > is harder than just selecting a virtual range in the vmalloc range.
>> >
>> > In addition, having the kernel mapping in the linear mapping prevents
>> > the use of hugepage for the linear mapping resulting in performance loss
>> > (at least for the GB that encompasses the kernel).
>> >
>> > Why do you find this "ugly" ? The vmalloc region is just a bunch of
>> > available virtual addresses to whatever purpose we want, and as noted by
>> > Zong, arm64 uses the same scheme.
>
> I don't get it :-)
>
> At least on powerpc we move the kernel in the linear mapping and it
> works fine with huge pages, what is your problem there ? You rely on
> punching small-page size holes in there ?

That was my original suggestion, and I'm not actually sure it's invalid.  It
would mean that both the kernel's physical and virtual addresses are set by the
bootloader, which may or may not be workable if we want to have an sv48+sv39
kernel.  My initial approach to sv48+sv39 kernels would be to just throw away
the sv39 memory on sv48 kernels, which would preserve the linear map but mean
that there is no single physical address that's accessible for both.  That
would require some coordination between the bootloader and the kernel as to
where it should be loaded, but maybe there's a better way to design the linear
map.  Right now we have a bunch of unwritten rules about where things need to
be loaded, which is a recipe for disaster.

We could copy the kernel around, but I'm not sure I really like that idea.  We
do zero the BSS right now, so it's not like we entirely rely on the bootloader
to set up the kernel image, but with the hart race boot scheme we have right
now we'd at least need to leave a stub sitting around.  Maybe we just throw
away SBI v0.1, though, that's why we called it all legacy in the first place.

My bigger worry is that anything that involves running the kernel at arbitrary
virtual addresses means we need a PIC kernel, which means every global symbol
needs an indirection.  That's probably not so bad for shared libraries, but the
kernel has a lot of global symbols.  PLT references probably aren't so scary,
as we have an incoherent instruction cache so the virtual function predictor
isn't that hard to build, but making all global data accesses GOT-relative
seems like a disaster for performance.  This fixed-VA thing really just exists
so we don't have to be full-on PIC.

In theory I think we could just get away with pretending that medany is PIC,
which I believe works as long as the data and text offset stays constant, you
you don't have any symbols between 2GiB and -2GiB (as those may stay fixed,
even in medany), and you deal with GP accordingly (which should work itself out
in the current startup code).  We rely on this for some of the early boot code
(and will soon for kexec), but that's a very controlled code base and we've
already had some issues.  I'd be much more comfortable adding an explicit
semi-PIC code model, as I tend to miss something when doing these sorts of
things and then we could at least add it to the GCC test runs and guarantee it
actually works.  Not really sure I want to deal with that, though.  It would,
however, be the only way to get random virtual addresses during kernel
execution.

> At least in the old days, there were a number of assumptions that
> the kernel text/data/bss resides in the linear mapping.

Ya, it terrified me as well.  Alex says arm64 puts the kernel in the vmalloc
region, so assuming that's the case it must be possible.  I didn't get that
from reading the arm64 port (I guess it's no secret that pretty much all I do
is copy their code)

> If you change that you need to ensure that it's still physically
> contiguous and you'll have to tweak __va and __pa, which might induce
> extra overhead.

I'm operating under the assumption that we don't want to add an additional load
to virt2phys conversions.  arm64 bends over backwards to avoid the load, and
I'm assuming they have a reason for doing so.  Of course, if we're PIC then
maybe performance just doesn't matter, but I'm not sure I want to just give up.
Distros will probably build the sv48+sv39 kernels as soon as they show up, even
if there's no sv48 hardware for a while.
