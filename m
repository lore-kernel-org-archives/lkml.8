Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CEFC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7D9020791
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 16:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598719736;
	bh=nX+JQR9DpT/+z2PqkacX5gzHhZ3MRE2mzN0FA/mMxYM=;
	h=From:Date:Subject:To:List-ID:From;
	b=yVc6izHdED4/YGBTyyZD3QrEDVa8VG+tB9MoGHNG/ghpLu/MGokm7WLzDrHccbUH7
	 sINuydxpctVchuo+KUzaWsFYF4zmSC0z+FJj8+9cAMGsCPnKhQUbfQSwXxjot5VRir
	 ZAnFkDNlLUFs9TV/ZqUCsZzKdnYgUssavkOn0yFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgH2Qsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgH2Qsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 12:48:50 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 327CA2098B
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598719730;
        bh=nX+JQR9DpT/+z2PqkacX5gzHhZ3MRE2mzN0FA/mMxYM=;
        h=From:Date:Subject:To:From;
        b=gjj2VOKgmlou8/oRMJraCUn0ECUW/RD46ePvRU5zoT0HzzdRwMcuuNOw4diRamBCW
         /FcVsnaoAGdh2ydjqEAL6nBmf0w5YpQe+J+CY9Eb6wa3u8Da9nQnxO6ChAMl6tQbZQ
         RNKOiXOOnzFshtVGLqIxDJh2ggXHwvSAEdF1CbXU=
Received: by mail-wm1-f49.google.com with SMTP id w2so1853155wmi.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 09:48:50 -0700 (PDT)
X-Gm-Message-State: AOAM530ZcLreIKx+1Zlo5lvIJlkri3WbVrsXKsJxAij0998SDP/fQt5v
        QuF+089sMxm7mwhfMne3PVUpe1yju1VdfVlP7eKRfg==
X-Google-Smtp-Source: ABdhPJzCYIE2nWwadzkl6zgOl19uRGQl4a1pbYN2Z6IYBBYHhTkXGUAt5TUZr1XVZ7s0UiZWCw5L8nB+tJPG4aBf5a8=
X-Received: by 2002:a05:600c:2183:: with SMTP id e3mr4015900wme.49.1598719728834;
 Sat, 29 Aug 2020 09:48:48 -0700 (PDT)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 29 Aug 2020 09:48:37 -0700
X-Gmail-Original-Message-ID: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
Message-ID: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
Subject: ptrace_syscall_32 is failing
To:     Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to be a recent regression, maybe related to entry/exit work changes.

# ./tools/testing/selftests/x86/ptrace_syscall_32
[RUN]    Check int80 return regs
[OK]    getpid() preserves regs
[OK]    kill(getpid(), SIGUSR1) preserves regs
[RUN]    Check AT_SYSINFO return regs
[OK]    getpid() preserves regs
[OK]    kill(getpid(), SIGUSR1) preserves regs
[RUN]    ptrace-induced syscall restart
    Child will make one syscall
[RUN]    SYSEMU
[FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
[RUN]    Restart the syscall (ip = 0xf7f3b549)
[OK]    Restarted nr and args are correct
[RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
[OK]    Replacement nr and args are correct
[OK]    Child exited cleanly
[RUN]    kernel syscall restart under ptrace
    Child will take a nap until signaled
[RUN]    SYSCALL
[FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
[RUN]    SYSCALL
[OK]    Args after SIGUSR1 are correct (ax = -514)
[OK]    Child got SIGUSR1
[RUN]    Step again
[OK]    pause(2) restarted correctly
