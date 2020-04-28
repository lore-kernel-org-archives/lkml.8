Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24FC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7722064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YyCEijth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgD1IVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726621AbgD1IVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:21:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B606C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:21:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so16522049ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Beulz3eYiXK9znAwwrzxGHeGgQMNh0d9KO0tZVeerX0=;
        b=YyCEijthLzJZij4FLuBKEi61PR7+UjBRJUNcyg0wveaxpD8Oy97R7wgwiswXEE8ia1
         fN5LofI4unGwslLYIZkU7Ttq6FjzFORAQYor/X6kg8vojtUt4w36+Zo26NKcImelM/9S
         btjww7Ng3YfaJfvOjrXl7g7eAmJThl2tM7MIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Beulz3eYiXK9znAwwrzxGHeGgQMNh0d9KO0tZVeerX0=;
        b=ajCsMEVwbcUdD3vjAxjY/NF67/qcg3Xhl/yZMV7gkQXjeNJdzVd/A6Kv9NphZ2zDOv
         UX7Xx2wSXMPkNipflpmUrLJhJ6gO0hMyc4EeQRwURtEr+DvK3jw3MR13xNCIBwfm4Z1Z
         +GZei42oW4XeAVWncFym4IqBxTDJ9Rzul5oZxi9v8GsE13VNSSKmVPLylKWLO0g7ZN4w
         EjN9fp5SuEVW50eSNPeMyHSLAE3dpA9oAcxROY4u+JXnpA8dFMfOYGqkDW05a81Xp2cw
         urj5I5J0x+4LngSLkw8R9OdOVP1HqtfgtbkZYw2e6ZfO9P6UlCHYHx+IRUQL3d3zxpmW
         dVXg==
X-Gm-Message-State: AGi0PuYhfgX46SU5VoAKJ1uzSN2eUtZwr4dlhXj40BzJR2BRJJBZcycG
        wNxEt5PzzN3hTguzOx3Zbr6jDo52q58FOwyHoqLgnA==
X-Google-Smtp-Source: APiQypKS4m63MMNLMCzgc5Bn4XQvr4p1Bar3QttoueFGAN8X/bLOQmYRG4AMwQn5fZ30hczEAu6wGEgHC93FQnOiMlw=
X-Received: by 2002:a17:906:8549:: with SMTP id h9mr22753079ejy.145.1588062072243;
 Tue, 28 Apr 2020 01:21:12 -0700 (PDT)
MIME-Version: 1.0
References: <1585733475-5222-1-git-send-email-chakragithub@gmail.com>
 <CAJfpegtk=pbLgBzM92tRq8UMUh+vxcDcwLL77iAcv=Mxw3r4Lw@mail.gmail.com>
 <CAH7=fosGV3AOcU9tG0AK3EJ2yTXZL3KGfsuVUA5gMBjC4Nn-WQ@mail.gmail.com> <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
In-Reply-To: <CAH7=fosz9KDSBN86+7OxYTLJWUSdUSkeLZR5Y0YyM6=GE0BdOw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 28 Apr 2020 10:21:01 +0200
Message-ID: <CAJfpegvWBHootLiE_zsw35G6Ee387V=Da_wCzaV9NhZQVDKYGg@mail.gmail.com>
Subject: Re: [PATCH] fuse:rely on fuse_perm for exec when no mode bits set
To:     Chakra Divi <chakragithub@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 3:46 PM Chakra Divi <chakragithub@gmail.com> wrote:
>
> On Tue, Apr 21, 2020 at 4:21 PM Chakra Divi <chakragithub@gmail.com> wrote:
> >
> > On Mon, Apr 20, 2020 at 4:55 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Apr 1, 2020 at 11:31 AM Chakra Divi <chakragithub@gmail.com> wrote:
> > > >
> > > > In current code, for exec we are checking mode bits
> > > > for x bit set even though the fuse_perm_getattr returns
> > > > success. Changes in this patch avoids mode bit explicit
> > > > check, leaves the exec checking to fuse file system
> > > > in uspace.
> > >
> > > Why is this needed?
> >
> > Thanks for responding Miklos. We have an use case with our remote file
> > system mounted on fuse , where permissions checks will happen remotely
> > without the need of mode bits. In case of read, write it worked
> > without issues. But for executable files, we found that fuse kernel is
> > explicitly checking 'x' mode bit set on the file. We want this
> > checking also to be pushed to remote instead of kernel doing it - so
> > modified the kernel code to send getattr op to usespace in exec case
> > too.
>
> Any help on this Miklos....

I still don't understand what you are requesting.  What your patch
does is unconditionally allow execution, even without any 'x' bits in
the mode.  What does that achieve?

Thanks,
Miklos
