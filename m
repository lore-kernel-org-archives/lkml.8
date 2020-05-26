Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B37BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D462073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590481597;
	bh=PRPzGOrQqvEQBN/N0+9VbQnpxXcG2qlYBS09NRwkock=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gaENWf786rzUMs/s9OXeizwU5sSmEa0N43ZeJ1pGGLUx49XMNRmLDBA5NfjoGpyP0
	 LYU4+uLHXV4gRcFxRC0tf+GvfsMj1rny949mRDe22kTQi4CPRtfiuL6fEbi8XendVR
	 OpZ3hfzHi3bsmgM3dYeyCAuAuIe12p9HGfB4Ik5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbgEZI0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:26:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46283 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:26:36 -0400
Received: by mail-ot1-f67.google.com with SMTP id g25so15574686otp.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfZcS3sVg2fpD6HZFI+A0Ry10Gey+/n6ph5NbDr2ebM=;
        b=eehqJpHDBG5LoN6iqhTMF5+zWjhbd9DlzWqOW4EFLG8LzcE/kjzmYgTuRmWo9leL0N
         d3BlE9h1LErLc9ZEq25j9NX374lcX8SyOA6CWtZjObPpgPS0UVaQvljJVjLNI9LFGEj0
         HgGkYREOVnkf2CNiTnpi89s10Ude97q6xlcaDJUiw5VQBQQfrbNv+fEWxYFu1IoSvZDf
         PULqy/DtMnBMUX/SiyPTz8y/58kiqv29f84xA1QkYAJ5KtDgHmZ/9qvkT3mAiT+Ly1gd
         9KhJRfQvRZyyLH1m2FUpsiJrtl+MExuiOkP3F80WK5XxyFzzGpi8nzEipE684txg7mHE
         TX1A==
X-Gm-Message-State: AOAM531zPGFgbP6+nq+W8Y5GKQTwuVqm5kJu+m9vPuZg9LPT9R13rPNG
        qjGEWhkF0i07L+wRV4vpI+SsZhOZl47wqxUvIzQ=
X-Google-Smtp-Source: ABdhPJyTGZXVPrfl68oPWE/dPo1Sgt9c9Bgocz3xJYuIgmN/Fl9bZ7/3rHMk/53FTmw/BKbMyvaSn/mOv4kaNx6KlqM=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr66736otc.262.1590481595090;
 Tue, 26 May 2020 01:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200524153041.2361-1-gregkh@linuxfoundation.org>
 <20200524153041.2361-2-gregkh@linuxfoundation.org> <CAKdAkRShA2sAMH12H_zpCm=9XJn_yEcnAaaZhLgvhaUMxC-EMw@mail.gmail.com>
 <20200526055806.GA2576013@kroah.com>
In-Reply-To: <20200526055806.GA2576013@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 May 2020 10:26:23 +0200
Message-ID: <CAJZ5v0ii+hMh5DCuYuuO9auFHD0GLxmOVR1FoDmCwrNEnh9gMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kobject: send KOBJ_REMOVE uevent when the object is
 removed from sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 7:58 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, May 25, 2020 at 03:49:01PM -0700, Dmitry Torokhov wrote:
> > On Sun, May 24, 2020 at 8:34 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > It is possible for a KOBJ_REMOVE uevent to be sent to userspace way
> > > after the files are actually gone from sysfs, due to how reference
> > > counting for kobjects work.  This should not be a problem, but it would
> > > be good to properly send the information when things are going away, not
> > > at some later point in time in the future.
> > >
> > > Before this move, if a kobject's parent was torn down before the child,
> >
> > ^^^^ And this is the root of the problem and what has to be fixed.
>
> I fixed that in patch one of this series.  Turns out the user of the
> kobject was not even expecting that to happen.
>
> > > when the call to kobject_uevent() happened, the parent walk to try to
> > > reconstruct the full path of the kobject could be a total mess and cause
> > > crashes.  It's not good to try to tear down a kobject tree from top
> > > down, but let's at least try to not to crash if a user does so.
> >
> > One can try, but if we keep proper reference counting then kobject
> > core should take care of actually releasing objects in the right
> > order. I do not think you should keep this patch, and instead see if
> > we can push call to kobject_put(kobj->parent) into kobject_cleanup().
>
> I tried that, but there was a _lot_ of underflow errors reported, so
> there's something else happening.  Or my attempt was incorrect :)

So it looks like there is something in there that's been overlooked so far.

I'll try to look at the Guenter's traces and figure out what went
wrong after the Heikki's patch.
