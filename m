Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D497C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1562085B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="foHqhRb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbgFXEoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbgFXEoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:44:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3095C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ev7so110884pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yc7m6q+AETZbQf/A/NW3gp84TMebMUYFiYcSc962UaI=;
        b=foHqhRb7hf5KgQA5HSRO5284qQLj7K1f7jI6KtpF4wP8UIugY2Q4C+9vTK7tIsFkyu
         gCNVka1KLRgmXwoVN0JFbY5Ac/BHQH24PxKAlxSyvl0q99hluofpS33VW/NvUHVQlz+U
         gne2QItKrmtHY7DGvrNp9LyDns2aXJiINfTjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yc7m6q+AETZbQf/A/NW3gp84TMebMUYFiYcSc962UaI=;
        b=LeXA7UT839ib+9EpHKNIQgXWueyMpyLx53ksRisAMfwpOBX+J8Yf3x0Ilsh2JplQbN
         nek++cqKU/e009WbOfLLiea5FnpZJUccrYHAsVtx07iEfsSPvBQJXJAuHAEsZy2IicOB
         ZfD0dPPTh7/gwVGkM5F3J4qrGCOwI9IkQNXPWjGgGjR4DM4f0AWZBlt+DULSLQ6CcL8w
         JFY+ui0zXXb0LDiIjUlvkB3pEkQ2S3SmiBg/6VWTrtf+dtVzG1YFgFEDHWj4T1Znt3Si
         vzwMBJJhuNMG8dfbvKC1l2PKlycJtg2D7zffGOqsxrPcDYVG7q9ZsUVu45P/Kq5M61CW
         XGKA==
X-Gm-Message-State: AOAM531wyLnu9vI4+OeezQqVG/gXK33XI8tJmuvjEFbEE2RQMZhAzNlz
        9kJnDTJWREc1P4uOh17C6b8qIg==
X-Google-Smtp-Source: ABdhPJwXxE4pwrV4JSPaLhEV6G1BlATgL4ZGVyFiXtLbOqPg4UWtN+ePnA8hBS3vgqyDG0O2W9xKlw==
X-Received: by 2002:a17:90b:a02:: with SMTP id gg2mr6864076pjb.110.1592973853293;
        Tue, 23 Jun 2020 21:44:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c7sm3578791pfj.106.2020.06.23.21.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 21:44:12 -0700 (PDT)
Date:   Tue, 23 Jun 2020 21:44:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/9] efi/libstub: Remove .note.gnu.property
Message-ID: <202006232143.66828CD3@keescook>
References: <20200624014940.1204448-1-keescook@chromium.org>
 <20200624014940.1204448-4-keescook@chromium.org>
 <20200624033142.cinvg6rbg252j46d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624033142.cinvg6rbg252j46d@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:31:42PM -0700, 'Fangrui Song' via Clang Built Linux wrote:
> On 2020-06-23, Kees Cook wrote:
> > In preparation for adding --orphan-handling=warn to more architectures,
> > make sure unwanted sections don't end up appearing under the .init
> > section prefix that libstub adds to itself during objcopy.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > drivers/firmware/efi/libstub/Makefile | 3 +++
> > 1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 75daaf20374e..9d2d2e784bca 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -66,6 +66,9 @@ lib-$(CONFIG_X86)		+= x86-stub.o
> > CFLAGS_arm32-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > CFLAGS_arm64-stub.o		:= -DTEXT_OFFSET=$(TEXT_OFFSET)
> > 
> > +# Remove unwanted sections first.
> > +STUBCOPY_FLAGS-y		+= --remove-section=.note.gnu.property
> > +
> > #
> > # For x86, bootloaders like systemd-boot or grub-efi do not zero-initialize the
> > # .bss section, so the .bss section of the EFI stub needs to be included in the
> 
> arch/arm64/Kconfig enables ARM64_PTR_AUTH by default. When the config is on
> 
> ifeq ($(CONFIG_ARM64_BTI_KERNEL),y)
> branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET_BTI) := -mbranch-protection=pac-ret+leaf+bti
> else
> branch-prot-flags-$(CONFIG_CC_HAS_BRANCH_PROT_PAC_RET) := -mbranch-protection=pac-ret+leaf
> endif
> 
> This option creates .note.gnu.property:
> 
> % readelf -n drivers/firmware/efi/libstub/efi-stub.o
> 
> Displaying notes found in: .note.gnu.property
>   Owner                Data size        Description
>   GNU                  0x00000010       NT_GNU_PROPERTY_TYPE_0
>       Properties: AArch64 feature: PAC
> 
> If .note.gnu.property is not desired in drivers/firmware/efi/libstub, specifying
> -mbranch-protection=none can override -mbranch-protection=pac-ret+leaf

We want to keep the branch protection enabled. But since it's not a
"regular" ELF, we don't need to keep the property that identifies the
feature.

-- 
Kees Cook
