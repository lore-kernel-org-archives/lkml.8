Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F4A20FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 21:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iS5qr4j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgFQV1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 17:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbgFQV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 17:27:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C98C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:27:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t7so1911269pgt.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 14:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2nweBLFqBZAQdpGCmNWKSAsTxcg83keuNMEngTx9xf4=;
        b=iS5qr4j2jYfHzGGbhesyIJUTnsGRa9IuN+Jl4fPLDGmN8Gke6H88DdYjKDHwrWfEf1
         /juIa85YnrqZffvIfhiCjYqxxxAIkDfxVWShz0uKUrVPf/7IsN76HMeksxs//UhpzeGK
         TmNk1sEkVyNbwZ4I2Sqdw7gfzZLCpugvbg4r0zmyFHpo869eLEJeZyWSPsqT8yv0K96r
         w9zTU5DHZj70u+cUsqzcVJx3Bc3SZYG/SBfcndzrRQhv6CuMwHA9NhaI8lss21I1BOgV
         RJw0PmOazu4zptp4cPhneUrJXlLBGHLgvAQLt5xApO6v/359aVgyNfiQDi39AXVKNSWW
         LZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2nweBLFqBZAQdpGCmNWKSAsTxcg83keuNMEngTx9xf4=;
        b=tJsnxVBKiaghGhoVEhbObt5reFVkQvdyg9QWIjG+7WinQMNZgP3n0fZfAWGHUb1lkw
         HSAWPwr5bFd0po16c4l0MaTbaZ+Ua17Bpgogt4ierdZ39d92wZsjJppAYxrraq9jwH17
         8/cJGhiAnU8rJ4PrvUXmybTVvb9a4SSFxZzQS0Sd+KwRxX0W9lN6JRalBClIP9x8YiWj
         ZgFiWV+MYQLQUf8GzaecCs+StQZ/XiGbwBGF1zrvY44/JfaQ2ZwRV3661N933WXYftxM
         nMUyykAhgsVZ/9aaGwfikSgNSFiaCNq9DsiALrkW/qPwZdaUwuCgIHdG/igZWHiKZd56
         EEaQ==
X-Gm-Message-State: AOAM53022eKojfoK1azStqb7SVyryf4UXaHmqoYW/WEDowkJKRS+6k3O
        c9SQO4heb8uO0tptXQBvKsyHbg==
X-Google-Smtp-Source: ABdhPJxYyUBYE6IphPAEyvDdCsWndemGsGv25bBXi+wuKSeSYT+KvkLCOsnLwdE99qal0DA1+G+XFg==
X-Received: by 2002:a63:5307:: with SMTP id h7mr702582pgb.28.1592429228594;
        Wed, 17 Jun 2020 14:27:08 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id m4sm644574pgp.32.2020.06.17.14.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 14:27:07 -0700 (PDT)
Date:   Wed, 17 Jun 2020 14:27:05 -0700
From:   =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of
 .text too
Message-ID: <20200617212705.tq2q6bi446gydymo@google.com>
References: <20200617210613.95432-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617210613.95432-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-06-17, Nick Desaulniers wrote:
>ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
>be part of .text, as well as .text.unlikely and .text.unlikely.*.

>ld.lld will produce .text.hot.*/.text.unlikely.* sections.

Correction to this sentence. lld is not relevant here.

-ffunction-sections combined with profile-guided optimization can
produce .text.hot.* .text.unlikely.* sections.  Newer clang may produce
.text.hot. .text.unlikely. (without suffix, but with a trailing dot)
when -fno-unique-section-names is specified, as an optimization to make
.strtab smaller.

We've already seen that GCC can place main in .text.startup without
-ffunction-sections. There may be other non -ffunction-sections cases
for .text.hot.* or .text.unlikely.*. So it is definitely a good idea to
be more specific even if we don't care about -ffunction-sections for
now.

>Make sure to group these together.  Otherwise these orphan sections may
>be placed outside of the the _stext/_etext boundaries.
>
>Cc: stable@vger.kernel.org
>Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
>Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
>Link: https://reviews.llvm.org/D79600
>Reported-by: Jian Cai <jiancai@google.com>
>Debugged-by: Luis Lozano <llozano@google.com>
>Suggested-by: Fāng-ruì Sòng <maskray@google.com>
>Tested-by: Luis Lozano <llozano@google.com>
>Tested-by: Manoj Gupta <manojgupta@google.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> include/asm-generic/vmlinux.lds.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index d7c7c7f36c4a..fe5aaef169e3 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -560,7 +560,9 @@
>  */
> #define TEXT_TEXT							\
> 		ALIGN_FUNCTION();					\
>-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
>+		*(.text.hot .text.hot.*)				\
>+		*(TEXT_MAIN .text.fixup)				\
>+		*(.text.unlikely .text.unlikely.*)			\
> 		NOINSTR_TEXT						\
> 		*(.text..refcount)					\
> 		*(.ref.text)						\
>-- 
>2.27.0.290.gba653c62da-goog
>
