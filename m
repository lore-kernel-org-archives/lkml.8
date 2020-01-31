Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C540C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A0B20707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580471585;
	bh=sk6Vyukx5ndsd3eN3CYB8iEtq6T0bAEoJZtAqSsLY7U=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=wkPRMq3PRkTY+VoZsIToN1ZlhrtQGC/3w9Ngbm+tdQ67LMG0HccIFwZLZG+3mlaph
	 kBb83ySYA/aMuXEcCHlXcB+6NKzBkgf4ip7/yz0dAgBTJHdFEOrQ+eBkK0V27EZgNY
	 gzrLYmFwsDqjtFcaQRqqf1LDOwwmr6ykja+Pisuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgAaLxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:53:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgAaLxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:53:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id s10so7564607wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 03:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tq9+oZKrlV5RWut1xN84D3VSDmerEK8R8REdRN6WTDM=;
        b=eY2O5NVbb0wUahMtQC7RlbeWByrjy1v/UZ4znmxO4DY2i96XnBa/5G1IOjclQwFJ1O
         OQ/mXQ+TLQw/lQziNhH/WlYn+0WxiP1c43ePVCLNtfr3hM4ndAXZc4Uux0/cRZ0wHH5C
         sl1Tz6I5QdB0tqLhvBcus5Gu7i+/cq8a8HMdbSn48Csy49W/1MIPt4YTd9kpewYRsbjP
         g2KBULnZtm7CR7EtuN4VxTXHLIkFZw/meo48fMR+J/Wp4Iek3x+dnVHormvM6M7uOCVR
         hNPv6eJvaceLJR4W1DMjZVm2Q6rU1fbSbHgXg5gzP9PpDBDvyOsmTiEM9o9q4phn3dfB
         IVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=tq9+oZKrlV5RWut1xN84D3VSDmerEK8R8REdRN6WTDM=;
        b=OxiEI+LvnW++Pxhwrw+SjUn6E23yqyFnIHjYOHF5NKJq7WcMjuHJOboo7rKhOookTT
         klNKg8WOpDhim/DKAUOXMv8IM4/kuHojUNGIgpBnqyJCRSplRpvBrLHQS+nx6QHlqJi6
         qZF8jLUkes0xf4LSWC44DqrJZvQgFPn3CMA1o1EH3Bc/pehWo2vInRptpUW+S7r3OLde
         YHETNI1JfSeGm63exO6XUjfIAds7klqfaGQWbs+PeZJ/dyRR5dzYjNkmaAzbZ7rI1sn+
         pdSl3CRTdUhqcnHY3E4t/4ARfzyaJeBbGJgUHRAABqPV8KT1v2o2vTxl/fzUoh4Eoxht
         1Edw==
X-Gm-Message-State: APjAAAVAPz7GYVNDlPJmhl5CECoqQn5x7FWWi0XxDis7sGj7VrUZDDgb
        qEbJFnF/ZJtWztQZUpGCJWwnPxQe
X-Google-Smtp-Source: APXvYqzjFB7jitdTtm3Z/YBiXCG2/Phcz6J3hXNi+whbAnTBsm2y4vXYF2xjnuO6hufZ0zvrICtXPQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr11682561wml.88.1580471581922;
        Fri, 31 Jan 2020 03:53:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id i10sm12005564wru.16.2020.01.31.03.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 03:53:01 -0800 (PST)
Date:   Fri, 31 Jan 2020 12:52:59 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200131115259.GA91121@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 6bd3357b6181bd38c1a757168a8842e09ec6f3fb Merge branches 'x86/hyperv', 'x86/kdump' and 'x86/misc' into x86/urgent, to pick up single-commit branches

Misc fixes:

 - three fixes and a cleanup for the resctrl code,
 - a HyperV fix,
 - a fix to /proc/kcore contents in live debugging sessions,
 - a fix for the x86 decoder opcode map.

 Thanks,

	Ingo

------------------>
Masami Hiramatsu (1):
      x86/decoder: Add TEST opcode to Group3-2

Omar Sandoval (1):
      x86/crash: Define arch_crash_save_vmcoreinfo() if CONFIG_CRASH_CORE=y

Wei Liu (1):
      x86/hyper-v: Add "polling" bit to hv_synic_sint

Xiaochen Shen (4):
      x86/resctrl: Fix use-after-free when deleting resource groups
      x86/resctrl: Fix use-after-free due to inaccurate refcount of rdtgroup
      x86/resctrl: Fix a deadlock due to inaccurate reference
      x86/resctrl: Clean up unused function parameter in mkdir path


 arch/x86/include/asm/hyperv-tlfs.h     |  3 ++-
 arch/x86/kernel/Makefile               |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 48 ++++++++++++++++++----------------
 arch/x86/kernel/crash_core_32.c        | 17 ++++++++++++
 arch/x86/kernel/crash_core_64.c        | 24 +++++++++++++++++
 arch/x86/kernel/machine_kexec_32.c     | 12 ---------
 arch/x86/kernel/machine_kexec_64.c     | 19 --------------
 arch/x86/lib/x86-opcode-map.txt        |  2 +-
 tools/arch/x86/lib/x86-opcode-map.txt  |  2 +-
 9 files changed, 71 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/kernel/crash_core_32.c
 create mode 100644 arch/x86/kernel/crash_core_64.c
