Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E381C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4EE207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="movOQeaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbgFYIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbgFYIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:39:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:39:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so3522335eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 01:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=knPtliwcot5N5At1mGwZ9m1E+XwC5jbJSjbHxedMECg=;
        b=movOQeaGutOa6q9thMN8ZraO6v4VdyA9FM8pu+UtoU1mi8sXZ9l+nEY09G4OhYBeG8
         o2I8o/PMvdFbCBkMwCAs0AEXndwzuD/HYNOLykRsnJ4Fc58u49SmCPmlpuC+piylSthN
         Ar8b5NwI4DMivCEBUb6vfjgA5mRDuYgBiBBo0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=knPtliwcot5N5At1mGwZ9m1E+XwC5jbJSjbHxedMECg=;
        b=dlWBIBThXmTW1fzKW+C16UeZ3zuyqCzNh/0sTa4o/bpCVp6TD5OPkSmqXXnj5UkQ1e
         SC2rEfcVfeh/2gXoVs22IB9oe+pnj+wyinvWnf1cl2swuTg3k7JHhUrWEZFYo39GbPa9
         3hs7u4z/MF5RjroodJhKPnRbJjSo51/0RKyuWENKk6H2cQifzmJO6pTDlq7+K9nXoYuy
         EpNzF8LIYVZ2iXuQLobtQIMgrD+R2oqBjg9DhFDYb2xhmrnY2snUYmgd+WqQD6sZVW5n
         Oznn88zeW5B+5C8BjBAPY7l2Da3RYB0aoUqn6yloqK2FeAXvK5oCTdEspqHuoSJGRGIv
         nezw==
X-Gm-Message-State: AOAM530PhsxaybtuV38q/diy5KcrmKUP46mGrSyC/Ro53RmM4Iphx6sY
        awgkATYCe89ZhBCuvgqEY6PTnLmFfKi39lRnUg0=
X-Google-Smtp-Source: ABdhPJyPQLpgHxd5w/+/WdO1Rr6K2x3LcdgiLXQsrbeM0k1gT2/a5db0/ecTK/5NhZr7XOPQKXjb6AnduT6s+asA66w=
X-Received: by 2002:a05:6402:459:: with SMTP id p25mr30314307edw.383.1593074364477;
 Thu, 25 Jun 2020 01:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590079968.git.christophe.leroy@csgroup.eu>
 <8c593895e2cb57d232d85ce4d8c3a1aa7f0869cc.1590079968.git.christophe.leroy@csgroup.eu>
 <20200616002720.GA1307277@ubuntu-n2-xlarge-x86> <68503e5e-7456-b81c-e43d-27cb331a4b72@xilinx.com>
 <20200616181630.GA3403678@ubuntu-n2-xlarge-x86> <50fb2dd6-4e8f-a550-6eda-073beb86f2ff@xilinx.com>
 <87bllidmk4.fsf@mpe.ellerman.id.au> <878sgmdmcv.fsf@mpe.ellerman.id.au>
 <CAKwvOdnkcjLGay0jdQ77kHTmKhE56F9jvzh01XWwEE8rjbhLAA@mail.gmail.com>
 <87tuz9ci7e.fsf@mpe.ellerman.id.au> <20200618031622.GA195@Ryzen-9-3900X.localdomain>
 <87eeqbco82.fsf@mpe.ellerman.id.au>
In-Reply-To: <87eeqbco82.fsf@mpe.ellerman.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 25 Jun 2020 08:39:12 +0000
Message-ID: <CACPK8XdCmDgHuJ=rvHzdr9Agu=2dGNoNh_WfVH=52mchffA2=w@mail.gmail.com>
Subject: Re: [PATCH v5 01/13] powerpc: Remove Xilinx PPC405/PPC440 support
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 11:02, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Nathan Chancellor <natechancellor@gmail.com> writes:
> >> It's kind of nuts that the zImage points to some arbitrary image
> >> depending on what's configured and the order of things in the Makefile.
> >> But I'm not sure how we make it less nuts without risking breaking
> >> people's existing setups.
> >
> > Hi Michael,
> >
> > For what it's worth, this is squared this away in terms of our CI by
> > just building and booting the uImage directly, rather than implicitly
> > using the zImage:
> >
> > https://github.com/ClangBuiltLinux/continuous-integration/pull/282
> > https://github.com/ClangBuiltLinux/boot-utils/pull/22
>
> Great.
>
> > We were only using the zImage because that is what Joel Stanley intially
> > set us up with when PowerPC 32-bit was added to our CI:
> >
> > https://github.com/ClangBuiltLinux/continuous-integration/pull/100
>
> Ah, so Joel owes us all beers then ;)

Hey, you owe me beers for finding broken machines!

This machine was picked from a vague discussion on an internal chat.
The two requirements were that it would build, and boot in qemu.

If there's a better supported 32 bit machine then we should switch the
CI over. We don't want the Clang CI to be the only user and give the
false impression that someone out there is still booting upstream
kernels on it.

> > Admittedly, we really do not have many PowerPC experts in our
> > organization so we are supporting it on a "best effort" basis, which
> > often involves using whatever knowledge is floating around or can be
> > gained from interactions such as this :) so thank you for that!
>
> No worries. I definitely don't expect you folks to invest much effort in
> powerpc, especially the old 32-bit stuff, so always happy to help debug
> things, and really appreciate the testing you do.

+1

Cheers,

Joel
