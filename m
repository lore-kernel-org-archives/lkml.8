Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46ACF20716
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579977948;
	bh=A7WTXqLdUu+CmDmtHBI7lHSK6Jj/P5gnEhhaLf29Mcc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y5dUG36ye5ae+s3AqvlZbE4NRi/yZDwdfCu5IPoKsfLf8wNQrRPHigySG2wD51p5Y
	 r2yqGq893yvNny5oM2Ir5fbmhGGarGy9Z2P64mFkD41RK2FQo9umrxbOa3w0b9o6DN
	 WyYaG5qDo6gEwPU3lrtogIRT1suTHRaoal1Sd4t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgAYSpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 13:45:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40683 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgAYSpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 13:45:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18so6279686ljo.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 10:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=ebrkpC8lWGHzj/TTwQVlGmpfBj+LMhP3xc48s3IkdXLpfPBkmBQH8glAibN3NZzhJ7
         eaX+oPyIl6RK4Fcu/p33lei0jipvUcU+PHgqX1Ir4aJDuHlpLIX4SbceygCECD/xiFMl
         QwEsuOsJJnKRw8LKLW82q3yqXp++TF+4Q343k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agKBgndk3wOWKqvCTJf0yLyX2bJKGsFMAU50Ri7/n9U=;
        b=gjVVxc156CJZmaqKbkyVD/I5yNy+phhXY5hMxZaI5C0RQ130Up83oZmPufzKL1BSJn
         h5k5A8H4rK3X2YfmGDjkLOi63OiMu1GpdqzQapyTlaWLhSwxIgGASXcDkG4hbATgYhZW
         /MBMwYM6BTGj2dDhFwTCNMi7k0PxTIqECwC2hWCaXQ8XojfBdlFb9psy2AtGyzDIo9gj
         9cafVswsQIzNKsg9iH2mF+fnIXK5d6ivDhUY9z5EaemM0e7Ah4ZbxCdgZSk+vMAQ3rue
         Pwj2Sw5xjw2r2mUm+WTshudYfOOXhjt+H0yno6/mkq4Zpw3YEyeKBBWhxK/uJVBKJRDJ
         g5jQ==
X-Gm-Message-State: APjAAAW8YLIslZN9VAo+NdYrM4ILPwXFktjA3TUwdy+z+H/pIz3IUSh0
        f7EPS+eiKDX+zRpL9Kepf+sEWxNd4RI=
X-Google-Smtp-Source: APXvYqyIReUAAsIjv+VZqX0A8d9/iReBbfTUEnFwiHszDiP5Y424DXFUv8/qSa9OLTQaTpklSsntoQ==
X-Received: by 2002:a2e:7311:: with SMTP id o17mr5729144ljc.197.1579977942957;
        Sat, 25 Jan 2020 10:45:42 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id s9sm6312144ljh.90.2020.01.25.10.45.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 10:45:42 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id h23so6266918ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 10:45:41 -0800 (PST)
X-Received: by 2002:a05:651c:ce:: with SMTP id 14mr2080983ljr.241.1579977941361;
 Sat, 25 Jan 2020 10:45:41 -0800 (PST)
MIME-Version: 1.0
References: <20200125130541.450409-1-gladkov.alexey@gmail.com> <20200125130541.450409-8-gladkov.alexey@gmail.com>
In-Reply-To: <20200125130541.450409-8-gladkov.alexey@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jan 2020 10:45:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Message-ID: <CAHk-=wiGNSQCA8TYa1Akp0_GRpe=ELKDPkDX5nzM5R=oDy1U+Q@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] proc: flush task dcache entries from all procfs instances
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
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
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 5:06 AM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>
> This allows to flush dcache entries of a task on multiple procfs mounts
> per pid namespace.

From a quick read-through, this is the only one I really react negatively to.

The locking looks odd. It only seems to protect the new proc_mounts
list, but then it's a whole big rwsem, and it's taken over all of
proc_flush_task_mnt(), and the locking is exported to all over as a
result of that - including the dummy functions for "there is no proc"
case.

And proc_flush_task_mnt() itself should need no locking over any of
it, so it's all just for the silly looping over the list.

So

 (a) this looks fishy and feels wrong - I get a very strong feeling
that the locking is wrong to begin with, and could/should have been
done differently

 (b) all the locking should have been internal to /proc, and those
wrappers shouldn't exist in a common header file (and certainly not
for the non-proc case).

Yes, (a) is just a feeling, and I don't have any great suggestions.
Maybe make it an RCU list and use a spinlock for updating it?

But (b) is pretty much a non-starter in this form. Those wrappers
shouldn't be in a globally exported core header file. No way.

               Linus
