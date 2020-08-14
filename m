Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CEAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703282074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdAUceeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHNUsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:48:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6317CC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 13:48:03 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id q19so4721385pll.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 13:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=244FLypaM2NGxDoPpAzfSJH2dcpfhRfVt7B8PZPpN74=;
        b=EdAUceeP6gRUYKxDODNpLLFRfYeVOfk9v1P9+lVBcPIxT5mh/aq7k+d5908y5Z4sub
         dP2K0x/VMTRTLiMM/f9LENa4xaVvHz+RL07I8UIvLTpfc3mgk4zA+DZO5FD5xWSSeMkP
         G3bv7pHrQ5jLgRebMtbPxrKGSb9+oUY18DIz6EvECWCyFJpzUOT0J3DHvKDxOy6L4VGp
         H+wsqxYaH339xB94oUViMQ0X5eLuyNptg9MavVApc5QT9HKBTwmfJxeNqxlYjoEsMgyG
         NijouYW8gH5fA5Ns5VP5ORmX/iTtwS3xVMGhVrIybSh7QtGkFi4mVLPZHk/+8fAaNoGD
         kMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=244FLypaM2NGxDoPpAzfSJH2dcpfhRfVt7B8PZPpN74=;
        b=kKV3ZIFB4yBsjI/23xIeKxov3bfcDhE7QiTq5P3vkBmz4o+y2SoNA4WCnFDGWGB0kU
         RStJ/+l1I6anjkheAhoTC9g4SVjexMrvyx76ppAt7tJtm/IiCYh5wnfLDik4mgrwGjdC
         sZqardfAcdQV7OciEnF4XktxDYr+uAC1OdbTQGSsneAmI0mohcJnjsbONPTv21wfIynY
         ZVwf6RD5E583XERkrMz5hbqZ3DO5/eSh50upWIu9ydOPCLI3tbkHzRt2hBJmATbdMzx4
         EY2zgWfJKfYDekC3EpSMiQD5fRx8FyUxzRydUY3j9FcHIUQXmoeD+FFqaubxJJSWRzUA
         ie3g==
X-Gm-Message-State: AOAM5331OqKWaK53bRnDQLx1FVOhWGBd76VeT+Or4OOGenO9CC/KKvFI
        r4IhE4zGazj23eTGP8qrn73PvnzqAPA=
X-Google-Smtp-Source: ABdhPJzQxQrtT+XVWqyzF3rDOzH4vwvHsCkPG5c2B4gJ2aiJ3l66nUnnSpzjDmpp5uH7Pz1cBOJdaA==
X-Received: by 2002:a17:90b:11d1:: with SMTP id gv17mr3507737pjb.167.1597438082257;
        Fri, 14 Aug 2020 13:48:02 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id 132sm8973214pgg.83.2020.08.14.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 13:48:01 -0700 (PDT)
Date:   Sat, 15 Aug 2020 05:47:59 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: [GIT PULL] OpenRISC updates for v5.9
Message-ID: <20200814204759.GT80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull:

The following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 55b2662ec665cc8b592809a011fe807b05370ab8:

  openrisc: uaccess: Add user address space check to access_ok (2020-08-09 07:57:21 +0900)

----------------------------------------------------------------
OpenRISC updates for 5.9

A few patches all over the place during this cycle, mostly bug and
sparse warning fixes for OpenRISC, but a few enhancements too.  Note,
there are 2 non OpenRISC specific fixups.

Non OpenRISC fixes:

 - In init we need to align the init_task correctly to fix an issue with
   MUTEX_FLAGS, reviewed by Peter Z.  No one picked this up so I kept it
   on my tree.
 - In asm-generic/io.h I fixed up some sparse warnings, OK'd by Arnd.
   Arnd asked to merge it via my tree.

OpenRISC fixes:

 - Many fixes for OpenRISC sprase warnings.
 - Add support OpenRISC SMP tlb flushing rather than always flushing the
   entire TLB on every CPU.
 - Fix bug when dumping stack via /proc/xxx/stack of user threads.

----------------------------------------------------------------
Luc Van Oostenryck (1):
      openrisc: fix __user in raw_copy_to_user()'s prototype

Stafford Horne (11):
      init: Align init_task to avoid conflict with MUTEX_FLAGS
      openrisc: Add support for external initrd images
      openrisc: Fix oops caused when dumping stack
      openrisc: Implement proper SMP tlb flushing
      asm-generic/io.h: Fix sparse warnings on big-endian architectures
      openrisc: io: Fixup defines and move include to the end
      openrisc: uaccess: Fix sparse address space warnings
      openrisc: uaccess: Use static inline function in access_ok
      openrisc: uaccess: Remove unused macro __addr_ok
      openrisc: signal: Fix sparse address space warnings
      openrisc: uaccess: Add user address space check to access_ok

 arch/openrisc/include/asm/io.h      |  9 +++-
 arch/openrisc/include/asm/uaccess.h | 23 +++++-----
 arch/openrisc/kernel/setup.c        |  8 ++--
 arch/openrisc/kernel/signal.c       | 14 +++---
 arch/openrisc/kernel/smp.c          | 85 +++++++++++++++++++++++++++++++++----
 arch/openrisc/kernel/stacktrace.c   | 18 +++++++-
 arch/openrisc/kernel/vmlinux.lds.S  | 12 ------
 arch/openrisc/mm/tlb.c              | 17 +++++---
 include/asm-generic/io.h            | 16 +++----
 init/init_task.c                    |  1 +
 10 files changed, 145 insertions(+), 58 deletions(-)
