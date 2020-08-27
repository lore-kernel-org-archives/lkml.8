Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A31C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8262087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PPb8oqOj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgH0RWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0RWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:22:30 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8DC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:22:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d139so6597395qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LzdfP6LA5gT4sxc5D/mTAUgxcIMZMneFMWeK08iY3Ys=;
        b=PPb8oqOjktS1lCmnAdruSvzS2kQ/SMeP0HBKVD4EJiI2lPbNPByF9GJrRBoVYQRNVN
         VkWayom1EmERgLQxShnDryiScCBV/sUvFLkf8TQLMLPVqDYpRBE7ciW/0MYzY0q3Hz5D
         piNQtISPZP6CAMxt1TRJ45z+4x9+nyh2A5ykoKuIlqKEuipdg7e/0H050k8HhF97/8oT
         6V4t/SShTVdusMAd/XuA5sdpWDbOgu+o6b6TdslYyoHZxsvCKFrdWEk/z/aRIVqN6R9i
         YUNJ89qwkGlR7IUfxDLHYqUP0pd+F8qX5f5hSvUMJj6gEJDlFeAk+aCTUOCyxT+xBCM9
         XQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LzdfP6LA5gT4sxc5D/mTAUgxcIMZMneFMWeK08iY3Ys=;
        b=D+9lgLzUt8RYFdmeMnw2+QDYpOKfnmoDYnbap/twuolVk5JpvezD1dslcgF3k23WjI
         uu/qjWO2Sq5BCFYZXMtfH0H9KlKnLS5LNe0O4100gDHD//0tz1Ri+aLChBT3syazb2Ps
         976RD7G8gf+4+HTIB9w7x5J2T6nk+KbOZDPBe7jhSTDgJatsBdK7ZfT5ylL0ufYyQwl5
         Kl94pCmdcBfxUMhk/ufDq1OwWBZobhVKBRZ8A8T7nNNcHFUqRc50AGfBAcdXdeX0d5Cf
         23qVUwuYNpc8PYWL0/dFrKila71+LxqBpFPGPGxx+MwXIJYFRBv/mc6YbSskslOQ112n
         EflQ==
X-Gm-Message-State: AOAM530iruqqEglUw1JCkjv3OpTeABPbKL/73R1DDFtVNjqAiC18O0YH
        882Yhkt5D7ptptQDoEmTy1vR8zc+WxBnE/+LUSOeAA==
X-Google-Smtp-Source: ABdhPJwEuYsl6kdz4x5MV1MDd279JzsSlE4TSOAu1/qArH5gHUfvqgzJDC+kYF093anMkIXlN+uDJsUKKYahYaBVsjA=
X-Received: by 2002:a37:74d:: with SMTP id 74mr19814431qkh.147.1598548947537;
 Thu, 27 Aug 2020 10:22:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name> <20200827160506.GC684514@kroah.com>
 <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com> <20200827171745.GA701089@kroah.com>
In-Reply-To: <20200827171745.GA701089@kroah.com>
From:   Hridya Valsaraju <hridya@google.com>
Date:   Thu, 27 Aug 2020 10:21:51 -0700
Message-ID: <CA+wgaPO-WqMcvsEHZ926eKfvcCwfgDwT+Cg4A-JvEpA5xTwDNA@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Christoph Hellwig <hch@infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        John Stultz <john.stultz@linaro.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Laura Abbott <laura@labbott.name>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 27, 2020 at 10:31:41PM +0530, Amit Pundir wrote:
> > On Thu, 27 Aug 2020 at 21:34, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Aug 27, 2020 at 09:31:27AM -0400, Laura Abbott wrote:
> > > > On 8/27/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > > > The ION android code has long been marked to be removed, now that=
 we
> > > > > dma-buf support merged into the real part of the kernel.
> > > > >
> > > > > It was thought that we could wait to remove the ion kernel at a l=
ater
> > > > > time, but as the out-of-tree Android fork of the ion code has div=
erged
> > > > > quite a bit, and any Android device using the ion interface uses =
that
> > > > > forked version and not this in-tree version, the in-tree copy of =
the
> > > > > code is abandonded and not used by anyone.
> > > > >
> > > > > Combine this abandoned codebase with the need to make changes to =
it in
> > > > > order to keep the kernel building properly, which then causes mer=
ge
> > > > > issues when merging those changes into the out-of-tree Android co=
de, and
> > > > > you end up with two different groups of people (the in-kernel-tre=
e
> > > > > developers, and the Android kernel developers) who are both annoy=
ed at
> > > > > the current situation.  Because of this problem, just drop the in=
-kernel
> > > > > copy of the ion code now, as it's not used, and is only causing p=
roblems
> > > > > for everyone involved.
> > > > >
> > > > > Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> > > > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > > > Cc: Christian Brauner <christian@brauner.io>
> > > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > > Cc: Hridya Valsaraju <hridya@google.com>
> > > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > > Cc: John Stultz <john.stultz@linaro.org>
> > > > > Cc: Laura Abbott <laura@labbott.name>
> > > > > Cc: Martijn Coenen <maco@android.com>
> > > > > Cc: Shuah Khan <shuah@kernel.org>
> > > > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > > Cc: Todd Kjos <tkjos@android.com>
> > > > > Cc: devel@driverdev.osuosl.org
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Cc: linaro-mm-sig@lists.linaro.org
> > > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > >
> > > > We discussed this at the Android MC on Monday and the plan was to
> > > > remove it after the next LTS release.
> > >
> > > I know it was discussed, my point is that it is actually causing
> > > problems now (with developers who want to change the internal kernel =
api
> > > hitting issues, and newbies trying to clean up code in ways that isn'=
t
> > > exactly optimal wasting maintainer cycles), and that anyone who uses
> > > this code, is not actually using this version of the code.  Everyone =
who
> > > relies on ion right now, is using the version that is in the Android
> > > common kernel tree, which has diverged from this in-kernel way quite =
a
> > > bit now for the reason that we didn't want to take any of those new
> > > features in the in-kernel version.
> > >
> > > So this is a problem that we have caused by just wanting to wait, no =
one
> > > is using this code, combined with it causing problems for the upstrea=
m
> > > developers.
> > >
> > > There is nothing "magic" about the last kernel of the year that requi=
res
> > > this code to sit here until then.  At that point in time, all users
> > > will, again, be using the forked Android kernel version, and if we
> > > delete this now here, that fork can remain just fine, with the added
> > > benifit of it reducing developer workloads here in-kernel.
> > >
> > > So why wait?
> >
> > Hi,
> >
> > I don't know what is the right thing to do here. I just want to
> > highlight that AOSP's audio (codec2) HAL depends on the ION system
> > heap and it will break AOSP for people who boot mainline on their
> > devices, even for just testing purpose like we do in Linaro. Right now
> > we need only 1 (Android specific out-of-tree) patch to boot AOSP with
> > mainline and Sumit is already trying to upstream that vma naming
> > patch. Removal of in-kernel ION, will just add more to that delta.
>
> As AOSP will continue to rely on ION after December of this year, all
> you are doing is postponing the inevitable a few more months.
>
> Push back on the Android team to fix up the code to not use ION, they
> know this needs to happen.
>

Hi all,

We are currently working with the codec2 team to transition codec2 to
use libdmabufheap instead of libion. It will definitely happen during
the Android S timeframe.

Thanks,
Hridya

> thanks,
>
> greg k-h
