Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A1FC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6A3207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582327188;
	bh=EoSuApvz6JnO8zR+ryOwz6Q+9IHlq43BC+a9n20lGpU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G2cSSdZcNZ8DNCPqdb8oOeZN8PQBsIcaxK8E4CueUAiv5HqDn8AYH5bDf/mk3veUO
	 8pu2XR2x5INQ2hJHk67O4qlMbc3yZb3jeDT7k9SclIEFkS+bj3jNx/q3CG6PAmVGTO
	 GJvtYT6GN8yX8FrIh0I/3rW0tY2VlEudEom2Y9GE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgBUXTr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:19:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33312 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgBUXTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:19:46 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-Xc3R4icMNLag4_uDGsbNuQ-1; Fri, 21 Feb 2020 18:19:41 -0500
X-MC-Unique: Xc3R4icMNLag4_uDGsbNuQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B36D7100550E;
        Fri, 21 Feb 2020 23:19:39 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 670AE60499;
        Fri, 21 Feb 2020 23:19:36 +0000 (UTC)
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
Subject: [RFC 0/4] perf expr: Add flex scanner
Date:   Sat, 22 Feb 2020 00:19:31 +0100
Message-Id: <20200221231935.735145-1-jolsa@kernel.org>
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


Available also in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric_flex

thanks,
jirka


---
Jiri Olsa (4):
      perf expr: Add expr.c object
      perf expr: Move expr lexer to flex
      perf expr: Increase EXPR_MAX_OTHER
      perf expr: Straighten expr__parse/expr__find_other interface

 tools/perf/tests/expr.c       |   6 ++--
 tools/perf/util/Build         |  11 +++++++-
 tools/perf/util/expr.c        | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.h        |   8 ++----
 tools/perf/util/expr.l        |  83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.y        | 185 +++++++++++++++++++++----------------------------------------------------------------------------------------------------
 tools/perf/util/stat-shadow.c |   4 +--
 7 files changed, 242 insertions(+), 166 deletions(-)
 create mode 100644 tools/perf/util/expr.c
 create mode 100644 tools/perf/util/expr.l

