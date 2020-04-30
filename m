Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5BFC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5796420731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588265692;
	bh=GRz0MjdAJYUSKX0qjB7uaN1+gBpFef7jlGLPAFPcUn0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wdRPAdpNXNYa0dYupRkJPReGU/YhB5Zd58On7cNCSX3vUoDjhpIvTb0ydpjVFYiCc
	 BpX7juOR6ywjdkBZ797U2w12of3LvCauGprB5ylp5Xq71pEqwTVHUEGHy5J2XXciZy
	 N+a36/z1Ox3rKaohAGNV9EMW4ftp6TqE0hilMdJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgD3Qyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD3Qyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:54:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22CDC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:54:50 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a21so40116ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jusIkjp3Dz4is1PZPLtprnCAT5bOhq5lF7YlVU3AWyQ=;
        b=K/L1x2WLoEDVhKcajWjRfk8di4UnhY9fQ857BctryF99FXnh8lvm/+FMFP7To9VzLC
         Oeh5Zl2gS6/3rwg+PAIfEpUDm0vFKxb3sBkuIMd/j+tdM33ErRljDKSRox35DyrhVqQy
         cxTvpJRHT1GSdzAq5WmfU86CiiQNmQ4AcXgOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jusIkjp3Dz4is1PZPLtprnCAT5bOhq5lF7YlVU3AWyQ=;
        b=JdjxCR9B3TWfZWtVRiU6rp8SIRyq1H5xV4mfYnA625wjVrgRIaN8kcY/fSrgl1HWuj
         R329ym6twrBiubGPlBRVbTKErROetNPHXWy3e02GJozlD/n+KGJc2UBpXlSrMIAWfuFH
         POY8z8IdcT3ZvaMXUm8kwhL+3vhqxo5bFv1+AsvaLZ7Z9x54cOYLfqYjv1g1mTgphEH0
         +OJYB4Riym7f68qJ3efvkc85jqohy6SkWzcHlrkbZEVOmCy/JxBdi5o/kh9/Wqo0xu51
         X5KpflxbbwVuTnVzXbcJPtQJNtFS566dwVMBLs35R+FLP0c1vy5w69zSmB2rG/Ps5Wue
         tZNg==
X-Gm-Message-State: AGi0PuaFsbQ13X2Pme4XhdZqHHrm5gLbPym3IovFmMLNAdekVVQrWlVw
        rCIeGGJzBsCZ73imnTmcl9WJHQkh6wI=
X-Google-Smtp-Source: APiQypImXeEbxtL7c3uuxIaXyJw9GW1Gz1zvC/A4TrCZhI3oJTRqVBrNKH5JRJeYLUsuQGs7Iiz5vg==
X-Received: by 2002:a05:651c:39b:: with SMTP id e27mr130566ljp.145.1588265687533;
        Thu, 30 Apr 2020 09:54:47 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id g3sm255111ljk.27.2020.04.30.09.54.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:54:46 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j14so1813586lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:54:45 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr2728777lfk.192.1588265685113;
 Thu, 30 Apr 2020 09:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429214954.44866-1-jannh@google.com> <20200429215620.GM1551@shell.armlinux.org.uk>
 <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com> <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
In-Reply-To: <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 09:54:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Message-ID: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem
 properly in there
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
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

On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
>
> > in load_flat_file() - which is also used to loading _libraries_. Where
> > it makes no sense at all.
>
> I haven't looked at the shared lib support in there for a long time,
> but I thought that "id" is only 0 for the actual final program.
> Libraries have a slot or id number associated with them.

Yes, that was my assumption, but looking at the code, it really isn't
obvious that that is the case at all.

'id' gets calculated from fields that very much look like they could
be zero (eg by taking the top bits from another random field).

> > Most of that file goes back to pre-git days. And most of the commits
> > since are not so much about binfmt_flat, as they are about cleanups or
> > changes elsewhere where binfmt_flat was just a victim.
>
> I'll have a look at this.

Thanks.

> Quick hack test shows moving setup_new_exec(bprm) to be just before
> install_exec_creds(bprm) works fine for the static binaries case.
> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
> dig into that to see why.

Just moving setup_new_exec() would at least allow us to then join the
two together, and just say "setup_new_exec() does the credential
installation too".

So to some degree, that's the important one.

But that flush_old_exec() does look odd in load_flat_file(). It's not
like anything but executing a binary should flush the old exec.
Certainly not loading a library, however odd that flat library code
is.

My _guess_ is that the reason for this is that "load_flat_file()" also
does a lot of verification of the file and does that whole "return
-ENOEXEC if the file format isn't right". So we don't want to flush
the old exec before that is done, but we obviously also don't want to
flush the old exec after we've actually loaded the new one into
memory..

So the location of flush_old_exec() makes that kind of sense, but it
would have made it better if that flat file support had a clear
separation of "check the file" from "load the file".

Oh well. As mentioned, the whole "at least put setup_new_exec() and
install_exec_creds() together" is the bigger thing.

But if it's true that nobody really uses the odd flat library support
any more and there are no testers, maybe we should consider ripping it
out...

                Linus
