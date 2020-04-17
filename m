Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F33C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D6820656
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDQUpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgDQUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:45:49 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028D0C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:45:49 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPXro-0006wp-2U; Fri, 17 Apr 2020 22:45:40 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 83013100C47; Fri, 17 Apr 2020 22:45:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: Re: [PATCH] x86: introduce memcpy_flushcache_clflushopt
In-Reply-To: <CAPcyv4jjJ_SZuAjdhdQKGWh6qiP1O4kFyzP9BcBgbb2oanc=yQ@mail.gmail.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com> <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com> <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com> <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com> <CAPcyv4jjJ_SZuAjdhdQKGWh6qiP1O4kFyzP9BcBgbb2oanc=yQ@mail.gmail.com>
Date:   Fri, 17 Apr 2020 22:45:39 +0200
Message-ID: <87a739zvrg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
> On Fri, Apr 17, 2020 at 5:47 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>> +#define __HAVE_ARCH_MEMCPY_FLUSHCACHE_CLFLUSHOPT 1
>> +void memcpy_flushcache_clflushopt(void *dst, const void *src, size_t cnt);
>
> This naming promotes an x86ism and it does not help the caller
> understand why 'flushcache_clflushopt' is preferred over 'flushcache'.

Right.

> The goal of naming it _inatomic() was specifically for the observation
> that your driver coordinates atomic access and does not benefit from
> the cache friendliness that non-temporal stores afford. That said
> _inatomic() is arguably not a good choice either because that refers
> to whether the copy is prepared to take a fault or not. What about
> _exclusive() or _single()? Anything but _clflushopt() that conveys no
> contextual information.
>
> Other than quibbling with the name, and one more comment below, this
> looks ok to me.
>
>> Index: linux-2.6/drivers/md/dm-writecache.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/md/dm-writecache.c   2020-04-17 14:06:35.139999000 +0200
>> +++ linux-2.6/drivers/md/dm-writecache.c        2020-04-17 14:06:35.129999000 +0200
>> @@ -1166,7 +1166,10 @@ static void bio_copy_block(struct dm_wri
>>                         }
>>                 } else {
>>                         flush_dcache_page(bio_page(bio));
>> -                       memcpy_flushcache(data, buf, size);
>> +                       if (likely(size > 512))
>
> This needs some reference to how this magic number is chosen and how a
> future developer might determine whether the value needs to be
> adjusted.

I don't think it's a good idea to make this decision in generic code as
architectures or even CPU models might have different constraints on the
size.

So I'd rather let the architecture implementation decide and make this

                         flush_dcache_page(bio_page(bio));
 -                       memcpy_flushcache(data, buf, size);
 +                       memcpy_flushcache_bikesheddedname(data, buf, size);

and have the default fallback memcpy_flushcache() and let the
architecture sort the size limit and the underlying technology out.

So x86 can use clflushopt or implement it with movdir64b and any other
architecture can provide their own magic soup without changing the
callsite.

Thanks,

        tglx



