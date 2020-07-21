Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C79A20771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="hsWZwjsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgGUXsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgGUXsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:48:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286F9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:48:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k1so197500pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mDc030Vht0H+5kxn8kLZcM0RglBvmobnh33JIp70Q9A=;
        b=hsWZwjsrrb6MHnGlDjXciuMZQ0nzpaGX0XqqotTf6FxppNdslwj80bOHq4XiVr8B4N
         SCpSNd4Uu+fKdrj6GAgEnicqXWWEP9PCWq23ucc9/tt2akFpRFgjuE9SeU+cCHODPhj8
         maVEeY1DOS1y5XfHe5sHYmNqjl4RoWUBn7w7lB8TeTWwtt4QeijAeuGNPjcLeBnjV19B
         SmugmuJ8ByDeMpqvSyeew7HlPpyj9My215QEtBoF9dt3tORKxn+X2oVXdd2uNIyHmd9b
         VDJVMDJNscIIFoT2kCXV0OaSjuh8jGAbeGFch/4XoFGO9VWRYU5PdpQ3sp+SqpvXySKf
         YI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mDc030Vht0H+5kxn8kLZcM0RglBvmobnh33JIp70Q9A=;
        b=aBS0MpQVgIYww82zJId50cm4b8R+hiBCEGoh/Byl23tQG26j9UpS+eMkPtBCNHeH6q
         NUVV3dSo7xdZrdpfSJT+F1LGZHHhnwITJYaxvL19NqRkcwSj5zu/nS7M+ELLeqh7/Kto
         R6aSQ2AfNs7BM7q4mk7PRz4rYvHfNLHSetbzqN0E8k8mhI5SLgWSlrprDiRgzKuEWxmV
         lZ3fJ2C2WMfB/3354zwAZSw6S5aszFeQ+IZy+NsPv0dChy739iwR3leHmz/RJzDKoxOD
         XPmSTbwHmnG52OSOGl8dSAANMKg0cD/Jskubg4f7nNXsmOQ+HPlugzhP8/85D1KLoxN9
         FTmg==
X-Gm-Message-State: AOAM531r5vAwCrgUuRJdksq6X2lbdZGYKvuA9cGGeSFtk663EcQDqUSA
        fbywZLoQZsADh0XYFXa07lFH7w==
X-Google-Smtp-Source: ABdhPJz7GQOPhPQo7WdQAVqmRGBn/kBHYhew0a/7KykfyZ8e5DBJEpqbOEQfucs+jTILpvC6kcl9RQ==
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr6637665pju.80.1595375292546;
        Tue, 21 Jul 2020 16:48:12 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i66sm20870634pfc.12.2020.07.21.16.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 16:48:11 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:48:11 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 16:48:10 PDT (-0700)
Subject:     Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
In-Reply-To: <6fbea8347bdb8434d91cf3ec2b95b134bd66cfe3.camel@kernel.crashing.org>
CC:     alex@ghiti.fr, mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     benh@kernel.crashing.org
Message-ID: <mhng-cd9a74ea-2edf-47e4-aade-b090f1a069f1@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 16:12:58 PDT (-0700), benh@kernel.crashing.org wrote:
> On Tue, 2020-07-21 at 12:05 -0700, Palmer Dabbelt wrote:
>>
>> * We waste vmalloc space on 32-bit systems, where there isn't a lot of it.
>> * On 64-bit systems the VA space around the kernel is precious because it's the
>>   only place we can place text (modules, BPF, whatever).
>
> Why ? Branch distance limits ? You can't use trampolines ?

Nothing fundamental, it's just that we don't have a large code model in the C
compiler.  As a result all the global symbols are resolved as 32-bit
PC-relative accesses.  We could fix this with a fast large code model, but then
the kernel would need to relax global symbol references in modules and we don't
even do that for the simple code models we have now.  FWIW, some of the
proposed large code models are essentially just split-PLT/GOT and therefor
don't require relaxation, but at that point we're essentially PIC until we
have more that 2GiB of kernel text -- and even then, we keep all the
performance issues.

>>  If we start putting
>>   the kernel in the vmalloc space then we either have to pre-allocate a bunch
>>   of space around it (essentially making it a fixed mapping anyway) or it
>>   becomes likely that we won't be able to find space for modules as they're
>>   loaded into running systems.
>
> I dislike the kernel being in the vmalloc space (see my other email)
> but I don't understand the specific issue with modules.

Essentially what's above, the modules smell the same as the rest of the
kernel's code and therefor have a similar set of restrictions.  If we build PIC
modules and have the PLT entries do GOT loads (as do our shared libraries) then
we could break this restriction, but that comes with some performance
implications.  Like I said in the other email, I'm less worried about the
instruction side of things so maybe that's the right way to go.

>> * Relying on a relocatable kernel for sv48 support introduces a fairly large
>>   performance hit.
>
> Out of curiosity why would relocatable kernels introduce a significant
> hit ? Where about do you see the overhead coming from ?

Our PIC codegen, probably better addressed by my other email and above.

>
>> Roughly, my proposal would be to:
>>
>> * Leave the 32-bit memory map alone.  On 32-bit systems we can load modules
>>   anywhere and we only have one VA width, so we're not really solving any
>>   problems with these changes.
>> * Staticly allocate a 2GiB portion of the VA space for all our text, as its own
>>   region.  We'd link/relocate the kernel here instead of around PAGE_OFFSET,
>>   which would decouple the kernel from the physical memory layout of the system.
>>   This would have the side effect of sorting out a bunch of bootloader headaches
>>   that we currently have.
>> * Sort out how to maintain a linear map as the canonical hole moves around
>>   between the VA widths without adding a bunch of overhead to the virt2phys and
>>   friends.  This is probably going to be the trickiest part, but I think if we
>>   just change the page table code to essentially lie about VAs when an sv39
>>   system runs an sv48+sv39 kernel we could make it work -- there'd be some
>>   logical complexity involved, but it would remain fast.
>>
>> This doesn't solve the problem of virtually relocatable kernels, but it does
>> let us decouple that from the sv48 stuff.  It also lets us stop relying on a
>> fixed physical address the kernel is loaded into, which is another thing I
>> don't like.
>>
>> I know this may be a more complicated approach, but there aren't any sv48
>> systems around right now so I just don't see the rush to support them,
>> particularly when there's a cost to what already exists (for those who haven't
>> been watching, so far all the sv48 patch sets have imposed a significant
>> performance penalty on all systems).
