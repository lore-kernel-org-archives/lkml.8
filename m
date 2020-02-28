Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05822C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A36246B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898467;
	bh=Zr3Ps4Mhr3jVlQ1LrEVMGg4/ITzOkOaobucR6J0OQ1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MEY5c6dxxvuN9mBKDSVa5n60jkkTKb3BBfmbTRMJGVLr4lM+dxU+4gzlOSpyE3JFH
	 P3amMu/jnfhzR+tkvaNoF2Qo3oIx0RfdGH1EhTnLCMwZO+eFXima0fQctrzJE5Mikm
	 qiGFZVuyrW7DI7AKCr50b6f9TIWVW1CMJPbCJNUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgB1OBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgB1OBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:06 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AB1246B7;
        Fri, 28 Feb 2020 14:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898465;
        bh=Zr3Ps4Mhr3jVlQ1LrEVMGg4/ITzOkOaobucR6J0OQ1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=orgelm3WrYjwwdiwZDvo9cAhibdktOJwK+6au+j+7CiHTOaXTaON6qdF8YkEgejzf
         2FvjAkpQUGbanUU9wWTs0PggeeIQkKJ1tH8BhbIrwPWnQxRnNB2LtvU6m5lk3aCxkz
         SxKyTIzfvFthWD/Ayeo/Ckoy3Sewo01zzp4/L1ZI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Song Liu <songliubraving@fb.com>,
        Taeung Song <treeze.taeung@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/15] perf annotate: Fix perf config option description
Date:   Fri, 28 Feb 2020 11:00:08 -0300
Message-Id: <20200228140014.1236-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

perf config annotate options says it works only with TUI, which is wrong.
Most of the TUI options are applicable to stdio2 as well. So remove that
generic line and add individual line with each option stating which
browsers supports that option. Also, annotate.show_nr_samples config is
missing in Documentation. Describe it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Taeung Song <treeze.taeung@gmail.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Yisheng Xie <xieyisheng1@huawei.com>
Link: http://lore.kernel.org/lkml/20200213064306.160480-8-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-config.txt | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c4dd23c4b478..9dae0df3ab7e 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -239,7 +239,6 @@ buildid.*::
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
 annotate.*::
-	These options work only for TUI.
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
@@ -269,6 +268,8 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 		│              return n;
 
+		This option works with tui, stdio2 browsers.
+
         annotate.use_offset::
 		Basing on a first address of a loaded function, offset can be used.
 		Instead of using original addresses of assembly code,
@@ -287,6 +288,8 @@ annotate.*::
 
 		             368:│  mov    0x8(%r14),%rdi
 
+		This option works with tui, stdio2 browsers.
+
 	annotate.jump_arrows::
 		There can be jump instruction among assembly code.
 		Depending on a boolean value of jump_arrows,
@@ -306,6 +309,8 @@ annotate.*::
 		│1330:   mov    %r15,%r10
 		│1333:   cmp    %r15,%r14
 
+		This option works with tui browser.
+
         annotate.show_linenr::
 		When showing source code if this option is 'true',
 		line numbers are printed as below.
@@ -325,6 +330,8 @@ annotate.*::
 		│                     array++;
 		│             }
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_nr_jumps::
 		Let's see a part of assembly code.
 
@@ -335,6 +342,8 @@ annotate.*::
 
 		│1 1382:   movb   $0x1,-0x270(%rbp)
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_total_period::
 		To compare two records on an instruction base, with this option
 		provided, display total number of samples that belong to a line
@@ -348,11 +357,30 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+		This option works with tui, stdio2, stdio browsers.
+
+	annotate.show_nr_samples::
+		By default perf annotate shows percentage of samples. This option
+		can be used to print absolute number of samples. Ex, when set as
+		false:
+
+		Percent│
+		 74.03 │      mov    %fs:0x28,%rax
+
+		When set as true:
+
+		Samples│
+		     6 │      mov    %fs:0x28,%rax
+
+		This option works with tui, stdio2, stdio browsers.
+
 	annotate.offset_level::
 		Default is '1', meaning just jump targets will have offsets show right beside
 		the instruction. When set to '2' 'call' instructions will also have its offsets
 		shown, 3 or higher will show offsets for all instructions.
 
+		This option works with tui, stdio2 browsers.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
-- 
2.21.1

