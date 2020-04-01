Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96271C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE32078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QmCo1b5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbgDAPdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:33:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24187 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732799AbgDAPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:33:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585755216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=8JHRCFd1oXn6L8SvLvSkk2sGlOqpoRxgSzYpaPG5G2Q=;
        b=QmCo1b5vpCpwyYKR1GdphLgxVdwq7IgkFnejkuIKYn9XWasEUezENIBbtaqpV73ycjyMg9
        hDoRCgRZn3QCdCa+4Zz4utgp2kkqUkjwFjWXB7o1W2FsSDbqjsWdqWNtVjyRP0TX5XisfX
        CXDBxzlLX8XSkFtTscfV/2s9wRDtTbo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-7hmq2t2wOKGYzHqVhT2enw-1; Wed, 01 Apr 2020 11:33:32 -0400
X-MC-Unique: 7hmq2t2wOKGYzHqVhT2enw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D51E3100551A;
        Wed,  1 Apr 2020 15:33:30 +0000 (UTC)
Received: from quaco.ghostprotocols.net (unknown [10.3.128.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EBB795E009;
        Wed,  1 Apr 2020 15:33:29 +0000 (UTC)
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 352D0409A3; Wed,  1 Apr 2020 12:33:25 -0300 (-03)
Date:   Wed, 1 Apr 2020 12:33:25 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1 FYI] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <20200401153325.GC12534@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

	Just a FYI about this tooling capability:

        perf trace -e msr:* --filter=msr==IA32_CORE_CAPS

or:

        perf trace -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'

And see only those MSRs being accessed via:

  # perf trace -v -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'
  New filter for msr:read_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:write_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:rdpmc: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)

Cheers,

- Arnaldo

---

To pick up the changes in:

  6650cdd9a8cc ("x86/split_lock: Enable split lock detection by kernel")

Addressing this warning when build tools/perf:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Which causes these changes in tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  --- before	2020-04-01 12:11:14.789344795 -0300
  +++ after	2020-04-01 12:11:56.907798879 -0300
  @@ -10,6 +10,7 @@
   	[0x00000029] = "KNC_EVNTSEL1",
   	[0x0000002a] = "IA32_EBL_CR_POWERON",
   	[0x0000002c] = "EBC_FREQUENCY_ID",
  +	[0x00000033] = "TEST_CTRL",
   	[0x00000034] = "SMI_COUNT",
   	[0x0000003a] = "IA32_FEAT_CTL",
   	[0x0000003b] = "IA32_TSC_ADJUST",
  @@ -27,6 +28,7 @@
   	[0x000000c2] = "IA32_PERFCTR1",
   	[0x000000cd] = "FSB_FREQ",
   	[0x000000ce] = "PLATFORM_INFO",
  +	[0x000000cf] = "IA32_CORE_CAPS",
   	[0x000000e2] = "PKG_CST_CONFIG_CONTROL",
   	[0x000000e7] = "IA32_MPERF",
   	[0x000000e8] = "IA32_APERF",
  $

  $ make -C tools/perf O=/tmp/build/perf install-bin
  <SNIP>
    CC       /tmp/build/perf/trace/beauty/tracepoints/x86_msr.o
    LD       /tmp/build/perf/trace/beauty/tracepoints/perf-in.o
    LD       /tmp/build/perf/trace/beauty/perf-in.o
    LD       /tmp/build/perf/perf-in.o
    LINK     /tmp/build/perf/perf
  <SNIP>

Now one can do:

	perf trace -e msr:* --filter=msr==IA32_CORE_CAPS

or:

	perf trace -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'

And see only those MSRs being accessed via:

  # perf trace -v -e msr:* --filter='msr==IA32_CORE_CAPS || msr==TEST_CTRL'
  New filter for msr:read_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:write_msr: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)
  New filter for msr:rdpmc: (msr==0xcf || msr==0x33) && (common_pid != 8263 && common_pid != 23250)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index d5e517d1c3dd..12c9684d59ba 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -41,6 +41,10 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_TEST_CTRL				0x00000033
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT	29
+#define MSR_TEST_CTRL_SPLIT_LOCK_DETECT		BIT(MSR_TEST_CTRL_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
 #define SPEC_CTRL_IBRS			BIT(0)	   /* Indirect Branch Restricted Speculation */
 #define SPEC_CTRL_STIBP_SHIFT		1	   /* Single Thread Indirect Branch Predictor (STIBP) bit */
@@ -70,6 +74,11 @@
  */
 #define MSR_IA32_UMWAIT_CONTROL_TIME_MASK	(~0x03U)
 
+/* Abbreviated from Intel SDM name IA32_CORE_CAPABILITIES */
+#define MSR_IA32_CORE_CAPS			  0x000000cf
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT  5
+#define MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT	  BIT(MSR_IA32_CORE_CAPS_SPLIT_LOCK_DETECT_BIT)
+
 #define MSR_PKG_CST_CONFIG_CONTROL	0x000000e2
 #define NHM_C3_AUTO_DEMOTE		(1UL << 25)
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
-- 
2.21.1

