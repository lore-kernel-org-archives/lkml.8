Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64F6C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE7824650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 03:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582775931;
	bh=m8KRML3npq2G+ZWM9UjEaYAbgafYW3jKje6WYayAnW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QCdhBnwuf9Cv5CVUnQUOlqzvGcyxYEiCoxzmQuGwIljHtiQF8YVZOt8G/o02SYn4h
	 8r0osnHTWRTRKc9MqbXYAcxFHXs+G+KtSMIP+qmzzDCH0a0g+FVgLP1JkTXB/TIMnm
	 /ysn7uJdqARCgr+TZL8F1GzBcVdr789tQ6DRCKbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgB0D6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 22:58:50 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:26156 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgB0D6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 22:58:50 -0500
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 01R3wf5t022684;
        Thu, 27 Feb 2020 12:58:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 01R3wf5t022684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582775922;
        bh=4uYESe3IX1A8M0n72AIHavcEeKHRwHUScqFhq3hkdVY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=phyVR1UaAWo7/HnwO++C5eSAeLXxOrjJmHxGPzfAYVqwNq0ivD87XYFPZePZjcjJ8
         6ao8D1X9IYOtyo/HQg+fb2EFPzhJ4lL++ipmHJz/7wXAw1NDmpQnbgx0Vz1VbgJY0q
         3WNqlHpEoE7y9AdFb5B6hogQf5JR7xzpcEdE0AujYMeHYSKhdnsK8nOStp32AD7L/i
         AsZaQF8gaWN13VKCVjhZYkGFXiYNNTHrt2qsmTzuBMHvYAjJjDzITVNXwPgqZqH0qz
         NhINRcp6YUGkLeL4egJtXSiY0pUfHJMia3LEUzoa3yqVkpJYc7cdMU7Nci+gvkdi7G
         tQ5MioAv4WMhA==
X-Nifty-SrcIP: [209.85.221.178]
Received: by mail-vk1-f178.google.com with SMTP id i78so359921vke.0;
        Wed, 26 Feb 2020 19:58:42 -0800 (PST)
X-Gm-Message-State: APjAAAVWRdYFIgvboO7C4aUQVCdbY1L6XhbIJKl/IqQLpVqU5BF8gdxi
        9TrOvt8LNkENhwWc1xZpfMZazV7KxZX4U7qlZU8=
X-Google-Smtp-Source: APXvYqzCoFfHbnxncVSSL5HnDHE8JA+wdwrnv98m0vSgkeCYMgbtsiJvb4E2/FRbHwBiEy1Megk3yox+VqkTHq4lKCs=
X-Received: by 2002:a1f:2f4c:: with SMTP id v73mr278752vkv.12.1582775920997;
 Wed, 26 Feb 2020 19:58:40 -0800 (PST)
MIME-Version: 1.0
References: <20200225210250.64366-1-ndesaulniers@google.com> <20200226232336.252872-1-ndesaulniers@google.com>
In-Reply-To: <20200226232336.252872-1-ndesaulniers@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 27 Feb 2020 12:58:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASGSWTO+MRAFg0XKvucSe0-y6-i0MiUoSLB4fMyFaLj0g@mail.gmail.com>
Message-ID: <CAK7LNASGSWTO+MRAFg0XKvucSe0-y6-i0MiUoSLB4fMyFaLj0g@mail.gmail.com>
Subject: Re: [PATCH v3] Documentation/llvm: add documentation on building w/ Clang/LLVM
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 8:23 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Added to kbuild documentation. Provides more official info on building
> kernels with Clang and LLVM than our wiki.
>
> Suggested-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V2 -> V3:
> * Drop Randy's Suggested-by tag. Sorry Randy, I do appreciate the review
>   though.
> * Add F: line to MAINTAINERS.
>
> Changes V1 -> V2:
> * s/On going/ongoing/
> * add Randy's Suggested-by
> * add Nathan and Sedat's Reviewed-by
> * Upgrade Kees' Sugguested-by to Reviewed-by
> * s/suffix/prefix/


Setting aside the minimal version discussion,
I am fine with this patch version.

I will apply it shortly.

Thanks.



-- 
Best Regards
Masahiro Yamada
