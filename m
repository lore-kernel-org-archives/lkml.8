Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85563C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D41E2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFW9zqFU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgHFTRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgHFTRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:17:22 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B523C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:17:22 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so3901568pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGw36nAvKdWXoAUWiTJPP1buT7PpTyoMWVcd5KcuaEY=;
        b=DFW9zqFUE6UVv/NaVI75iFcIdiXnJS93SWnk7O+7CjAlc8gNumlsOWPSXXtOOIUKo+
         nKk6n/Z85ltJEdpP+o5GdhyOqODga0cLxlSQLwR89YqY4W7VScc4T7sXz4g8sUjcmzLF
         VyZi8rkD7YQ5Hmdft+EDfCoLzKQV0q/GiNqkWcLx4ZokrEcBNEJKXdr8MAf4oPRG862O
         CDLfqGXmCoAgwlmp54J39Q6fhlz9ZM7hWSY1Or0d5Rk2heRHDA3E1SEfMxGaEvsHosSh
         knXPwzo6jQF18xgEKz5l6sepIqTiE6Z4z+BIKE65bqmHvL1lZBnPVaxaZynP/j/9dgTJ
         tBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UGw36nAvKdWXoAUWiTJPP1buT7PpTyoMWVcd5KcuaEY=;
        b=II7Zq5aI2evXesHaMd3DNo/8allTr73LLk0ugVNcS6HrWoDEaSqWr1nSm0iRYe74jc
         6MmWzuBSTTy1/JwebuYXp4nVNDsQhSowz15xN8IO1MNHBbtAd6A41PAusf9WzUBIwqIU
         xV9WD1ANHWXHT2NksKnZOHfOCRcBm3uzZhZPlVVQTuna7sxU5jsc6gcT84DO6azSHByR
         YCZ80rwNQVLVxJ7k0bb1KcV7/d7v9H+NX5hpTVGwBpThy237iJ0e03wIAYaoxxlGvUC9
         OOgdT3lsS6hNSmx2JjLDwyFum1zNViB0vNUsJ+ajst7RXmiU3zAqD0IzayC/rA542PXv
         0liw==
X-Gm-Message-State: AOAM533W5dkM9D2L4yOMhDDEcqZS0gdVjIUBetMN5WKk8phgUAiTlzzc
        Rk/Xvpidlk9d3QxAOKE9THsIag==
X-Google-Smtp-Source: ABdhPJzoT1G0SlbqzFmLb6EOwVf73tF88sKWs484NPe384VDxj3BsxPArY1ZsNbRHHWT/wbvM8d4kw==
X-Received: by 2002:a63:cc49:: with SMTP id q9mr8350589pgi.390.1596741441391;
        Thu, 06 Aug 2020 12:17:21 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id d5sm7709517pju.15.2020.08.06.12.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:17:20 -0700 (PDT)
Date:   Thu, 6 Aug 2020 12:17:14 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated
 assembler
Message-ID: <20200806191714.GA1980587@google.com>
References: <20200805181920.4013059-1-samitolvanen@google.com>
 <20200806120109.GD23785@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806120109.GD23785@gaia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:01:09PM +0100, Catalin Marinas wrote:
