Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C732087C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ShdT1Amb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgH0RRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgH0RQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 13:16:59 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A0AC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:16:58 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so5131760qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 10:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/sinItkw0fMiz5k7wOtwmeJNSHN2dJzPeRRCsjiQAtw=;
        b=ShdT1Amb8cFBk7QoerCq9MBv460dUKx9sasPl2jpNbpvbgSAPVWV1LNx4tNYqtQl9s
         a8HdJGAP5RIyyGO7e0efjwna6tgvCBDt7cWACvicGcPSuDwwtI31DAPAR1z+iz0qFt+v
         0/SjLFZFPIMFXTXQj50g4wJaPpgsQqv825O8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/sinItkw0fMiz5k7wOtwmeJNSHN2dJzPeRRCsjiQAtw=;
        b=URvbk4Sq0sY7PApZhCpQd/R/K6w17TXilafEFs3RuaGb7b1tllgu0I26y0tZ2ApZdp
         We9k0T8RR+hiWcQE7sXJ4z4l9CcOdwoizwQDZ3aAePbosakomFkYJtRlpReHUmIwK+UG
         8saVQG2RN3FN7fC3Y0x3QJyvZeq5G6TzGa5XOZHZoZpGSBmStAZtL2lqQotbFcO4rQ2c
         /M9UV3QOt7PPNcRCpvn/HjX3r6/w96Z8ettMz0KEQgX78azJZ/wETbfB+5TGpyJM5H7f
         HkjS+AM3XD6/s6dktUfZT1W2rTIPAKX8l0/hLdJoQ1XSDUeGbhoWZAHD1bzrunRkHUPa
         IOxw==
X-Gm-Message-State: AOAM533mHocXoer4z/8vFDzBNuO9SxtsjEVsqaTDyOr/qBoQWCm7XmA8
        itYSKm1DA6stqHOoR+OGVPNk+g==
X-Google-Smtp-Source: ABdhPJxuoVfZ2k+iph3eNvKD2GUzguirA7HTRHhpEpY4GfJL7dVTt29kDuTvD8xTRmBEMbzNMNsKkQ==
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr18870259qtw.91.1598548617909;
        Thu, 27 Aug 2020 10:16:57 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id k48sm2441720qtk.44.2020.08.27.10.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:16:57 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:16:56 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Amit Pundir <amit.pundir@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laura Abbott <laura@labbott.name>,
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
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Hridya Valsaraju <hridya@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: ion: remove from the tree
Message-ID: <20200827171656.GA3090278@google.com>
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
 <3d8de519-65b3-123b-8ace-e820982884e0@labbott.name>
 <20200827160506.GC684514@kroah.com>
 <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMi1Hd1Ch1RWvOTnON3tsrucaKThTuGQnwNFo94GqUjufVmnOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:31:41PM +0530, Amit Pundir wrote:
> On Thu, 27 Aug 2020 at 21:34, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Aug 27, 2020 at 09:31:27AM -0400, Laura Abbott wrote:
> > > On 8/27/20 8:36 AM, Greg Kroah-Hartman wrote:
> > > > The ION android code has long been marked to be removed, now that we
> > > > dma-buf support merged into the real part of the kernel.
> > > >
> > > > It was thought that we could wait to remove the ion kernel at a later
> > > > time, but as the out-of-tree Android fork of the ion code has diverged
> > > > quite a bit, and any Android device using the ion interface uses that
> > > > forked version and not this in-tree version, the in-tree copy of the
> > > > code is abandonded and not used by anyone.
> > > >
> > > > Combine this abandoned codebase with the need to make changes to it in
> > > > order to keep the kernel building properly, which then causes merge
> > > > issues when merging those changes into the out-of-tree Android code, and
> > > > you end up with two different groups of people (the in-kernel-tree
> > > > developers, and the Android kernel developers) who are both annoyed at
> > > > the current situation.  Because of this problem, just drop the in-kernel
> > > > copy of the ion code now, as it's not used, and is only causing problems
> > > > for everyone involved.
> > > >
> > > > Cc: "Arve Hjønnevåg" <arve@android.com>
> > > > Cc: "Christian König" <christian.koenig@amd.com>
> > > > Cc: Christian Brauner <christian@brauner.io>
> > > > Cc: Christoph Hellwig <hch@infradead.org>
> > > > Cc: Hridya Valsaraju <hridya@google.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > > Cc: John Stultz <john.stultz@linaro.org>
> > > > Cc: Laura Abbott <laura@labbott.name>
> > > > Cc: Martijn Coenen <maco@android.com>
> > > > Cc: Shuah Khan <shuah@kernel.org>
> > > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > > Cc: Suren Baghdasaryan <surenb@google.com>
> > > > Cc: Todd Kjos <tkjos@android.com>
> > > > Cc: devel@driverdev.osuosl.org
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linaro-mm-sig@lists.linaro.org
> > > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > We discussed this at the Android MC on Monday and the plan was to
> > > remove it after the next LTS release.
> >
> > I know it was discussed, my point is that it is actually causing
> > problems now (with developers who want to change the internal kernel api
> > hitting issues, and newbies trying to clean up code in ways that isn't
> > exactly optimal wasting maintainer cycles), and that anyone who uses
> > this code, is not actually using this version of the code.  Everyone who
> > relies on ion right now, is using the version that is in the Android
> > common kernel tree, which has diverged from this in-kernel way quite a
> > bit now for the reason that we didn't want to take any of those new
> > features in the in-kernel version.
> >
> > So this is a problem that we have caused by just wanting to wait, no one
> > is using this code, combined with it causing problems for the upstream
> > developers.
> >
> > There is nothing "magic" about the last kernel of the year that requires
> > this code to sit here until then.  At that point in time, all users
> > will, again, be using the forked Android kernel version, and if we
> > delete this now here, that fork can remain just fine, with the added
> > benifit of it reducing developer workloads here in-kernel.
> >
> > So why wait?
> 
> Hi,
> 
> I don't know what is the right thing to do here. I just want to
> highlight that AOSP's audio (codec2) HAL depends on the ION system
> heap and it will break AOSP for people who boot mainline on their
> devices, even for just testing purpose like we do in Linaro. Right now
> we need only 1 (Android specific out-of-tree) patch to boot AOSP with
> mainline and Sumit is already trying to upstream that vma naming
> patch. Removal of in-kernel ION, will just add more to that delta.

So that means you now have to carry 2 patches instead of 1, right? That's not
that bad :-D.

BTW, why doesn't your mainline testing use dmabuf already?

AFAIK, upstream has inertia catching up to products etc, so sooner its
removed the better if it is mostly dead (Before it turns into ashmem which
nobody can remove). My 2c.

thanks,

 - Joel

