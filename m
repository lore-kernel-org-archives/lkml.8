Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A808EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EA3E207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 00:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnOQyrPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGUA1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbgGUA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:27:49 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8549DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:27:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so9477792plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 17:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eHMkd52N9iG/J38uCcPxIkcFupcNU7Z95N/n272nES4=;
        b=JnOQyrPOjp8U4Qxp718M6F2K1vYere++W78PpAQmkQTjjRuiCwTiRymUuMbyYp8x3z
         f0lOJ02SfXfK1BSYjBAUwcEG649O6miSZpI5TntWAIUUdpDilgvyXInWpT2hX/gKKQ29
         mRHbaGiBWO0Vwu70hG5X939xB2ivtYqIrdmIvo5uvx/+p90r8djVEwYGQH9lgJPC+Pp6
         fvS2jH8Mr3AGjtLPifJQLqmc6Qz86vN+uNXi77ECVDk6RuCCSJH9oCZ3vvCZgnHw+9uR
         rvDUJZmxAQTmYvHNO/gpNQzBYGuyszoYrOz+0cHubEDJLMFB6ZSm502ZRtDDjSO4DPbW
         R4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eHMkd52N9iG/J38uCcPxIkcFupcNU7Z95N/n272nES4=;
        b=Nns9sFgaYCPE65uXD5OKzc0zVkopykyP1RVQ+IjMUNFuUNJbwSK9qUVVaF/s84ct5C
         kVNR21Ddj3I2X9cfCvFOGB7vNiETxg4NMJMUFI3R0r4wZMp94zbtvPmavVl7QYfmiB3T
         MHA7OO90cxAcZtiV248EZaNxncr+j2QUmhL+p9+Q398FAdhVGRG+47kDnmxfT5UUNRUY
         KbtAi2lViEPO2B3/yy/gQ1eKNU9G5bGGTtCFlbGVeKq+Fywp/eAWOeBTQKUBfsrYELIY
         MiRcm5uIZK3Pz2VuP21DtUk4fP69jWvty3Srj/h4yZAb7gQ1HLWkb329ud8KHNHx7fIK
         94RA==
X-Gm-Message-State: AOAM533GPYDDTTRZlVqyc01bQczXBcrkdxu++rAAb2lqNdudVP1U9LhB
        Jg+2E6fo/O/3e+xiPNLXQ0m2ZA==
X-Google-Smtp-Source: ABdhPJwMiVGdCJ/oTtHkqhLZ2OV8CS78/nFJcz+Jp2i9jIjwcpykNtgN/M4+Do/9zXTgCj7tEums/g==
X-Received: by 2002:a17:902:8d8b:: with SMTP id v11mr4583554plo.316.1595291268175;
        Mon, 20 Jul 2020 17:27:48 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s89sm768445pjj.28.2020.07.20.17.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 17:27:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:27:44 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>, Bill Wendling <morbo@google.com>
Subject: Re: [PATCH] Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross
 compilation
Message-ID: <20200721002744.c5a4dj5t2hfac25o@google.com>
References: <20200720181237.3015826-1-maskray@google.com>
 <20200720181646.GA6160@ubuntu-n2-xlarge-x86>
 <CAKwvOd=tF7j-mTHMKvvmRkxjFZ-a2ah2+4zLY527WtebZzum8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOd=tF7j-mTHMKvvmRkxjFZ-a2ah2+4zLY527WtebZzum8Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-20, Nick Desaulniers wrote:
