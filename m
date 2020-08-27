Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABCAC20737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJdS2QFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0RCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0RCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:02:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4353CC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:02:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w13so6060232wrk.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iaDJiDThZeeDEzVlzU4moTVS3qRE8PjuLAm4ANV0fPA=;
        b=QJdS2QFBX5yromQSOgok4Hu/Nj+uS0RxjYDbQ8Ks5RYDnERghNSeoKkMDULiCKRwKg
         AWfhg93e3wtc5bzAU7Oo/RdIFgF70toIKidKT6KxIYu2BYpPw/s/L+ciMfc2Deq5zoR+
         W+sPNlrl/U8NbcydIyjiYuZVlRQnpQooKHV39pSp1gEHTbkm3zWcF8tr95xOUAmRXP06
         uVJnybjpBL8V3c0f7/zNK20dyhF7zpYQf7H5VhEduk1wZ77gcjLHSSZgUWAhhLdddDn6
         Gpi/cic/sDPjxY/5rqFmak/ZIFYW54WjvCeF5+VXTh/NXAzF8msIjTE3hfGwr2hz9sRd
         C/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iaDJiDThZeeDEzVlzU4moTVS3qRE8PjuLAm4ANV0fPA=;
        b=g87M6t92HrHONRtIqmGWPWHqTEI7KajuadZbadwh2VyXTduYuaga2zYrnP/A3r0jhq
         4Cr84ZGQE67B0564zsu7FY3VYW/fi8p26XGLiKlZ7F9e10Y9BOGmv9gt39uZdPLTIDVp
         blEgCcik8OHcJcrwkjKFgZnnbeFKeVMNl6Dh8vJWXsqOenjJwMKhqrYvyoN1gcuUdQ14
         fz4FqOLpwzgix5JEvTBA3mvgazJVugLDOXNs1t7iuUsvrc9MIz0KEE5B1+/pyH02DJ8z
         lEHzy5/gtTz3FVT99OgO5EJSeTZ9ZOdN9gN6QJMiYtHINqFGWA3UFsTJvPHvOSIjnA2E
         AAaQ==
X-Gm-Message-State: AOAM533Phlv/owEQMnj10+8u99KrXRGfer96Ui+jb1haEhCuI7D/uuCQ
        Wr35W+bRXUzo3VkCw8giqfGXwrQRxGGqOCkCigIS2g==
X-Google-Smtp-Source: ABdhPJx2h4Suq8Q/8FtsNU6SR+9RMB/Kow8o2Jcg/4T455UHRuZ7Oyo36M9mR7aTSczGcHXxhR4Y5Y4E8PwPBYYbluQ=
X-Received: by 2002:adf:9ec1:: with SMTP id b1mr20983425wrf.171.1598547737864;
 Thu, 27 Aug 2020 10:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name> <20200827160506.GC684514@kroah.com>
In-Reply-To: <20200827160506.GC684514@kroah.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 27 Aug 2020 22:31:41 +0530
Message-ID: <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com>
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Laura Abbott <laura@labbott.name>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linaro-mm-sig@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 21:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Aug 27, 2020 at 09:31:27AM -0400, Laura Abbott wrote:
> > On 8/27/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > The ION android code has long been marked to be removed, now that we
> > > dma-buf support merged into the real part of the kernel.
> > >
> > > It was thought that we could wait to remove the ion kernel at a later
> > > time, but as the out-of-tree Android fork of the ion code has diverge=
d
> > > quite a bit, and any Android device using the ion interface uses that
> > > forked version and not this in-tree version, the in-tree copy of the
> > > code is abandonded and not used by anyone.
> > >
> > > Combine this abandoned codebase with the need to make changes to it i=
n
> > > order to keep the kernel building properly, which then causes merge
> > > issues when merging those changes into the out-of-tree Android code, =
and
> > > you end up with two different groups of people (the in-kernel-tree
> > > developers, and the Android kernel developers) who are both annoyed a=
t
> > > the current situation.  Because of this problem, just drop the in-ker=
nel
> > > copy of the ion code now, as it's not used, and is only causing probl=
ems
> > > for everyone involved.
> > >
> > > Cc: "Arve Hj=C3=B8nnev=C3=A5g" <arve@android.com>
> > > Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> > > Cc: Christian Brauner <christian@brauner.io>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Hridya Valsaraju <hridya@google.com>
> > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Cc: Laura Abbott <laura@labbott.name>
> > > Cc: Martijn Coenen <maco@android.com>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > Cc: Todd Kjos <tkjos@android.com>
> > > Cc: devel@driverdev.osuosl.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linaro-mm-sig@lists.linaro.org
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > We discussed this at the Android MC on Monday and the plan was to
> > remove it after the next LTS release.
>
> I know it was discussed, my point is that it is actually causing
> problems now (with developers who want to change the internal kernel api
> hitting issues, and newbies trying to clean up code in ways that isn't
> exactly optimal wasting maintainer cycles), and that anyone who uses
> this code, is not actually using this version of the code.  Everyone who
> relies on ion right now, is using the version that is in the Android
> common kernel tree, which has diverged from this in-kernel way quite a
> bit now for the reason that we didn't want to take any of those new
> features in the in-kernel version.
>
> So this is a problem that we have caused by just wanting to wait, no one
> is using this code, combined with it causing problems for the upstream
> developers.
>
> There is nothing "magic" about the last kernel of the year that requires
> this code to sit here until then.  At that point in time, all users
> will, again, be using the forked Android kernel version, and if we
> delete this now here, that fork can remain just fine, with the added
> benifit of it reducing developer workloads here in-kernel.
>
> So why wait?

Hi,

I don't know what is the right thing to do here. I just want to
highlight that AOSP's audio (codec2) HAL depends on the ION system
heap and it will break AOSP for people who boot mainline on their
devices, even for just testing purpose like we do in Linaro. Right now
we need only 1 (Android specific out-of-tree) patch to boot AOSP with
mainline and Sumit is already trying to upstream that vma naming
patch. Removal of in-kernel ION, will just add more to that delta.

Regards,
Amit Pundir

>
> thanks,
>
> greg k-h
