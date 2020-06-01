Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1185DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E06A0206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591029811;
	bh=SiEJn+cOwzvhSgNCIqeh95ymuEUTelU4wdjA9h0Zpjc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=L6DEZO5lO5cDGH9a2eMXBIYYvY8QTo6hCrAppCrojt+3NVdN5WqOwQW3SqJ7B+U0L
	 vLbqoeXNPJZv50YWHi40/KVNAMJ1qSP/OKK152KacZgoibCbRhvBxqSKCEOkscqdWg
	 xXUMfYYVdupPHPLE+8W4RwjPtXBVJAqxwQwA+cXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgFAQnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFAQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:43:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C791C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:43:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so489604wrc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=29TWkmKityh2OmaxlGu3xjS1ye22PwX1Vjw2ZiZ4cvE=;
        b=RnVuqSFUaz2DFK9gcS7zk7hWaEzJ6dYAYnfv50+SV7eVYROcOO/aBSO5xy0chW4oTX
         hq0S7xOJKkBp0VmDyQms3ai9qyM94f5wi1lbzjZpM9zS7huGCcLRy7ALMj2RTodRMcPg
         b7un4S8lqDffYFQmS6Tt8WwVd1xel3gDZrCK4OBLPWrDL6/qNfFhIhGfUmBDiSOIKXas
         nih4nz/Ngk4KX6wzPz64d0nqbv9+0bRn+y7w9N69ZvF1Ofvtg5P4iZ40KEsH9O56Qsk5
         36Eihj9ButXdpJc4Hq7XUtM/I/kx6C7CJopVVrhM7OU5+FR+WhywnpZ6RL4S52A9mbtC
         BYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=29TWkmKityh2OmaxlGu3xjS1ye22PwX1Vjw2ZiZ4cvE=;
        b=aRuqfM/P0/khh3Ds6Mr2i/vRqyZLqhQkpvVnS1s5WI0zabevfhSBLg8fIwSLpelWOF
         a2f5yIuNZ9qOYjgz2Ma8pe9C6vTDipOSrH/iL8OCP2tWJ3AvVRbTx7A/MQu9BHu1ndo9
         NRLT4vOTmcQIUmCu9ApFJwE/i7PodyTjtn4dHGz654+klFTvS6kLrE8SFlw6DMstWxAS
         I5HcLMcxobmEa5z/yXgzaFqWy3YYBG4i0M4ha/p8TCNiz3oBjCJ/Bnk3xfzJnQfMHhzx
         BJrtKpNpVkXsF/36w5r3C7q8Trd0DSRVWi3cv0lebrGys8JdLd9I0bQav+2/AW9r+nc6
         EfpA==
X-Gm-Message-State: AOAM531qAI88IwQJL2bgeD4o28hwhfR2veQkn22pENeK63XRLc9rUNHB
        mr1dI/h06/7Bhk+mPDYp8c4=
X-Google-Smtp-Source: ABdhPJyRCXe83nKHdzBlOYFHce7Jb/213AqasXi8lOUttb2xb91UVl+vF6NAMbRoHjtK6NKqDdjhSQ==
X-Received: by 2002:a5d:4701:: with SMTP id y1mr22143719wrq.310.1591029809137;
        Mon, 01 Jun 2020 09:43:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 1sm202753wmz.13.2020.06.01.09.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:43:28 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:43:26 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v5.8
Message-ID: <20200601164326.GA1260535@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/cpu git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-2020-06-01

   # HEAD: 3d81b3d1e55a518837c3d1f722c6d93abe34aa85 x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h

Misc updates:

 - Extend the x86 family/model macros with a steppings dimension,
   because x86 life isn't complex enough and Intel uses steppings to
   differentiate between different CPUs. :-/

 - Convert the TSC deadline timer quirks to the steppings macros.

 - Clean up asm mnemonics.

 - Fix the handling of an AMD erratum, or in other words, fix a kernel erratum.

Signed-off-by: Ingo Molnar <mingo@kernel.org>

  out-of-topic modifications in x86/cpu:
  ----------------------------------------
  include/linux/mod_devicetable.h    # e9d7144597b1: x86/cpu: Add a steppings fie

 Thanks,

	Ingo

------------------>
Borislav Petkov (2):
      x86/cpu: Add a X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS() macro
      x86/apic: Convert the TSC deadline timer matching to steppings macro

Kim Phillips (1):
      x86/cpu/amd: Make erratum #1054 a legacy erratum

Mark Gross (1):
      x86/cpu: Add a steppings field to struct x86_cpu_id

Uros Bizjak (2):
      x86/cpu: Use INVPCID mnemonic in invpcid.h
      x86/cpu: Use RDRAND and RDSEED mnemonics in archrandom.h


 arch/x86/include/asm/archrandom.h    | 26 +++++-----------
 arch/x86/include/asm/cpu_device_id.h | 31 ++++++++++++++++++--
 arch/x86/include/asm/invpcid.h       |  7 ++---
 arch/x86/kernel/apic/apic.c          | 57 ++++++++----------------------------
 arch/x86/kernel/cpu/amd.c            |  3 +-
 arch/x86/kernel/cpu/match.c          |  7 ++++-
 include/linux/mod_devicetable.h      |  2 ++
 7 files changed, 59 insertions(+), 74 deletions(-)
