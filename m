Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2197C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E79B2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731681AbgGaHed convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:34:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:60131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731670AbgGaHec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:34:32 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MCayD-1jrp3N1wgN-009jOT for <linux-kernel@vger.kernel.org>; Fri, 31 Jul
 2020 09:34:30 +0200
Received: by mail-qk1-f175.google.com with SMTP id j187so27937790qke.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:34:30 -0700 (PDT)
X-Gm-Message-State: AOAM531xlJLtqPOQNTuFfPMDsAuB9a4aAW8wRU+WcFG37fP53WRIlbFm
        yVBUmbeLaavu/59KP7pc5QOeyO6wJAL09G5fwaA=
X-Google-Smtp-Source: ABdhPJxYk3wIyoxiO9LUCf/QsYM6dUKOpKBu16SsDD6IATmeJ5ingRMD/m8u2OxTjlKcCpmR5ojXc2QcoL/2khVzoU8=
X-Received: by 2002:a37:b942:: with SMTP id j63mr2753181qkf.138.1596180869243;
 Fri, 31 Jul 2020 00:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200728192924.441570-1-yepeilin.cs@gmail.com>
 <30b2a31f-77c2-56c1-ecde-875c6eea99d5@gmail.com> <CADnq5_NXOiAc7q5gQqF_wwtJD1o6nHjXM4O3gY6EwAQe9iOtXw@mail.gmail.com>
 <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
In-Reply-To: <8c5cf518-12d2-7495-7822-c7ebf8e61972@amd.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 31 Jul 2020 09:34:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2+Vv5=bKDR=NU8jcNgAoZRk+EKG11NU7bQSetyVDvn=w@mail.gmail.com>
Message-ID: <CAK8P3a2+Vv5=bKDR=NU8jcNgAoZRk+EKG11NU7bQSetyVDvn=w@mail.gmail.com>
Subject: Re: [Linux-kernel-mentees] [PATCH] drm/amdgpu: Prevent
 kernel-infoleak in amdgpu_info_ioctl()
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>, Trek <trek00@inbox.ru>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Leo Liu <leo.liu@amd.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:gJrIMeofloy2jpE2Bfl/I2r8jhJ/tDRSJXVBTwZwcgROj2LJk6q
 4bR+piArYZitwHX1goomtRE9jgXo8TWm40OijgLgVdnGDkiIKM5HAuS8IQynWw88f4O51vM
 +bt4Eq3cCaEhWqQXrU99lw6FTi2ymkgWOq2FvKZdynvSY5fI0In7NsLzpZar1lLBCMoY/9s
 x5yG/PHigPaAQouSTY2sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5ByNqUGpY+8=:cziZjiHs/ma9W437MPbOK1
 luERkLRmmSGdwZI6Kq4ryUowgRcQD0oeCfeiyOrIIY7XII3sIp7TDltXRV+48w4XNcUl/MAhh
 urUjCtssjKWOSkBJaXVPQxaAi5OcTnFgg2hUx/pR+5QdBJFnuamvSSaSWR2jQ8Igs20rrTbEP
 QW5Z41/poa7MkTGvowerd1kLIRiCxfM2EU5p50iZJhZkhnFHj+dlwhxF+OaFXEyft6PrcRXgA
 zR02rccIihjKVk9Vin9H9nVT9Za4QAkQmFS850oOR5EI5DMTKuMU8YE+A2/IKOjoPPtpMSU8i
 a+Y9epNiBAmpIo77+8dF3UkDxw1AchCARvTvIKdnVDwwufoPeauUYiRfhWA/gHgQKVzMGGl+s
 yQHPmfACPVaC1AnrYLdhBetPvVeaIZdmbtcn1Rf/UxBnx1AIXyDKIXQxS3lr8Pf6JVRV0jRS+
 vPsFNc9JpJUBn4RItzwiudWnso2x0fBA/4PJAFOZYemcBlxMlEG3paIgbhrtTnmPXt573sc5I
 1gpVMBu2Zj4JtG0b4RrHii+Ys03GJY9VkhcHwaUKiliZ2minOhFImDvIbPiso1He7R4PviVk2
 9fui6vPL3W7QCM5dkvZZKsYZIELeYeTnZfdVwjl7oJBp1yR2MV9pHJPhV6w7WPrRGNdqt8HKK
 Hi/bd96l2nuo4amxtRQ0vuiaZJnJXI1ThbR0bO/b3cdr7tSYzgHoq6jlbAtsXAFsWeWIhjwU+
 4W6f9O/CemipsGJUMc/8ol5fnJ2ekM4MExWGZNF0OdDSPLYwvywSqrZ/Z00NmT7r5c6IC2Skd
 SEfzOF4CjyOh6NPn38N/NF/1pP7OyA653hAH1wWHAPtfrrbYGabOR7ZR16cJ2cth1Rfycgjh4
 saAUXdGPr9N6jPPyUseD3yehvGyyAvyFUnsCGOCEwDsds5PJ0oF4wEsbXZ5jUUETBRYU3gKfc
 yvv71HeSKxXvUSUYNncQHCVdX7fdPvktyY2HRBcIU3lvMHNHB13fZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:09 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
> On 2020-07-29 9:49 a.m., Alex Deucher wrote:
> > On Wed, Jul 29, 2020 at 4:11 AM Christian König
> > <ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >> Am 28.07.20 um 21:29 schrieb Peilin Ye:
> >>> Compiler leaves a 4-byte hole near the end of `dev_info`, causing
> >>> amdgpu_info_ioctl() to copy uninitialized kernel stack memory to userspace
> >>> when `size` is greater than 356.
> >>>
> >>> In 2015 we tried to fix this issue by doing `= {};` on `dev_info`, which
> >>> unfortunately does not initialize that 4-byte hole. Fix it by using
> >>> memset() instead.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: c193fa91b918 ("drm/amdgpu: information leak in amdgpu_info_ioctl()")
> >>> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> >>> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> >>> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> >>
> >> Reviewed-by: Christian König <christian.koenig@amd.com>
> >>
> >> I can't count how many of those we have fixed over the years.
> >>
> >> At some point we should probably document that using "= {}" or "= { 0 }"
> >> in the kernel is a really bad idea and should be avoided.
> >
> > Moreover, it seems like different compilers seem to behave relatively
> > differently with these and we often get reports of warnings with these
> > on clang.  When in doubt, memset.
>
> There are quite a few of those under drivers/gpu/drm, for "amd/", "scheduler/"
> drm*.c files,
>
> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *(|NULL|0) *}" \{\} \+ | wc -l
> 374
> $_
>
> Out of which only 16 are of the non-ISO C variety, "= {}",
>
> $find . \( -regex "./drm.*\.c" -or -regex "./amd/.*\.c" -or -regex "./scheduler/.*\.c" \) -exec egrep -n -- " *= *{ *}" \{\} \+ | wc -l
> 16
> $_

That is an unrelated issue, those were introduced to deal with older compilers
that do not accept '{0}' as an initializer for an aggregate whose
first member is
another aggregate. Generally speaking, '= { }' is better to use in the
kernel than
'= { 0 }' because all supported compilers interpret that the same way for all
structures.

     Arnd
