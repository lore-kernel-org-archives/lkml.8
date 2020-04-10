Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E7C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA1520769
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 00:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRsrd9fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgDJAMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:12:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40783 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:12:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id a7so157804oid.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JjCg+0ZKVUEU3m1mtuE7C2U4b9dMYk265cCmLvmPh20=;
        b=ZRsrd9foGs0GWEd9amU602pwhj9SzLnjEnilwCYt8UiT2smbNEbJlYImi6QRkHncC8
         AaS9xP6V3zjvdz1p8XPHlz+BL+on5msn1cCcROxTzceDs5y54LB6YEJxRJ6bYZNCQT1V
         SrS4DieBPjvUhoQnk6YbFcJf0LPyQw4d13Djak7JeOyYl/CUlfSqpZZFr4pQgp7TTHP8
         umlC6iW+1U7zKs5p0/2D8Z/R6mO263qt1PvyDno367L24yUnOcLbk5EBLnHhUkh8xewV
         tpGCi6ZwJO8yqZfZ9nsskBfoG1zMklLNkGnH2+5bQdTeOY/021d+DsTPRx+2qGOIDiv5
         zf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JjCg+0ZKVUEU3m1mtuE7C2U4b9dMYk265cCmLvmPh20=;
        b=HBEJ+VZJmFR//yqGkBkBO7YXHF/yTt2GA47KV+jO/Tm7dXaVxXDFdvR/njVtUW8l4Z
         0cnQGfuk8eBcmZj5HxC3yGCOjuG6ZhTkKG1pv4nGsxozT/J3PILF43K8BPKaD2R3QzKK
         Nb+BjMhbzUySrnldvfUsODTCCPyISoNVpT+uTvk5Q/MME3BBV4l9khMN7+9ukGo3iEFU
         /fIfd1oectWxW4xGJuspj6tjm0ArAqfFE/1I1fvMHNul/A8fKCEQRKY1sOkQdb6oKXI9
         UQClq5kf/rVo6CownCXJM0iZBKFLQkQSY/s/AcDgqNXpqIN2wxGF9FAOsN6gQv2N6i1c
         GKxQ==
X-Gm-Message-State: AGi0PuYSN8pqQ9+Aqccil3m2WleP6kLYPsnmj3898iZVPbUQaYJP338v
        uDhQAQ4rEb60JXH95EgurJc=
X-Google-Smtp-Source: APiQypLi1t8vlbkrqsMgkH03bKYkFF/ExZPKQY8Aok71iKZxs/zkBasvqvoTdonteG/ffgwudiljlQ==
X-Received: by 2002:aca:c311:: with SMTP id t17mr1528797oif.169.1586477524193;
        Thu, 09 Apr 2020 17:12:04 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id 186sm307290ooi.30.2020.04.09.17.12.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 17:12:03 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:12:01 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jian Cai <caij2003@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Jian Cai <jiancai@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200410001201.GA15303@ubuntu-s3-xlarge-x86>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAKwvOdkot0Q7FSCMKGm6ti4hhvD3N+AMUK4Xv2Xxiiu3+pURgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkot0Q7FSCMKGm6ti4hhvD3N+AMUK4Xv2Xxiiu3+pURgQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 05:01:33PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> On Thu, Apr 9, 2020 at 4:28 PM Jian Cai <caij2003@gmail.com> wrote:
> >
> > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> 
> Hi Jian, thank you for the patch.  It's pretty much spot on for what I
> was looking for.  Some notes below:
> 
> s/assemmbler/assembler
> 
> :set spell
> 
> ;)
> 
> Also, could use a link tag, ie.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/975
> 
> (Always include the link tag to help us track when and where patches land).
> 
> Finally, I think the hunks for the two different files should be
> split; the init/Kconfig change should be it's own dedicated change
> that goes to Masahiro, the maintainer of the Kbuild tree.  Then when
> we have that, the dependent configs should go separately.  Would you
> mind splitting this patch in two, and re-sending just the Kbuild patch
> for now?  Since you used Sami's patch for inspiration
> (https://github.com/ClangBuiltLinux/linux/issues/975#issuecomment-611694153,
> https://github.com/samitolvanen/linux/commit/fe9786cb52a0100273c75117dcea8b8e07006fde),
> it would be polite to Sami to add a tag like:
> 
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> 
> or maybe better yet, take Sami's patch, add your signed off by tag
> (maintaining him as the git author, see `git log --pretty=fuller`),
> then rebase your AS_IS_CLANG hunk on top, make that a second patch,
> then finally have the arm change as a third patch.
> 
> This change is exactly what I'm looking for, so these are just process concerns.

I think that they can be sent as a series that is picked up by Masahiro
with an ack from an ARM maintainer.

> > kernel.
> >
> > Signed-off-by: Jian Cai <caij2003@gmail.com>
> > ---
> >  arch/arm/Kconfig | 2 +-
> >  init/Kconfig     | 6 ++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 66a04f6f4775..39de8fc64a73 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
> >
> >  config IWMMXT
> >         bool "Enable iWMMXt support"
> > -       depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
> > +       depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)
> >         default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
> >         help
> >           Enable support for iWMMXt context switching at run time if
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 1c12059e0f7e..b0ab3271e900 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -19,6 +19,12 @@ config GCC_VERSION
> >  config CC_IS_CLANG
> >         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> >
> > +config AS_IS_CLANG
> > +       def_bool $(success,$(AS) --version | head -n 1 | grep -q clang)

$(AS) is being replaced with $(LLVM_IAS). That line should be:

    def_bool $(success,test $(LLVM_IAS) -eq 1)

I think. That depends on a commit in Masahiro's for-next branch [1] so
it should be based/tested against that.

Otherwise, I agree with Nick's comment about being split into two
patches (one for the init/Kconfig change and one for the ARM change) and
adding the Link tag.

I ran about 75 randconfigs with LD=ld.lld and LLVM_IAS=1 and I did not
see any Kconfig warnings from this and CONFIG_IWMMXT was unset in every
one. Should prevent the errors that you encountered. Feel free to apply
the following tags to any follow up revisions.

Tested-by: Nathan Chancellor <natechancellor@gmail.com> # randconfig
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git

> > +config LD_IS_LLD
> > +       def_bool $(success,$(LD) --version | head -n 1 | grep -q LLD)
> > +
> >  config CLANG_VERSION
> >         int
> >         default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> > --
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 

Cheers,
Nathan
