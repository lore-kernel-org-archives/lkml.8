Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B730C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0892065F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dPc0cv+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgFOJgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgFOJgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:36:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706DCC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:36:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so18353234lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22kS9L9B/ois1Ha/GYEYnbqzF7cTylSOmt/vj8WNXQQ=;
        b=dPc0cv+HsIER0Sn1puUNnpOALEmOKBQNe6madCuFxhjtZBOpyXgMvgLh5RX+5VlOG6
         nUj95LeZLpM+kpYtC51SOF1tteYW7eQUBYNBIt95FZ0xrPOqSHSmcdZgSB6wPl49xeOb
         A6ngEucZtEp6Fn/xm/vVIa3HFC92bDUnPs2jYfFmPz472qaN8JCp/mW7uSs70hdk+E12
         z+oWtIRwRemkKEBYGiDiMonGbb0LKWFo1BMVZKBwHh2M6AX96gQG1WXvpzVHM3GaKKmV
         /SSUpYFjmf+rR6ZJRZJrjTgZqRahuOHotlWMtzzKEEYGr5XqXbm7F+8Uo8tRldgAS675
         KfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22kS9L9B/ois1Ha/GYEYnbqzF7cTylSOmt/vj8WNXQQ=;
        b=eJsVdp/trelFaNeqq/ejHCoysUBK7RFj2IEiZd53nf1dibUdNHR0PEKTpIT4dxxXWr
         ThM9ejnzkDzHW1gvpSm+gfJQfOQ75eshxtnihcC6sS6QCrJQraQlGMKl8GMG6DQbFdWR
         dnT4TV5/Xzw6C/f0LZIY5FoQ+AngiFKqWmLMWqItaBNryWY7O+IsouPriHUzOIeGz1zn
         Nzr2o23kTxdZJxGjhze77h2NkosZhjMoTXiF7dWzEDY5py78eY9Epm359ps5GFMVuoHO
         SVBbbcqU08b9ITcYNOPSo03JMBl5uiSuTHjlsxenPXCybiTjtF3CWFwnkMwM11GbX6ws
         Lm2g==
X-Gm-Message-State: AOAM5326Q1FOS6VYGE1yeh6BBGXyC//pPOxeWtIA+XoNas4A3ID6tIiH
        KM/5Cvi9N8Bq7L0HKMmXgsoLrOxOhbNujURz2mTY/A==
X-Google-Smtp-Source: ABdhPJwRU2jzVYZnkHe1W/+KPEzJhKKWPFPgo4Z700O+yxFlCpBBlu0uLExT1SdYzrNsb4FqBJyO5n6lUmtFTduqpZk=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr11434276ljb.156.1592213808587;
 Mon, 15 Jun 2020 02:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200613072609.5919-1-sargun@sargun.me>
In-Reply-To: <20200613072609.5919-1-sargun@sargun.me>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 15 Jun 2020 11:36:22 +0200
Message-ID: <CAG48ez2ZyYkHhbuwLYehR5fx2_d9yoVg4tBmyqvVqpy-oZ-0cA@mail.gmail.com>
Subject: Re: [RFC PATCH] seccomp: Add extensibility mechanism to read notifications
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 9:26 AM Sargun Dhillon <sargun@sargun.me> wrote:
> This introduces an extensibility mechanism to receive seccomp
> notifications. It uses read(2), as opposed to using an ioctl. The listener
> must be first configured to write the notification via the
> SECCOMP_IOCTL_NOTIF_CONFIG ioctl with the fields that the user is
> interested in.
>
> This is different than the old SECCOMP_IOCTL_NOTIF_RECV method as it allows
> for more flexibility. It allows the user to opt into certain fields, and
> not others. This is nice for users who want to opt into some fields like
> thread group leader. In the future, this mechanism can be used to expose
> file descriptors to users,

Please don't touch the caller's file descriptor table from read/write
handlers, only from ioctl handlers. A process should always be able to
read from files supplied by an untrusted user without having to worry
about new entries mysteriously popping up in its fd table.

> such as a representation of the process's
> memory. It also has good forwards and backwards compatibility guarantees.
> Users with programs compiled against newer headers will work fine on older
> kernels as long as they don't opt into any sizes, or optional fields that
> are only available on newer kernels.
>
> The ioctl method relies on an extensible struct[1]. This extensible struct
> is slightly misleading[2] as the ioctl number changes when we extend it.
> This breaks backwards compatibility with older kernels even if we're not
> asking for any fields that we do not need. In order to deal with this, the
> ioctl number would need to be dynamic, or the user would need to pass the
> size they're expecting, and we would need to implemented "extended syscall"
> semantics in ioctl. This potentially causes issue to future work of
> kernel-assisted copying for ioctl user buffers.

I don't see the issue. Can't you replace "switch (cmd)" with "switch
(cmd & ~IOCSIZE_MASK)" and then check the size separately?
