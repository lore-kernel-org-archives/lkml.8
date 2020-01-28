Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0138C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29102465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580195330;
	bh=zWlaM1XUjQHl4aXswLAWn9LHxL/45yzkMzRS2qc86KE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=10eIIbJwZNuH/o6ONXDXkMZwYRkHbfQ5QefnUHR1RwFtGC+EfMWmUCGgkQ11mPGx3
	 oE0loNm6pVc8raYqTePwkOmhc9ASsSb/d0LkszwE5MITJ2XgOFNqdKKFbHnt43cHx2
	 j9yA2k+YurGCQGyXld9egMW+86A/GVHEEw9K8WRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgA1HIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:08:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37881 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1HIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:08:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so1285337wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=TENwhnwSIPAwYdIrWDT0RLsXWGKz0Pmkc/s9Nb8v5z4=;
        b=gPsbUd5wkX88gddnJRUfYIIqNG4I3P3ApIsjFN1kC771UF0hgAu8WM/DhVN2TtcJ8q
         Fp/Qh9W6mfObxqdao+9RW7MRXdUxKWN6zHo/ayVCk/Jsg2UP8K1sM3jF2j2y1Y/Gt1SD
         VX+MNoLhSD6S1ERl0DPObe+CiIvfhLJWFOy9RK1AyCdU8/jiE38NXIguxrpNAcaRFFPd
         IrEhc75KjtP1PN1+cGc5YUwh9j042hss0MSoWL8hTf0ilKvwT8SPGaFZxuty089JzsQB
         R994ugQwbpfCjYceC9s7GdN6saR+CwjFfT14EA0vo+QiEY1ZwddYEy/oCOxNm+2fjbph
         /7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=TENwhnwSIPAwYdIrWDT0RLsXWGKz0Pmkc/s9Nb8v5z4=;
        b=JvQ0P25LhS9eRA8aBuR+QSyPOHBaOyiBVXL/9veZbSF+ZacmZQ34ltSByW81+McLww
         wtnH5dK+eD+1xYqJFl79SsTTNEEXGNfYUmMytnQ0rPueKiqdiIryUApD9QWPhZ43OyAO
         26jfO1XuLs7gv+cACp7m0GRztBGrMNKL715ge/GCParyXjy6/WMwWIpqGlCrHkBGUa4O
         mSgCmMj3xFbFd6kHsiLMkkTAPIXENbyqEMBTGhyfstzkjKPUeAKOZvcn3qJQvNG03ybU
         INapeAs3vYC6OYFraaz+L90BXGrQ6ebbR8YtYFyrsGcfxB8pJ87PGqw5N3wP7lUvUX5E
         Sgew==
X-Gm-Message-State: APjAAAVvD6lnIURcVKRzSFMWB37GE9+FLApjrILKq4ZEYrM+Uu3zLWQd
        dLpfriTx0V7Qpvm9UiW0FSQ=
X-Google-Smtp-Source: APXvYqzWkc87rBCjAY84+wUcr+S5AkiHlnCd8+WVGKJLN1Jly7WmmA9nIvDjzIwEK2a8toExhi0efA==
X-Received: by 2002:a1c:1fc5:: with SMTP id f188mr3231279wmf.55.1580195327214;
        Mon, 27 Jan 2020 23:08:47 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x17sm24262272wrt.74.2020.01.27.23.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 23:08:46 -0800 (PST)
Date:   Tue, 28 Jan 2020 08:08:44 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] objtool changes for v5.6
Message-ID: <20200128070844.GA6655@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-objtool-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-objtool-for-linus

   # HEAD: 22a7fa8848c5e881d87ef2f7f3c2ea77b286e6f9 x86/unwind/orc: Fix !CONFIG_MODULES build warning

The main changes are to move the ORC unwind table sorting from early init 
to build-time - this speeds up booting. No change in functionality 
intended.

 Thanks,

	Ingo

------------------>
Shile Zhang (8):
      scripts/sortextable: Rewrite error/success handling
      scripts/sortextable: Clean up the code to meet the kernel coding style better
      scripts/sortextable: Remove dead code
      scripts/sortextable: Refactor the do_func() function
      scripts/sorttable: Rename 'sortextable' to 'sorttable'
      scripts/sorttable: Implement build-time ORC unwind table sorting
      x86/unwind/orc: Remove boot-time ORC unwind tables sorting
      x86/unwind/orc: Fix !CONFIG_MODULES build warning


 arch/arc/Kconfig                       |   2 +-
 arch/arm/Kconfig                       |   2 +-
 arch/arm64/Kconfig                     |   2 +-
 arch/microblaze/Kconfig                |   2 +-
 arch/mips/Kconfig                      |   2 +-
 arch/parisc/Kconfig                    |   2 +-
 arch/powerpc/Kconfig                   |   2 +-
 arch/s390/Kconfig                      |   2 +-
 arch/x86/Kconfig                       |   2 +-
 arch/x86/kernel/unwind_orc.c           |  11 +-
 arch/xtensa/Kconfig                    |   2 +-
 init/Kconfig                           |   2 +-
 scripts/.gitignore                     |   2 +-
 scripts/Makefile                       |  13 +-
 scripts/link-vmlinux.sh                |  13 +-
 scripts/sortextable.h                  | 209 ------------------
 scripts/{sortextable.c => sorttable.c} | 305 ++++++++++++--------------
 scripts/sorttable.h                    | 380 +++++++++++++++++++++++++++++++++
 18 files changed, 559 insertions(+), 396 deletions(-)
 delete mode 100644 scripts/sortextable.h
 rename scripts/{sortextable.c => sorttable.c} (67%)
 create mode 100644 scripts/sorttable.h
