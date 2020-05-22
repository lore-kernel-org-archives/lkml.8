Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A18C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E227120727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jIclSPKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgEVQdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:33:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56137 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730031AbgEVQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590165192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4sy0ib9KEdvEVMUccLs1iu3r+olJXF2ra9ooHBixRc=;
        b=jIclSPKARplo1dy+Jy0Vm9JVduZEagBLKBOdPqJ1CgyAoj6kdGRpuatse7fE36Fspg6xdQ
        OeGdO9rMqbdwv33pKOY0ewE+iEC2IOfs761xqzboF8krJ7/5YQ51a3uHnVGYJDBv4kCIj9
        h24Oaxv7O/Xj89BG+fNIB2mQKXmYWtY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-3Sqif6oIMgGLubVHjzNiNg-1; Fri, 22 May 2020 12:33:11 -0400
X-MC-Unique: 3Sqif6oIMgGLubVHjzNiNg-1
Received: by mail-qt1-f197.google.com with SMTP id e44so12325204qta.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4sy0ib9KEdvEVMUccLs1iu3r+olJXF2ra9ooHBixRc=;
        b=APr/kq7iq8KRLr851YC9rH9Iq4b31k3+gtUTIWYjbXpSIJLId9vWkGIC/0+X3YEbKR
         xOqQ3pE3ouLIj/9M16Gffx1VE9Va+b9YvjEj396i0LyLUf1fZRbogO2I4IsVnMydfqiN
         YPpQb9R3orrQ1jdaDd2UXifh5Lts9mE+9Y7t+5ApW+/hxBL3dDEarUEQwokhx5B1hJ9p
         gYaMNKWt5nEPBuorZfwjasf+oipz+yo9XLFQD16mafsZXxorSeO4jTVVodp4L5Hd4Pxo
         kejZY/u+PbdLkrCngAg91063RNpFrSXFj9N+gnWexcCE/aOHir8RYpZDZ8qxoYjZ6l9x
         86tA==
X-Gm-Message-State: AOAM530OO6busnu1Tl1JWJEKnq5QVGDhiaje7Yt2TGHNXxFwaUm+Gy6v
        /tDeb3NMtEAx2GlTdxzXOl/eycZDq1oef55XdY7UL/XGmN2zrHJlhw7KgKCRIfZqQMJ69fMb0iE
        uKDLZSCawC37+zaXtjV937hlEY0suKghkMq8HfCD+
X-Received: by 2002:a37:8187:: with SMTP id c129mr15675239qkd.211.1590165190418;
        Fri, 22 May 2020 09:33:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwan68PpwoXP+D6L8Pi8mUQ11pMuHqUW7nq4FeZkfYH5C3xdBN7yioropShBDXxBxctjj/0oxtD9IHE2Fx9vMw=
X-Received: by 2002:a37:8187:: with SMTP id c129mr15675212qkd.211.1590165190105;
 Fri, 22 May 2020 09:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200522085723.29007-1-mszeredi@redhat.com> <20200522160815.GT23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522160815.GT23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 22 May 2020 18:32:59 +0200
Message-ID: <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: make private mounts longterm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 6:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 22, 2020 at 10:57:23AM +0200, Miklos Szeredi wrote:
> > Overlayfs is using clone_private_mount() to create internal mounts for
> > underlying layers.  These are used for operations requiring a path, such as
> > dentry_open().
> >
> > Since these private mounts are not in any namespace they are treated as
> > short term, "detached" mounts and mntput() involves taking the global
> > mount_lock, which can result in serious cacheline pingpong.
> >
> > Make these private mounts longterm instead, which trade the penalty on
> > mntput() for a slightly longer shutdown time due to an added RCU grace
> > period when putting these mounts.
> >
> > Introduce a new helper kern_unmount_many() that can take care of multiple
> > longterm mounts with a single RCU grace period.
>
> Umm...
>
> 1) Documentation/filesystems/porting - something along the lines
> of "clone_private_mount() returns a longterm mount now, so the proper
> destructor of its result is kern_unmount()"
>
> 2) the name kern_unmount_many() has an unfortunate clash with
> fput_many(), with arguments that look similar and mean something
> entirely different.  How about kern_unmount_array()?
>
> 3)
> > -     mntput(ofs->upper_mnt);
> > -     for (i = 1; i < ofs->numlayer; i++) {
> > -             iput(ofs->layers[i].trap);
> > -             mntput(ofs->layers[i].mnt);
> > +
> > +     if (!ofs->layers) {
> > +             /* Deal with partial setup */
> > +             kern_unmount(ofs->upper_mnt);
> > +     } else {
> > +             /* Hack!  Reuse ofs->layers as a mounts array */
> > +             struct vfsmount **mounts = (struct vfsmount **) ofs->layers;
> > +
> > +             for (i = 0; i < ofs->numlayer; i++) {
> > +                     iput(ofs->layers[i].trap);
> > +                     mounts[i] = ofs->layers[i].mnt;
> > +             }
> > +             kern_unmount_many(mounts, ofs->numlayer);
> > +             kfree(ofs->layers);
>
> That's _way_ too subtle.  AFAICS, you rely upon ->upper_mnt == ->layers[0].mnt,
> ->layers[0].trap == NULL, without even mentioning that.  And the hack you do
> mention...  Yecchhh...  How many layers are possible, again?

500, mounts array would fit inside a page and a page can be allocated
with __GFP_NOFAIL. But why bother?  It's not all that bad, is it?

Thanks,
Miklos

