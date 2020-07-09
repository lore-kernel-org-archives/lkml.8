Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15029C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E691820774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0JZ5pO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGIWGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgGIWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:06:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE7C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 15:06:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so1368067pld.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8CK0I8zJbGlH0rJDFXmQvv5rpjqRFDp888sWR1bVovw=;
        b=s0JZ5pO/GZ7fXyqQDzDmx8kuDguwspLqorvrH+OdYjBFl/uCF0Be7BpE7WGfgBRcen
         4Htj9cQoZMRn4Z3ToPS9QIEmkfghneRkevOktoFcG7CLk7KCwN8ZyJsceZArCZZB7TBu
         IGhyyBu38L+7+mARgarW6v6rqsVnMQKlVY45ClkQpAPr/4D5jgxo9kTmKcVSn9RTkkYL
         eMsOxA2kaMLQ5LTNrvMTzqstPrtXoLW2AAoozhtuV31v0esflicl6y61CUlNWmJc1oxj
         Zt/saYZAe1nU4NqGrqLWw5l2dmiBQix+rIP2lxS/8JIODBlTgY7VEUtpa0VT92815QnE
         1+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8CK0I8zJbGlH0rJDFXmQvv5rpjqRFDp888sWR1bVovw=;
        b=UqR7Fd1129DKuX2vGyt37jSx6uNvLBXHl8SOiXWGeD0NjBoIBn0wkLZtN222EWrS/1
         e8V0rqBWgHCVVVHrbMRguwzzHa8f3wR/WJX9Qe5cjVeMBT3hno6vRgQLOIx9d9Eggcpp
         WqXjRU7l2MwVkT4lS2tEdb//KIKyCNGAGZnS4VTIPSIzhBrtZvrxSPoWOj++Iz9FOVZj
         UONWPFbsK0YKetAn7CrgtOFC4znjRuJTzsr8fRr5erOeoi8aK+2o9el0DqBbF+Y4l9zB
         hCVDClziYHHJ3QOQBV6+S0XjJ3MMv2Lbd8QcDtLguOHDFyduc4CXGMpUPMxDgn5XdLe9
         RDxg==
X-Gm-Message-State: AOAM531CLBdrrYeBzSTamz3sU7+0LSsSv93Bp/Z26nLgZyyxjvc4kJP8
        HMR3KEgoT1HjwIT6gX7OBqv2VQ==
X-Google-Smtp-Source: ABdhPJyR7Siu7Y/A4iQg3bBo7ftXxCV5V8bWZODguKGhUXjoYZ4xnZ1Kn21deuob8QYmEuB9LYfIOw==
X-Received: by 2002:a17:90a:2367:: with SMTP id f94mr2400859pje.20.1594332403444;
        Thu, 09 Jul 2020 15:06:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q20sm3875614pfn.111.2020.07.09.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:06:42 -0700 (PDT)
Date:   Thu, 09 Jul 2020 15:06:42 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 14:48:00 PDT (-0700)
Subject:     Re: [PATCH V2 0/3] riscv: Enable LOCKDEP
In-Reply-To: <1593266228-61125-1-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, tycho@tycho.ws, nickhu@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-af022fcc-7dce-4d1b-9204-d31241538412@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 06:57:05 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Lockdep is needed by proving the spinlocks and rwlocks. To support it,
> we need to add TRACE_IRQFLAGS codes in kernel/entry.S. These patches
> follow Documentation/irqflags-tracing.txt.
>
> Fixup 2 bugs that block the lockdep implementation.
>
> ---
> Changes in v2
>  - Remove sX regs recovery codes which are unnecessary, because
>    callee will handle them. Thx Greentime :)
>
>  - Move "restore a0 - a7" to handle_syscall, but if _TIF_SYSCALL_WORK
>    is set, "restore a1 - a7" is still duplicated. I prefer a C wrapper
>    for syscall.
>
> Guo Ren (2):
>   riscv: Fixup static_obj() fail
>   riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
>
> Zong Li (1):
>   riscv: Fixup lockdep_assert_held with wrong param cpu_running
>
>  arch/riscv/Kconfig              |  3 +++
>  arch/riscv/kernel/entry.S       | 33 ++++++++++++++++++++++++++++++++-
>  arch/riscv/kernel/smpboot.c     |  1 -
>  arch/riscv/kernel/vmlinux.lds.S |  2 +-
>  4 files changed, 36 insertions(+), 3 deletions(-)

These are on for-next.  As far as I can tell lockdep is working, but I'm just
doing some simple boot tests.

Thanks!
