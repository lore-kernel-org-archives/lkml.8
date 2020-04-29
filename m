Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A0CC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523CF2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD2UQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:16:30 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:16:30 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MzQbw-1jGV2Z47ii-00vMwI for <linux-kernel@vger.kernel.org>; Wed, 29 Apr
 2020 22:16:28 +0200
Received: by mail-qv1-f51.google.com with SMTP id di6so1834486qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 13:16:27 -0700 (PDT)
X-Gm-Message-State: AGi0PuZe7Uew5U/oEsOZv+Nq1I4+4sJ15IiZqWZ/TO8LnWWf35ef1hCY
        BzhZeYqJy2xaWnvrjC6gae2w8Y4cRzH4rwZU/SM=
X-Google-Smtp-Source: APiQypLcjPwxokzpMF7Rw8kO99qPhqxtI0E31pommY4IAHy487ZiF1AuTEEi6jnKVWVL5iHLduQMeGZW8J6vPMtaFeU=
X-Received: by 2002:a0c:ea43:: with SMTP id u3mr26292131qvp.211.1588191386818;
 Wed, 29 Apr 2020 13:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200429092207.4049268-1-arnd@arndb.de> <f9738a59-5c7d-57ad-0d56-6455d6938964@amd.com>
In-Reply-To: <f9738a59-5c7d-57ad-0d56-6455d6938964@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 29 Apr 2020 22:16:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3YCKtkt2pHQZGg8SQsbdA2Ai3ZhxCGKToD2KVRHQgnrw@mail.gmail.com>
Message-ID: <CAK8P3a3YCKtkt2pHQZGg8SQsbdA2Ai3ZhxCGKToD2KVRHQgnrw@mail.gmail.com>
Subject: Re: [PATCH] [v2] amdgpu: fix gcc-4.8 build warnings
To:     "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RDmGAp3DV7ndHjMb0upD3PfacNxAEoJ+GIDIHPBWlTpPshUWvtW
 Y/sItoQVbL690fZo0YZoGNCPE+I6x/jTJukkcZz/2Y14uaNe65ImNIZd+IuCL4QqtnPeNdy
 dgHsIAs71aDhjbX5Q87a7hKTTuECtICSVtzbG8GM+8aRGaY7aobHl6tbzWObcu1bIsc/Q3d
 +KJExGLC7Fu8HAXqR3eqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5mb7fICL+Q=:nNBWL6Dz2/VF/uxJqrh9kx
 qOggmqDbriu1Xy/Lg4QPUuoRcxGl8TuXSTrUKTs72Olcsx5rSkrmqLPmUutH+W5DTdY+P9rgV
 dh9Ox8ZUV8uF4CFDzmU5EiUDIHBixuu+iy90d6wPe4lgYvYajAmSDq9dJudR9n99VagBvTclM
 /lI19iLirk8VKSdQpdm8mWwyyyFnEyl44PCyVWqb2yaSkGEB/Eh8bSyNxQPNzpx9DJCIC8uSx
 e4hgkFZUhWlSRHJqJQ/rNazKJuc1zl2YSHYEX6jt8BKjMETKnKFGeWddmaliIAIkbwGTu8Ipj
 MiXsN+GZ9bRnj5c4bCF2ifnD0wXl4CBrm6X238OXawYfQlvAv3yEu93jU51Gny0w9pVQt+w5n
 luktri9S4/hQKiIDRpiWzsqhcpipewlUgqDsk5SVquJ/NlbssE889mrm+jZlPxdVnqjqujk68
 IjotsXQvhjCvxjYqejFvIiCHO9PW7fJPBxS7liC59vUjvW6HflsCuwGqid1wbC5XLZVGSCMJs
 GvMnJK4ep38f3VIQURUl97G0RSC04+M2pEnre18klpxMMWLXPHVW85mCwVEtjfz7VZuzvrI0m
 aaROec7uoDz14pKIbKgJYsjJ7mWbZcP1uYphpvtoXxAYf+lq0JX4DAFQMXzQYUMg+5CXjEsOG
 fJD3lKijQb8oYvwS1AQKG/1rWjWX39bUEkissv0N6mVarHnkn5Km2YSozg4uIc5juWqRX1Vyl
 uUBx/hzyCSh5uOR+gRAVxoIlIZ3pjnSLpd2MzZlCBcvsPje/h7qTJD3Bu0GHveRhrSqcE9MRe
 FwL+5vsZfg41gXxh2w4tmEP6zqWw/Vo/WMn6D1dy22ZLprcH34=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 3:42 PM Kazlauskas, Nicholas
<nicholas.kazlauskas@amd.com> wrote:
>
> On 2020-04-29 5:20 a.m., Arnd Bergmann wrote:
> > Older compilers warn about initializers with incorrect curly
> > braces:
> >
> > drivers/gpu/drm/drm_dp_mst_topology.c: In function 'drm_dp_mst_dsc_aux_for_port':
> > drivers/gpu/drm/drm_dp_mst_topology.c:5497:9: error: missing braces around initializer [-Werror=missing-braces]
> >    struct drm_dp_desc desc = { 0 };
> >           ^
> >
> > Change all instances in the amd gpu driver to using the GNU empty
> > initializer extension.
>
> These should actually be memset - instead of GCC complaining, it'll be
> clang instead.

I'm not sure what you mean, clang certainly supports most GNU extensions,
and this one is used all over the kernel.

There is a good reason for using memset instead of ={}, e.g. when you want
to be sure that all padding fields get initialized before copying
stack variables
to user space, but I find it a little harder to read.

       Arnd
