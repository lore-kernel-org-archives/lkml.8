Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C65DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D097220781
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585661580;
	bh=xjsNuevst2hdoei+2YBbw5AgZ2uz8egnJHzxF30a8nE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KwgNFYmqY4JNeXX2VN7ig2bcGm/fJpBTzY6y6C6A0Oj4L0P7CZ0C+Du9WMvgtYAnB
	 xP/A94cn3mx6X2nePPyVEKLOlQlPhdtO9y/Epf7U54sFrrT8KcUl7XBCV66WidYsCb
	 AzewGVD04lzxbcblsJPfNqIPgA2FFezHXvi+5kTo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbgCaNc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730216AbgCaNc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:32:59 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A652071A;
        Tue, 31 Mar 2020 13:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585661578;
        bh=xjsNuevst2hdoei+2YBbw5AgZ2uz8egnJHzxF30a8nE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AKHoXwoa7Zff+4XX9H7YktH1P5TqfcvSPOjj3q5b12fvv7S5USQRJJavhLGvPoq1r
         v2jq3btdOo7/KW9kO57RD6C7jxevyGTT5TsbRizoP7pFIC44Pi0ZZUz11qzo34gefh
         WUZq/LzvwaNl+ty9qjxc3W99SMtO0ucdw+uQt5KQ=
Date:   Tue, 31 Mar 2020 22:32:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Zong Li <zong.li@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/9] Support strict kernel memory permissions for
 security
Message-Id: <20200331223254.919b92750962fefed5a6646f@kernel.org>
In-Reply-To: <cover.1583772574.git.zong.li@sifive.com>
References: <cover.1583772574.git.zong.li@sifive.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zong,

On Tue, 10 Mar 2020 00:55:35 +0800
Zong Li <zong.li@sifive.com> wrote:

> The main purpose of this patch series is changing the kernel mapping permission
> , make sure that code is not writeable, data is not executable, and read-only
> data is neither writable nor executable.
> 
> This patch series also supports the relevant implementations such as
> ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.

The order of the patches seems a bit strange. Since the first 7 patches
makes kernel read-only, at that point ftrace is broken and it is fixed
by the last 2 patches. That is not bisect-friendly. Can you move the
last 2 patches to the top?

Thank you,

> 
> Changes in v3:
>  - Fix build error on nommu configuration. We already support nommu on
>    RISC-V, so we should consider nommu case and test not only rv32/64,
>    but also nommu.
> 
> Changes in v2:
>  - Use _data to specify the start of data section with write permission.
>  - Change ftrace patch text implementaion.
>  - Separate DEBUG_WX patch to another patchset.
> 
> Zong Li (9):
>   riscv: add ARCH_HAS_SET_MEMORY support
>   riscv: add ARCH_HAS_SET_DIRECT_MAP support
>   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
>   riscv: move exception table immediately after RO_DATA
>   riscv: add alignment for text, rodata and data sections
>   riscv: add STRICT_KERNEL_RWX support
>   riscv: add macro to get instruction length
>   riscv: introduce interfaces to patch kernel code
>   riscv: patch code by fixmap mapping
> 
>  arch/riscv/Kconfig                  |   6 +
>  arch/riscv/include/asm/bug.h        |   8 ++
>  arch/riscv/include/asm/fixmap.h     |   2 +
>  arch/riscv/include/asm/patch.h      |  12 ++
>  arch/riscv/include/asm/set_memory.h |  48 +++++++
>  arch/riscv/kernel/Makefile          |   4 +-
>  arch/riscv/kernel/ftrace.c          |  13 +-
>  arch/riscv/kernel/patch.c           | 120 ++++++++++++++++++
>  arch/riscv/kernel/traps.c           |   3 +-
>  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
>  arch/riscv/mm/Makefile              |   2 +-
>  arch/riscv/mm/init.c                |  44 +++++++
>  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
>  13 files changed, 445 insertions(+), 15 deletions(-)
>  create mode 100644 arch/riscv/include/asm/patch.h
>  create mode 100644 arch/riscv/include/asm/set_memory.h
>  create mode 100644 arch/riscv/kernel/patch.c
>  create mode 100644 arch/riscv/mm/pageattr.c
> 
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
