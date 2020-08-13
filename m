Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A82C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD13320774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 20:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAr6fIww"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHMUDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 16:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMUDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 16:03:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B59C061757;
        Thu, 13 Aug 2020 13:03:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z20so3107929plo.6;
        Thu, 13 Aug 2020 13:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rVxj8isGcYg2kSrB/8odI4mBvo5lkZ3mbyPx7lehTCk=;
        b=IAr6fIwwzTiZGKClZ9Pe3JtoUQo7mOnpW92ti6GtjfPYl8G85HlKzWg+9jyEKkzYmg
         kxZZcTpnNA6KG9DrEJ6HSERqxUymq37PbGGSPsibYe8g4sw1dF5gBuyrpPIaHMLq1lWw
         8fIWFd4IKC2ivK+pnnjqbX3+ullwDICSRbSSX/b6jQjwGiFlznQFhOtBn0x3GhkqgWO4
         UNTagKuvGQqXo1D9KbX4Aw8+1BCdURdIEERU2yKlTfVrfEDNxF43hdVrMD30xCR2M87V
         KRJ89cH0J9QAzUjm4si8yi2nxN4OrOLs1G+aMS51PUU9n3a5df0VdWvF5S3g9tnD90xl
         RkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=rVxj8isGcYg2kSrB/8odI4mBvo5lkZ3mbyPx7lehTCk=;
        b=tR+9GZuZiMKckE55mUMAUCls/J1hZPjOn0NmSSjNbL0IHAKCyZUIJ7lAm0qHl/GJk9
         rr6jHuNzTOgWf4PoPhJFc4dRnAo43xo0zgr0grz8hbmIu+w+wSCATdignPlPSKac5VS7
         9k3Bq8CjDYFW/06pcZ6gDjlYBLfQ0fgdylbrT53C/TINRGlL6xmRg8tVkqiLfB5Fl3Bz
         raV9onsweJbaQR3EYGnLPW0hFJA67AuBNE9VYeScUOMrv6Zv1I6JxU0zy+VH75ZYke9T
         oL+20cjXoZswfd9S3CPW6T8XevFfMBy57Ff5QyPOJYvNP7BIzv0+TP8bDHp6z24/+5fA
         YsPQ==
X-Gm-Message-State: AOAM533zrbjTESWNAUvblyR7VlSgHHx+GsyKDAzxjyaOJ1hHHcsAyaUC
        U4HhwTwiwdPZXoIu94+dgfFFWI5d
X-Google-Smtp-Source: ABdhPJzT5s+nsEuvDNCSpqijl5yQ813fK1jGKafJsya9S2oQHL/1Q2WbdqxQ1G35qqtR8Zr6jWCUzA==
X-Received: by 2002:a17:902:6b41:: with SMTP id g1mr5322293plt.108.1597348980886;
        Thu, 13 Aug 2020 13:03:00 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm6127359pjx.14.2020.08.13.13.02.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 13:03:00 -0700 (PDT)
Date:   Thu, 13 Aug 2020 13:02:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Rich Felker <dalias@libc.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/seqlock, headers: Untangle the spaghetti monster
Message-ID: <20200813200258.GA113946@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 02:35:11PM +0200, Peter Zijlstra wrote:
> By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> attacked.
> 
> Attack back by reducing seqlock.h dependencies from two key high level headers:
> 
>  - <linux/seqlock.h>:               -Remove <linux/ww_mutex.h>
>  - <linux/time.h>:                  -Remove <linux/seqlock.h>
>  - <linux/sched.h>:                 +Add    <linux/seqlock.h>
> 
> The price was to add it to sched.h ...
> 
> Core header fallout, we add direct header dependencies instead of gaining them
> parasitically from higher level headers:
> 
>  - <linux/dynamic_queue_limits.h>:  +Add <asm/bug.h>
>  - <linux/hrtimer.h>:               +Add <linux/seqlock.h>
>  - <linux/ktime.h>:                 +Add <asm/bug.h>
>  - <linux/lockdep.h>:               +Add <linux/smp.h>
>  - <linux/sched.h>:                 +Add <linux/seqlock.h>
>  - <linux/videodev2.h>:             +Add <linux/kernel.h>
> 
> Arch headers fallout:
> 
>  - PARISC: <asm/timex.h>:           +Add <asm/special_insns.h>
>  - SH:     <asm/io.h>:              +Add <asm/page.h>
>  - SPARC:  <asm/timer_64.h>:        +Add <uapi/asm/asi.h>
>  - SPARC:  <asm/vvar.h>:            +Add <asm/processor.h>, <asm/barrier.h>
>                                     -Remove <linux/seqlock.h>
>  - X86:    <asm/fixmap.h>:          +Add <asm/pgtable_types.h>
>                                     -Remove <asm/acpi.h>
> 
> There's also a bunch of parasitic header dependency fallout in .c files, not listed
> separately.
> 
> [ mingo: Extended the changelog, split up & fixed the original patch. ]
> 
> Co-developed-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Building sh:defconfig ... failed
--------------
Error log:
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
In file included from include/linux/spinlock.h:318,
                 from arch/sh/include/asm/smp.h:11,
                 from include/linux/smp.h:82,
                 from include/linux/lockdep.h:14,
                 from include/linux/rcupdate.h:29,
                 from include/linux/init_task.h:5,
                 from init/init_task.c:2:
