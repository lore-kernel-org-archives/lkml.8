Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B1C206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580407396;
	bh=gDlc/sV4PffLDeEmAvCzJC5wSRJ+4ORO9/mXlIwT7dU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bL0aDu3+zZZbDtgp1bPSnfoBa+be2Ci/62F696pGjWOU9oDvfEPkwCryVdOpgtz1v
	 lG5qXc+oJjN5aboI4+wQUtFb8buPRAxpof1ED6vtyYwmThJbsxs5ASP9G92oNHf7/o
	 +gssBB5VU1n3mau8jHHL0yk+CHt8CT7ikO5vzdNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgA3SDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:03:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgA3SDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:03:15 -0500
Received: by mail-lj1-f196.google.com with SMTP id o11so4356865ljc.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9X8HUg12idUhOalYmqmMIhcIcQDy0wCmRGthHqv0oo=;
        b=fkFG0bT/IO/IJgFOieHFkw9uIuvGWcTtTiE+EBLzArGcj5YA8ITAbWwgiw5qGm9tBC
         NEYngFRhruJFMCaefC36aQcAu/e0Z2bPIzGfr0CgtMvLmOk8+Zmpfem7t6N9UscZXUFf
         1MyvVI8YNI1tNeNs8P3c3/OIt2PrT5CH8l5H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9X8HUg12idUhOalYmqmMIhcIcQDy0wCmRGthHqv0oo=;
        b=Uec3pBskZjRKevKRNgPY9aYUQD2pNTFlmgVIlzRYRIUP39DTCALKGM5UqCnKtRVKfh
         7ReKujrtSCDhS0uzgo0SQJKxR7RgMV1dUXhivc9xWdq+TMpI8cE94v4tbqTvMesoQ++h
         HZXP1yb4JXBPELMlpey7F/snbS/MoZOOO/HEw7C80ZvaJ20VCzODjYIVv4X0siiUrhVD
         eKSSspTy4Lg2B5u8jXx/mp5vAfbrarbtC7yTGUxwKU6/4iwE0yS0Ls9O5algQZ/8yXk2
         Ouwz4urgHTYbESTzhENuXEZbd5ozqVjLcx4PTzPdLiqeiCFyPsPyy4ctNGXmT3u/8zO7
         GB0Q==
X-Gm-Message-State: APjAAAWm3zmyVqv47NMAOEJO8JmC5lr8Bmq1wC4T3itrN/UYNIkUXIEx
        uGYOhx6zNnpmPn2isgyEn+wIhGQWrbY=
X-Google-Smtp-Source: APXvYqwyGdlAFcCJCjrlwXY1ZTwrtMlj2gniZz8M2bSwTIunP9/rAFUf3y+l7BSpp67CPYBcR972+Q==
X-Received: by 2002:a2e:9a01:: with SMTP id o1mr3665547lji.247.1580407392298;
        Thu, 30 Jan 2020 10:03:12 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id a12sm3340661ljk.48.2020.01.30.10.03.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:03:11 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id w1so4371428ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:03:11 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr3650122ljb.150.1580407390980;
 Thu, 30 Jan 2020 10:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic> <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic> <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
 <20200130085134.GB6684@zn.tnic> <CAHk-=wje_k92K6j0-=HH4F5Jmr8Fv7vB-ANObqbQeGS_RsikWA@mail.gmail.com>
 <20200130173910.GK6684@zn.tnic>
In-Reply-To: <20200130173910.GK6684@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jan 2020 10:02:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9xdJzfcPU4e4diAZDtUJVg+SSocoYP+aVYWnDZd-UMQ@mail.gmail.com>
Message-ID: <CAHk-=wh9xdJzfcPU4e4diAZDtUJVg+SSocoYP+aVYWnDZd-UMQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 9:39 AM Borislav Petkov <bp@suse.de> wrote:
>
> Yeah, makes sense. It would help if one slaps a relative JMP as *not*
> the first insn in an alternatives replacement and the build to warn that
> it can't work.

Maybe with the exception that a short conditional jump inside the
alternative code itself is fine.

Because a branch-over inside the alternative sequence (or a loop -
think inline cmpxchg loop or whatever) would be fine, since it's
unaffected by code placement.

              Linus
