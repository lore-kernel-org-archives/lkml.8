Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2C5C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF8920661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 00:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578614917;
	bh=RQWAn3WJN30LGW4AmEpiGnkoepag6KNpHGBu/yFRtP0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2gWJbYrsuwFdq7cA76RON936zRH0f9HbwM77s36KHRZgtpSH17SEh9HHCGIGrm/2p
	 y9sBNyTmensqpi++Qmg0PDYA8X/kvOERznck827/mQvnGeJzGfyt7GYbvSzqXuXrJL
	 uhW5ZoN9ujySBL+Uw13j4GpvlVp41ph1iNPnP4F4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgAJAIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 19:08:35 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40192 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbgAJAIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 19:08:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id i23so107919lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 16:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjrwlNrUWv0QXAIqsTPozbObZ8/7GgridjmNme8W52I=;
        b=ZtRoq1DRX7RXsXHhNmpxW4UB5JzoQNOKVTmOa01bx5ggT/DHqnRKaMysJGfaxE1BO8
         89pqzHmvERx+seKq1dYzZ8We/mt3eqN1+GxPl8i6s9a40Llm5xj1AoQQ53D6zO8ixCG8
         zDKJYDEBm9yUsTkdwHLUa14RvnsxxJ0XX8xZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjrwlNrUWv0QXAIqsTPozbObZ8/7GgridjmNme8W52I=;
        b=Ipy1gjXFoQo8X2V+cDTJHqfXmb0Z955GIvaDKom2CVGTCxRMZ+6+5drRRO2wxdC9OF
         iB8NzgRZy+ZUK6dXB1hg35V9XMXhZbFgQB/xVjXOYK8A5Ui2S6H2iG6hSPeDgwaIWUGs
         U0+pUavWqm9qMVnahL0pxwFqrHP8y5BSDezQ62ejnisR3jVxMX20CrEox77W1jUJAsLt
         vvAlu8KhQCVbJ90ysEsEM3VsPWtyKFuglrP3Ntdhzjv5CYvpa5toSolzaGnZBiXVaYBQ
         xyAvN4CbVW0afQdSLWw2gb/Oow6Vd2/ZvTZi+AfCFqGTrVyz/jWpvSmgg8WZou9mRH3R
         4RnQ==
X-Gm-Message-State: APjAAAWjGjB975w1dvC+q7pyUjRCOi5bI34oneviIaPr/LaHKqNcL8+H
        PxeW0wB7/LRacmmP50660gIXzXphcuY=
X-Google-Smtp-Source: APXvYqwUtoh90+vOapjRjjH3G1febpTJncU6xmgc+pfCEW8kYWYAbxJV4UrkrLF34MCYaqYh2KcZZQ==
X-Received: by 2002:ac2:4909:: with SMTP id n9mr252212lfi.21.1578614913528;
        Thu, 09 Jan 2020 16:08:33 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id i5sm88712ljj.29.2020.01.09.16.08.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2020 16:08:33 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id w1so228135ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 16:08:32 -0800 (PST)
X-Received: by 2002:a05:651c:239:: with SMTP id z25mr455607ljn.48.1578614912546;
 Thu, 09 Jan 2020 16:08:32 -0800 (PST)
MIME-Version: 1.0
References: <20191230072959.62kcojxpthhdwmfa@yavin.dot.cyphar.com>
 <20200101004324.GA11269@ZenIV.linux.org.uk> <20200101005446.GH4203@ZenIV.linux.org.uk>
 <20200101030815.GA17593@ZenIV.linux.org.uk> <20200101144407.ugjwzk7zxrucaa6a@yavin.dot.cyphar.com>
 <20200101234009.GB8904@ZenIV.linux.org.uk> <20200102035920.dsycgxnb6ba2jhz2@yavin.dot.cyphar.com>
 <20200103014901.GC8904@ZenIV.linux.org.uk> <20200108031314.GE8904@ZenIV.linux.org.uk>
 <CAHk-=wgQ3yOBuK8mxpnntD8cfX-+10ba81f86BYg8MhvwpvOMg@mail.gmail.com> <20200108213444.GF8904@ZenIV.linux.org.uk>
In-Reply-To: <20200108213444.GF8904@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jan 2020 16:08:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
Message-ID: <CAHk-=wiq11+thoe60qhsSHk_nbRF2TRL1Wnf6eHcYObjhJmsww@mail.gmail.com>
Subject: Re: [PATCH RFC 0/1] mount: universally disallow mounting over symlinks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        stable <stable@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>, dev@opencontainers.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 1:34 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The point is, we'd never followed mounts on /proc/self/cwd et.al.
> I hadn't checked 2.0, but 2.1.100 ('97, before any changes from me)
> is that way.

Hmm. If that's the case, maybe they should be marked implicitly as
O_PATH when opened?

> Actually, scratch that - 2.0 behaves the same way
> (mountpoint crossing is done in iget() there; is that Minix influence
> or straight from the Lions' book?)

I don't think I ever had access to Lions' - I've _seen_ a printout of
it later, and obviously maybe others did,

More likely it's from Maurice Bach: the Design of the Unix Operating
System. I'm pretty sure that's where a lot of the FS layer stuff came
from.  Certainly the bad old buffer head interfaces, and quite likely
the iget() stuff too.

> 0.10: forward traversal in iget(), back traversal in fs/namei.c:find_entry()

Whee, you _really_ went back in time.

So I did too.

And looking at that code in iget(), I doubt it came from anywhere.
Christ. It's just looping over a fixed-size array, both when finding
the inode, and finding the superblock.

Cute, but unbelievably stupid. It was a more innocent time.

In other words, I think you can chalk it up to just me, because
blaming anybody else for that garbage would be very very unfair indeed
;)

> How would your proposal deal with access("/proc/self/fd/42/foo", MAY_READ)
> vs. faccessat(42, "foo", MAY_READ)?

I think that in a perfect world, the O_PATH'ness of '42' would be the
deciding factor. Wouldn't those be the best and most consistent
semantics?

And then 'cwd'/'root' always have the O_PATH behavior.

> The latter would trigger automount,
> the former would not...  Or would you extend that to "traverse mounts
> upon following procfs links, if the file in question had been opened with
> O_PATH"?

Exactly.

But you know what? I do not believe this is all that important, and I
doubt it will matter to anybody.

So what matters most is what makes the most sense to the VFS layer,
and what makes the most sense to _you_.

Because my reaction from this thread is that not only have you thought
about this issue and followed the history a whole lot more than I
would ever have done, it's also that I trust you to DTRT.

I think it would be good to have some self-consistency, but at the
same time clearly we already don't really, and our behavior here has
subtly changed over the years (and not so subtly - if you go back
sufficiently far, /proc behavior wrt file descriptors has had both
"dup()" behavior and "make a new file descriptor with the same inode"
behavior, afaik).

               Linus
