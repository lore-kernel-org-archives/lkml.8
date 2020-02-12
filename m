Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2278CC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D912168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 17:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RgNyFI+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgBLRq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:46:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgBLRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 12:46:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id a6so3571986wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rx4KTasodBWEXi7d3hPmVYKTRypri6hdxgzackSE/8=;
        b=RgNyFI+76hVVd9bLK+K7AyL04E02I76wIucJMcXl5K7Xs9e29L1e4y6DmBJ+cmRDO1
         ekSS0P7f1Xn0j9tKFIMDKj48bggpN/JKyvPJeTOZ2EPXCC+DXsXy2DA7IRllzEfRwwTN
         NtkZAe82wVvZRE9Reu8M/e/zPM0CxKWLVjhAgqzc+8mA6m/oYjRy57M2JxAn9W8UIogk
         XYREUeWh3nHSN67bcWeY5YCezRcArl8cVZgLSYxIssxyO87A1LVKKPRBzyz+kF+XhuGa
         8ReZcAViIyAVTE+is3eatf34Nsf3WAUqhHx6AXiIbyqCjX6vI0xxq6xwAvSomJD1ysNT
         ZhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rx4KTasodBWEXi7d3hPmVYKTRypri6hdxgzackSE/8=;
        b=JL7YeH+RPKkq6SI8clCqI5yca9AX1dZAh8OE3DeoLg0jH0HVodK+zc7iXqVfckGcCS
         oWis4QbcgEVwcC5ASsWi1hrIVRO7uT4CMJcHqM5iPFBi6Qu6Flhksmnu9B1QquklCu/9
         97EQ8rOQ4i7p/zgboVNAUrRJ2nNCSPp2/Tlx0iylFDjoZYleiDgGw6GDSstArpEuSDzA
         FuL2jQ46WUgH/VL2wGLu+H4joTy4PxjAWqj1FnHzvG/Z/n2nT4GIBaUP1Msph73ngMel
         /jilTy7NmoXAEwt8j6udD84BcXwIjfsPFEg11nd41xmpj+xSx0SPaT7Kh3bYqq6amzSF
         EJ+g==
X-Gm-Message-State: APjAAAV00QF9c/G46R3joTiaQ72PwsTr9B2x5k5XiLybNDYJn8ewMl7e
        8qOuNWGtWep2TFhb4o/kSmYlCoAo+HG26bpCgI4xIA==
X-Google-Smtp-Source: APXvYqxXP7W080euceKOyzCr68oKnZBuSRgRENHmcqsXFSyTv2Pgiga3G/f1M0Kory185XV0aBc+fR0Ny8KZXA7jZHc=
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr178793wmj.155.1581529585441;
 Wed, 12 Feb 2020 09:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20200206165527.211350-1-smoreland@google.com> <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
 <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov> <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
 <a8321785-902d-9186-fcf5-ee12a362a207@tycho.nsa.gov> <CAHC9VhQVcgQ7ZKXi+Umm51WNgfNSzNX7Zoe=MyaLo1rRm-uUtA@mail.gmail.com>
In-Reply-To: <CAHC9VhQVcgQ7ZKXi+Umm51WNgfNSzNX7Zoe=MyaLo1rRm-uUtA@mail.gmail.com>
From:   Steven Moreland <smoreland@google.com>
Date:   Wed, 12 Feb 2020 09:46:13 -0800
Message-ID: <CAKLm695ZVCfdTnyA4UjaWeQmP3gGNjk_kMj1YOdV+kAbcvSrBw@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Colin Cross <ccross@android.com>,
        "Connor O'Brien" <connoro@google.com>, kernel-team@android.com,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And I strongly encourage our downstream in the same way :) I try, I
try. However, I am a n00b here (thanks for merging "my" first linux
patch).

Looking at this code, I was wondering, why isn't SELinux labelling
completely orthogonal to the fs type? Is this a measurable
memory/performance thing?


On Tue, Feb 11, 2020 at 7:17 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Feb 6, 2020 at 1:12 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 2/6/20 12:41 PM, Steven Moreland wrote:
> > > On Thu, Feb 6, 2020 at 9:35 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > >>
> > >> On 2/6/20 12:21 PM, Stephen Smalley wrote:
> > >>> On 2/6/20 11:55 AM, Steven Moreland wrote:
> > >>>> From: Connor O'Brien <connoro@google.com>
> > >>>>
> > >>>> Add support for genfscon per-file labeling of bpffs files. This allows
> > >>>> for separate permissions for different pinned bpf objects, which may
> > >>>> be completely unrelated to each other.
> > >>>
> > >>> Do you want bpf fs to also support userspace labeling of files via
> > >>> setxattr()?  If so, you'll want to also add it to
> > >>> selinux_is_genfs_special_handling() as well.
> > >>>
> > >
> > > Android doesn't currently have this use case.
> > >
> > >>> The only caveat I would note here is that it appears that bpf fs
> > >>> supports rename, link, unlink, rmdir etc by userspace, which means that
> > >>> name-based labeling via genfscon isn't necessarily safe/stable.  See
> > >>> https://github.com/SELinuxProject/selinux-kernel/issues/2
> > >>>
> > >
> > > Android restricts ownership of these files to a single process (bpfloader) and
> > > so this isn't a concern in our architecture. Is it a concern in general?
> >
> > I guess if the inodes are pinned in memory, then only the original name
> > under which the file is created will be relevant to determining the
> > label and subsequent rename/link operations won't have any effect. So as
> > long as the bpfloader creates the files with the same names being
> > specified in policy, that should line up and be stable for the lifecycle
> > of the inode.
> >
> > The alternative model is to have bpfloader look up a context from the
> > userspace file_contexts configuration via selabel_lookup(3) and friends,
> > and set it on the file explicitly.  That's what e.g. ueventd does for
> > device nodes.  However, one difference here is that you could currently
> > only do this via setxattr()/setfilecon() after creating the file so that
> > the file would temporarily exist in the default label for bpf fs, if
> > that matters.  ueventd can instead use setfscreatecon(3) before creating
> > the file so that it is originally created in the right label but that
> > requires the filesystem to call security_inode_init_security() from its
> > function that originally creates the inode, which tmpfs/devtmpfs does
> > but bpf does not.  So you'd have to add that to the bpf filesystem code
> > if you wanted to support setfscreatecon(3) on it.
>
> Considering the relative maturity of bpf, and bpffs, I think it's okay
> to take this small step right now, with the understanding that more
> work may need to be done, depending on how this is generally adopted
> by distros and users (for those of you not following the other thread,
> I've merged the v3 draft of this patch).
>
> However, I've been noticing a trend from the Android folks of tossing
> patches over the wall without much thought beyond the Android use
> case.  I understand the Android devs have a job to do, and products to
> focus on, but I would strongly encourage them to think a bit longer
> about more general use cases before submitting patches upstream.
>
> --
> paul moore
> www.paul-moore.com
