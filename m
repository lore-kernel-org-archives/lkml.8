Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAA020663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591997584;
	bh=6387mbErGnl14/gnz/EmmMKCe9zFoAKqrSDTMiGO2qw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pU3ybMMxJA9Q3TsYuu8VEzL6CO0DOO0TS9wR5JgQUObVy9oruBWrWyNSB6kUXhun+
	 LCgUDRWAOeSWud5K3oRyl8d77rkae/dHlbGAOqrIQ7zpr3Z+hj2ih4La5J+latiPeK
	 kny9nFS2Mm93FPkEvKVhCmwkWtEmzZ3GddqQv4JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFLVdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLVdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:33:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3846AC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:33:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id x18so12675090lji.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pL7avKA2KDNOM9X/kgFl9MqbEPb7aiLKYA3rHavzFAQ=;
        b=DUXfZ05dc4FLn033pP/DvBQEoDqo9l9I/qr+GeWTXdccy9NPuiJFBm8tJ6Ag/uVtPs
         HfhkXSv/7Jz63j3e9CKigwf5GeXP332/vjJYhT7vhVEnuBNN/DA1L+yF7svDbU0axGyW
         OJ7DBcOv91xpWm6tDakYfFrQRMOPXMXKekM4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pL7avKA2KDNOM9X/kgFl9MqbEPb7aiLKYA3rHavzFAQ=;
        b=MCmhtCGMPRCCzyBbNk75jyeRjgQnXBt5ww/DmoMLd4ZXjCC44xwwHQ1N6Ma+u2XCJz
         mD8w9AKAB+yFX0qzsRj11SkBIoyNf8BXv3Xr4xn6dqbCAVUGFN5H7oAXijzk8aOy0VGt
         163Lbskvk671DNW6kRR1DlD+WA9QRm6B75woevf9YDgjN7orqnZwS4HenBtVXlnVHkb0
         CPWcEPMq05Y3NR1gjAy56nPHhgY80BgSn7x6OgCFOq++LuI1IsxWEw53Je8i44fonDVi
         uyZsuzsPFIyVKAOjYhCd3xKkCrMDu82PCDG0BkTg41PfNwaPwWoCTFUOkjYaO0Y0w2R2
         goIg==
X-Gm-Message-State: AOAM531ZD4qcjgbQwBWq8Sxy8ScBI2xOl42CZLfAkI5Ou4SAcgzf9aCc
        5W83lNd90/nVeD4EQjEI8KvfSjA5onc=
X-Google-Smtp-Source: ABdhPJxwBnYei72qmllEIfwOclMELi/M1OwZWfb0venFl0tHxYNqfuxfXSFG1w5Hj9uu1lleO4AMCg==
X-Received: by 2002:a2e:9a09:: with SMTP id o9mr7558908lji.323.1591997579735;
        Fri, 12 Jun 2020 14:32:59 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o16sm2495412ljg.90.2020.06.12.14.32.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:32:59 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id e4so12723175ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:32:59 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr7467995ljj.102.1591997578744;
 Fri, 12 Jun 2020 14:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 14:32:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
Message-ID: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     Karel Zak <kzak@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Finally getting around to this since my normal pull queue is now empty ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> The notification stuff looks pretty promising, but I do not understand
> why we need to use pipe for this purpose

The original intent was never to use the "pipe()" system call itself,
only use pipes as the actual transport mechanism (because I do not for
a second believe in the crazy "use sockets" model that a lot of other
people seem to blindly believe in).

But using "pipe()" also allows for non-kernel notification queues (ie
where the events come from a user space process). Then you'd not use
O_NOTIFICATION_PIPE, but O_DIRECT (for a packetized pipe).

> Is it because we need to create a new file descriptor from nothing?
> Why O_NOTIFICATION_PIPE is better than introduce a new syscall
> notifyfd()?

We could eventually introduce a new system call.

But I most definitely did *NOT* want to see anything like that for any
first gen stuff.  Especially since it wasn't clear who was going to
use it, and whether early trials would literally be done with that
user-space emulation model of using a perfectly regular pipe (just
with packetization).

I'm not even convinced O_NOTIFICATION_PIPE is necessary, but at worst
it will be a useful marker. I think the only real reason for it was to
avoid any clashes with splice(), which has more complex use of the
pipe buffers.

I'm so far just reading this thread and the arguments for users, and I
haven't yet looked at all the actual details in the pull request - but
last time I had objections to things it wasn't the code, it was the
lack of any use.

             Linus
