Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE1BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C3320735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgEKHww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 03:52:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:48729 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgEKHww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 03:52:52 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N0FE1-1jDeNC143L-00xHUR for <linux-kernel@vger.kernel.org>; Mon, 11 May
 2020 09:52:49 +0200
Received: by mail-io1-f41.google.com with SMTP id s10so8562496iog.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:52:49 -0700 (PDT)
X-Gm-Message-State: AGi0PuaiuCEuSd7w38283vIRZih2+0sYxzOgToNtcbsmmDP/sucTiP6s
        tjkxSDUazwvePF+PehB5sJ0cyAjW422MDUALp/Y=
X-Google-Smtp-Source: APiQypLiww9K2vQQyR9/gMZxUya12W1EmcQHsxoRkn4Cxm8H8qPnH1jzICBK99UvxZyleyeClRL49HPOukqw1fr6hCg=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr14712603qtn.18.1589183567291;
 Mon, 11 May 2020 00:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200508220150.649044-1-arnd@arndb.de> <20200511025337.GA1823106@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20200511025337.GA1823106@iweiny-DESK2.sc.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 11 May 2020 09:52:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0EN=PrHEuDNr__kRkhsaYK0mM5yYa4qhceRSKfCC-MRA@mail.gmail.com>
Message-ID: <CAK8P3a0EN=PrHEuDNr__kRkhsaYK0mM5yYa4qhceRSKfCC-MRA@mail.gmail.com>
Subject: Re: [PATCH] drm: vmwgfx: include linux/highmem.h
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Lutomirski <luto@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Chris Zankel <chris@zankel.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Huang Rui <ray.huang@amd.com>, Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:9LKbY7tqE1DfG6TrAkfLHMN9y0TUQCmI87wrvMWGhK6JMdneipX
 3jZTq+iw6xAFtLVKED/XOPSgInxf6UtRg7OhYNW7STFStVGSCGEWeSx5IZNArcrOxTqKtH4
 nVtdQcJQEkkS5gnXfKAH7aMsA9akdaKC+oe2QDphsSONs/nxY/LExjjh0WuCGwrqmUnQgR5
 H1BkAhr9LCUrnzCg6XfOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f/tykteIZCE=:TqzR/pjX6wus4C5BBTGYrh
 GVyj/sdROhShIswCrpsV/xa4nYPgrpQ6F2DSAFFEhPvBQ9sQUEFuWHgF1zS4Av6fgJvqBatQn
 O8sJmWTCsvMSEN78nLLZCy/PJDd3/k7SH+nlsQdb+DDIBBHBye/uZUF6nzsDBO1nzjyC5g2MG
 axEIUbLe3OojjYjZIIo6X5XB8F2mI8dWuaa32nXssJao28s0L5Dc+EsvyyoozL9vGlYZpu6zr
 efOS/OsPG5I8vDFsWC+uYmK560yRb8ne/ETWlLhMINnzBOh32Us95vL1Boqg1AO/SpUjhXQpv
 B53IlTPQgg50mAmxSHsPSjclFOggC3XnTAuxkLYnhpldtNDUgQQbA73/apd93WB/MlFSbw8Qc
 C5IGmP1Mr5PYi3z6Aa1aJtskIZ5y87d5A+NFo868i/uSfn14FWcdOAAxLsZnbcEsnjb9gWTCY
 XEZeqyj84p0HMryKkrbUodBSmIKlo8vLfgEWAGrJP0D1bWeHWV335aztsfEDBQMC0k3CkQhIt
 jElLECsUEueZ56hB98WtnPzegMOBSzY+8xm/ibP2AwipxRD3pk7T96GlhAMco/FQagWal/Ltc
 OHNZq/+/xSI+2YtTPvCqeo1/1d5X2qNpRIUXYt+iccxW74JXmUFHIXuQY9cCXJUjLRVVR1JpX
 dRQAypV22CKgQvhh7YSDieggEjS9846pqmxbRJREk0/NgEeu1OdAQ3Kqlr3yw52UQ/jRWehnR
 pvP51iS1VualrI090hh0ahtxndKpPtO/tJe+nug2o49tKy0yYz8dVp+bclFxpjcM9XX10O0vX
 XfCCPzji5AegoH3jCNXos8n0T3T/xpbkRp/rTyJvEZz1NKatdo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:53 AM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Sat, May 09, 2020 at 12:01:31AM +0200, Arnd Bergmann wrote:
> > In order to call kmap_atomic() etc, we need to include linux/highmem.h:
> >
> > drivers/gpu/drm/vmwgfx/vmwgfx_blit.c: In function 'vmw_bo_cpu_blit_line':
> > drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:377:4: error: implicit declaration of function 'kunmap_atomic'; did you mean 'in_atomic'? [-Werror=implicit-function-declaration]
> >   377 |    kunmap_atomic(d->src_addr);
> >       |    ^~~~~~~~~~~~~
> >       |    in_atomic
> > drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:391:5: error: implicit declaration of function 'kmap_atomic_prot' [-Werror=implicit-function-declaration]
> >   391 |     kmap_atomic_prot(d->dst_pages[dst_page],
> >       |     ^~~~~~~~~~~~~~~~
> > drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:390:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >   390 |    d->dst_addr =
> >       |                ^
> > drivers/gpu/drm/vmwgfx/vmwgfx_blit.c:403:16: warning: assignment to 'u8 *' {aka 'unsigned char *'} from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >   403 |    d->src_addr =
> >       |                ^
> >
> > Fixes: 46385a895322 ("drm: remove drm specific kmap_atomic code")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> I'm curious about the config which failed...  Because this compiled for me.
> Regardless it was stupid of me to not include this.
>
> Thanks,
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

I do a lot of randconfig build tests and only one of them had this problem.

See https://pastebin.com/LmX0Jfbg for reference, I did not check further
which of the options caused this.

      Arnd
