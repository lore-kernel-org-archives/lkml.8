Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A18C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4903720671
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qi/PWOKJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETSRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:17:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B298EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:17:52 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so4098654wre.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Libttd99iUbokL4eNXNIr0x2nDmN388HD4Hj/6QN9+4=;
        b=qi/PWOKJaIsV+WRD8SAXbG8aQ8LQoyalUhA7Olpw/yRxHn4SbftcXoU4fr2OMo7zJA
         vrkYL2XHObkcLrY85WkFDgXIk1nh5qDkv7ZamU+QJu90n6pEs1hVHKT1gQi3FFRvdKfW
         67XN+uDYqJc05j3k7p8Gg16XxAbTxxWAXKCKQ/6QY2Tmictw9rYlyH3CGFpBhwHuKgW+
         b26KpDvM2qw7+UIcSnngaB+9p/xHHIXZLsprK/c5LPACHlsU3f+keWjSWa3Mv75+g6PQ
         4ehaxW9Cr+XaVRxc2LPIJ2GDjfcj3Icfnml4Q0+TtM2+C0Y6IpP/L3HQOeRjJSDRhiVJ
         qB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Libttd99iUbokL4eNXNIr0x2nDmN388HD4Hj/6QN9+4=;
        b=Xm4V5DATqEUYTXQyfo9Kf3t70FsDtljBZXtfOykq6qjqk5D8KexN2niUaNQvPoeSm7
         DxgcgJz3gsb/mZK3NG7CmQkTuwMNHgrlizpBDsV3X3WV6nad7kDk0pho+AIL8GcY8baE
         zyVJF7QzhQsvefKudowCN9UoahxzpK9Bf9Iz73c48RQCxCB9I06sLywK2wvS/lQ+7yDk
         52cs5qLGTurRRzJn53fYiy97vumU4p2o5k9pCKvPQUtWbin2Ki3tkTyFORFwNp1/42oi
         uIRyDzUEQ6lwWyQpdA3qhKBQ5aKRajMKsoYIzw7+H1nn0Xd/DYhnCXw1YZi2cbKOELQ9
         fZKw==
X-Gm-Message-State: AOAM533xRBnTPLBN2sP4MdVCP7V0mWUh8/1rB7tBfKZYbozpi3qWrxRT
        bgQ5+Zcw7XQKMDFBrF849YewDzZUo7BbPJykdyc=
X-Google-Smtp-Source: ABdhPJyoS1RFthA0f7b37gtjz2j4Mj2ZP62ahHIpEt7wQO2Vtigm5C5y3TshlxfB86MYYsKGW7XjW3KeZDyTg0zud0w=
X-Received: by 2002:adf:fa91:: with SMTP id h17mr5086725wrr.111.1589998671412;
 Wed, 20 May 2020 11:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200519225545.GA2066@embeddedor> <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
In-Reply-To: <1065d63e-7959-e4b4-af4e-70607ba92296@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 May 2020 14:17:40 -0400
Message-ID: <CADnq5_MNhmTS_1R+jcngCeDsp1x6U=eVPAGNyE8bEQTg2uzf9w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: Replace one-element array and use
 struct_size() helper
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Wed, May 20, 2020 at 3:42 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 20.05.20 um 00:55 schrieb Gustavo A. R. Silva:
> > The current codebase makes use of one-element arrays in the following
> > form:
> >
> > struct something {
> >      int length;
> >      u8 data[1];
> > };
> >
> > struct something *instance;
> >
> > instance =3D kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > instance->length =3D size;
> > memcpy(instance->data, source, size);
> >
> > but the preferred mechanism to declare variable-length types such as
> > these ones is a flexible array member[1][2], introduced in C99:
> >
> > struct foo {
> >          int stuff;
> >          struct boo array[];
> > };
> >
> > By making use of the mechanism above, we will get a compiler warning
> > in case the flexible array does not occur last in the structure, which
> > will help us prevent some kind of undefined behavior bugs from being
> > inadvertently introduced[3] to the codebase from now on. So, replace
> > the one-element array with a flexible-array member.
> >
> > Also, make use of the new struct_size() helper to properly calculate th=
e
> > size of struct smu10_voltage_dependency_table.
> >
> > This issue was found with the help of Coccinelle and, audited and fixed
> > _manually_.
> >
> > [1] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgcc.gnu.org%2Fonlinedocs%2Fgcc%2FZero-Length.html&amp;data=3D02%7C01%7Cchr=
istian.koenig%40amd.com%7C8a400bdb88924a1d951508d7fc471966%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637255254622039268&amp;sdata=3DILOPPn17c%2B3oy=
LLdh%2BgH2b%2B8RdhWuTFGxruRD7GUHOo%3D&amp;reserved=3D0
> > [2] https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2FKSPP%2Flinux%2Fissues%2F21&amp;data=3D02%7C01%7Cchristian.koe=
nig%40amd.com%7C8a400bdb88924a1d951508d7fc471966%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637255254622039268&amp;sdata=3DlCr5Otij55Snq27BDp4RmtW4h=
NhOS%2Bm4vSUOOAz07XA%3D&amp;reserved=3D0
> > [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> May I suggest that we add a section how to correctly do this to
> Documentation/process/coding-style.rst or similar document?
>
> I've seen a bunch of different approaches and some even doesn't work
> with some gcc versions and result in a broken binary.
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 6 ++----
> >   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h | 2 +-
> >   2 files changed, 3 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > index 246bb9ac557d8..c9cfe90a29471 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> > @@ -410,12 +410,10 @@ static int smu10_get_clock_voltage_dependency_tab=
le(struct pp_hwmgr *hwmgr,
> >                       struct smu10_voltage_dependency_table **pptable,
> >                       uint32_t num_entry, const DpmClock_t *pclk_depend=
ency_table)
> >   {
> > -     uint32_t table_size, i;
> > +     uint32_t i;
> >       struct smu10_voltage_dependency_table *ptable;
> >
> > -     table_size =3D sizeof(uint32_t) + sizeof(struct smu10_voltage_dep=
endency_table) * num_entry;
> > -     ptable =3D kzalloc(table_size, GFP_KERNEL);
> > -
> > +     ptable =3D kzalloc(struct_size(ptable, entries, num_entry), GFP_K=
ERNEL);
> >       if (NULL =3D=3D ptable)
> >               return -ENOMEM;
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h b/driver=
s/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> > index 1fb296a996f3a..0f969de10fabc 100644
> > --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> > +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.h
> > @@ -192,7 +192,7 @@ struct smu10_clock_voltage_dependency_record {
> >
> >   struct smu10_voltage_dependency_table {
> >       uint32_t count;
> > -     struct smu10_clock_voltage_dependency_record entries[1];
> > +     struct smu10_clock_voltage_dependency_record entries[];
> >   };
> >
> >   struct smu10_clock_voltage_information {
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
