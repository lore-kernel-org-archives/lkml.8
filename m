Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFD1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B022173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580234276;
	bh=6q1eDP/QEl+QNfDISOMpx81t1LhnSt0hStv8JtqES54=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=iZvE3fBgfEBuUfSucfMhvGCzC7R0NkzwIhfKgmwi0Top4+qHqL3ygrUiujtfZ5Pp6
	 SFUPlX7+2B2ltIcHbfGF8pVrNLSNKVWRDKqEzyLEFfcenVCnARn5/6nMhwWFMlBPJM
	 Nn+l2equIFvAO7jSX7svTOtC/HTWRkvjULEHMjZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgA1R5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:57:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46027 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgA1R5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:57:55 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so2510173wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9Tw6I+bdKFWlq3JNEMm8pUCXB8gbZx0JUi+n+3Sv+9o=;
        b=U8FwwC5fErdvG/ZINlWlNxX1z4wuzLQ02FAmwtn68qIaHwqsw3Y5e5jc3YGWPbhT6Y
         43HosLwGREH1EjMDAWhSxkwnDxmplHV3ZAG8WnA2YRdJI+oj9Yvn1+sn9SuSHMggT91a
         dzcZtfiPHckVNIUtIkWPnYMUa9DbVBn+jTQlp79+1X0l37eNpGWEJSXi1EyJmJYb7Q6/
         z5caB8dOG0T+sIGHT1q2tqTiJWs0FjgPJSX5WUswNTgFhgyQamPXTUzaboWifgkUaWvs
         fFeHqBHY1KfI52B+kUfpAD/NVjVCIWyodSaIa4DHPemjM01KYdVY/bWOyj+qZWJ//GoI
         9AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=9Tw6I+bdKFWlq3JNEMm8pUCXB8gbZx0JUi+n+3Sv+9o=;
        b=AZsY1j4ieBnwa101Su+e2+GnJw6iCHPVE3gpf3/k/CyyUpfdIQQbOdPtC7GK4rG5G7
         xwTGLAGpPk43zxEy+NQFk8uBFfX0oN6bRh6a6aQyHABkEmbnbWz0u6r+LUhvjmDBEFYk
         USEmsioHAmHOycLjVR2Tuop7rENzoUZgGbS8eiAUDrakfg1t23u6LTBWOzJgNgSnkTX4
         W9asaaQAgoe+J+eSH+a0bBmpVebqoz0MatFN4EP4YU6Q+/mb6r3WIWF3YGln+8P8dE0c
         SfaE+A1Y/jJcmD05QtoV2LtWRJPzNPebf9Lnu69o/MVPj5lSjUDSAvjWICZeOPsFJhtz
         AcVQ==
X-Gm-Message-State: APjAAAWZSuf27KKoPLTA+ZbZPcXgRh8O7cXZNjF54qFxY4KtvCVYH6We
        q98hbODr9kzXU4HOd57kWGw=
X-Google-Smtp-Source: APXvYqxqQlOybML9uCWbe/MoL/jgru9wv6+NI5M4mgv11ipqOValRfyBdvX5/s2dKBHNuPhH0YVG1A==
X-Received: by 2002:a5d:5345:: with SMTP id t5mr32018009wrv.0.1580234273471;
        Tue, 28 Jan 2020 09:57:53 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o4sm27065193wrx.25.2020.01.28.09.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 09:57:53 -0800 (PST)
Date:   Tue, 28 Jan 2020 18:57:51 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.6
Message-ID: <20200128175751.GA35649@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: 283bab9809786cf41798512f5c1e97f4b679ba96 x86/cpu: Remove redundant cpu_detect_cache_sizes() call

The biggest change in this cycle was a large series from Sean 
Christopherson to clean up the handling of VMX features. This both fixes 
bugs/inconsistencies and makes the code more coherent and future-proof.

There are also two cleanups and a minor TSX syslog messages enhancement.

 Thanks,

	Ingo

------------------>
Borislav Petkov (2):
      x86/bugs: Move enum taa_mitigations to bugs.c
      x86/cpu/tsx: Define pr_fmt()

Sean Christopherson (20):
      x86/msr-index: Clean up bit defines for IA32_FEATURE_CONTROL MSR
      selftests, kvm: Replace manual MSR defs with common msr-index.h
      tools/x86: Sync msr-index.h from kernel sources
      x86/intel: Initialize IA32_FEAT_CTL MSR at boot
      x86/mce: WARN once if IA32_FEAT_CTL MSR is left unlocked
      x86/centaur: Use common IA32_FEAT_CTL MSR initialization
      x86/zhaoxin: Use common IA32_FEAT_CTL MSR initialization
      x86/cpu: Clear VMX feature flag if VMX is not fully enabled
      x86/vmx: Introduce VMX_FEATURES_*
      x86/cpu: Detect VMX features on Intel, Centaur and Zhaoxin CPUs
      x86/cpu: Print VMX flags in /proc/cpuinfo using VMX_FEATURES_*
      x86/cpu: Set synthetic VMX cpufeatures during init_ia32_feat_ctl()
      x86/cpufeatures: Add flag to track whether MSR IA32_FEAT_CTL is configured
      KVM: VMX: Drop initialization of IA32_FEAT_CTL MSR
      KVM: VMX: Use VMX feature flag to query BIOS enabling
      KVM: VMX: Check for full VMX support when verifying CPU compatibility
      KVM: VMX: Use VMX_FEATURE_* flags to define VMCS control bits
      perf/x86: Provide stubs of KVM helpers for non-Intel CPUs
      KVM: VMX: Allow KVM_INTEL when building for Centaur and/or Zhaoxin CPUs
      x86/cpu: Print "VMX disabled" error message iff KVM is enabled

Tony W Wang-oc (1):
      x86/cpu: Remove redundant cpu_detect_cache_sizes() call


