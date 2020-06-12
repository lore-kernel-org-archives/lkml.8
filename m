Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8116C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17C4206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 22:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591999307;
	bh=dc++cKcn9hbikF614qbE0I/h20J2BhEZ50rTafvnWBI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QiPbvOhwmkbg2NQ29NJDceUbz8IGg9yPCBhc5Goc1KBhi41MPkcSZkzaH2Vxr5gWi
	 W9RiHL20nnFFrZ2g32hy8pajjs2Avd8D/XIdOMdQ0GjZQ6UKSxdWYnwlv5Uot9awfu
	 ix4I8SBnLkFbNq+lGFhXv6HcBcVFR1Xo2FT4HWGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgFLWBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbgFLWBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:01:32 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659FCC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so6303168lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWYJp5nNaxwsgKcZ1Z6bBPv+CeaisGshv5pM/NlGa8g=;
        b=iGB7pNOJkr6LRcHMfXc8Hc5bgDWNnC9dhToyz0MVwqn+5ZDrq4FXB5hkdU+1LIx/wY
         29BCG06xc7ngZQKzimY3IdOfI1AOPkYaI0qAzWHwrDzGuh5uZPT59r9N9W8aG0jjBok4
         wPUVKZCV++VNxKinJaOsg6Y3DzKn42vwmy34o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWYJp5nNaxwsgKcZ1Z6bBPv+CeaisGshv5pM/NlGa8g=;
        b=f4sLikjiGgDNlyhTFoHo/CSfIN7QnGybJZxuo1Vs4IJNh56cenqTxW92czvLBjUVwf
         mne4+k8whep9cZnvMoIyEdEryhCmPFyt1lVQhJDGZFzPYlheWn5hINjDG1iLFc1ii0Op
         //AeE4fNu34TpiEYNervuVm3kydvcCZwnObrog3n9RCDPZ3SlbHGL6GAfK7llIOKZbM7
         ONLyeaoKRjkcOM6mLhumPCqQ8Rc9SslSYNFRnxj4wk9RGmCtj4K2IUvqTLIG4DmUJDe6
         TQkXQ1DknsjC/31dJuDBWGS7RGlAYbHmVg8uYO4d2rQa1+MSB+nYREjpu4SAI+AM3mde
         Me3w==
X-Gm-Message-State: AOAM533V5Q0zwEJle07gfdls6/A9XFE+wIPDwiwFuxEP4XAzeNscoTwx
        LPP9omSnz3zOzWL8wPKEHmyWHRDP9E8=
X-Google-Smtp-Source: ABdhPJwflMJK5GfwIh+MJNxw5SqUgb3zIi6pslUWlrcMHplf/yZlRv71a4x1f/ErVkGxMkDWdoDJAg==
X-Received: by 2002:a05:6512:3190:: with SMTP id i16mr7831110lfe.158.1591999289612;
        Fri, 12 Jun 2020 15:01:29 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id u6sm2039195ljk.109.2020.06.12.15.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 15:01:27 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id d27so1716580lfq.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 15:01:27 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr7689820lfu.192.1591999286926;
 Fri, 12 Jun 2020 15:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 15:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
Message-ID: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
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

[ Actually going through the code now ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> All the next operations are done with "fd". It's nowhere used as a
> pipe, and nothing uses pipefd[1].

As an aside, that isn't necessarily true.

In some of the examples, pipefd[1] is used for configuration (sizing
and adding filters), although I think right now that's not really
enforced, and other examples seem to have pipefd[0] do that too.

DavidH: should that perhaps be a hard rule, so that you can pass a
pipefd[0] to readers, while knowing that they can't then change the
kinds of notifications they see.

In the "pipe: Add general notification queue support" commit message,
the code example uses pipefd[0] for IOC_WATCH_QUEUE_SET_SIZE, but then
in the commit message for "watch_queue: Add a key/keyring notification
facility" it uses pipefd[1].

And that latter example does make sense: using the write-side
pipefd[1] for configuration, while the read-side pipefd[0] is the side
that sees the results. That is also how it would work if you have a
user-mode pipe with the notification source controlling the writing
side - the reading side can obviously not add filters or change the
semantics of the watches.

So that allows a trusted side to add and create filters, while some
untrusted entity can then see the results.

This isn't going to hold up me merging the code, but it would be good
to clarify and make that something that gets enforced if we decide
it's worth it.

It does seem conceptually like a good idea, and potentially actually
useful to clearly separate the domain of "you can add watches and
filters" from "you can see the notifications".

               Linus
