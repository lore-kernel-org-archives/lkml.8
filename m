Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0CC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2EB02053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eT5PDPYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgAQWay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:30:54 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37913 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgAQWax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:30:53 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so28046988ljh.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QnXq6pOPNr85Wv+pnBUgx0ksc9gD9czuLdtLLhv2wcg=;
        b=eT5PDPYAbcnfGiJmdszWf9PgnKzYuOs2aJYz2+M/Eqi5z8IV5z6aDBiIWiOpCAZDuQ
         qrZOI9AuuWyUzTiMH12kF3HC6n42WOKCjs6ne8o9zonNkOaN4AahOh8cJ/yABElv+/R9
         jCtPBieW/eB2hvEMhWQ9FNb8k61NsGBFffgeNv0ItSpjp7CBEPTmkgWoBjHpktdgAJ05
         0uid3IgjVoWSluz7Gh7uEG3tY52te5flBnA2fI6PNoYMjETtN3K87sN++YMxBATufriL
         882g7l2IxKwXGqcSPF0E04SuFtQ7J2lmdQHHj59wvzT51fz182MEwF82H+pZZ1oB85BP
         mlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QnXq6pOPNr85Wv+pnBUgx0ksc9gD9czuLdtLLhv2wcg=;
        b=L5TgveTpqGRPNhWS9e2eI7+p+uTs+8IPTyd4Xeycn/ctMzCRLTnWlE48CaSVKtOFJq
         KQTd9kGHnS6gJc/cm8lxqvzHagPoxxj/HtUQTy2FCTmNcs3zWII93+B7zYZIs9RI+/M6
         ek8HlNjPzeduPvWOijKomz8k3p9b8ZRvB14LDE3pxCgmQWfk/rRxhg3Dst7Hioaqmqga
         kvrjSoN1Qk+NhatLTvlMIZxJBJ8p9nVNm7YrzDwULtDMSQLlZDPEqvaR2V+v2uOyU8zx
         s7TmwGHkDVj69etkxUzvA3SBO5JtZ0xqS775lE1yZCc1KQe/PgkS6M3FnQJQSkCLrhwW
         b8Zw==
X-Gm-Message-State: APjAAAUa4gPhK5ltKbJS67K4oAGv3D2THzHm4x20jTtcIhEPiQGU6hVm
        myecaPY8XmzEk42efG0Ojez+y9l2ladSHK956ZZp/A==
X-Google-Smtp-Source: APXvYqzKEuQM2on6ljo2JXy1kuV7rK2JmWtGbc1ZKZNRbNyWn2UNiFCXqjY1bQwxSlByevH/7c2t8VNHBLT4UPwpTTw=
X-Received: by 2002:a2e:7005:: with SMTP id l5mr7192266ljc.230.1579300251291;
 Fri, 17 Jan 2020 14:30:51 -0800 (PST)
MIME-Version: 1.0
References: <1578671054-5982-1-git-send-email-martin.fuzzey@flowbird.group> <20200114152249.GA2041689@kroah.com>
In-Reply-To: <20200114152249.GA2041689@kroah.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 17 Jan 2020 14:30:40 -0800
Message-ID: <CAHRSSEzi_hpPiMh3g4RzyXHjND-dhJH0W4jpg-c5jyYqhaOBSg@mail.gmail.com>
Subject: Re: [PATCH] binder: fix log spam for existing debugfs file creation.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 7:22 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jan 10, 2020 at 04:44:01PM +0100, Martin Fuzzey wrote:
> > Since commit 43e23b6c0b01 ("debugfs: log errors when something goes wrong")
> > debugfs logs attempts to create existing files.
> >
> > However binder attempts to create multiple debugfs files with
> > the same name when a single PID has multiple contexts, this leads
> > to log spamming during an Android boot (17 such messages during
> > boot on my system).
> >
> > Fix this by checking if we already know the PID and only create
> > the debugfs entry for the first context per PID.
> >
> > Do the same thing for binderfs for symmetry.
> >
> > Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
>
> Does this need a "Fixes:" and cc: stable tag?

It would probably make sense to take it into 5.4 (spam issue was
introduced in 5.2).

Please add "Fixes:" as Greg suggests citing the commit above.
Acked-by: Todd Kjos <tkjos@google.com>

>
> And it would be good to get a review from the binder maintainer(s) to
> see if this is sane or not...
>
> thanks,
>
> greg k-h
