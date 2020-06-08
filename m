Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD539C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CC6206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 13:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QdtkN0Q9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgFHNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 09:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFHNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:50:20 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB4FC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 06:50:20 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so17462549wrw.9
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uvwgW89KNJaCpkAay5Bmt5Q5u2ENn3zZzl6ZGX4sCzs=;
        b=QdtkN0Q9RhALxTt6SR7EAnfG+MxLms9iFM1XlfFaX0Xwax8Yy7wnlMt9Q4uqkWNiNO
         yQcijaXgdzVVThzSCn1F39bQPrgg8Epv3ZU/I9X2WPoqLaobrA/VXlhp7L5Wpo+mZEzk
         umMCiPHVf3iLmTUC9l6VPIRYd/3wlECWqnFKKO2yQ24XXVWUmu4KJaLZ9vLeNXXBX8qt
         Z1xEpquBVDkr2nAeHkeNe2k3DoSeeM5/eif9NWZvMF0cDrH9pAe6xOLbr33B5mP9goDa
         3WcenuwKEHCmcNsaARbkiGPI3ePRu8Y/5rcenAcFP0bd6IQzgXUrCS//aYArpnR4jmLH
         /2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uvwgW89KNJaCpkAay5Bmt5Q5u2ENn3zZzl6ZGX4sCzs=;
        b=Fk6qBHU8PDgFTw8S/qJRaFZCJ6tjl5TjMuRP6zke08AkCTL/jHNz0wgEI6Io3S8J1R
         qhYMCWH6sqi3eYA26qgEaHDwxoYQ2Ce/7eCX9lXUcN20pCDvR8WY8b0fjcMTrvhvDi5o
         ELF5Dsbubik/m+0fbW929YbvntdYtHXnWsAIcgtzBIWIkOOSYBdqYxztipO6bgNp9m34
         2Yj5BBusQx2AzumDyNb91llPMl1H+Ucy3zhG2dt3aJmORnhsFU30Du6Qv02WNQ2RyTX1
         n1Ch/+n/0AO4NXaasW5RDdK3S5sDuZkArbuGYsJfTEuGpR0v/QeJaTysjPyhBDhNmoBv
         2sEA==
X-Gm-Message-State: AOAM530UYqZKMcEob+Aw9b6H7D+XbEDRHifKvwL2tCNoPMcyn9GMbQno
        tamBP1u5BiVCW3ULzB3zeXLG5oB2cHs=
X-Google-Smtp-Source: ABdhPJwXhuwBVRp078X1AQ9dwW6AAdWmm8G4+q5L37eauA5bHgAS+mkxL5jmNO0JlGeaG6UMB4wowg==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr23168437wrq.420.1591624219092;
        Mon, 08 Jun 2020 06:50:19 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h15sm22724547wrt.73.2020.06.08.06.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 06:50:18 -0700 (PDT)
Date:   Mon, 8 Jun 2020 14:50:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-ID: <20200608135016.5pdxidpepjujqw6b@holly.lan>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
 <20200605142953.GP2750@hirez.programming.kicks-ass.net>
 <20200605144457.GD2948@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605144457.GD2948@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 04:44:57PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 05, 2020 at 04:29:53PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > > placement. If the debugger is commanded to place a breakpoint at an
> > > address then it will do so even if that breakpoint results in kgdb
> > > becoming inoperable.
> > > 
> > > A stop-the-world debugger with memory peek/poke does intrinsically
> > > provide its operator with the means to hose their system in all manner
> > > of exciting ways (not least because stopping-the-world is already a DoS
> > > attack ;-) ) but the current no safety rail approach is not easy to
> > > defend, especially given kprobes provides us with plenty of machinery to
> > > mark parts of the kernel where breakpointing is discouraged.
> > > 
> > > This patchset introduces some safety rails by using the existing
> > > kprobes infrastructure. It does not cover all locations where
> > > breakpoints can cause trouble but it will definitely block off several
> > > avenues, including the architecture specific parts that are handled by
> > > arch_within_kprobe_blacklist().
> > > 
> > > This patch is an RFC because:
> > > 
> > > 1. My workstation is still chugging through the compile testing.
> > > 
> > > 2. Patch 4 needs more runtime testing.
> > > 
> > > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> > >    more review especially for its impact on arch specific code.
> > > 
> > > To be clear I do plan to do the detailed review of the kprobe blacklist
> > > stuff but would like to check the direction of travel first since the
> > > change is already surprisingly big and maybe there's a better way to
> > > organise things.
> > 
> > Thanks for doing these patches, esp 1-3 look very good to me.
> > 
> > I've taken the liberty to bounce the entire set to Masami-San, who is
> > the kprobes maintainer for comments as well.
> 
> OK, after having had a second look, one thing we can perhaps address
> with the last patch, or perhaps on top of that, is extending the
> kprobes_blacklist() with data regions.
> 
> Because these patches only exclude kgdb from setting breakpoints on
> code; data breakpoints do not match what we do with
> arch_build_bp_info().

Right, my patches will only affect the code paths where kgdb sets
software breakpoints.

In principle h/w breakpoints, whether they are code or data, should be
able to rely on hw_breakpoint_arch_parse() and any errors from the hw
breakpoint API will propagate into the kgdb core and do the right
thing.

In practice it looks like kgdb/x86/hw_breakpoint have plumbed together
in a manner that circumvents the parse (and therefore#
arch_build_bp_info() never runs). Rather the h/w/ break problem using
the kprobe blacklist I think we could just fix these code paths.

The following is 100% untested (not even compile) and I copied a line
or two from register_perf_hw_breakpoint() without checking what they
do ;-). Nevertheless I hope it gives a clear idea about what I am
talking about! If this was developed into a "real" patch then I think
dbg_release_bp_slot() should perhaps be replaced with a better API that
doesn't bypass the checks rather than solving everything in kgdb.c .


Daniel.


diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index c44fe7d8d9a4..64ac0ee9b55c 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -223,11 +223,12 @@ static void kgdb_correct_hw_break(void)
 		hw_breakpoint_restore();
 }
 
-static int hw_break_reserve_slot(int breakno)
+static int kgdb_register_hw_break(int breakno)
 {
 	int cpu;
 	int cnt = 0;
 	struct perf_event **pevent;
+        struct arch_hw_breakpoint hw = { };
 
 	if (dbg_is_early)
 		return 0;
@@ -237,6 +238,11 @@ static int hw_break_reserve_slot(int breakno)
 		pevent = per_cpu_ptr(breakinfo[breakno].pev, cpu);
 		if (dbg_reserve_bp_slot(*pevent))
 			goto fail;
+		if (hw_breakpoint_arch_parse(*pevent, &(*pevent)->attr, hw)) {
+			cnt++;
+			goto fail;
+		}
+		(*pevent)->hw.info = hw;
 	}
 
 	return 0;
@@ -361,7 +367,7 @@ kgdb_set_hw_break(unsigned long addr, int len, enum kgdb_bptype bptype)
 		return -1;
 	}
 	breakinfo[i].addr = addr;
-	if (hw_break_reserve_slot(i)) {
+	if (kgdb_register_hw_break(i)) {
 		breakinfo[i].addr = 0;
 		return -1;
 	}
