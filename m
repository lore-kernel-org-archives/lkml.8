Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B8BC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A29824672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582882589;
	bh=/7OP3Am9UxUSfFUwAl7HdgQzAmOm7Fzv8SdJOkAvDSI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uHXfRTChyDltlY0Fkq31sM1s+hoThOjh5J5hEy4XYvqSDzE7rQ4Ib29X2Eq3ndgUt
	 /cKmmrk2/NKX+LGX0LcKg1R+6y8vmR5U3kaKq1xlDYrLQZuUG5F2cEKjtyyeVG7k7G
	 DlmJOTJ3pszQQmxef3QqHppleegArtuERdmC95qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgB1Jg2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:36:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726875AbgB1Jg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:36:27 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-HGP-EOL_MOK3CoN6k2mXyQ-1; Fri, 28 Feb 2020 04:36:22 -0500
X-MC-Unique: HGP-EOL_MOK3CoN6k2mXyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CADA48017CC;
        Fri, 28 Feb 2020 09:36:20 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A2938C09C;
        Fri, 28 Feb 2020 09:36:17 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCHv3 0/5] perf expr: Add flex scanner
Date:   Fri, 28 Feb 2020 10:36:11 +0100
Message-Id: <20200228093616.67125-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
while preparing changes for user defined metric expressions
I also moved the expression manual parser to flex.

The reason is to have an easy and reasonable way to support
and parse multiple user-defined metric expressions from
command line or file.

I was posponing the change, but I just saw another update to
the expr manual scanner (from Kajol Jain), so cherry picked
just the expr flex code changes to get it out.

Kajol Jain,
I think it should ease up your change for unknown values marked
by '?'. Would you consider rebasing your changes on top of this?


v3 changes:
  - keep the EXPR_MAX_OTHER not too high (Andi)
  - add normalize call to flexer, so we have all symbols covered [kajoljain]

v2 changes:
  - handle special chars properly
  - fix return value for expr__parse

Available also in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric_flex

thanks,
jirka


---
Jiri Olsa (5):
      perf expr: Add expr.c object
      perf expr: Move expr lexer to flex
      perf expr: Increase EXPR_MAX_OTHER
      perf expr: Straighten expr__parse/expr__find_other interface
      perf expr: Make expr__parse return -1 on error

 tools/perf/tests/expr.c       |  10 +++----
 tools/perf/util/Build         |  11 +++++++-
 tools/perf/util/expr.c        | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        |   8 ++----
 tools/perf/util/expr.l        | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.y        | 185 +++++++++++++++++++++----------------------------------------------------------------------------------------------------
 tools/perf/util/stat-shadow.c |   4 +--
 7 files changed, 276 insertions(+), 168 deletions(-)
 create mode 100644 tools/perf/util/expr.c
 create mode 100644 tools/perf/util/expr.l

