Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECC2C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BDB2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KXYKfEgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgDXFSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726010AbgDXFSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:18:40 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4F2C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:18:38 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s10so3344928plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3r14pcehiaeg8c1gluTkCirQUS8K8VVYGROm4MkK5QA=;
        b=KXYKfEgTQ5EXwwxLG9RmNvkLorOAuifOFP0Jo1PgS5JnsroGJXe/LJAPJPldzixlCa
         faXS7RdX0YZR48AC6vPh1sRq0u+eObGgO4vP0f9XVQQrLQlKyjuGE7zXtQik8saY+wlf
         aTrtJnICVWUs6vOyllLus5BTR1ucdgOiv7hOPPan24x+aYWm7SzTT41lp1GqhfD4O7nS
         nglU+d2i184PfZoDWSjIE5MaSJHL4Wfgq1iFLondc4kXVsgH3OwLhfm4xt4r90nyJ1gF
         QEupp5ir1XYw6uDIhVXLPpO6SfndGHR0VKoPWU/uzLQDbHri0/i9eDSctPUrxxp8bRW0
         AWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3r14pcehiaeg8c1gluTkCirQUS8K8VVYGROm4MkK5QA=;
        b=Eo3lu3AVelgcE7OlRYnaIMoUVgclzPYbrpuOdoMRE/McW7QkcYYUlqc55yNcB3YVEq
         YeVSfGRy0jczEzXHmbqSWwQFOg8MkmYaGHu/tkTfd7uddy8EfUVAsJ3r+RoedtQVHz49
         4DmrtgS+I4OJ3dbUM681zxsnIAqdHPtxlSLYaXS6rE3Qwomnnjre4X93jKxqONKUlqQe
         31g6PBSBKUCofOog0E7hMj8JKA3DQOkuHGlbgF/8VvAMPfySaAwRAW4GqQwoN3FRkq9y
         05CkaFHsZPbvJWFSNEGrL3xTsJ1vbIB74bC2R0hf948KAL9LKhma23E/XMKc8D3t+QtY
         Bh6w==
X-Gm-Message-State: AGi0Pubx77eReRdqhc2ZLKkaOYbST2dHgKrDWLsL9q0e0EzNvYlrutAs
        U5LVvDb+N+yz2oqLT4gj1h+3VQ==
X-Google-Smtp-Source: APiQypJmeqdjpGlNZTdkR2FhNfmpZ8PyKVQ6oDgs+pl+1mGkPWQU3Rmw7WEgVf6VY7UtjKD6ng63oA==
X-Received: by 2002:a17:90a:8d02:: with SMTP id c2mr4424414pjo.113.1587705517818;
        Thu, 23 Apr 2020 22:18:37 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id c84sm4662673pfb.153.2020.04.23.22.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 22:18:36 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:18:33 -0700
From:   Fangrui Song <maskray@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [RFC PATCH 1/2] kbuild: add CONFIG_LD_IS_BINUTILS
Message-ID: <20200424051833.4om5dzimpnvegeab@google.com>
References: <20200419131947.173685-1-sedat.dilek@gmail.com>
 <CAKwvOd=Rt0q0+nRJasc8GzOXSj1_-jZGNc2bAWJkmd7Vzr8FFw@mail.gmail.com>
 <CAK7LNAQzh8EajBkXSSgFh2=5iF38XvkADf1C7J0JnwTov=NmNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAQzh8EajBkXSSgFh2=5iF38XvkADf1C7J0JnwTov=NmNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-24, Masahiro Yamada wrote:
>On Fri, Apr 24, 2020 at 3:44 AM Nick Desaulniers
><ndesaulniers@google.com> wrote:
>>
>> On Sun, Apr 19, 2020 at 6:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> >
>> > This patch is currently not mandatory but a prerequisites for the second one.
>> >
>> > Folks from ClangBuiltLinux project like the combination of Clang compiler
>> > and LLD linker from LLVM project to build their Linux kernels.
>> >
>> > Sami Tolvanen <samitolvanen@google.com> has a patch for using LD_IS_LLD (see [1]).
>> >
>> > Documentation/process/changes.rst says and uses "binutils" that's why I called
>> > it LD_IS_BINUTILS (see [2] and [3]).
>> >
>> > The second patch will rename existing LD_VERSION to BINUTILS_VERSION to have
>> > a consistent naming convention like:
>> >
>> > 1. CC_IS_GCC and GCC_VERSION
>> > 2. CC_IS_CLANG and CLANG_VERSION
>> > 3. LD_IS_BINUTILS and BINUTILS_VERSION
>> >
>> > [1] https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46
>> > [2] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n34
>> > [3] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n76
>> >
>> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
>>
>> Just some background on Sami's patch.  Originally we were using
>> ld.gold (for LTO for Pixel 3) before moving to ld.lld (for LTO for
>> Pixel 4 and later).  Not sure if Kconfig would be a better place to
>> check if gold is used, then warn?  I kind of prefer the distinction
>> that binutils contains two different linkers, though if no one is
>> supporting ld.gold, and it doesn't work for the kernel, then maybe
>> that preference is moot?
>
>
>I prefer LD_IS_BFD, like this patch:
>https://lore.kernel.org/patchwork/patch/1039719/
>
>We do not need LD_IS_GOLD, though.
>
>-- 
>Best Regards
>Masahiro Yamada

+1 for CONFIG_LD_IS_BFD

Usually GNU ld is also installed as ld.bfd and can be referred to by -fuse-ld=bfd (GCC >= 9, or clang)

The repository binutils-gdb includes two linkers: GNU ld and GNU gold, so CONFIG_LD_IS_BINUTILS would be ambiguous.
