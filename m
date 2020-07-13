Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DA5C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF7A20758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOC/nv0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgGMMXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729644AbgGMMX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:23:29 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91272C061755;
        Mon, 13 Jul 2020 05:23:29 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so5617425qvb.13;
        Mon, 13 Jul 2020 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HwcEC42H0zTATu6DQ9BO7GlySiE5+PPSThoRe1JfoPk=;
        b=IOC/nv0a9MCBpDa157+eJk6cC4/4JJ4l0JY3uhKtvsYAKQE7Ija7cwGEMqRImWi/w/
         tWl85DYAfgNt4Fko32AjPLfKNlC+5y892Ouucq8/6zJJtRRJjtYBidkF9is7pkIq2DUy
         POh7J2xOBygj1fB9vgCWbhSF3ck65l09BgoCNI6dxGvULA6BNzqzMwkaG+M5z+j5tyxq
         O1q2wbYVWni+JbsTAa3/ejg4zAHjku/djKkJYFiePb0GTnSihD41gqhca0/3hKZdWy76
         +Lm93p71u2UhzjGa7cm5FK/7e2KVF3VwbWc8662dpv7xrfjBpBUzV/qYFiTBpoJsrMff
         goHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwcEC42H0zTATu6DQ9BO7GlySiE5+PPSThoRe1JfoPk=;
        b=fm0TB8R1inTgE60D9OS60/KBSRazcohycVP8vgOfUZUp3p/LmVt1FqkfrlXgjsinmy
         YEDcrSl00tMEMqqUwdgkjAYnXd/YIavqPlqHTdF3Xjr03Lyc7SKuZ6FCm/X4dX4697HE
         AcuVZqr7gz3A8D+QDMtP+KuZM1cFXUvFK0XFIOoHSlKuDIC6p4v1dGJB71Kzgkmt/ezZ
         Ss5yEfFY1MZNe1Khw413f90rrvTChqvP5H6yPKZsnZnSYUw5QsGcC4cWcHlr1faNFAIn
         U19wGX9zNHM6hBsVZXT6SDx2gXZKL8hEfo3YATqf9IYR7RFVLqzDW9nrxwQp4+oiaA5M
         zsFg==
X-Gm-Message-State: AOAM532lGaH8w7WMGdrkUytcS/zCHAtzq95DYxV3fD/NIXlGIbewXbRd
        xYBUVqGYx4WFu/UvtPsuqC4=
X-Google-Smtp-Source: ABdhPJwpoyYG59FDdLRsqqOJI5cchUh+Aqa1xYmmBSAhY/Wkms+JYZ4PI1pq5O5l+rS/At6qOMZbMQ==
X-Received: by 2002:a0c:a2c1:: with SMTP id g59mr13868748qva.138.1594643008492;
        Mon, 13 Jul 2020 05:23:28 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id x29sm18616965qtv.80.2020.07.13.05.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 05:23:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2E16D27C0054;
        Mon, 13 Jul 2020 08:23:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 Jul 2020 08:23:25 -0400
X-ME-Sender: <xms:PFIMX7ynWTlov9bwdW9xDcsi0lKeLmSm2pjRGgOlS7CoFS2RZYy7_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvdekgdehvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepsghoqhhunhdr
    fhgvnhhgsehgmhgrihhlrdgtohhmnecuggftrfgrthhtvghrnhepuddvgfeutdeuhefggf
    fhlefggeevueeliefgvdfggeeukeehleelueeiiedukedunecukfhppeehvddrudehhedr
    udduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeg
    hedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomh
    esfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:PFIMXzRvJemfnVxics2mwdHF--kokKMCjTwCxFGfA2gyiMGaLKyayQ>
    <xmx:PFIMX1VpKXoKXRFdKBq0aTEJi7mbFP8hFz7PFdfQfJ6CVuyrY0vrlw>
    <xmx:PFIMX1ijg03MJpgelHhaWTIDfls-COz1lhUGhd_QcjG6czdK3pVUqw>
    <xmx:PVIMX8U3qR8YaZ1EFLe5oDyPW0g0peugFWQ_US2MUXeFSDQuLWprydcG-U8>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7EEF730600B4;
        Mon, 13 Jul 2020 08:23:23 -0400 (EDT)
