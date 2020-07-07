Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AE1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E068206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ur/ID3tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGGLkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgGGLkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:40:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DFB5C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 04:40:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so45902882ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 04:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NlD5Coj6tItyyuvkckmXcC1NzYj94/V/Y7EED+OVWYo=;
        b=ur/ID3tfSVMUmuYc56bPe6NPM1LH2sYj4bu4bhvgZAmORagv/bvqXunhRxwyqeod6L
         SOm/cGGjOtiumCNKjq0K3oDIZWwDwqm95Dj83bqeIZD2Rtyf6YOKwx6sGcjHePyu7aUj
         G1nKcmBmSiqLu18Io1vVZcf9ny8a+5q1hBkQjzbmra5VbcqKI8Q2Tq7ljTYr3gjOs0IY
         bEFhHK2Swntv/N5IkEbC5vyIlSwff0Svb4JNTFaxeweXV1er6tXcsdYxwJ9zkC85J2wh
         ViXR4KEJnfkEY8clR9ou0fiEewKDwfvy4M/9i+ZMwrzhbHf7z6Ls3fe8LzrJ5jnMHQy4
         +m2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NlD5Coj6tItyyuvkckmXcC1NzYj94/V/Y7EED+OVWYo=;
        b=FnEWLzkY9C4DAufkVHfTyl74vpo6qpmCsPG2qwOETnM+plxJOxijc5AdJ7lmxgkrhS
         tsiOHo5/05wUJg0LOGNUiDDTIS9f6WSH1BQp8UHouW8s2Vk0psO3qRRFzSx5QgfVlzT8
         VyxHr40XLLhmFsHLWIaEaqhQcC+3btEpvdX1NYt3rvAu1ftz/WJbiGtd6qzvVGH0mB8/
         FHhaFF5mP8Lraou4cCKoKGJUfyzLBbGu5dE7o+oLXmFaiu0eQqF6v9rKXkS13PSBYYse
         m/ycBnxfTrB9SOFyz94mUgaYAqLC+yu0wz412RZQvigv0ZglRwDWiZ6PCL4/dSzv046b
         5Ckg==
X-Gm-Message-State: AOAM530YVN/zIAfh8O5+CWIqEcD67mWb36ZxcA8BlcJNDNhTqV5OOfQJ
        CFoPVTPhql33ELRFUc0LI7tJVc1aqUqt2focaU8=
X-Google-Smtp-Source: ABdhPJzhH1+0xPd3Q4buxdjJqgwE4vDYVmSliZxyPTqVkoGiSg5XII9WREdm6ITrWaZ34HU1/VmklFDcrGbcJ8rh5yw=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr22572230ljj.68.1594122019940;
 Tue, 07 Jul 2020 04:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <1594059372-15563-1-git-send-email-jrdr.linux@gmail.com>
 <1594059372-15563-2-git-send-email-jrdr.linux@gmail.com> <4bafb184-6f07-2582-3d0f-86fb53dd30dc@suse.com>
In-Reply-To: <4bafb184-6f07-2582-3d0f-86fb53dd30dc@suse.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 7 Jul 2020 17:10:08 +0530
Message-ID: <CAFqt6zaWbEiozfkEuMvusxig15buuS1vjJaj4Q5okxNsRz_1vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] xen/privcmd: Corrected error handling path
To:     =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        sstabellini@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Paul Durrant <xadimgnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 3:05 PM J=C3=BCrgen Gro=C3=9F <jgross@suse.com> wrot=
e:
>
> On 06.07.20 20:16, Souptick Joarder wrote:
> > Previously, if lock_pages() end up partially mapping pages, it used
> > to return -ERRNO due to which unlock_pages() have to go through
> > each pages[i] till *nr_pages* to validate them. This can be avoided
> > by passing correct number of partially mapped pages & -ERRNO separately=
,
> > while returning from lock_pages() due to error.
> >
> > With this fix unlock_pages() doesn't need to validate pages[i] till
> > *nr_pages* for error scenario and few condition checks can be ignored.
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Paul Durrant <xadimgnik@gmail.com>
> > ---
> >   drivers/xen/privcmd.c | 31 +++++++++++++++----------------
> >   1 file changed, 15 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> > index a250d11..33677ea 100644
> > --- a/drivers/xen/privcmd.c
> > +++ b/drivers/xen/privcmd.c
> > @@ -580,13 +580,13 @@ static long privcmd_ioctl_mmap_batch(
> >
> >   static int lock_pages(
> >       struct privcmd_dm_op_buf kbufs[], unsigned int num,
> > -     struct page *pages[], unsigned int nr_pages)
> > +     struct page *pages[], unsigned int nr_pages, unsigned int *pinned=
)
> >   {
> >       unsigned int i;
> > +     int page_count =3D 0;
>
> Initial value shouldn't be needed, and ...
>
> >
> >       for (i =3D 0; i < num; i++) {
> >               unsigned int requested;
> > -             int pinned;
>
> ... you could move the declaration here.
>
> With that done you can add my
>
> Reviewed-by: Juergen Gross <jgross@suse.com>

Ok. But does it going make any difference other than limiting scope ?

>
>
> Juergen
