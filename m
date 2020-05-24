Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6443C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A2A20787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590339951;
	bh=J53P8zzsT1oVBQ51buzREFwPZHAGUcyIpF9ZyZ300Oc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=licY9YFmerFDLYbGCwG/JqmyEsM7zLtFyxnU2JseHvbUNPw9N0Gvnc8lh8JahGxK5
	 6n47P33wXxu2XuaBlITNn/7639lpdAZr3UQmESP94oxmNmpFF+fYYe46nudnTiyll+
	 5pXhvzK0ymNV3h6RLQRX1UWZ43bpx0ZcL3G6ITGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgEXRFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgEXRFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:05:50 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F1C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:05:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so18283337lji.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TwCyGvyCQqQdbGDVRyocSJojCZ1jttQnby01wFW1pL4=;
        b=CPULp+5lRooG8mexU0N4QIYyjQQu2PgM2L8b7+cJIXAn73WOYQ/EsZgiGPiz4S3lEn
         xJk9uv/9Yyi6dHhI3X/FVZ3wqucLvfGiBewG/h0qpAuOm3VQXkxEj0Ubk9sTd06oKpif
         M7j9fLulA4Gu9RdB3ol/vCGS68HniXNFpkaec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TwCyGvyCQqQdbGDVRyocSJojCZ1jttQnby01wFW1pL4=;
        b=VAeCxhcHhyEcW6A5eOiKSsnEDeH8EMw7GsofVhEqazT83GnOvukLD0fzIiU2FUvzPV
         MldOQI7ZN+vnAyMViZOgSKRXCp+Jb9mJx6/9p/pHlATTYB92kJ86fti3nAzSoIW4Rm7D
         QwlE20NifKnvPMh5n4K7IDgIJpK2g/39hbBLSQasbCGQm5SnjWqGM2Z4uhe5qXFb87kv
         S64o2MMSLV5RHP3wOp6YFE5Ao1JkbzwcMCG7ZYOjO28ccdKitoJCoPKU3aH/KauiPaLe
         fBHK8RQNHS4hakT+cklC6mapGloXEDekp8MwTmcJEaxkYTLp5r5ZcHYcvjYGOGGw1COp
         riSA==
X-Gm-Message-State: AOAM531sgPLFc/0y2BYXdguA/+nReEYEYRVOeFjOXVW0u9MDnHJdy/Wp
        HV22ox3u9qBZOt5eU43s7r+bzF/NtgM=
X-Google-Smtp-Source: ABdhPJzhKT26LIwycmJJz8E/RVbCERz8U9auD3swBpuAnBaKhhL2CLe+nVzCXVHTp3KTI9BnOoEv7w==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr12943228ljk.16.1590339946804;
        Sun, 24 May 2020 10:05:46 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y24sm4343117ljh.18.2020.05.24.10.05.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 10:05:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l15so17976815lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 10:05:45 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr11699290ljd.102.1590339945019;
 Sun, 24 May 2020 10:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200523131759.GA55886@kroah.com> <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com> <20200524150018.GB11262@kroah.com>
In-Reply-To: <20200524150018.GB11262@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 May 2020 10:05:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
Message-ID: <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 8:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 23, 2020 at 11:14:28AM -0700, Linus Torvalds wrote:
> >
> > Hmm. That original patch looks obviously buggy: in kobject_cleanup()
> > it would end up doing "kobject_put(parent)" regardless of whether it
> > had actually done __kobject_del() or not.
> >
> > That _could_ have been intentional, but considering the commit
> > message, it clearly wasn't in this case.  It might be worth re-trying
> > to the commit, just with that fixed.
>
> Turns out that wasn't the real problem here, the culprit is the
> lib/test_printf.c code trying to tear down a kobject tree from the
> parent down to the children (i.e. in the backwards order).

Note that the "obviously buggy or at least not documented" behavior of
that commit 4ef12f719802 ("kobject: Make sure the parent does not get
released before its children") that got reverted is true regardless.

Should the parent be released unconditionally (like that commit does),
or should it be released only when kobject_del() was called when it
had "state_in_sysfs" set?

Even if the problem Guenter reported was due to something else, that
other change is a rather fundamental change and should at least be
mentioned by the commit log.

It's entirely possible that the parent dropping should always be done,
but the way it was done in that reverted commit it looked kind of
accidental.

> What is really odd now, is that 'git log lib/kobject.c' does not show
> the change/revert at all.  Is that because there was a revert?  Or is it
> a git config option/default somewhere that prevents that from showing
> up?

No, it's fundamentally how git works.

Remember: git does _not_ track "changes".

Any SCM that tracks changes to a file is fundamentally broken, for
fundamental reasons. It mostly boils down to "what happens when the
source of the change the same file in two branches is different".
Think "rename to X" and "create X", and remember all the problems SVN
has when that happens.

So no, git never _ever_ tracks "what changed". Instead, git
fundamentally tracks "what is the state". The "change" is not
fundamental, it's something that gets computed afterwards when you
have a "before and after" state.

Why does that matter?

In the current git tree, when you start looking at the history of
lib/kobject.c, it looks at my merge of your tree, and goes "the
contents of that file were the same before and after the merge, so the
side history from you is clearly irrelevant".

And git is clearly right: your branch made changes to the file, but
then reverted them all, so clearly that branch doesn't matter. Git
will by default only show the simplified history - the part that
matters.

If you want it all, use "git log --full-history", but then you will
_really_ get the full history and a lot of pointless noise. And even
then, things like "blame" won't waste time on following merges that
made no difference in the end.

(This, btw, is also true if your branch _did_ make real changes, but
the merge itself ended up throwing them away - either because somebody
undid them in the merge, or because the main development line had
those same changes already, so that the branch that got merged didn't
actually matter. Again, this comes from the fact that git tracks the
history of the full _state_ of the tree, not "these are the changes
done here").

Sasha mentioned "--follow", which also happens to show that commit,
but that's more of an incidental happenstance than anything else. "git
log --follow" is kind of a special case, where git stops doing some of
the pathname-based simplifying, because if the file shows up from
nothing, git will try to then figure out where it came from. The fact
that "--follow" this ends up not pruning irrelevant history as
aggressively is more of an implementation artifact than anything else.

So generally, don't use "--follow". It's kind of a hack to emulate
"track changes to a file", but it is a hack, and it fundamentally is a
bogus operation (for all the same reasons that the CVS/SCCS/SVN/etc
notion of a "file identity" is complete garbage and leads to
fundamental problems).

So "--follow" also can't handle multiple paths (or directories), and
is generally just a "placate people who don't understand why SVN is
wrong" option. It can be very useful in practice for the simple cases,
but it can also end up missing real changes in other situations.

              Linus
