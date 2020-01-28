Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD79C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAB7214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580232898;
	bh=4ZRiXFBvxjNF1vSR2mMc8kfjR2X6mCSZ/le9+O4KKm4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=hdc7kST3ywrJ2hGEqRHzq2Xk9RhE+qtl6rgDEN2p4O2oA3X8w8Uq3P5DwTk3Bxo5y
	 LdjsCzzHAC9Boh0h2U8R8GuekgxyYokmzd1AV6v1cAetA9nPWk0XwV4FOaMu6jkeg8
	 0MroJacJ1rr2dYUyw+yfME/sKIGsxYpg4uGzDQu8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA1Re5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:34:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39770 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1Re5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:34:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so3491769wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lx3j6BrSnjaR1j8BXuFz2mANCw6TQ/1Pb+Fl70a0flY=;
        b=YHTW/jXoim+GJrxkWXxgq8dKV3TVjVr3GE6qZckCo89Q5rr0Hv4vZScQ2+z8rRE0QB
         tGBayuAPeZLfAqMdcZwctBfjmAdLTXwbaIfPMjxxa8gLf/zbd0NdV4ZKHFtg5HQirsaA
         fLatv25rTvpDv0QMRu/PHpFC+ESKGpsTnnaTzh5ZnunYjErfX4M4+pt60BQuCDCSbPlr
         BYhcIpzvWalE8VB2VlVPgE3etG7C6RvS9cnnmfhL4p5ZdeOHIxtuTj1y74VT5iXwqV8n
         /N+9PrVC6LGq+bdCMX9FOBoUUvw0Jk1YFOw4FvzjaKkcxTGb9LXzyJ7UdR7gbPrZ48J7
         v1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=lx3j6BrSnjaR1j8BXuFz2mANCw6TQ/1Pb+Fl70a0flY=;
        b=bWUhKpBIP2OrE3LJ+na3aGW9qVcZ4v0wDzjYx+QFvma8sRQ11+wDodA4s4n0Ud5D/s
         K/6t6YEgbph+GxDUz9S3zw359H7wBsBpZGGLqjaQ/MRyrjtbmIaOpXeS+n0Y80IfKtrY
         G6AheabXONCc8RFjfT6onwYUVJaac9dnMjJJu3LES3wRYLDW8W/YfLHj/I6vKMzqx58b
         5qcdKSfHl9mHOWPi4hwsfqBDcZwoycTvo9kvZAeb8uw5DIrERJz72np0b5KPBG/OATcI
         yEb1uME1/pNhVWaJkZQwGBh+7fOuWUEQgm7rKc7HZVtNOM4ofUGAikI84GEYUP5mt/4I
         97bg==
X-Gm-Message-State: APjAAAWdHq+prySihnpafVHniWDv8J9Pa2wwj8ovoN0ijdGqMxuEWgH0
        pSE2GlS5czAzhDAUi+m4xAQ=
X-Google-Smtp-Source: APXvYqyPse6KreDjxSFgxcfNgBmZYUMAg/hzB07m5sRd/5Ck2QNmGnPozV+/mQQud1m4/ZvDO4nQNA==
X-Received: by 2002:a1c:5ac2:: with SMTP id o185mr6196566wmb.179.1580232894923;
        Tue, 28 Jan 2020 09:34:54 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id h17sm28247256wrs.18.2020.01.28.09.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:34:54 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:34:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups
Message-ID: <20200128173452.GA25020@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 3c749b81ee99ef1a01d342ee5e4bc01e4332eb75 x86/CPU/AMD: Remove amd_get_topology_early()

Misc cleanups all around the map.

 Thanks,

	Ingo

------------------>
Anthony Steinhauser (1):
      x86/nospec: Remove unused RSB_FILL_LOOPS

Benjamin Thiel (1):
      x86/cpu: Add a missing prototype for arch_smt_update()

Borislav Petkov (1):
      x86/CPU/AMD: Remove amd_get_topology_early()

Enrico Weigelt (1):
      Documentation/x86/boot: Fix typo

Ingo Molnar (2):
      x86/setup: Clean up the header portion of setup.c
      x86/setup: Enhance the comments

Julia Lawall (1):
      x86/crash: Use resource_size()

Krzysztof Kozlowski (1):
      x86/Kconfig: Fix Kconfig indentation

Mateusz Nosek (1):
      x86/tsc: Remove redundant assignment

Randy Dunlap (1):
      x86/Kconfig: Correct spelling and punctuation

Sean Christopherson (1):
      x86/boot: Fix a comment's incorrect file reference

Valdis Kletnieks (1):
      x86/vdso: Provide missing include file

yu kuai (1):
      x86/process: Remove set but not used variables prev and next


 Documentation/x86/boot.rst           |   2 +-
 arch/x86/Kconfig                     |  74 ++++++++--------
 arch/x86/entry/vdso/vdso32-setup.c   |   1 +
 arch/x86/include/asm/nospec-branch.h |   1 -
 arch/x86/include/asm/realmode.h      |   4 +-
 arch/x86/kernel/cpu/amd.c            |  10 +--
 arch/x86/kernel/cpu/common.c         |   1 +
 arch/x86/kernel/crash.c              |   2 +-
 arch/x86/kernel/process.c            |   4 -
 arch/x86/kernel/setup.c              | 163 ++++++++++-------------------------
 arch/x86/kernel/tsc_sync.c           |   1 -
 arch/x86/xen/Kconfig                 |   8 +-
 12 files changed, 96 insertions(+), 175 deletions(-)