> On Wed, Aug 05, 2020 at 11:19:20AM -0700, Sami Tolvanen wrote:
> > diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> > index d493174415db..66c2aab5e9cb 100644
> > --- a/arch/arm64/include/asm/tlbflush.h
> > +++ b/arch/arm64/include/asm/tlbflush.h
> > @@ -16,6 +16,16 @@
> >  #include <asm/cputype.h>
> >  #include <asm/mmu.h>
> >  
> > +/*
> > + * Enable ARMv8.4-TLBI instructions with ARM64_TLB_RANGE. Note that binutils
> > + * doesn't support .arch_extension tlb-rmi, so use .arch armv8.4-a instead.
> > + */
> > +#ifdef CONFIG_ARM64_TLB_RANGE
> > +#define __TLBI_PREAMBLE	".arch armv8.4-a\n"
> > +#else
> > +#define __TLBI_PREAMBLE
> > +#endif
> > +
> >  /*
> >   * Raw TLBI operations.
> >   *
> > @@ -28,14 +38,16 @@
> >   * not. The macros handles invoking the asm with or without the
> >   * register argument as appropriate.
> >   */
> > -#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
> > +#define __TLBI_0(op, arg) asm (__TLBI_PREAMBLE				       \
> > +			       "tlbi " #op "\n"				       \
> >  		   ALTERNATIVE("nop\n			nop",		       \
> >  			       "dsb ish\n		tlbi " #op,	       \
> >  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
> >  			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
> >  			    : : )
> >  
> > -#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
> > +#define __TLBI_1(op, arg) asm (__TLBI_PREAMBLE				       \
> > +			       "tlbi " #op ", %0\n"			       \
> >  		   ALTERNATIVE("nop\n			nop",		       \
> >  			       "dsb ish\n		tlbi " #op ", %0",     \
> >  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
> 
> A potential problem here is that for gas (not sure about the integrated
> assembler), .arch overrides any other .arch. So if we end up with two
> preambles included in the same generated .S files in the future, it will
> lead to some random behaviour.
> 
> Does the LLVM integrated assembler have the same behaviour on .arch
> overriding a prior .arch?

I would assume so, but each inline assembly block is independent in
LLVM, so unless there are .arch changes within the block, that shouldn't
be an issue for the integrated assembler.

> Maybe a better solution is for all inline asm on arm64 to have a
> standard preamble which is the maximum supported architecture version.
> We can add individual .arch_extension as those are not overriding.

Sure, that works. How would you feel about something like this, so we can
keep the preamble in sync with future -Wa,-march changes? I'm not sure if
asm/compiler.h is the correct place for the definition though.

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 55bc8546d9c7..0dd07059beaa 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -82,8 +82,8 @@ endif
 # compiler to generate them and consequently to break the single image contract
 # we pass it only to the assembler. This option is utilized only in case of non
 # integrated assemblers.
-ifneq ($(CONFIG_AS_HAS_ARMV8_4), y)
-branch-prot-flags-$(CONFIG_AS_HAS_PAC) += -Wa,-march=armv8.3-a
+ifeq ($(CONFIG_AS_HAS_PAC), y)
+asm-arch := armv8.3-a
 endif
 endif
 
@@ -91,7 +91,12 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)
 
 ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
 # make sure to pass the newest target architecture to -march.
-KBUILD_CFLAGS	+= -Wa,-march=armv8.4-a
+asm-arch := armv8.4-a
+endif
+
+ifdef asm-arch
+KBUILD_CFLAGS	+= -Wa,-march=$(asm-arch) \
+		   -DARM64_ASM_ARCH='"$(asm-arch)"'
 endif
 
 ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
index 51a7ce87cdfe..6fb2e6bcc392 100644
--- a/arch/arm64/include/asm/compiler.h
+++ b/arch/arm64/include/asm/compiler.h
@@ -2,6 +2,12 @@
 #ifndef __ASM_COMPILER_H
 #define __ASM_COMPILER_H
 
+#ifdef ARM64_ASM_ARCH
+#define ARM64_ASM_PREAMBLE ".arch " ARM64_ASM_ARCH "\n"
+#else
+#define ARM64_ASM_PREAMBLE
+#endif
+
 /*
  * The EL0/EL1 pointer bits used by a pointer authentication code.
  * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index d493174415db..cc3f5a33ff9c 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -28,14 +28,16 @@
  * not. The macros handles invoking the asm with or without the
  * register argument as appropriate.
  */
-#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
+#define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE			       \
+			       "tlbi " #op "\n"				       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op,	       \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
 			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
 			    : : )
 
-#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
+#define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
+			       "tlbi " #op ", %0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
 			       "dsb ish\n		tlbi " #op ", %0",     \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \

Sami
