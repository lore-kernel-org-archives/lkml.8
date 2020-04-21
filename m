Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C48C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A344F206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587492839;
	bh=1r2YT2MwVBclZi0yBJtvnmVPr+pwRzYsdkT5t1PhyWo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=SIpMiDui4TUMcEaHFZJuaxowPyRaklQiVyI8T58XQGFmQWIaGQM39rv51k0h+200e
	 ou8F6y88GRl8W+lRaEweJObegg3AUuNbJPtaQV2va1WTqzOGFCtzuI9pid6X5oOOeC
	 f0pC9uAZkP0u5U2MFN9voVVTlJ7gDr+qWDQGHokY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgDUSN6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:13:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53048 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729083AbgDUSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:13:56 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-8jo4PPKNN6GUc1SdNnEATA-1; Tue, 21 Apr 2020 14:13:47 -0400
X-MC-Unique: 8jo4PPKNN6GUc1SdNnEATA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7ED8107ACC4;
        Tue, 21 Apr 2020 18:13:43 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EC6FB3A76;
        Tue, 21 Apr 2020 18:13:38 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCHv2 0/3] perf tools: Add support for user defined metric
Date:   Tue, 21 Apr 2020 20:13:33 +0200
Message-Id: <20200421181337.988681-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Joe asked for possibility to add user defined metrics. Given that
we already have metrics support, I added --metrics-file option that
allows to specify custom metrics.

  $ cat metrics
  # IPC
  mine1 = instructions / cycles;
  /* DECODED_ICACHE_UOPS% */
  mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));

  $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
  #           time       insn per cycle                mine1                mine2
       1.000536263                0.71                   0.7                 41.4
       2.002069025                0.31                   0.3                 14.1
       3.003427684                0.27                   0.3                 14.8
       4.004807132                0.25                   0.2                 12.1
  ...

v2 changes:
  - add new --metrics-file option
  - rebased on current perf/core expression bison/flex enhancements

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thanks,
jirka


---
Jiri Olsa (3):
      perf expr: Add parsing support for multiple expressions
      perf expr: Allow comments in custom metric file
      perf stat: Add --metrics-file option

 tools/perf/Documentation/perf-stat.txt |  3 +++
 tools/perf/builtin-stat.c              |  7 +++++--
 tools/perf/tests/expr.c                | 13 +++++++++++++
 tools/perf/util/expr.c                 |  6 ++++++
 tools/perf/util/expr.h                 | 19 +++++++++++++++++--
 tools/perf/util/expr.l                 | 24 ++++++++++++++++++++++++
 tools/perf/util/expr.y                 | 13 ++++++++++++-
 tools/perf/util/metricgroup.c          | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.h          |  3 ++-
 tools/perf/util/stat.h                 |  1 +
 10 files changed, 142 insertions(+), 13 deletions(-)

