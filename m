Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CFC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1853B206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588201863;
	bh=EbrJxVvjSGFr7dymhaWpVGrrJN6sLo0D4cT74xq2ljs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R/CwX9DxcRM6PQ9PWaykNln049RcMNQT/Y4onTU/VvE7++rNfjDP4/h627r0f8srA
	 2tu+ogRAKd6Yuq4+R1YpFbeowuKuopyj+6YBfQSDb6eQIg0r0uKcT12ntexSwXZ9jP
	 Ru8j1BV8O7dUQ7xT+lyZxyCvWVw5Phl1mQsbeAFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgD2XLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgD2XLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:11:02 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BF1C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:11:00 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so2970042edv.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ur9jfHYBxvOMHwCSyzgCuO4pNPy1puU85FIa2ankgiI=;
        b=DrKHR3jwpIzSm+/wrDYjisbgySATaGLQu0oa0TojG2F2InX9rTKCVNl6/HZqurU3pj
         UJIyVXdxk5hO/DdTXuKDLWUrdoodxV3U8YTqMXkuAyOg5qLHqAdR8oZRRYrFIzlXyC4k
         sCR1zfwZ36sLzjhZCni2LVoS/XzTKFMv0dEak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ur9jfHYBxvOMHwCSyzgCuO4pNPy1puU85FIa2ankgiI=;
        b=H+uthNe2iN4czy89ejofO4bRkmGd3Qkrdrs3a5GAM/ioV8W9Ywbj0JCdm+VY5oWFYr
         hvJba3OWtmRcM/82UUwUe0I0ExUVRnhKugN3jGjbaxpRloo9CgXcET+kvAXi9NsSLVj0
         V1d2D2DeXiIXiRNTbjgFOzpMx48SWfn6QpFUkYJIHOCG+JT/nuc9rOCZU5QSrbZaxsd5
         MbffQvV8I9GvJu5hlFMmSsW+fuFljkaSu1R87BoPv+DQxMaRYONfV/vBN301MBZd4Ex7
         K/mWQmwPCegf5AFmgMAvOmomZvQBIZ4KbQYLZhoiZL+iRHt/eD/0aeZ9BncPBJnEyBsZ
         RK/Q==
X-Gm-Message-State: AGi0PuZL8JH3ijixmc1eQ0KH+eLTbu/uKl3sgeMSRHvOad6lyqz4KjWd
        9ikDuT7DtGkCIE8O/c7xcGQPmbE1dLI=
X-Google-Smtp-Source: APiQypKF7x/QeJ5pd2AUTuF6DCXek8I3raFtnR7ION2hIcQLiasjpLCcRnIcYzcjjhFnlNyzkl/9nQ==
X-Received: by 2002:a05:6402:204b:: with SMTP id bc11mr309661edb.114.1588201858580;
        Wed, 29 Apr 2020 16:10:58 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id z26sm920236ejb.36.2020.04.29.16.10.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 16:10:58 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id k13so4575385wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:10:58 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr119932lfk.30.1588201425482;
 Wed, 29 Apr 2020 16:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429215620.GM1551@shell.armlinux.org.uk>
In-Reply-To: <20200429215620.GM1551@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 16:03:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
Message-ID: <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:57 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> I've never had any reason to use FDPIC, and I don't have any binaries
> that would use it.  Nicolas Pitre added ARM support, so I guess he
> would be the one to talk to about it.  (Added Nicolas.)

While we're at it, is there anybody who knows binfmt_flat?

It might be Nicolas too.

binfmt_flat doesn't do core-dumping, but it has some other oddities.
In particular, I'd like to bring sanity to the installation of the new
creds, and all the _normal_ binfmt cases do it largely close together
with setup_new_exec().

binfmt_flat is doing odd things. It's doing this:

        /* Flush all traces of the currently running executable */
        if (id == 0) {
                ret = flush_old_exec(bprm);
                if (ret)
                        goto err;

                /* OK, This is the point of no return */
                set_personality(PER_LINUX_32BIT);
                setup_new_exec(bprm);
        }

in load_flat_file() - which is also used to loading _libraries_. Where
it makes no sense at all.

It does the

        install_exec_creds(bprm);

in load_flat_binary() (which makes more sense: that is only for actual
binary loading, no library case).

I would _like_ for every binfmt loader to do

        /* Flush all traces of the currently running executable */
        retval = flush_old_exec(bprm);
        if (retval)
                return retval;

   .. possibly set up personalities here ..

        setup_new_exec(bprm);
        install_exec_creds(bprm);

all together, and at least merge 'setup_new_exec()' with 'install_exec_creds()'.

And I think all the binfmt handlers would be ok with that, but the
flat one in particular is really oddly set up.

*Particularly* with that flush_old_exec/setup_new_exec() being done by
the same routine that is also loading libraries (and called from
'calc_reloc()' from binary loading too).

Adding Greg Ungerer for m68knommu. Can somebody sort out why that
flush_old_exec/setup_new_exec() isn't in load_flat_binary() like
install_exec_creds() is?

Most of that file goes back to pre-git days. And most of the commits
since are not so much about binfmt_flat, as they are about cleanups or
changes elsewhere where binfmt_flat was just a victim.

               Linus
