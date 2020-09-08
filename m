Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A29C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 994C22074D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588295;
	bh=Qoayjoiq0uSKgxLGXmLIhulkMjEAiiCj6O1lrgz1Tlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OZtkhjfBdKViyAbBVi6Urns3+CweNjBhUzLLy8SkjZIhdj+MK9gx2vCSrlKB8LzS7
	 8keaypU2yvWypYXvflgl32GPR20FPe8TMCi0POHcR2P+IA5q9FrnLZvdWZnirORiyZ
	 Kmg+HXfi1lkaR0EYN5KxB4BNHSRb1PdDjaj09utA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgIHSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731525AbgIHQMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39A2247BD;
        Tue,  8 Sep 2020 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580284;
        bh=Qoayjoiq0uSKgxLGXmLIhulkMjEAiiCj6O1lrgz1Tlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHczBkCd87lGh72ECWimUP+jO0BpRQL7NKLePr0ZdKGmZ7BOpHP0Pb8kmXnvI3ogb
         yMESldtRKXZhViwMskFO40FR618A4TIZxS8EhfYaQHOaYnFMl26bTAV5VtyGR1pBhU
         9GWD58rEL7Jz1z64GRx+IX2gFAnVD+31GW5Tuohk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Clarke <pc@us.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Tony Jones <tonyj@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.14 03/65] perf record/stat: Explicitly call out event modifiers in the documentation
Date:   Tue,  8 Sep 2020 17:25:48 +0200
Message-Id: <20200908152217.194473530@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152217.022816723@linuxfoundation.org>
References: <20200908152217.022816723@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

commit e48a73a312ebf19cc3d72aa74985db25c30757c1 upstream.

Event modifiers are not mentioned in the perf record or perf stat
manpages.  Add them to orient new users more effectively by pointing
them to the perf list manpage for details.

Fixes: 2055fdaf8703 ("perf list: Document precise event sampling for AMD IBS")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Paul Clarke <pc@us.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Tony Jones <tonyj@suse.de>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200901215853.276234-1-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/Documentation/perf-record.txt |    4 ++++
 tools/perf/Documentation/perf-stat.txt   |    4 ++++
 2 files changed, 8 insertions(+)

--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -33,6 +33,10 @@ OPTIONS
         - a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
 	  hexadecimal event descriptor.
 
+        - a symbolic or raw PMU event followed by an optional colon
+	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
+	  linkperf:perf-list[1] man page for details on event modifiers.
+
 	- a symbolically formed PMU event like 'pmu/param1=0x3,param2/' where
 	  'param1', 'param2', etc are defined as formats for the PMU in
 	  /sys/bus/event_source/devices/<pmu>/format/*.
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -39,6 +39,10 @@ report::
 	- a raw PMU event (eventsel+umask) in the form of rNNN where NNN is a
 	  hexadecimal event descriptor.
 
+        - a symbolic or raw PMU event followed by an optional colon
+	  and a list of event modifiers, e.g., cpu-cycles:p.  See the
+	  linkperf:perf-list[1] man page for details on event modifiers.
+
 	- a symbolically formed event like 'pmu/param1=0x3,param2/' where
 	  param1 and param2 are defined as formats for the PMU in
 	  /sys/bus/event_source/devices/<pmu>/format/*


