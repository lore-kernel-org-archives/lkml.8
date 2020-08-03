Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC6C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C63B22B4E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596477822;
	bh=gG1nd579SgehLZ1Y0KRxeScORYBGahYzVewQTJj+czM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ay+XNSenQDXh+laFlnmefPgMXMTcO80MaCpn2UBrEsr5csRLeis+Nr/7Y2+I4D8o0
	 kAYXmEjCuDjGL8LQL4tQ1ceRZ6BW7dKT7mjTSRtJWhUt/pcm24UKF4vSAEPTpVPsH6
	 y+O2SfWwNuj0IqIhPrGMoGJfXL/n5J6N2lJ3xNyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHCSDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:03:40 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B977C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:03:40 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c2so22043881edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zz8pMnWfwqjIc1QH80CM195LrN4zEHz6+QPeMsumgmA=;
        b=rkZBWfQGxFIsbvByQHe4jspK9v9vFtSG2lVJZKMxFhs/dh5FGbNtL4hPJHsRHbHVn7
         +a9Z2oEEwV94sWxz3rqVeKJY2onSbonouyURxV97gy4h7ln/j4r4n6HJz06Sjedt1hNv
         NDn5OzW7fvqOioeQzpzRnp1EFDU1L7wrdQGEkdxAEl9tKmY5dLPj0JXqpc08CmSRBMg0
         2Rpy2Eryaw4LMPzbKJFUbIlko3aIlNcLtoM/n0gu4xID2lZxu/eJdc1zPO/bqiIgZ4l3
         xPedAAgoUYshQ31rw4S0jYt5JA079uEJ8y4hNTBJPlh5Goum7LPXpuX/B47MZZ9m63/X
         7SRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Zz8pMnWfwqjIc1QH80CM195LrN4zEHz6+QPeMsumgmA=;
        b=HVDNCCb7Uaa3yhvwrJlXxYmshr2wNuygXJEJynJMiHmefuhaNnoaMLE76mexas2wDt
         MXwLVEy+/oxN6JL5fM6mzolarVqTp5nKQO7iIVm/uwMusT9OmbRwWSb+7qkLW/zLKH2c
         x/Z8lvSG0bqHmetrW30qODKpVByD71UKzlZPfcZikA+D8H3JI0CF6+Nss9zQywv3CpO1
         nyhdh902UcCKt/l1z0vehLrFhVPPL52RSsAUiYCkYH5gnPE6zwSOKskiAemM5Fweyy2G
         hYgphMn8v4m67q6fCajORUTo0fdF+tEOeytehYW7NFBzFkUagS5//dkBLcPlvRoI/WLL
         lrqA==
X-Gm-Message-State: AOAM533mtLOuSq4QgXOHBF0xJZMFpJ83w4v9oFPwuYop7XVcAAD2LZ/n
        ufcBRZaqmnjyFMkO9rIiD7k+ABdd
X-Google-Smtp-Source: ABdhPJx6jeOQ0ivGVE1Alf+zhPAROKHodplfgEIUeh2NqIiu2vu90oGgtzRkQlBUY89xkkeLRgZiQA==
X-Received: by 2002:a50:e848:: with SMTP id k8mr8403750edn.192.1596477818917;
        Mon, 03 Aug 2020 11:03:38 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c7sm16579423ejr.77.2020.08.03.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:03:38 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:03:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.9
Message-ID: <20200803180336.GA1041383@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cpu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-08-03

   # HEAD: f69ca629d89d65737537e05308ac531f7bb07d5c x86/cpu: Refactor sync_core() for readability

Misc changes:

 - Prepare for Intel's new SERIALIZE instruction
 - Enable split-lock debugging on more CPUs
 - Add more Intel CPU models
 - Optimize stack canary initialization a bit
 - Simplify the Spectre logic a bit

  out-of-topic modifications in x86-cpu-2020-08-03:
  ---------------------------------------------------
  drivers/misc/sgi-gru/grufault.c    # 9998a9832c40: x86/cpu: Relocate sync_core(
  drivers/misc/sgi-gru/gruhandles.c  # 9998a9832c40: x86/cpu: Relocate sync_core(
  drivers/misc/sgi-gru/grukservices.c# 9998a9832c40: x86/cpu: Relocate sync_core(

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/speculation: Merge one test in spectre_v2_user_select_mitigation()

Brian Gerst (1):
      x86/stackprotector: Pre-initialize canary for secondary CPUs

Fenghua Yu (1):
      x86/split_lock: Enable the split lock feature on Sapphire Rapids and Alder Lake CPUs

Ricardo Neri (3):
      x86/cpufeatures: Add enumeration for SERIALIZE instruction
      x86/cpu: Relocate sync_core() to sync_core.h
      x86/cpu: Refactor sync_core() for readability

Tony Luck (1):
      x86/cpu: Add Lakefield, Alder Lake and Rocket Lake models to the to Intel CPU family


 arch/x86/include/asm/cpufeatures.h    |  1 +
 arch/x86/include/asm/intel-family.h   |  7 ++++
 arch/x86/include/asm/processor.h      | 64 -------------------------------
 arch/x86/include/asm/special_insns.h  |  1 -
 arch/x86/include/asm/stackprotector.h | 12 ++++++
 arch/x86/include/asm/sync_core.h      | 72 +++++++++++++++++++++++++++++++++++
 arch/x86/kernel/alternative.c         |  1 +
 arch/x86/kernel/cpu/bugs.c            | 13 ++-----
 arch/x86/kernel/cpu/intel.c           |  2 +
 arch/x86/kernel/cpu/mce/core.c        |  1 +
 arch/x86/kernel/smpboot.c             | 14 +------
 arch/x86/xen/smp_pv.c                 |  2 -
 drivers/misc/sgi-gru/grufault.c       |  1 +
 drivers/misc/sgi-gru/gruhandles.c     |  1 +
 drivers/misc/sgi-gru/grukservices.c   |  1 +
 15 files changed, 105 insertions(+), 88 deletions(-)
