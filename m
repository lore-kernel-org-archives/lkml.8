Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40476C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3AA20708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fe+Nkt75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbgGHDno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgGHDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:43:43 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18967C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 20:43:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so12658549otq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mHwnZGqBxO1eR5fw/gOLrflI6sKMZmZB5dQJW/fz1OI=;
        b=Fe+Nkt75c5SHX6EoJc25ohkfwpVvt9Shez4gGJsFcnlofCj1p4EV0/9LYeXnB7Ps5I
         GbuUp7Z9dTQ77ECCS2E3WkR/9ObL4djO5nw+5lALHOqtF+X3XwCoWSAyNqBy41djgYc+
         E36Ge2uQyBowWhOaERpqgUrExPkfmEUp60YAiYcfYIoCEJ4GxhSXJM4C44UUVdAKgptU
         BzkgjU5yxVVL/jD+u5cU4WT57KieNFDZ/83O+CbyRoYpVJ5FSBPy6+vLcAmH+5aLHsrU
         2d644BAm8cYMwpkzlShwpkcSY0FWHEBC8SU+QSuKgaTjXfzcJJnkF3rYniKnfCr8PmW8
         LRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mHwnZGqBxO1eR5fw/gOLrflI6sKMZmZB5dQJW/fz1OI=;
        b=iF/6x7Yx2/ljHvtq93+wKhNGiLJSxWMbcmyWAw0rOmTZo2XrIEZyZqt4FZaODP8rth
         CWeY7kStGsidUdOQ1dlFHfNThoo7D/zc7Y4kZ4gGmx9NdP2yZuGjH6d+Q/yQSa0FXV+8
         OOp9+o+/vLFyKKz830Mi5hEXyAzrj9X9uWNosO/f4WuvTeTRjarCVtkKb+i+PnnO2bFq
         xoZXCQevP0sHfjUfasMiv96dgsoB7036yo2HG5V4s5N/kUknB0PRViOSZGAmCXM+oipX
         PRJBU38v1VDWhvudeE8MFPuea2mbOvfMFHd/deFr2TOwZvJp9RgcZxBWeZ+aFI/tO56d
         k6Fw==
X-Gm-Message-State: AOAM532LvKgqlbF7WS0mXhWwTOt9CH5l2Tsq8VD482q+JjvgdWi/1Unb
        f0ROB1/zt+is5UhhOMv6B6Hah/X36WX4+7MSnXCIcg==
X-Google-Smtp-Source: ABdhPJzAu9QJrh4zqPuK1ULgvhkk3S7kmolCzNiGAneauQgVnQWUl8xkvWerju6/BQBeQKcs2e83J8fINMSb4CvYdms=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr40868563otk.221.1594179821275;
 Tue, 07 Jul 2020 20:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200414134629.54567-1-orjan.eide@arm.com> <20200414141849.55654-1-orjan.eide@arm.com>
 <20200414142810.GA958163@kroah.com> <CALAqxLX-SUhHPH6ewt-s9cEMc8DtMTgXem=JruAkLofuJf1syg@mail.gmail.com>
 <20200416102508.GA820251@kroah.com> <20200420082207.ui7iyg7dsnred2vv@wittgenstein>
 <CALAqxLW-txNEqW=P_9VTxvOVu_fgpjzHHDbR5BhtpYwhg1SXgw@mail.gmail.com>
 <20200421080544.GA611314@kroah.com> <20200703070403.GB2221524@kroah.com>
In-Reply-To: <20200703070403.GB2221524@kroah.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 7 Jul 2020 20:43:30 -0700
Message-ID: <CALAqxLUHT=CGNxffz+3G-bUNc2FM_TawDrymFN+S=ZiPcM9pkg@mail.gmail.com>
Subject: Re: [PATCH] staging: android: ion: Skip sync if not mapped
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     driverdevel <devel@driverdev.osuosl.org>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Todd Kjos <tkjos@android.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        lkml <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Anders Pedersen <anders.pedersen@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        nd <nd@arm.com>, Martijn Coenen <maco@android.com>,
        Laura Abbott <laura@labbott.name>,
        Christian Brauner <christian@brauner.io>,
        linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 12:03 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Apr 21, 2020 at 10:05:44AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 20, 2020 at 01:03:39PM -0700, John Stultz wrote:
> > > The dmabuf heaps have been in an official kernel now for all of three
> > > weeks. So yea, we can "delete [ION] and see who even notices", but I
> > > worry that may seem a bit like contempt for the folks doing the work
> > > on transitioning over, which doesn't help getting them to participate
> > > within the community.
> >
> > But they aren't participating in the community today as no one is
> > touching the ion code.  So I fail to see how keeping a dead-end-version
> > of ion in the kernel tree really affects anyone these days.
>
> So, any thoughts here?  What's the timeline for ion being able to be
> removed that you are comfortable with?

Sorry for the slow reply.  So my earlier plan was to drop it after the next LTS?

thanks
-john
