Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A44FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04DD420658
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597163491;
	bh=1bGkqbxXRxs8nZtgA7u8/gl4kuWmpCxjJpvFGP6d9ZA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BdMP+O5408EZ4pSg2AGc2vAgJpa0pb8kqv26CTp9DSIGavWhRtm6dJrMjyvGUABmZ
	 rcOndbirRgoXPzAcifOB0cO52wYeh1qEuWRhne3rOETqPXfnocyMfEo9YD54dJiv7C
	 YWRTKPX7z5IaENKHIlLOqhBUvS+0fstCFnkm4e70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgHKQb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgHKQbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:31:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E160C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:07 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so14186340ljn.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=WPJKoAqHiSl/tMI6ux9ZyiwFZyLZeSf9IYnGPT6aXv5JxD0edUrsFyfwibupSRZPli
         sRgA0IHx4UhfQY9IUr+rb1b91G/QJ4IOfgHOH9XwY0IGnWNZoZAF+orZ9O7vZ9YyH60H
         QN4mw78jv4VsrakmBralo6Vc4sNZK78skPMUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N7traUqX1fM13wKjAbxkcSlNBWmdCV6QJf9i7XpWydE=;
        b=Rsq+o8ja6rrWBDZN/PnlNI0w+FofDbxtG/oArzKv7bZSfJ+wrrKyVH4YQk1dcPpM4e
         Hi4JEwoKJHxdb3U7i87+FiGWMihZ0Ct++xfzfoF/RRZRMo8fXRffh7lPAP4f1bY9M6rG
         ix01sTpNe94wl6lBFUC2a2t6JGSSO2S6TAP56oQJ28qNfFMZo9YS5xrfj0Hf+KaB2RbV
         LdNNn3ezGHslFSrtoffGe+3xJOw6lLSOgurZyM4FGv5+J81+A+EAh7kuacT+2zUDNpWR
         vmjXUdKB/2YSq0YKgEu77jLJog93qk2Pg79g/KQE0hN+Jn6vw8M6bopm7J2Ptl35lcrx
         UqWg==
X-Gm-Message-State: AOAM533Htvplbq0uS6Hs1CrmJyY+cpqqqe2mVj68C51k8tbQ3bv2Li3a
        4OaFhXu1sdMGL8R7d4AItgXVHBK3LFM=
X-Google-Smtp-Source: ABdhPJzOVvpZEEMQUmwTy389ocxDFXmhdG9Rj2qfygIadCy6NvcMUCT5qwOxay5Q+mn15TXuUrEJwA==
X-Received: by 2002:a2e:b619:: with SMTP id r25mr3697568ljn.220.1597163465442;
        Tue, 11 Aug 2020 09:31:05 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a30sm11702806lfo.1.2020.08.11.09.31.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 09:31:04 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 185so14210519ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:31:04 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr3282002lji.314.1597163463666;
 Tue, 11 Aug 2020 09:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
In-Reply-To: <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 09:30:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Message-ID: <CAHk-=whNwsV6PYrB=MB6y8AJ00GO70CGVUcgKxZHZybhcNp_6w@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 9:17 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> This doesn't work so well for setxattr(), which we want to be atomic.

Well, it's not like the old interfaces could go away. But yes, doing

        metadatafd = openat(fd, "metadataname", O_ALT | O_CREAT | O_EXCL)

to create a new xattr (and then write to it) would not act like
setxattr(). Even if you do it as one atomic write, a reader would see
that zero-sized xattr between the O_CREAT and the write.

Of course, we could just hide zero-sized xattrs from the legacy
interfaces and avoid things like that, but another option is to say
that only the legacy interfaces give that particular atomicity
guarantee.

> Since a////////b has known meaning, and lots of applications
> play loose with '/', its really dangerous to treat the string as
> special. We only get away with '.' and '..' because their behavior
> was defined before many of y'all were born.

Yeah, I really don't think it's a good idea to play with "//".

POSIX does allow special semantics for a pathname with "//" at the
*beginning*, but even that has been very questionable (and Linux has
never supported it).

                   Linus
