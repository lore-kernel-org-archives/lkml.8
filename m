Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C114C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8B3120781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3Weqppl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHLT4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgHLT4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:56:37 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF7C061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:56:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 77so3213768qkm.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWaTeN8Ytl2katk+bZVElXkZxt9E6gO+CzcMFpZntSQ=;
        b=m3WeqpplCCpS0xJJWpLWDAQaigUOSDmVuwIm36QQ9zskb15CkeTK+NRNRxkXXSsJSf
         dAJN7VDaKTJYy47Xry5yjydZN1p2kNS0t0KfkLu0zsAUC+6aJSn4PcjcrocXeQsNKari
         blt//CydgIt4FzJ6yaqeN+nAVwv22VgLCiVi3km7A/didrMaOWiNSDHNq0nomwupZC0r
         ApbixQkEQJaPw7Jq9otRQSZC/Gjaxn6yerB/i+Fl5pqfZ+Tm9DZp8y429mk/yIEo1j0i
         zy79HPlk+i69PZRJtanKvVUOM/TFusVGRM+2stVzrxz7kn4Ew5I7rrkInK+GLlxL+9/C
         555w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWaTeN8Ytl2katk+bZVElXkZxt9E6gO+CzcMFpZntSQ=;
        b=cYEAkF8qXs8HmekZHlmDNRYJEUUHPujJspQsukTmig+hs1mfhBdcfX+vyMU9vywqAy
         wN3hVE2ITHJ9G4WRRTb1kRXCYrNxNGIpQhaP06SDTui1RIHMUqKgBJNvVJ4zkD3tlCMl
         wJkXFA0xVRW0IaT2w4Hh/AtEVKerB/eMSYK79IDr3T/YDA9qjnK4/ftaEtAaFwO/MDj5
         R8EMPDVp2gEboOW5ka0HNHQMUtiEmiv3Lj/cN4Su2jwmmkR0q1LSsdWRkrbfuQWIQ7MO
         VTvjfzKfjVFlHbqFzNUP7dPB0NUCP+9FV2VWJeiAGURyj+PpF3K8vX/ESezY3eZjcRUx
         MYig==
X-Gm-Message-State: AOAM532hXVDCe37jPhbdgIQWWqoIs+JZhQ47NaDmjoz4+0w4dd3PElZ7
        i/x/NhuYFoZuEATUoNmP+zNxq3vwHHzn7UGW2Z4ftA==
X-Google-Smtp-Source: ABdhPJxlNv49vjfthdqybFz6I4TmdrQxha3I6eHrJTK2H7Ds+fA0zXBQ1K47l/wZU1TZghoJCdQ7loXB/gPs6JzVpII=
X-Received: by 2002:a37:a354:: with SMTP id m81mr1537714qke.277.1597262196294;
 Wed, 12 Aug 2020 12:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200812173958.2307251-1-masahiroy@kernel.org>
In-Reply-To: <20200812173958.2307251-1-masahiroy@kernel.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 12 Aug 2020 14:56:24 -0500
Message-ID: <CAJkfWY6vhW9kNK-t+2vZQ7Rhn3HedykvT2du7AfO0_9oUAXvjw@mail.gmail.com>
Subject: Re: [PATCH 0/3] kbuild: clang-tidy
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Roeder <tmroeder@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Rob Herring <robh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 12:40 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>
> I improved gen_compile_commands.py in the first two patches,
> then rebased Nathan's v7 [1] on top of them.
> To save time, I modified the Makefile part.
> No change for run-clang-tools.py
>
> I am not sure if the new directory, scripts/clang-tools/,
> is worth creating only for 2 files, but I do not have
> a strong opinion about it.
>
> "make clang-tidy" should work in-tree build,
> out-of-tree build (O=), and external module build (M=).
> Tests and reviews are appreciated.
>
> "make clang-tidy" worked for me.
>
> masahiro@oscar:~/workspace/linux-kbuild$ make -j24 CC=clang clang-tidy
>   DESCEND  objtool
>   CALL    scripts/atomic/check-atomics.sh
>   CALL    scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   GEN     compile_commands.json
>   CHECK   compile_commands.json
>
> But "make clang-analyzer" just sprinkled the following error:
>
>   Error: no checks enabled.
>   USAGE: clang-tidy [options] <source0> [... <sourceN>]
>
> I built clang-tidy from the latest source.
> I had no idea how to make it work...

How are you building clang-tidy? The clang static-analyzer may not
have been built.
I believe the static analyzer is built as a part of clang, not as a
part of clang-tools-extra.

I use this command to build.
cmake -DCMAKE_BUILD_TYPE="release"
-DLLVM_TARGETS_TO_BUILD="X86;AArch64;ARM;RISCV"
-DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld;llvm-as"
-DLLVM_ENABLE_LLD=1 -G "Ninja" ../llvm

Adding clang to the list of -DLLVM_ENABLE_PROJECTS will build the
static analyzer.
-DCLANG_ENABLE_STATIC_ANALYZER=1 might also work, but I haven't tested it.

I tested the patchset and both clang-tidy and clang-analyzer work for me.

>
> [1] https://patchwork.kernel.org/patch/11687833/
>
>
>
> Masahiro Yamada (2):
>   gen_compile_commands: parse only the first line of .*.cmd files
>   gen_compile_commands: wire up build rule to Makefile
>
> Nathan Huckleberry (1):
>   Makefile: Add clang-tidy and static analyzer support to makefile
>
>  MAINTAINERS                                 |   1 +
>  Makefile                                    |  45 +++++-
>  scripts/clang-tools/gen_compile_commands.py | 117 +++++++++++++++
>  scripts/clang-tools/run-clang-tools.py      |  74 ++++++++++
>  scripts/gen_compile_commands.py             | 151 --------------------
>  5 files changed, 233 insertions(+), 155 deletions(-)
>  create mode 100755 scripts/clang-tools/gen_compile_commands.py
>  create mode 100755 scripts/clang-tools/run-clang-tools.py
>  delete mode 100755 scripts/gen_compile_commands.py
>
> --
> 2.25.1
>
