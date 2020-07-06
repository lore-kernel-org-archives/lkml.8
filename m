Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55707C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF7420786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GxlPDIG4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgGFStt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729569AbgGFStt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:49:49 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FC2C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 11:49:49 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b25so8387227qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yv+2qoUkWJkOmSkuD+6Zhek3EagvDoaLy45NE8bixuo=;
        b=GxlPDIG45LTTDD1kWDdmX1M7FoMxCNKnp2QZoNVs7Bj+I6LP46Fu4TmbCETmGBBLre
         M2xPXnTO+hZrIdnhmYd/s+pqJgyLIBxxd4NbnnP1Fo0n9wOwQx43zbPbR5/9XI2nIwq6
         Ae7DkB6OB5n4XZsnXynaQYoziDwCfKtJpEIPudHglE4Do+lZrDkv3rmGu+ryUpxydl9N
         dQpiU8kkJagmxBndydK0X4WFB2r71VhszefjXI14leVWNO3WviIGzjhTrAX4mgpaeuW0
         B2tRhAOpHHej7XJ+2aztGiRBHpWoI1fRAXnu5PaBOkNvgwQtPxNVRGlM2PGj4tNCqydN
         npQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yv+2qoUkWJkOmSkuD+6Zhek3EagvDoaLy45NE8bixuo=;
        b=l6Zj8vnAqozB4v6JYlUDC0wcYSAVFvrwkrakDDukmNAJPcyYjlHt7UmA+Hp19gv+QT
         jqKsML1ywgw0cqdONyMdDK1YnkbWVe8DZdXwpaRFTPjwxD2Qy7/TqyIPb3chYJA6w9xn
         3D/+U1rY1Yprdy3M+EP3FvTFPZ9wSHG+ZivFolQIXPTo3tGbLh9gNN0mENMcORmMJemk
         Ig88XwivkLfYjpR5KvM2sr6TibwZiWZ65WmZyCrNJlF5B3Yx4WH6yMkR7GjFli3y+2mQ
         s/P3/cHvB5mG7XpYG560kkMdJIP5fOfpy1C1SQmnyBw3BggDGW2endRSVlxtXPxNCaqR
         tA0A==
X-Gm-Message-State: AOAM531fkqddhkB6p2uEoGLkO8wsqMsU1c/LP0JASpMdrXS05JpV2V6u
        EksS/Btp/2jKDAnZ80ezyNJ8CQ==
X-Google-Smtp-Source: ABdhPJylhDHloqwwJwH4Qg87S7gSuhUeV+LtjYzV0qcJFznYAkiiHitnSWUEUNpclYrULZu1AnFKAQ==
X-Received: by 2002:ac8:1305:: with SMTP id e5mr51177762qtj.78.1594061388370;
        Mon, 06 Jul 2020 11:49:48 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a68sm5341658qkc.110.2020.07.06.11.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 11:49:47 -0700 (PDT)
Date:   Mon, 6 Jul 2020 14:49:41 -0400
From:   Qian Cai <cai@lca.pw>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [kernel/smp] 5408b78b7a: BUG:KASAN:out-of-bounds_in_c
Message-ID: <20200706184941.GA1651@lca.pw>
References: <20200705082603.GX3874@shao2-debian>
 <20200705173703.GR9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705173703.GR9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 10:37:03AM -0700, Paul E. McKenney wrote:
> Good catch, but someone beat you to it.  This commit contains the fix:
> 
> 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")

Well, I can still reproduce this on next-20200706 which contains the said fix.

CSD_LOCK_WAIT_DEBUG=n

commit 0504bc41a62c4a42b9316244da7208feca7295cb
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue Jun 30 13:22:54 2020 -0700

    kernel/smp: Provide CSD lock timeout diagnostics

    This commit causes csd_lock_wait() to emit diagnostics when a CPU fails
    to respond quickly enough to one of the smp_call_function() family of
    function calls.  These diagnostics include NMI stack traces, and so the
    exclusion of idle CPUs is also removed.  These diagnostics are enabled
    by a new CSD_LOCK_WAIT_DEBUG Kconfig option that depends on DEBUG_KERNEL.

    This commit was inspired by an earlier patch by Josef Bacik.

    [ paulmck: Avoid 64-bit divides per kernel test robot feedback. ]
    [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
    Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
    Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

[19929.567055][    T0] BUG: KASAN: out-of-bounds in flush_smp_call_function_queue+0x65f/0x7c0
csd_lock_record at kernel/smp.c:119
(inlined by) flush_smp_call_function_queue at kernel/smp.c:395
[19929.575391][    T0] Read of size 8 at addr ffffc900320879b8 by task swapper/35/0
[19929.582845][    T0] 
[19929.585060][    T0] CPU: 35 PID: 0 Comm: swapper/35 Tainted: G           O      5.8.0-rc3-next-20200706 #1
[19929.594784][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
[19929.604072][    T0] Call Trace:
[19929.607253][    T0]  dump_stack+0x9d/0xe0
[19929.611304][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
[19929.617355][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
[19929.623415][    T0]  print_address_description.constprop.8.cold.9+0x56/0x4fc
[19929.630521][    T0]  ? log_store.cold.32+0x11/0x11
[19929.635353][    T0]  ? lock_downgrade+0x720/0x720
[19929.640097][    T0]  ? nr_iowait_cpu+0x78/0xf0
[19929.644576][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
[19929.650625][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
[19929.656674][    T0]  kasan_report.cold.10+0x37/0x7c
[19929.661587][    T0]  ? flush_smp_call_function_queue+0x65f/0x7c0
[19929.667647][    T0]  flush_smp_call_function_queue+0x65f/0x7c0
[19929.673535][    T0]  flush_smp_call_function_from_idle+0x41/0x71
[19929.679598][    T0]  do_idle+0x2d6/0x4f0
[19929.683557][    T0]  ? arch_cpu_idle_exit+0x40/0x40
[19929.688480][    T0]  cpu_startup_entry+0x14/0x16
[19929.693143][    T0]  secondary_startup_64+0xb6/0xc0
[19929.698059][    T0] 
[19929.700270][    T0] 
[19929.702476][    T0] Memory state around the buggy address:
[19929.708007][    T0]  ffffc90032087880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[19929.715986][    T0]  ffffc90032087900: 00 00 f2 f2 00 00 00 00 00 00 00 00 00 00 00 00
[19929.723963][    T0] >ffffc90032087980: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
[19929.731940][    T0]                                            ^
[19929.737999][    T0]  ffffc90032087a00: 00 00 00 f2 f2 f2 00 00 00 00 00 00 00 00 00 00
[19929.745982][    T0]  ffffc90032087a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