include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
   90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
      |   ^~~~~~~~~~~~
      |   xchg_acquire
include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'dep_map'
   90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);

and many more. Bisect log attached.

Guenter

---
# bad: [dc06fe51d26efc100ac74121607c01a454867c91] Merge tag 'rtc-5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
# good: [96e3f3c16b7aedcd71502ccfc5778dddfc2e7b15] Merge tag 'thermal-v5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux
git bisect start 'HEAD' '96e3f3c16b7a'
# good: [32663c78c10f80df90b832de0428a6cb98a64e9a] Merge tag 'trace-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace
git bisect good 32663c78c10f80df90b832de0428a6cb98a64e9a
# bad: [3a5139f1c5bb76d69756fb8f13fffa173e261153] cma: don't quit at first error when activating reserved areas
git bisect bad 3a5139f1c5bb76d69756fb8f13fffa173e261153
# good: [8d3e09b43312991c503478bf0f5f99e92c23ccf1] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 8d3e09b43312991c503478bf0f5f99e92c23ccf1
# bad: [97d052ea3fa853b9aabcc4baca1a605cb1188611] Merge tag 'locking-urgent-2020-08-10' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 97d052ea3fa853b9aabcc4baca1a605cb1188611
# good: [4bcf69e57063c9b1b15df1a293c969e80a1c97e6] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
git bisect good 4bcf69e57063c9b1b15df1a293c969e80a1c97e6
# good: [1f0b067b6e4927f06f5ffaea8eccdf722e563819] f2fs: compress: disable compression mount option if compression is off
git bisect good 1f0b067b6e4927f06f5ffaea8eccdf722e563819
# good: [13c01139b17163c9b2aa543a9c39f8bbc875b625] x86/headers: Remove APIC headers from <asm/smp.h>
git bisect good 13c01139b17163c9b2aa543a9c39f8bbc875b625
# good: [e28c02b94f9e039beeb5c75198caf6e17b66c520] gfs2: When gfs2_dirty_inode gets a glock error, dump the glock
git bisect good e28c02b94f9e039beeb5c75198caf6e17b66c520
# good: [163c3e3dc0ddcea3edac51612fced13c597f37dc] Merge tag 'for-linus-5.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs
git bisect good 163c3e3dc0ddcea3edac51612fced13c597f37dc
# good: [828add774f0d2bf930cdeca6c982c1fbcdd846bb] f2fs: prepare a waiter before entering io_schedule
git bisect good 828add774f0d2bf930cdeca6c982c1fbcdd846bb
# bad: [0cd39f4600ed4de859383018eb10f0f724900e1b] locking/seqlock, headers: Untangle the spaghetti monster
git bisect bad 0cd39f4600ed4de859383018eb10f0f724900e1b
# good: [b3545192e2b4647234254c5122f8cbfddbcbdaa0] locking, arch/ia64: Reduce <asm/smp.h> header dependencies by moving XTP bits into the new <asm/xtp.h> header
git bisect good b3545192e2b4647234254c5122f8cbfddbcbdaa0
# first bad commit: [0cd39f4600ed4de859383018eb10f0f724900e1b] locking/seqlock, headers: Untangle the spaghetti monster
