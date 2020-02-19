Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0839C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C6B2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582131644;
	bh=v+9b/hr8Jv4VAOV0zdeJ4j1Oyz2AnGcLWoJAJWFKAVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jgSJo6FMCiotbin/duK/UI4nrZckmUiTk5oTKNHqvqe7bF1Q3+J22yN7e1qAfJuP9
	 Tw1aaVKGyznWcdknDTR2j4je/d/Cimy33It6DSelzRHjfnYuxBANg9gWP2mngJRHBH
	 w7SVoGYLOkGfH219Y4Ith2c/D68WTfLTnil7l3gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSRAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:00:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33357 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:00:43 -0500
Received: by mail-lj1-f194.google.com with SMTP id y6so1157801lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5MHK2yWJoKDFDgFN/xoudtHEVHOYHcak3UXICAOE48=;
        b=QIshA1U9KR9JH3ePvLT5ZY3Vx07hTFRKDbl+K9mKTvwZGUJgQmsNDzQNHyD8IIWR2d
         Q0yRg6+HxDrXEGdXe9VGj4GRg91S0SZg3nykCIODKvhX+L/Jppo0cyFJQEhwA9V8JwEk
         yE0AI/4FI83Suua0qMGWnvqbFXRE2hRE7jPY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5MHK2yWJoKDFDgFN/xoudtHEVHOYHcak3UXICAOE48=;
        b=Ic5DUxjPpQNVcyc5TWlI+99jdEeYDEzSNRnFbAqNf4+mzbZi1ATOEVoRUtV/HrmLVm
         JZWYQQkUtRzT/ZsjWL+fEA+XsyQFAzPhmjg5L8hQpqCFffOFT8/2/vK4W7eBq91/wrqk
         I0Te1wal0zjx5Ry1pmu/bzeq47ycdNQuaJq8KDFw1yBzcvTySxTq4mm0VtIJHgbfZ5cE
         XNlfS1Go4f8XvWwWy4jIqipOk4fLF55cdMclBeLKK4rstz+xizl9jMtRBs4P1T99mPRn
         3bJI3zqeVY1V8KtuuEiyqVkikAtAM6HSUJjS0Vq+BpuahQ0SCbT7chuqzAPGyP9VadcT
         6u4A==
X-Gm-Message-State: APjAAAUPhf/ST9h3txc+GZCzWunAWuK6o0L3TbKJBfGyR6Nbdyc1rhXD
        10KPQOBdCOpV427uYyMaJ3EhRUm4KOI=
X-Google-Smtp-Source: APXvYqzc3oQYR/7O5pCO+VWzs2JPkK2HMPX4ZEUuzlhzoH0c6dSlYh+tGffvaWRky4ZbDcHH5hd/xg==
X-Received: by 2002:a2e:9d0f:: with SMTP id t15mr16405522lji.171.1582131639920;
        Wed, 19 Feb 2020 09:00:39 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q10sm156329ljj.60.2020.02.19.09.00.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 09:00:39 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id y6so1157627lji.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:00:38 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr16681270ljk.201.1582131638422;
 Wed, 19 Feb 2020 09:00:38 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com> <227117.1582124888@warthog.procyon.org.uk>
In-Reply-To: <227117.1582124888@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 09:00:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
Message-ID: <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 7:08 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > The above nicely explains what the patch does.
> > However, unless I'm missing something, this fails to explain the "why"
> > (except for the vague "[...] is something that AFS needs ...".
>
> I'm not allowed to implement pioctl() for Linux, so I have to find some other
> 'structured' (to quote Linus) way to implement the extra functions for the
> in-kernel AFS client.

Honestly, the "create_mountpoint()" thing isn't any better. It's worse
and exposes an interface that makes no sense.

What are the insane pioctl semantics you want?

If you can't even open a file on the filesystem, you damn well
shouldn't be able to to "pioctl" on it.

And if you *can* open a file on the filesystem, why can't you just use
ioctl on it?

So no, the new system calls make no sense, and your explanation for
them is lacking too.

Give a very concrete example of what you want to do, and why AFS would
be so super-duper-magical, and why you can't just use ioctl on an
existing directory.

And no, "maybe the directories aren't readable" isn't an excuse, as
mentioned. Why the hell would you want to do pioctl on a non-readable
path in the first place?

                Linus
