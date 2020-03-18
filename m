Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC4AC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3007B2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:13:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCRMNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:13:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36359 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgCRMNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:13:30 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEXZW-0001wI-9u; Wed, 18 Mar 2020 12:13:18 +0000
Date:   Wed, 18 Mar 2020 13:13:17 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] clone3: allow creation of time namespace with offset
Message-ID: <20200318121317.2vyfyqj223sx5ybq@wittgenstein>
References: <20200317083043.226593-1-areber@redhat.com>
 <20200317083043.226593-3-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200317083043.226593-3-areber@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:30:42AM +0100, Adrian Reber wrote:
> This extends clone3() to support the time namespace via CLONE_NEWTIME.
> In addition to creating a new process in a new time namespace this
> allows setting the clock offset in the newly created time namspace.
> 
> The time namespace allows to set an offset for two clocks.
> CLOCK_MONOTONIC and CLOCK_BOOTTIME.
> 
> This clone3() extension also offers setting both offsets through the
> newly introduced clone_args members timens_offset and
> timens_offset_size.
> 
> timens_offset:      Pointer to an array of clock offsets for the
>                     newly created process in a time namespaces.
>                     This requires that a new time namespace has been
>                     requested via CLONE_NEWTIME. It is only possible
>                     to set an offset for CLOCK_MONOTONIC and
>                     CLOCK_BOOTTIME. The array can therefore never
>                     have more than two elements.
>                     clone3() expects the array to contain the
>                     following struct:
>                     struct set_timens_offset {
>                             int clockid;
>                             struct timespec val;
>                     };
> 
> timens_offset_size: This defines the size of the array referenced
>                     in timens_offset. Currently this is limited
>                     to two elements.
> 
> To create a new process using clone3() in a new time namespace with
> clock offsets, something like this can be used:
> 
>   struct set_timens_offset timens_offset[2];
> 
>   timens_offset[0].clockid = CLOCK_BOOTTIME;
>   timens_offset[0].val.tv_sec = -1000;
>   timens_offset[0].val.tv_nsec = 42;
>   timens_offset[1].clockid = CLOCK_MONOTONIC;
>   timens_offset[1].val.tv_sec = 1000000;
>   timens_offset[1].val.tv_nsec = 37;
> 
>   struct _clone_args args = {
>     .flags = CLONE_NEWTIME,
>     .timens_offset = ptr_to_u64(timens_offset),
>     .timens_offset_size = 2;
>   };

In all honesty, this would be a terrible API and I think we need to come
up with something better than this. I don't want to pass down an array
of structs and in general would like to avoid this array + size pattern.
That pattern kinda made sense for the pid array because of pid
namespaces being nested but not for this case, I think. Also, why
require the additional clockid argument here? That makes sense for
clock_settime() and clock_gettime() but here we could just do:

struct timens {
	struct timespec clock_bootime;
	struct timespec clock_monotonic;
};

no? And since you need to expose that struct in a header somewhere
anyway you can version it by size just like clone_args. So the kernel
can apply the same pattern to be backwards compatible that we have with
struct clone_args and for openat2()'s struct open_how via
copy_struct_from_user. Then you only need one additional pointer in
struct clone_args.

What do we think?

Christian
