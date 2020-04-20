Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B35BC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CEB5206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="poQyuPWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgDTS1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDTS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:27:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:27:42 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id g30so5357439pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=3j7I+GwBPTWoE/gepMWkNd8iIKlyP+O5Cvl6ddDtBIE=;
        b=poQyuPWbKffKCW0Q6nE3FUGjjj9O/c5xdGoYcp6Es73N4nBCmfEhbhBe9jR2mPg6Yt
         eZc8KCC3HNbKl6zWcLIWEBbW5fhYpWz5Tx3EoUtDDDWtr0sils+CHfTYihCyub8miFXp
         DPAkJSzeD/1MHdDblb7jequuMEp03aKqh6jLw5bvOFt6Wipo6KxdUpIFzTREmLR5rkGE
         Q40qX3K/Npci9Q3C5tWYBV7tywXIWei2BqN+55DoPd/dI/bYFqn4yECk6iYdWV3GCEHF
         vLq39hy0+y3aEEuJRCQEQ4KKMmPFSo/au3pJv9k4CoSJVMxlxRjuF6q0umQFRScR23p1
         JeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=3j7I+GwBPTWoE/gepMWkNd8iIKlyP+O5Cvl6ddDtBIE=;
        b=CTijmXteh8vlbyGu8TYk4nD0k/Gcyb+YKzudZkA6Q5S9RHQqUxhlLrcMev344STgj5
         PdaTWFSUCZr+FxfbK/TYT4Q6zsRjWG9U72ZCH6NrFxwgIqwZq+q2ikD4XZbUZziW7Bz8
         p9aFnrFaIu4ZPlBQtYMoKoQvAMJ2Mam4qlbIbf96IVvDnSdXdxE1XeQrjHbXKcsqFjY4
         JwP1/gwFzykCG/zIaMn9i4BkA+mzKRm8srXFhPutXvwkK26sdrB2fHZ39JRzdh9+ZzUn
         onCahJ8jpnpdgUj/WInJ/UcmMuwANfBssCurkC3UM8oMP8mVGxlNT+WHGMDPntUi7jo1
         PziQ==
X-Gm-Message-State: AGi0PuY1Wp8GvLb1Q7fEndfryr3W4MajqIoMcbXquAczSz7jbyEcBQUa
        bQSm8dYc0yKECnDBwGggQ+wqRg==
X-Google-Smtp-Source: APiQypLv50XPkHoI7VnUU30/Sn6iEsoPmL7NIe1/tSUt4S/CGGJSca5v0TQ7gj9mPAYJYoPVl9vRNw==
X-Received: by 2002:a63:62c1:: with SMTP id w184mr16558626pgb.296.1587407262240;
        Mon, 20 Apr 2020 11:27:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id j7sm61576pjy.9.2020.04.20.11.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:27:40 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:27:40 -0700 (PDT)
X-Google-Original-Date: Mon, 20 Apr 2020 11:23:07 PDT (-0700)
Subject:     Re: [PATCH v5 0/9] Support strict kernel memory permissions for security
In-Reply-To: <cover.1586332296.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-103aea95-cf25-47c5-8e8d-56534f40c570@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020 00:56:55 PDT (-0700), zong.li@sifive.com wrote:
> The main purpose of this patch series is changing the kernel mapping permission
> , make sure that code is not writeable, data is not executable, and read-only
> data is neither writable nor executable.
>
> This patch series also supports the relevant implementations such as
> ARCH_HAS_SET_MEMORY, ARCH_HAS_SET_DIRECT_MAP,
> ARCH_SUPPORTS_DEBUG_PAGEALLOC and DEBUG_WX.
>
> Changes in v5:
>  - Add lockdep_assert_held and more comments for text_mutex.
>
> Changes in v4:
>  - Use NOKPROBE_SYMBOL instead of __kprobe annotation
>  - Use text_mutex instead of patch_lock
>  - Remove 'riscv_' prefix of function name
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
>   riscv: add macro to get instruction length
>   riscv: introduce interfaces to patch kernel code
>   riscv: patch code by fixmap mapping
>   riscv: add ARCH_HAS_SET_MEMORY support
>   riscv: add ARCH_HAS_SET_DIRECT_MAP support
>   riscv: add ARCH_SUPPORTS_DEBUG_PAGEALLOC support
>   riscv: move exception table immediately after RO_DATA
>   riscv: add alignment for text, rodata and data sections
>   riscv: add STRICT_KERNEL_RWX support
>
>  arch/riscv/Kconfig                  |   6 +
>  arch/riscv/include/asm/bug.h        |   8 ++
>  arch/riscv/include/asm/fixmap.h     |   2 +
>  arch/riscv/include/asm/patch.h      |  12 ++
>  arch/riscv/include/asm/set_memory.h |  48 +++++++
>  arch/riscv/kernel/Makefile          |   4 +-
>  arch/riscv/kernel/ftrace.c          |  26 ++--
>  arch/riscv/kernel/patch.c           | 128 +++++++++++++++++++
>  arch/riscv/kernel/traps.c           |   3 +-
>  arch/riscv/kernel/vmlinux.lds.S     |  11 +-
>  arch/riscv/mm/Makefile              |   2 +-
>  arch/riscv/mm/init.c                |  44 +++++++
>  arch/riscv/mm/pageattr.c            | 187 ++++++++++++++++++++++++++++
>  13 files changed, 466 insertions(+), 15 deletions(-)
>  create mode 100644 arch/riscv/include/asm/patch.h
>  create mode 100644 arch/riscv/include/asm/set_memory.h
>  create mode 100644 arch/riscv/kernel/patch.c
>  create mode 100644 arch/riscv/mm/pageattr.c

Looks like there are quite a few conflicts here.  Do you mind re-spinning the
patch set for me?  It's a bit early to spin off for-next right now so there
might be some more conflicts, but hopefully not too many.

Thanks!
