Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B085FC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812FC20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 08:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582532971;
	bh=FWNamR9M47TzLk9tOqnRtoNRd3YMo/ZiaBvXFUDXsh0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=uxd5fC1DMrrI6jHqGlWsDHoR05iuaXzJ+jxMxyTORSQW8fIcBoWE/WMmId++HoHAm
	 +d1bhFx9fu35b/WCNU1B9DxMTaSVz3xEcSSJNSwk2jnq6gKP7aWHDioEXVKTT42fTR
	 kJcssZolHnPZemiLOWL7X1JIBTOZ4ov6n1POoQfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbgBXI3a convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 03:29:30 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37428 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbgBXI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 03:29:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-z-P-SpuqO9aP6hr7_tNl8Q-1; Mon, 24 Feb 2020 03:29:25 -0500
X-MC-Unique: z-P-SpuqO9aP6hr7_tNl8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36FA113E2;
        Mon, 24 Feb 2020 08:29:23 +0000 (UTC)
Received: from krava.redhat.com (ovpn-205-68.brq.redhat.com [10.40.205.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD7BE85781;
        Mon, 24 Feb 2020 08:29:19 +0000 (UTC)
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
Subject: [PATCHv2 0/5] perf expr: Add flex scanner
Date:   Mon, 24 Feb 2020 09:29:13 +0100
Message-Id: <20200224082918.58489-1-jolsa@kernel.org>
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

 tools/perf/tests/expr.c       |  10 +++---
 tools/perf/util/Build         |  11 ++++++-
 tools/perf/util/expr.c        | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        |   8 ++---
 tools/perf/util/expr.l        |  87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.y        | 208 ++++++++++++++++++++++++++++++++-----------------------------------------------------------------------------------------
 tools/perf/util/stat-shadow.c |   4 +--
 7 files changed, 272 insertions(+), 168 deletions(-)
 create mode 100644 tools/perf/util/expr.c
 create mode 100644 tools/perf/util/expr.l

