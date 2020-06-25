Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4393206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e9HsILcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406298AbgFYQcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406180AbgFYQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:32:20 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5F6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:32:20 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so3472952pjc.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d+K5u9P3ZstJbh0afCn3t6yP6SQdou+jClfehHgXvl0=;
        b=e9HsILcRH/pogv3ijUVs+4/J/zhRS+a9VPMnmgkqWLI/Wu+FCS7PTwh5XhntUipUaZ
         muZUSvBlz8dSrHWLaOfujK6bPtWafyVrJrYxCM+8aIqsvZMDHI4diUYrrDb5i8alZCZv
         FGSLp58yBCU8OXO+v0yG+cNH7ms+B6+uw/PkylgoreBkytLJlPBRhTMD2hPnOaaT3ysC
         RTHlZYauCqEXG4Xu1y7CSuugLAx/j0aOeMMyiFhjvtB1xaC7BmjmSMEDEfp63D5/gfyP
         idDddczzLeppEbtrkDgp3NRlTH+ZJFsMhpHwzwzlM2Mlvye8SnIf9DDcPZHa0GrBXwhV
         fcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d+K5u9P3ZstJbh0afCn3t6yP6SQdou+jClfehHgXvl0=;
        b=Z6W03W9PQaV1mCrpFKaOvHbc7oo3KphuIx2SplIWX5cfqNqn/a7gjtldh2a0uIXDRv
         FhxNCCdeDpEjeWxHZvshKPSXPUJFcTCPoveyHcDNJIPYGNsFgfwNij4PU1R/FIDMWKj7
         +PFubRTqyY2sNrXwWZdwPWkOAH3v/vrVBl30MUQah61QIz1moPKNx0o4CVJpZIIxJ6b2
         GynkoXLF04gsfbK4UfYTNEeLt8NEU2rQxhYEtEla53NBMnycj2mxFsm0kHJ3yzDHcsNH
         yyvozsaEEW+yVSPk6b1kamY5+4Hvm2Oi9yu7Y/eNrF6xkHYHolyPirMAlem69HQvoyou
         i1Zg==
X-Gm-Message-State: AOAM530B+yJQ5+L9fnYlQwzU4DnPW9Q3q6IFV5YiM/6GjforFp4tXHbc
        JD7LHCgbEGnr6C5LU/af6Jwo6OXlNNCOp8Ysai/XVQ==
X-Google-Smtp-Source: ABdhPJytwmdVQWB9BByogkA6BvCJzw6QJUuG4tFembUiKOQGqpiuUYMBGeeEJXdh18HpVLsrJpSQy4yk5BXZNon+nw0=
X-Received: by 2002:a17:902:b698:: with SMTP id c24mr32946349pls.223.1593102739486;
 Thu, 25 Jun 2020 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200624035920.835571-1-natechancellor@gmail.com> <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org>
In-Reply-To: <1bbb6956-d9de-e0c8-5b45-20b6fecc2189@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Jun 2020 09:32:07 -0700
Message-ID: <CAKwvOd=5nE6fkwp8iw0JqwQFp5KcUaC7RyEf2L6+tkbp9smsvg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/boot: Use address-of operator on section symbols
To:     Geoff Levand <geoff@infradead.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:19 PM Geoff Levand <geoff@infradead.org> wrote:
>
> Hi Nathan,
>
> On 6/23/20 8:59 PM, Nathan Chancellor wrote:
> > These are not true arrays, they are linker defined symbols, which are
> > just addresses.  Using the address of operator silences the warning
> > and does not change the resulting assembly with either clang/ld.lld
> > or gcc/ld (tested with diff + objdump -Dr).
>
> Thanks for your patch.  I tested this patch applied to v5.8-rc2 on a
> PS3 and it seems OK.

PS3?  Folks still have ones that can boot Linux?  Those ****ers took
my Yellow Dog Linux away from me; I enjoyed depositing that settlement
check!  Hopefully by now, folks have figured out how to roll back the
system firmware?

>
> Tested-by: Geoff Levand <geoff@infradead.org>
>
>
> --

-- 
Thanks,
~Nick Desaulniers
