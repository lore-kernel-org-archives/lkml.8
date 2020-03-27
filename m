Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21284C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77E02071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1kxgtdl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgC0R1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:27:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42229 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0R1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:27:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id z5so10275623oth.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ClBYvSVmf83rxBcoJPioNptteHGrQ49oK3IN7T/4Mgc=;
        b=p1kxgtdlAlcm9ZYp0voSXEtcsJCiehEdu2swGy2F/tJZXZEDEM0LiBh5bLYFtdgFZc
         vsH8oBKUYVuWCQSRJUlNW+M4qg4yLXiWgD2eK+pQCBZ69YoTQhmD3rwBCLNgQqIhOlvk
         ABETgIyKgHprRV5zGNhl+GGjY2bpPLCWeBOFSQCn0HbGJbZQ/g60ZuYwe2cfmOOAGajh
         Kf0cjQ/kS6FJKgws+xZ3OVq2EwfuFkKLdUaqmqF6Ul8xX/bBN2ZEnNowVyy1ujh15FJs
         xnswehxIsxVIpsUdnGDvqjPgUAqQSKKMrB0vNuBQo1ni7AIwNHppUSReQB9iSUvLNxD4
         T8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ClBYvSVmf83rxBcoJPioNptteHGrQ49oK3IN7T/4Mgc=;
        b=d7fWcOvZhJbPGgq5UFBL7q/gTQsdsbA7UoL7i5RSFMXyvHWwSxYjKtZE+3HmWQYQPW
         g+UslBPyR6BrRpbUF1Jy6Mrxa2F5Lmee0LC60dhX6b9gKnDXJMQdKLJTBOVYKFozgBhs
         34UUVkBsOv+EqocgHJa/IzTvz4/LTWjvD4y/OolShv2a3bJXgcAiTK6kwwDRkVTf0taJ
         +KuKai0dFAcs7ZEAJp30ltm2q2VrQdbCc3q4rC8BwC1OeTmWXgRuTviggnEF0hZLlDTA
         G8f8bxSS040ZCiEfDnYkQOFViyVp7J+3yCTS/mOsaQgrq6eqg3RsqoOdyMoH3tydCXSm
         g53Q==
X-Gm-Message-State: ANhLgQ2+fA1H0qJ/TsiE/nmwC4k0G3wDWIbBNu/bfT75eSDL0mscaz4P
        l3A29LYHDMY2V7fKudCbE6s=
X-Google-Smtp-Source: ADFU+vvCryVp1EzUDSsGpKlMWDJ2IGkuG+A5nBaN01hdZ8Oaa4LyrQLUUb4FlTMO9zHE2KaPs5q0Og==
X-Received: by 2002:a4a:d88b:: with SMTP id b11mr421504oov.42.1585330026427;
        Fri, 27 Mar 2020 10:27:06 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id t4sm1105871otm.45.2020.03.27.10.27.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 10:27:05 -0700 (PDT)
Date:   Fri, 27 Mar 2020 10:27:03 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Clement Courbet <courbet@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v1] powerpc: Make setjmp/longjump signature standard
Message-ID: <20200327172703.GA28580@ubuntu-m2-xlarge-x86>
References: <20200327100801.161671-1-courbet@google.com>
 <CAKwvOdmLmfJY4Uk-Atd9dT5+zQTPeoagjMZMcDqdVfKCU7_BuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmLmfJY4Uk-Atd9dT5+zQTPeoagjMZMcDqdVfKCU7_BuA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:10:44AM -0700, Nick Desaulniers wrote:
> On Fri, Mar 27, 2020 at 3:08 AM Clement Courbet <courbet@google.com> wrote:
> >
> > Declaring setjmp()/longjmp() as taking longs makes the signature
> > non-standard, and makes clang complain. In the past, this has been
> > worked around by adding -ffreestanding to the compile flags.
> >
> > The implementation looks like it only ever propagates the value
> > (in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
> > with integer parameters.
> >
> > This allows removing -ffreestanding from the compilation flags.
> >
> > Context:
> > https://lore.kernel.org/patchwork/patch/1214060
> > https://lore.kernel.org/patchwork/patch/1216174
> >
> > Signed-off-by: Clement Courbet <courbet@google.com>

Thanks for fixing this properly, not really sure why I did not think of
this in the first place. I guess my thought was the warning makes it
seem like clang is going to ignore the kernel's implementation of
setjmp/longjmp but I can't truly remember.

> Hi Clement, thanks for the patch! Would you mind sending a V2 that
> included a similar fix to arch/powerpc/xmon/Makefile?

Agreed.

> For context, this was the original patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aea447141c7e7824b81b49acd1bc78
> which was then modified to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9029ef9c95765e7b63c4d9aa780674447db1ec0
> 
> So on your V2, if you include in the commit message, the line:
> 
> Fixes c9029ef9c957 ("powerpc: Avoid clang warnings around setjmp and longjmp")
> 
> then that will help our LTS branch maintainers back port it to the
> appropriate branches.

The tags should be:

Cc: stable@vger.kernel.org # v4.14+
Fixes: c9029ef9c957 ("powerpc: Avoid clang warnings around setjmp and longjmp")

that way it explicitly gets picked up for stable, rather than Sasha's
AUTOSEL process, which could miss it.

With the xmon/Makefile -ffreestanding removed and the tags updated,
consider this:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Cheers,
Nathan
