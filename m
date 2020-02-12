Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A1C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080472467D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581537023;
	bh=5BhYJKA3gORqzCNRHwgf0DsrwzjD8c/aFfBMdkZL8IE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bFfmZdgZj1+gej40erGH9gZCik5t028VTTNA3f6q2JhH/31a+js2RdWwV6NHdtGUI
	 kx8QCc4chyAFfYU34/N/liLq8OGN2eMvjiha3rQR8TFcfEgc8SkJy+gWvX2jf7LF3W
	 4ezSMtx0kOD67Op++FtZFngZYwjrwtcMwn1y5DwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgBLTuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:50:22 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46878 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbgBLTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:50:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id x14so3721946ljd.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=F1RTR2Mk3atysxi94JEv4Vc5seMqqx02k5CmzRHPSL9IrjapbyqOHw2Fl4dXiCvUEV
         ncTWbgP69pZD/8vVK6OQciM9WRN9WfMjKk6TsKRj9cuZUdWmWVaikWPX14ZlXYji3kdw
         CWzsabp8eT8r94ZjWLxWvcikM9+qEZil4HvcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CHXH6o1ncLcAF0HeWBgC/IvihmP9toR2+/NwDUguxaw=;
        b=bG/rYnd8LkmTFoYBRun486aMp+qLgHy8vlZcJZE76g3MABWKGN4lHHPZeUjfk4kGrC
         OIkSwJu6Q3U3NYkd3Ur1lUMTdbhU9RYbvkA2NzeiRZf+mQt3G/YFhKO1+jFKR37s3LVz
         RkSloFCJ27YhxU3iwYs4U6s7WXhjmenanUw2vr5xkvMfViQzdFi4u9Q2+QDLik1OZz/M
         b2+Mm4UO1BRNW7QYq6ZDJA9Y1z9kE+CBk5/tpDvKLX/dDITu4tnR5sqBcSK/qQax7g1e
         yJl4g8XuqMku0r/zMRljA0CgzY79vjlijiOIQSOq//YEg9CMb3aAE2xLSJ1aiBUVBCr3
         lMHA==
X-Gm-Message-State: APjAAAVVZUpSU6D97vFLCu95Xwmhd/BU0/tlIkWQCixRI0phZnAidgsQ
        3f96XV5pKWvL5i2br7RAyHDF56rxoY8=
X-Google-Smtp-Source: APXvYqyWsKYUd1jbLMQIyg1PeqXvXSdkomDHR5vrj5B+neKgwherChs0rlwBpkbeRWKPGuEsOXxj+Q==
X-Received: by 2002:a2e:8944:: with SMTP id b4mr8826107ljk.90.1581537016606;
        Wed, 12 Feb 2020 11:50:16 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id w8sm75040ljj.75.2020.02.12.11.50.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:50:15 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id f24so2488863lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:50:15 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr7333707lfm.152.1581537014849;
 Wed, 12 Feb 2020 11:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20200210150519.538333-1-gladkov.alexey@gmail.com>
 <20200210150519.538333-8-gladkov.alexey@gmail.com> <87v9odlxbr.fsf@x220.int.ebiederm.org>
 <20200212144921.sykucj4mekcziicz@comp-core-i7-2640m-0182e6>
 <87tv3vkg1a.fsf@x220.int.ebiederm.org> <CAHk-=wg52stFtUxMOxs3afkwDWmWn1JXC7RJ7dPsTrJbnxpZVg@mail.gmail.com>
 <87v9obipk9.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9obipk9.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Feb 2020 11:49:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Message-ID: <CAHk-=wgwmu4jpmOqW0+Lz0dcem1Fub=ThLHvmLobf_WqCq7bwg@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:18 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> > So it's just fs_info that needs to be rcu-delayed because it contains
> > that list. Or is there something else?
>
> The fundamental dcache thing we are playing with is:
>
>         dentry = d_hash_and_lookup(proc_root, &name);
>         if (dentry) {
>                 d_invalidate(dentry);
>                 dput(dentry);
>         }

Ahh. And we can't do that part under the RCU read lock. So it's not
the freeing, it's the list traversal itself.

Fair enough.

Hmm.

I wonder if we could split up d_invalidate(). It already ends up being
two phases: first the unhashing under the d_lock, and then the
recursive shrinking of parents and children.

The recursive shrinking of the parent isn't actually interesting for
the proc shrinking case: we just looked up one child, after all. So we
only care about the d_walk of the children.

So if we only did the first part under the RCU lock, and just
collected the dentries (can we perhaps then re-use the hash list to
collect them to another list?) and then did the child d_walk
afterwards?

             Linus
