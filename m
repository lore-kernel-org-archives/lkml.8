Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3124C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99DA22465B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580232512;
	bh=/tQgaGVaBM+Q0f0uBbBRAfCoBJW2r1q6ZmYvnLwNNco=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=TDEZML/jMwzU4OD1Ck2EYKztjrM1gGRvdVO5Tsv66CvhQWrDfHhhX/y5KhxyAxbjm
	 QqNxtUZ/kfZJtK1uxEGZtNH9DAMvUXhvMnulKjkniIHFgAkyW7OLa+moEi0L25MWAq
	 Z1xZpVKk3Jk71oAWDZbuAm0IJ05XCxPAN40TosoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgA1R2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:28:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40149 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1R2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:28:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id j104so1097400wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oLsve5s46IKFfzoU3/Dy54fuK9UJTbV4+XMQymCE0gU=;
        b=lANJMZxiBxyPvHLLYnAnl6uTHF31x2F3hVjPWQar2B2YtD+O5p10CSElfjtx91+vYd
         gClzxHAvsxdVI+zSPLHdwwDTBdgXqGgAu1IaobG1tzxUWQXFGCLSJ4a1xDuBJxWcra8K
         2oHxVl8PhEWqa40c0DAZw7f4ueRLNm8J9wPhU9MwUnue5ti9wPVvFV5Wawi5AVR24sHo
         CKWuUsEE8zdMLlWFNiteU2hrE2IrUHgfS4o2KYqt96vRisOtZR0S9qKrnSiQ6bPfFxkl
         d4TBUY3Rh11G3Ee2Aq6c2q1pIPJFk0KlNsR1sW6K/GvNTWCL6fqz0U94Tb60ic7TZcNn
         oiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=oLsve5s46IKFfzoU3/Dy54fuK9UJTbV4+XMQymCE0gU=;
        b=GQC4ABDnITl7HakaQpnNncs8OXmTYP/0VPLGIMEw6DTmniA+9yLvXpMW0HzX5BUBm9
         O1MV7zd7SHx5Orpo32FstESYNPzno9rIuWNoMwj1piZ4HaTL+mWwxYeyG7I1dOwBz0bk
         cnVqvSi0R11Kez7FKCkZjYCYyCB4Nw7IJBSOadEYp0MQOX82ngrlE7MHOWQXCH7+0eTK
         tQkvhGDB7RFB+nCwhAxyApEDNW7GpcIN1DOgP1724qtzleMfWFZuCBgUiQvDN7Azb0vv
         QC+I2+x2vodriENC6RhZp78WzZDCkcz2Wzj5zQ+XO2E4PLVPNGzhY4xlQNq+uf2YkUQu
         Te/g==
X-Gm-Message-State: APjAAAW+JzerDyWPXB7+qUXSRONErmtjD6Ea/upk+IW7YGfQtZGQgM2c
        2VMSAZdEBmI/K2xNky8YUb0=
X-Google-Smtp-Source: APXvYqxM0MKpKrxvnpgftWnjXWuPYr5K5zop+Q4WwpD4Wm9wvzDClrjtt/3QVoNCm2JhQmLeBaPn+A==
X-Received: by 2002:a05:6000:118e:: with SMTP id g14mr31498828wrx.39.1580232509149;
        Tue, 28 Jan 2020 09:28:29 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s8sm25873962wrt.57.2020.01.28.09.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:28:28 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:28:26 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cache changes for v5.6
Message-ID: <20200128172826.GA83630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cache-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cache-for-linus

   # HEAD: e79f15a4598c1f3f3f7f3319ca308c63c91fdaf2 x86/resctrl: Add task resctrl information display

The main change in this tree is the extension of the resctrl procfs ABI 
with a new file that helps tooling to navigate from tasks back to resctrl 
groups: /proc/{pid}/cpu_resctrl_groups.

Also fix static key usage for certain feature combinations and simplify 
the task exit resctrl case.

  out-of-topic modifications in x86-cache-for-linus:
  ----------------------------------------------------
  fs/proc/Kconfig                    # e79f15a4598c: x86/resctrl: Add task resctr
  fs/proc/base.c                     # e79f15a4598c: x86/resctrl: Add task resctr
  include/linux/resctrl.h            # e79f15a4598c: x86/resctrl: Add task resctr

 Thanks,

	Ingo

------------------>
Chen Yu (1):
      x86/resctrl: Add task resctrl information display

Xiaochen Shen (2):
      x86/resctrl: Do not reconfigure exiting tasks
      x86/resctrl: Check monitoring static key in the MBM overflow handler


 arch/x86/Kconfig                       |  1 +
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/monitor.c  |  4 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 90 ++++++++++++++++++++++++++++++++++
 fs/proc/Kconfig                        |  4 ++
 fs/proc/base.c                         |  7 +++
 include/linux/resctrl.h                | 14 ++++++
 7 files changed, 119 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/resctrl.h
