Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A10C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBBD2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579642641;
	bh=QUWe9/OSXq14AlqO6CWHOBGaFF36ubPUSiw4lGfTBLI=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=IRN4vk1YolUpPetOMGhuwI04pFQpbxKnhCPStFqv6UOQdd0BqKhe6LK8msQnlWI5C
	 FXmhelo6Ex6U9L2WzPp/P+EyD/IBHGdTjFcOfl1koXPLaQHDmDrpmCGsxd5L9Y5bZa
	 sVTNq08iFk1PEZbHbCSlK4d0hG5Nncxx9MDcmhuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgAUVhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 16:37:20 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36178 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbgAUVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 16:37:20 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so2262435pjb.1;
        Tue, 21 Jan 2020 13:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=PwqtkEgxr4YZPsm04tb22IQNHlC+pPCtuqRKSuGvfTs=;
        b=U6CHXRs3Vwu2iQUbpN9tym4gsaU6BoRxACxBSx6LTuaiHmGhsn24SZyaCGqWzNR3pr
         H7z3fwbD/XJqJmh3SgbFKwiMcrLM+jnxO80qnQMnuxqvR8w0p4tTPFsBTjQ4YevMgXaP
         XC0ibc4HnS90kImhPG7oCtdq2WAlf5d5M02Sn0NCARj0YtE0ABq0PrCYHzQ+zR1uovRk
         o7Iq3yVf2lEnr4YDcnzBmOn075EFVqIZBWASrBm+0fR4SrbJZY5wolfgKCyh74sm2mEz
         n7URnI5leI2RdfiMl+VcUaGNA5d1w3v03AVjSLyk3BTDtJswwGTMkCl71VPuWDi03hzk
         ZvdQ==
X-Gm-Message-State: APjAAAWs1Z+C4py3dy2MDsdFa/XpR6hW52UqSwQHRywnW3+CER6LqBhh
        jUy7jWSp8BDpwjjHS6MEUuA=
X-Google-Smtp-Source: APXvYqwUT722uG1/KO2UrZ1qw5g5VBi0Eth40HOt628WFPBSNGURS3s3CITlb4ao5vkIup4flmWOqA==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr7604268plp.134.1579642639598;
        Tue, 21 Jan 2020 13:37:19 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id gc1sm372130pjb.20.2020.01.21.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 13:37:18 -0800 (PST)
Message-ID: <5e276f0e.1c69fb81.7e73d.180a@mx.google.com>
Date:   Tue, 21 Jan 2020 13:37:17 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Alexander Lobakin <alobakin@dlink.ru>
CC:     Paul Burton <paulburton@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Lobakin <alobakin@dlink.ru>,
        linux-mips@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH mips-fixes 0/3] MIPS: a set of tiny Kbuild fixes
References:  <20200117140209.17672-1-alobakin@dlink.ru>
In-Reply-To:  <20200117140209.17672-1-alobakin@dlink.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Alexander Lobakin wrote:
> These three fix two command output messages and a typo which leads
> to constant rebuild of vmlinux.lzma.its and all dependants on every
> make invocation.
> Nothing critical, and can be backported without manual intervention.
> 
> Alexander Lobakin (3):
>   MIPS: fix indentation of the 'RELOCS' message
>   MIPS: boot: fix typo in 'vmlinux.lzma.its' target
>   MIPS: syscalls: fix indentation of the 'SYSNR' message
> 
>  arch/mips/Makefile.postlink        | 2 +-
>  arch/mips/boot/Makefile            | 2 +-
>  arch/mips/kernel/syscalls/Makefile | 2 +-

Series applied to mips-next.

> MIPS: fix indentation of the 'RELOCS' message
>   commit a53998802e17
>   https://git.kernel.org/mips/c/a53998802e17
>   
>   Fixes: 44079d3509ae ("MIPS: Use Makefile.postlink to insert relocations into vmlinux")
>   Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>   [paulburton@kernel.org: Fixup commit references in commit message.]
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> MIPS: boot: fix typo in 'vmlinux.lzma.its' target
>   commit 16202c09577f
>   https://git.kernel.org/mips/c/16202c09577f
>   
>   Fixes: 92b34a976348 ("MIPS: boot: add missing targets for vmlinux.*.its")
>   Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>   [paulburton@kernel.org: s/invokation/invocation/]
>   Signed-off-by: Paul Burton <paulburton@kernel.org>
> 
> MIPS: syscalls: fix indentation of the 'SYSNR' message
>   commit 4f29ad200f7b
>   https://git.kernel.org/mips/c/4f29ad200f7b
>   
>   Fixes: 9bcbf97c6293 ("mips: add system call table generation support")
>   Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
>   Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
