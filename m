Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E765C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B2F2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 23:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="go7Cs1dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgE0Xfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 19:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0Xfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 19:35:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F60C08C5C1;
        Wed, 27 May 2020 16:35:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so30076600ejd.0;
        Wed, 27 May 2020 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhTO9C8pVsj5TXfFI7QbAfV6zOBGig3hgoqL4o5bXcs=;
        b=go7Cs1dHLxR4N4XqyAWX6emqwg31qx15uRNGZVlKcGEvDRK052lh0wY43jrs3goNSo
         QrjvemEO6QXFkuTjEZxqX5sjAFyaSLr5cXMR4ILZ3mTthCVUUokL67hisHns4gmSM+YP
         mFJ2qqQotfd80u13YmM6O2Di4K/ax68+z6P2vx5Nx7O0ceQhbbSqO92VHIbofHGtEo8b
         tJFYtTDu25u4B9X6AF6T3JorprSPpkMlrXCTcBky9E8RYCT+nR7ifd0kVPfx+kqqXHez
         6kFLVEPzjhcUVhqVZW1dDekms5YS/8cup48fWyEfPtPbTuW/IKwloq+uq/URXOzl/zsM
         bGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhTO9C8pVsj5TXfFI7QbAfV6zOBGig3hgoqL4o5bXcs=;
        b=niaKqFi9lBafis88NEOZI/Np3mfdserfvJH3m1oCguL4aPeL25ri76QNyy4HpafVeN
         qM/OxdHix2PmISKMKWLZq9wlUK8DRp13vr7egvfmvL197mkEbSYaeY3D0nwTWClX5aBH
         O2bzXe5GAJ2Zn/sBea01tdXF/PqUvrCob0gC/x0bjrBH94P8j4PEdxErEbmyvXD3nU2u
         mt0N8JeLTl/Niq3pLnjPaAnjXchJQPfKCpYAd6MDB1jhEZT8evGdMX6Ymw30Ii5cVQcm
         ZH9hGcYynjzAwz752bu7YyWbLzTFdOeFAZ7B77VtG/JogWSzRDYvF7o2t9WA38ophMbg
         TgQQ==
X-Gm-Message-State: AOAM5302Aq0Azg/aBB1LDImcZzsvPbnubuwz+Fx81ESQj2maOT5G/bAK
        kn6qQFhMIXwhIqy9yPBjW/El2wnfGdX+2d/B3QU=
X-Google-Smtp-Source: ABdhPJx+g6j7ezQts/dvXrW6l4O+vS3DtFLMC/d4qMisYvvDDruZYV54ewE8/2rEzrJ95TCMGX6waKfhKg3OtmqfoJ4=
X-Received: by 2002:a17:906:4088:: with SMTP id u8mr679123ejj.422.1590622538251;
 Wed, 27 May 2020 16:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200527230442.24228-1-wu000273@umn.edu> <CAKFNMokewQQnx9VyK1TpZx+o11UTmNoVsZ-eqFrRzXnYdP-NYg@mail.gmail.com>
In-Reply-To: <CAKFNMokewQQnx9VyK1TpZx+o11UTmNoVsZ-eqFrRzXnYdP-NYg@mail.gmail.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Thu, 28 May 2020 08:35:26 +0900
Message-ID: <CAKFNMon0KcoFXYOAPBGx0NbzvUTKMWmxkVQW8v9GM6=JMMNgwg@mail.gmail.com>
Subject: Re: [PATCH V2] nilfs2: Fix reference count leak in nilfs_sysfs_create_device_group
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>, wu000273@umn.edu,
        LKML <linux-kernel@vger.kernel.org>, kjlu@umn.edu,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

This v2 patch was not CC'ed to you.   Could you please
pick it up from LKML?

Regards,
Ryusuke Konishi

On Thu, May 28, 2020 at 8:23 AM Ryusuke Konishi
<konishi.ryusuke@gmail.com> wrote:
>
> Hi Andrew,
>
> Please pick this up as well.
>
> Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>
> On Thu, May 28, 2020 at 8:04 AM <wu000273@umn.edu> wrote:
> >
> > From: Qiushi Wu <wu000273@umn.edu>
> >
> > kobject_init_and_add() takes reference even when it fails.
> > In nilfs_sysfs_create_device_group(), the memory allocated by
> > kobject_init_and_add() is not freed when kobject_init_and_add()
> > fails. Fix this issue by calling kobject_put() to clean up the
> > kobject.
> >
> > Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
> > Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> > ---
> >  V2: using kobject_put() to handle kobject_init_and_add() instead of
> >  kobject_del().
> >
> >  fs/nilfs2/sysfs.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
> > index e60be7bb55b0..8416f915d118 100644
> > --- a/fs/nilfs2/sysfs.c
> > +++ b/fs/nilfs2/sysfs.c
> > @@ -999,8 +999,10 @@ int nilfs_sysfs_create_device_group(struct super_block *sb)
> >         init_completion(&nilfs->ns_dev_kobj_unregister);
> >         err = kobject_init_and_add(&nilfs->ns_dev_kobj, &nilfs_dev_ktype, NULL,
> >                                     "%s", sb->s_id);
> > -       if (err)
> > +       if (err) {
> > +               kobject_put(&nilfs->ns_dev_kobj);
> >                 goto free_dev_subgroups;
> > +       }
> >
> >         err = nilfs_sysfs_create_mounted_snapshots_group(nilfs);
> >         if (err)
> > --
> > 2.17.1
> >