Date:   Mon, 13 Jul 2020 20:23:22 +0800
From:   boqun.feng@gmail.com
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH v3 02/19] compiler.h: Split {READ,WRITE}_ONCE definitions
 out into rwonce.h
Message-ID: <20200713122322.GD72639@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-3-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-3-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 05:51:46PM +0100, Will Deacon wrote:
> In preparation for allowing architectures to define their own
> implementation of the READ_ONCE() macro, move the generic
> {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> file and into a new 'rwonce.h' header under 'asm-generic'.
> 
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  include/asm-generic/Kbuild    |  1 +
>  include/asm-generic/barrier.h |  2 +-
>  include/asm-generic/rwonce.h  | 91 +++++++++++++++++++++++++++++++++++
>  include/linux/compiler.h      | 83 +-------------------------------
>  4 files changed, 95 insertions(+), 82 deletions(-)
>  create mode 100644 include/asm-generic/rwonce.h
> 
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index 44ec80e70518..74b0612601dd 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -45,6 +45,7 @@ mandatory-y += pci.h
>  mandatory-y += percpu.h
>  mandatory-y += pgalloc.h
>  mandatory-y += preempt.h
> +mandatory-y += rwonce.h
>  mandatory-y += sections.h
>  mandatory-y += serial.h
>  mandatory-y += shmparam.h
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index 2eacaf7d62f6..8116744bb82c 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -13,7 +13,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/compiler.h>
> +#include <asm/rwonce.h>
>  
>  #ifndef nop
>  #define nop()	asm volatile ("nop")
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> new file mode 100644
> index 000000000000..92cc2f223cb3
> --- /dev/null
> +++ b/include/asm-generic/rwonce.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Prevent the compiler from merging or refetching reads or writes. The
> + * compiler is also forbidden from reordering successive instances of
> + * READ_ONCE and WRITE_ONCE, but only when the compiler is aware of some
> + * particular ordering. One way to make the compiler aware of ordering is to
> + * put the two invocations of READ_ONCE or WRITE_ONCE in different C
> + * statements.
> + *
> + * These two macros will also work on aggregate data types like structs or
> + * unions.
> + *
> + * Their two major use cases are: (1) Mediating communication between
> + * process-level code and irq/NMI handlers, all running on the same CPU,
> + * and (2) Ensuring that the compiler does not fold, spindle, or otherwise
> + * mutilate accesses that either do not require ordering or that interact
> + * with an explicit memory barrier or atomic instruction that provides the
> + * required ordering.
> + */
> +#ifndef __ASM_GENERIC_RWONCE_H
> +#define __ASM_GENERIC_RWONCE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/compiler_types.h>
> +#include <linux/kasan-checks.h>
> +#include <linux/kcsan-checks.h>
> +
> +#include <asm/barrier.h>
> +
> +/*
> + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> + * atomicity or dependency ordering guarantees. Note that this may result
> + * in tears!
> + */
> +#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> +
> +#define __READ_ONCE_SCALAR(x)						\
> +({									\
> +	__unqual_scalar_typeof(x) __x = __READ_ONCE(x);			\
> +	smp_read_barrier_depends();					\
> +	(typeof(x))__x;							\
> +})
> +
> +#define READ_ONCE(x)							\
> +({									\
> +	compiletime_assert_rwonce_type(x);				\

Does it make sense if we also move the definition of this compile time
assertion into rwonce.h too?

Regards,
Boqun

> +	__READ_ONCE_SCALAR(x);						\
> +})
> +

[...]
