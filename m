Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63448206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TuQrlx9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgHRPJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgHRPI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:08:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D0CC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:08:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v4so21862477ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rETSh+8yuTihjWF+BUTSPFBgl5bA8M3eQDalGhxFfpw=;
        b=TuQrlx9ltdfzy2BXM/J2LYEePbtt5B3+P7MjccLQ3uQ6Uy33ZMoL59hwUM94EYTIOP
         ePiPIpJnm9DIZTn2Ko1ylH4l/Q933ORzG7SG9jp22hAoaFi/MjiX1rsLQiS8SriNW/JL
         mXe2msw/QgUbYSRWgfPXE3QkhDFArRTP+3SoLFc2PfnVLXKt/mWT7SD/hoWl5ngIHhiI
         va+68H73TKONrFj3zf3N5eUj8uAHeSnwWoNDgMnJCZ09sW1w+sctB4PPQc6iSPBLgeYf
         InlH9BhM1cZXcll8D7ixfZ/ShMjuzbSZX3SdtYNKtHCh/Fh0NqeniOdJEWiCqGTZFn3E
         /VeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rETSh+8yuTihjWF+BUTSPFBgl5bA8M3eQDalGhxFfpw=;
        b=WZDcED2u/bzTtzvt+lCHNMPFTm2dsbREvntg35NTu+967Gd3djIf31eRwv9TDfzLC1
         q0ZVr6u0yYdet53DAN0MEn6AYogRTPmiBMf0khT4H5Ssksy9M8RFVml0iehX/vIGirhg
         0fgVZNgJMnFB+J+hg+FPp+A6aMBfNJr0z03V6Uaz5XHY/52+dNLwyhLIDeMr1sp38ts3
         gw77Y4kkrjCE/7KVvj8M3EaCGOreGCdlN2/c55EMZc7fgY7LPzk52l1pyFjY1aOiptp3
         ww3+T1pUt2KDgBZklTRxZggn9sDvrGQelQggVyLsWRdb4B+FLPKDC+XaM3IhPqttwD5+
         l0pQ==
X-Gm-Message-State: AOAM533bwOUgwPVbmlY20VzceSisQkRdArhhOdzECPwk4+D6G1arAMFq
        n8wF9SC0zROG2SIVeMOslSHlxVVTWMzaKp3RN27lLsTA8UuTjA==
X-Google-Smtp-Source: ABdhPJzFP/jL9HqM7+C+ZGX+JQAYbGvU8bb1EZGwmWqFhRvtDxyHbFA1E3GAJH4c/IDsC/tHOeWlK4THJj08BWmGM1c=
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr9176669ljk.139.1597763336196;
 Tue, 18 Aug 2020 08:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200818061239.29091-1-jannh@google.com> <20200818061239.29091-3-jannh@google.com>
 <20200818134027.GF29865@redhat.com>
In-Reply-To: <20200818134027.GF29865@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 18 Aug 2020 17:08:30 +0200
Message-ID: <CAG48ez01ZTUzZ+mEqyiz+mUQXq4SPiZfZtP1GmpEY1T2wLtnJQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] coredump: Let dump_emit() bail out on short writes
To:     Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 3:40 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 08/18, Jann Horn wrote:
> >
> > +     if (dump_interrupted())
> > +             return 0;
> > +     n = __kernel_write(file, addr, nr, &pos);
> > +     if (n != nr)
> > +             return 0;
> > +     file->f_pos = pos;
>
> Just curious, can't we simply do
>
>         __kernel_write(file, addr, nr, &file->f_pos);
>
> and avoid "loff_t pos" ?

Hm... e.g. ksys_write() has the same pattern of copying the value into
a local variable and back, but I guess maybe there it's done so that
->f_pos can't change when vfs_write() returns a negative value, or
something like that? Or maybe to make the update look more atomic?
None of that is a concern for the core-dumping code, so I guess we
could change it... but then again, maybe we shouldn't diverge from how
it's done in fs/read_write.c (e.g. in ksys_write()) too much.
Coredumping is already a bit too special, no need to make it worse...

It looks like Al Viro introduced this as part of commit 2507a4fbd48a
("make dump_emit() use vfs_write() instead of banging at ->f_op->write
directly"). Before that commit, &file->f_pos was actually passed as a
parameter, just like you're proposing. I don't really want to try
reverting parts of Al's commits without understanding what exactly is
going on...
