Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7D6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E022020716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580233625;
	bh=Pt1sOqlqhOOYniXm/FLnQ5CI/QyevPybuJFzU2TW0no=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=aabwI3jwCwdgx6M9v21RuIPf4Ajc87BDrYxvmfZ3YMYdtItLc1Ne3KWSk0pgwNK6O
	 5Y2QkvuOKbNWokWMm+vNSJz2Dg/NRHmlBsSoaEzQdtX827V7pDrBKZbW/qTniiLgAw
	 rU+QPHtf8ndJyy6rgPvi086Y+bMDBcBLXx2ZY3Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgA1RrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:47:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51027 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1RrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:47:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so3500457wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hQb+cHiC9iAYV3ISIe5+Y0ZDFn9xoej91otL5fRPA24=;
        b=I/Dm+KMAY1iLT6rWSk4+Q/3ovyslt2G3ATmsvaCpqAQ/IEfJ63oseHJXqKtxxJEHpO
         9ohm9QGuY/BeDH8S4EE8eviurAh8+7buqn4R+5A5GBbEENhcnYaRXJoT2V/4PjteJ0ny
         KwvhBI/f1qdjwRZO0ulgnVgrabcTYv40XHSNg+WKwZPCy7AMNZ2/EN1tlqXgFPAMvo6x
         HMnHWUsD0NwyhowYHhWM4X6nUSyJK2OYfibyWxDCFYBKCpnl437V5bw9+z4idBRIhKva
         exSbCrcG12tSXJ/Lf/DlLOU387OseP625SBZB6vvVYwJuqYRwN5Em4Xn9X2D3CcEdCEj
         Ew2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=hQb+cHiC9iAYV3ISIe5+Y0ZDFn9xoej91otL5fRPA24=;
        b=SnfJeu7d7MT0KIlaOMkIVVfvYXmPjG39usArxwCshSD6/2cHck++pOicrHkIqdO48H
         MAq/Co98U+WtnWvlsQa9SlPpnt4DeXPP61TzbJN5gAqJyDoX6+W8k7vjFzOBW/f2N6gY
         lbpI+3JL/7KKfcMBf01nhJKS63HRYyd7hK+UbvroMNhq581kHO+YO5/M0fJvc5qLM0Ff
         axvqlSnnMz5ixRKzRz2DEZUycCHiTjwrwwEYBIrRGd53yumHOfvVLI01iTfuUn59dTc3
         qT3nA6A0J3DYkA5MYMnMz65PzEbCmKWI7nY0QjROU78J7PFXy420hkLzTvZSmhU2wF8q
         xpMw==
X-Gm-Message-State: APjAAAUYPHCyrJW1bYkbwv6XH2QGMavFyra/YH6x9D4ErJMy6TRq/H3o
        M024dHNw2CQASJtn8kjw1hg=
X-Google-Smtp-Source: APXvYqxe/I3iaW9zsvP6G3VGAomvMCsccLf91KLVZYD/EpxPa+SjK6RywZWTYPLZa3ZvG7DwnezMFA==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr6296436wmi.35.1580233621777;
        Tue, 28 Jan 2020 09:47:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w19sm3756676wmc.22.2020.01.28.09.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:47:01 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:46:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/core changes for v5.6
Message-ID: <20200128174659.GA92880@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-for-linus

   # HEAD: 248ed51048c40d36728e70914e38bffd7821da57 x86/nmi: Remove irq_work from the long duration NMI handler

Misc changes:

 - Enhance #GP fault printouts by distinguishing between canonical 
   and non-canonical address faults, and also add KASAN fault decoding.

 - Fix/enhance the x86 NMI handler by putting the duration check into a 
   direct function call instead of an irq_work which we know to be broken 
   in some cases.

 - Clean up do_general_protection() a bit.

  out-of-topic modifications in x86-core-for-linus:
  ---------------------------------------------------
  include/linux/kasan.h              # 2f004eea0fc8: x86/kasan: Print original ad
  mm/kasan/report.c                  # 2f004eea0fc8: x86/kasan: Print original ad

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/traps: Cleanup do_general_protection()

Changbin Du (1):
      x86/nmi: Remove irq_work from the long duration NMI handler

Jann Horn (4):
      x86/insn-eval: Add support for 64-bit kernel mode
      x86/traps: Print address on #GP
      x86/dumpstack: Introduce die_addr() for die() with #GP fault address
      x86/kasan: Print original address on #GP


 arch/x86/include/asm/kdebug.h |   1 +
 arch/x86/include/asm/nmi.h    |   1 -
 arch/x86/include/asm/ptrace.h |  13 +++++
 arch/x86/kernel/dumpstack.c   |  26 +++++++++-
 arch/x86/kernel/nmi.c         |  20 ++++----
 arch/x86/kernel/traps.c       | 108 ++++++++++++++++++++++++++++++++++--------
 arch/x86/lib/insn-eval.c      |  26 +++++-----
 arch/x86/mm/kasan_init_64.c   |  21 --------
 include/linux/kasan.h         |   6 +++
 mm/kasan/report.c             |  40 ++++++++++++++++
 10 files changed, 198 insertions(+), 64 deletions(-)