>On Mon, Jul 20, 2020 at 11:16 AM Nathan Chancellor
><natechancellor@gmail.com> wrote:
>>
>> On Mon, Jul 20, 2020 at 11:12:22AM -0700, Fangrui Song wrote:
>> > When CROSS_COMPILE is set (e.g. aarch64-linux-gnu-), if
>> > $(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-,
>> > GCC_TOOLCHAIN_DIR will be set to /usr/bin/.  --prefix= will be set to
>> > /usr/bin/ and Clang as of 11 will search for both
>> > $(prefix)aarch64-linux-gnu-$needle and $(prefix)$needle.
>> >
>> > GCC searchs for $(prefix)aarch64-linux-gnu/$version/$needle,
>> > $(prefix)aarch64-linux-gnu/$needle and $(prefix)$needle. In practice,
>> > $(prefix)aarch64-linux-gnu/$needle rarely contains executables.
>> >
>> > To better model how GCC's -B/--prefix takes in effect in practice, newer
>> > Clang only searches for $(prefix)$needle and for example it will find
>
>"newer Clang" requires the reader to recall that "Clang as of 11" was
>the previous frame of reference. I think it would be clearer to:
>1. call of clang-12 as having a difference in behavior.
>2. explicitly link to the commit, ie:
>Link: https://github.com/llvm/llvm-project/commit/3452a0d8c17f7166f479706b293caf6ac76ffd90
>
>> > /usr/bin/as instead of /usr/bin/aarch64-linux-gnu-as.
>
>That's a common source of pain (for example, when cross compiling
>without having the proper cross binutils installed, it's common to get
>spooky errors about unsupported configs or host binutils not
>recognizing flags specific to cross building).
>
>/usr/bin/as: unrecognized option '-EL'
>
>being the most common.  So in that case, I'm actually very happy with
>the llvm change if it solves that particularly common pain point.
>
>> >
>> > Set --prefix= to $(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
>> > (/usr/bin/aarch64-linux-gnu-) so that newer Clang can find the
>> > appropriate cross compiling GNU as (when -no-integrated-as is in
>> > effect).
>> >
>> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>> > Signed-off-by: Fangrui Song <maskray@google.com>
>> > Link: https://github.com/ClangBuiltLinux/linux/issues/1099
>>
>> Sorry that I did not pay attention before but this needs
>>
>> Cc: stable@vger.kernel.org
>
>Agreed.  This change to llvm will blow up all of our CI jobs that
>cross compile if not backported to stable.

Thanks. I did not know this.

>>
>> in the body so that it gets automatically backported into all of our
>> stable branches. I am not sure if Masahiro is okay with adding that
>> after the fact or if he will want a v2.
>>
>> I am fine with having my signed-off-by on the patch but I did not really
>> do much :) I am fine with having that downgraded to
>
>Not a big deal, but there's only really two cases I can think of where
>it's appropriate to attach someone else's "SOB" to a patch:
>1. It's their patch that you're resending on their behalf, possibly as
>part of a larger series.
>2. You're a maintainer, and...well I guess that's also case 1 above.
>
>Reported-by is more appropriate, and you can include the tags
>collected from this thread.  Please ping me internally for help
>sending a v2, if needed.

Nathan's draft patch on
https://github.com/ClangBuiltLinux/linux/issues/1099 actually works.
I removed the slash. The words are my own. Since Nathan explicitly
requested a downgrade of his tag, I'll do that for V2.

I'll do that anyway because I need to fix a typo in the description:

$(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-
$(CROSS_COMPILE)elfedit is found at /usr/bin/aarch64-linux-gnu-elfedit

>>
>> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
>I tested with this llvm pre- and post-
>https://github.com/llvm/llvm-project/commit/3452a0d8c17f7166f479706b293caf6ac76ffd90.
>I also tested downstream Android kernel builds with
>3452a0d8c17f7166f479706b293caf6ac76ffd90. Builds that don't make use
>of CROSS_COMPILE (native host targets) are obviously unaffected.  We
>might see this issue pop up a few more times internally if the patch
>isn't picked up by stable, or if those downstream kernel trees don't
>rebase on stable kernel trees as often as they refresh their
>toolchain.
>
>Tested-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks for offerring proofreading service! I'm working on the
description...

>>
>> if people find it odd.
>>
>> Thanks for sending this along!
>>
>> Cheers,
>> Nathan
>>
>> > ---
>> >  Makefile | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 0b5f8538bde5..3ac83e375b61 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -567,7 +567,7 @@ ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
>> >  ifneq ($(CROSS_COMPILE),)
>> >  CLANG_FLAGS  += --target=$(notdir $(CROSS_COMPILE:%-=%))
>> >  GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
>> > -CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)
>> > +CLANG_FLAGS  += --prefix=$(GCC_TOOLCHAIN_DIR)$(CROSS_COMPILE)
>> >  GCC_TOOLCHAIN        := $(realpath $(GCC_TOOLCHAIN_DIR)/..)
>> >  endif
>> >  ifneq ($(GCC_TOOLCHAIN),)
>> > --
>> > 2.28.0.rc0.105.gf9edc3c819-goog
>> >
>>
>> --
>
>-- 
>Thanks,
>~Nick Desaulniers
