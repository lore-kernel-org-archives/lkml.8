Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52BDC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928E9246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898427;
	bh=zHdIjjQbQLQMg072pTF2APPhoR6PEVtUdwWCI8GoZQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=myqdbSpSxCtSUpyRNA4r/02EDIfHgpW9KASP4MJgX1uhVZtXx3/S2p4nyecOdjPhJ
	 yG4yBShuRGyXp0YCnGXBC7ZA51PbGJEKMcKoeHnBSvpL6ByULbHYqHwDDzs0N9cWJd
	 Dn+hv32jyHNDBvAcd97p2KZevWeqMHVf0zFYV+J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgB1OA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgB1OAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:00:25 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A269C246B0;
        Fri, 28 Feb 2020 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898425;
        bh=zHdIjjQbQLQMg072pTF2APPhoR6PEVtUdwWCI8GoZQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBmEvCOzGGb8CjaJyG385k1BOO0cVAwPbmOosXYA1KiQd9xNp3a5AQH+QVz6TWG9Q
         fnp6SGCTk8Ld5pG1oXhcb7zGOjG/DeG64z47US4kXCiEulZSMAzoaXiT2ieYmW/wJ3
         DY9YSg5nVFoAjHPWdkBybJ7uncwxR//6oXE4XugM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Kim Phillips <kim.phillips@amd.com>
Subject: [PATCH 01/15] tools arch x86: Sync the msr-index.h copy with the kernel sources
Date:   Fri, 28 Feb 2020 11:00:00 -0300
Message-Id: <20200228140014.1236-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick up the changes from these csets:

  21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF")

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ git diff
  diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
  index ebe1685e92dd..d5e517d1c3dd 100644
  --- a/tools/arch/x86/include/asm/msr-index.h
  +++ b/tools/arch/x86/include/asm/msr-index.h
  @@ -512,6 +512,8 @@
   #define MSR_K7_HWCR                    0xc0010015
   #define MSR_K7_HWCR_SMMLOCK_BIT                0
   #define MSR_K7_HWCR_SMMLOCK            BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
  +#define MSR_K7_HWCR_IRPERF_EN_BIT      30
  +#define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
   #define MSR_K7_FID_VID_CTL             0xc0010041
   #define MSR_K7_FID_VID_STATUS          0xc0010042
  $

That don't result in any change in tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index ebe1685e92dd..d5e517d1c3dd 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -512,6 +512,8 @@
 #define MSR_K7_HWCR			0xc0010015
 #define MSR_K7_HWCR_SMMLOCK_BIT		0
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_HWCR_IRPERF_EN_BIT	30
+#define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 
-- 
2.21.1

