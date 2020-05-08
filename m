Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73815C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59EE220A8B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEHLuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:50:06 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43595 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgEHLuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:50:06 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MpUpW-1ilv7N2tSe-00pthS for <linux-kernel@vger.kernel.org>; Fri, 08 May
 2020 13:50:01 +0200
Received: by mail-qk1-f174.google.com with SMTP id k81so1182567qke.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 04:50:01 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3WfVxPniMdySREj/WsyTORNfJDLcr44svmxew0owjQ51thxem
        hA1fm5BarptE16BMvbdk8bT6+XGeRWCz2Yoq+j4=
X-Google-Smtp-Source: APiQypKuVGUxirJvsRZsvrC1Yx5MvbOO463Sw5rDHdo/teRQmairNdwDfmEb/W7IuktuXebZ3ZIZpXSfPJvbtg/AN3o=
X-Received: by 2002:a37:b543:: with SMTP id e64mr2324391qkf.394.1588938600563;
 Fri, 08 May 2020 04:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200507224530.2993316-1-Jason@zx2c4.com> <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
 <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com> <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
In-Reply-To: <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 8 May 2020 13:49:44 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
Message-ID: <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
Subject: Re: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:07WxEC9YWYB8fs59rcXO4UhbXO2GFHkei5aXIEaVr2hasIklEiQ
 D6yugRnRTjs7jNFyfk84lkV7E6ePe0xNQAvXdT9sw+wf0VszhSDQf60Bku8uVd1se7PYuhF
 iHPPdEYvyABE49X2AqdH10n695STAJhyof2UQz1bXFfQmIMHHR2jlWR/BaKN8KaYTWlAHD8
 gBVD/kTqqANuDmnhRsgEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9+fEG5AREek=:X93Uqye24WFjZaxq6+yY5j
 D0pgeLvmKNyxkL8vqBlp1aacvLMIw2kAUEz0TdAGAWl4hh1VQA1pR6ufGW0inmWjAbAnLNn3R
 8sZtD6OW0LlnfceW86t/m3399kVVVsKsM/U/uIXtppsLz0ZzYiqw23RVloW6uYxnc2yGVbzwS
 JECXAltdVtSMuVQtyGpShd1uzDnHw36M27iH9Lb/gLEiJ1wlKSwh0q5SWF5UrdQ24mgsWZavS
 PXrTs6lx+fQDRdCqRv5hvr1exyWSPPPTgK7kDvEuRXPTpmqQv9mCZYUdgVhaTtB3zAuJ/5f0d
 IghPDIQp5zbHJ3YJ+SYAkRMW/jmZMU8WLgK+WmhL4l4hWgqnASSHU6OxwCwP7eUAwLSXCZG8n
 ABVh5zmcUXPkCgGK+0yBkXAp72BTLUrrGlIrDq7Y9wE1HtR/JNrPQ7fPE4mRfV91uOon55ILf
 Hb09pNpXZYCaaJxHf2fBNXp1AOznbfHtfk2toJKKQpPPfg2Cm1e9sMAR8n//l8c/pT2CfoJgi
 T2eFYnRSAC8dtArvKsFqN79LwU25lgovltPKGVipYXg2fk+AWRGMRN3LOBVt745/DWVHfSaTw
 wiAjUnx5ufZY1WCXXVfgYXTRXT6BTl+q73L4VqQfn1s3DUzrJYkhZ23++vPBkfCy1PrfUUxk3
 1Lyx9B0mzeow4O97LEbNZzF1YauCGWhWSVcrHcPc1cmKQpEwGclCnMnfI6BvHcqwyx3lQZA8t
 RA78qJOBEc+xTNEdYpu5lSEbEPOEpfkb/EhXA2JRuBGLa9BP1dUll3JOOvRxin1L1n6AMrw11
 MFi8lF20EN3IugWFSZd1na3UYe4xo3dDISOYmh2w4sSRuz7ODM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 1:33 PM Oleksandr Natalenko <oleksandr@redhat.com> wrote:
>
> On Fri, May 08, 2020 at 05:21:47AM -0600, Jason A. Donenfeld wrote:
> > > Should we untangle -O3 from depending on ARC first maybe?
> >
> > Oh, hah, good point. Yes, I'll do that for a v2, but will wait another
> > day for feedback first.
>
> Just keep in mind that my previous attempt [1] failed because of too
> many false positive warnings despite -O3 really uncovered a couple of
> bugs in the codebase.

I think my warning fixes were mostly picked up in the meantime, but
if there are any remaining, they would be mixed in with random other
fixes in my testing tree, so it's hard to know for sure.

I also want to hear the feedback from the gcc developers about what
the general recommendations are between O2 and O3, and how
they may have changed over time. According to the gcc-10 documentation,
the difference between -O2 and -O3 is exactly this set of options:

-fgcse-after-reload
-fipa-cp-clone
-floop-interchange
-floop-unroll-and-jam
-fpeel-loops
-fpredictive-commoning
-fsplit-loops
-fsplit-paths
-ftree-loop-distribution
-ftree-loop-vectorize
-ftree-partial-pre
-ftree-slp-vectorize
-funswitch-loops
-fvect-cost-model
-fvect-cost-model=dynamic
-fversion-loops-for-strides

It's a relatively short list, so someone familiar with the options could
perhaps look into whether we want to change the default for all
of them, or if it makes sense to be more selective.

Personally, I'm more interested in improving compile speed of the kernel
and eventually supporting -Og or some variant of it for my own build
testing, but of course I also want to make sure that the other optimization
levels do not produce warnings, and -Og leads to more problems than
-O3 at the moment.

       Arnd
