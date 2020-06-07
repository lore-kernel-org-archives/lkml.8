Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2077CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F317720659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 16:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591547862;
	bh=GMZS6Ep+zIM0ZGj3QPwKLwGCuAJNsMWCwnCGrZ+QF9g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r3PX0oKHG0TWacD4YFul1AGNLlp3A44eznESUQ6QdJ/gAtzoMwQgAfFh+sczQsYIC
	 wNU0AUhJfwM+B02v5It4X/L3vx3VTVUqCr+8weF14PsJaLgMlHfySQqQpmhsxvqnh3
	 e6DTI9jiwz0FYwg1Rl+FwrM1yQq+nv169Hbk9DRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgFGQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 12:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgFGQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:37:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE34C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:37:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so17530944ljo.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXd1D478P4SNq4RE8o4BF66Z33QidHeZFXik7VjM730=;
        b=W+WavM/Q4g1r7QpDGscIj1K4HsPcCtXjCr239DLBu5DURS8jE72otmlkWcQN9NjSj1
         SWpy1ih6gLF5LjUNCSFUMQuTEtCbzh/l+4WFpz+vgjC3Bk5zMrnKyVg2tX8TRQLWUy51
         4PhiIER9DTFk5NgUQjepDvbJFOnGkOYYAQCus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXd1D478P4SNq4RE8o4BF66Z33QidHeZFXik7VjM730=;
        b=Qt99oGIzNFzE0ga717IhIV/RdfcYaZaY8w1/ZrdYXLA0yQya2eDWtewJHkng4JIWsu
         XoV14ib0TWfA/BRzNoluO1r4WUwJ0gTJ0zQVNGWOekLo5+5PfBPieqIf0FGAQdtYcTDg
         B4j1gfHE3xqmT2+1mxohlSlTQjFp2KKb6fS+dey91ggXOqGmPg+8RyPdowUubB5/z52D
         CvxzL4blpfR8IaYdv4AUqMulEoos0GuRCOzAFihLv3sqAZKGt3ychNUWAiOJXFJCJC0k
         sCJDj0xZFY6aKcuFf6obPadHCyt48C35/blPo59J+2L2RcvOMnRAK1lWkBdvMTklv4y0
         1SGw==
X-Gm-Message-State: AOAM531cCKn0xHDw1XIuXLMsI54Ro2YYLDnwPSl/i0smsDJ94HI2oe5B
        616BcVJnhAm1d/BCwTt+AA834Lo4bSw=
X-Google-Smtp-Source: ABdhPJwWeL5KSZFyilbvhWPrO6GeC0El75E6sfs0Ya366+UdNT+LyPLmrmGcZXiDcXQquGPgQTmNoA==
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr9188465ljo.123.1591547858444;
        Sun, 07 Jun 2020 09:37:38 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h24sm3631196lfj.11.2020.06.07.09.37.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c21so8732964lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr10598957lfn.10.1591547857000;
 Sun, 07 Jun 2020 09:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200605142300.14591-1-linux@rasmusvillemoes.dk>
 <CAHk-=wgz68f2u7bFPZCWgbsbEJw+2HWTJFXSg_TguY+xJ8WrNw@mail.gmail.com> <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
In-Reply-To: <dcd7516b-0a1f-320d-018d-f3990e771f37@rasmusvillemoes.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 7 Jun 2020 09:37:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
Message-ID: <CAHk-=wixdSUWFf6BoT7rJUVRmjUv+Lir_Rnh81xx7e2wnzgKbg@mail.gmail.com>
Subject: Re: [PATCH resend] fs/namei.c: micro-optimize acl_permission_check
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 6:22 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Yes, I did think about that, but I thought this was the more obviously
> correct approach, and that in practice one only sees the 0X44 and 0X55
> cases.

I'm not sure about that - it probably depends on your umask.

Because I see a lot of -rw-rw-r--. in my home directory, and it looks
like I have a umask of 0002.

That's just the Fedora default, I think. Looking at /etc/bashrc, it does

    if [ $UID -gt 199 ] && [ "`/usr/bin/id -gn`" = "`/usr/bin/id -un`" ]; then
       umask 002
    else
       umask 022
    fi

iow, if you have the same user-name and group name, then umask is 002
by default for regular users.

Honestly, I'm not sure why Fedora has that "each user has its own
group" thing, but it's at least one common setup.

So I think that the system you are looking at just happens to have
umask 0022, which is traditional when you have just a 'user' group.

> That will kinda work, except you do that mask &= MAY_RWX before
> check_acl(), which cares about MAY_NOT_BLOCK and who knows what other bits.

Good catch.

> Perhaps this? As a whole function, I think that's a bit easier for
> brain-storming. It's your patch, just with that rwx thing used instead
> of mask, except for the call to check_acl().

Looks fine to me. Once we have to have rwx/mask separate, I'm not sure
it's worth having that early masking at all (didn't check what the
register pressure is over that "check_acl()" call, but at least it is
fairly easy to follow along.

Send me a patch with commit message etc, and I'll apply it.

               Linus
