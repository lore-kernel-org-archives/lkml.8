Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7563FC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB22087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBDRPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:15:20 -0500
Received: from mga03.intel.com ([134.134.136.65]:10963 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727367AbgBDRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:15:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 09:15:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,402,1574150400"; 
   d="scan'208";a="279118711"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2020 09:15:18 -0800
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 0/2] Introduce Control-flow Enforcement opcodes
Date:   Tue,  4 Feb 2020 09:14:23 -0800
Message-Id: <20200204171425.28073-1-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Control-flow Enforcement (CET) introduces 10 new instructions [1].  Add
them to the opcode map.  This series has been separated from the CET
patches [2] for ease of review.

[1] Detailed information on CET can be found in "Intel 64 and IA-32
    Architectures Software Developer's Manual":

    https://software.intel.com/en-us/download/intel-64-and-ia-32-
    architectures-sdm-combined-volumes-1-2a-2b-2c-2d-3a-3b-3c-3d-and-4

[2] CET patches:

    https://lkml.kernel.org/r/20190813205225.12032-1-yu-cheng.yu@intel.com/
    https://lkml.kernel.org/r/20190813205359.12196-1-yu-cheng.yu@intel.com/

Adrian Hunter (1):
  x86/insn: perf tools: Add CET instructions to the new instructions
    test

Yu-cheng Yu (1):
  x86/insn: Add Control-flow Enforcement (CET) instructions to the
    opcode map

 arch/x86/lib/x86-opcode-map.txt              |  17 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  17 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 112 +++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 196 +++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 236 +++++++++++++++++++
 5 files changed, 566 insertions(+), 12 deletions(-)

-- 
2.21.0

