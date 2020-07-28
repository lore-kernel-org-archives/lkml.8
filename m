Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BEFC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9206620775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nVjd2v2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgG1I5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgG1I5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:57:36 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC82C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id t11so3465530pfq.21
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=gVIM4kdH9NokKpwghbO519hac6rQk+0+42h/FkNtOmc=;
        b=nVjd2v2r9Q1oUMii1yR5ZajFAwiIRcWUQZazQMb/M7UontU6LQuWm5iwdtO3/n33O3
         Lb/zwJgQ/trsVmsWM8ohNipHPaIrC/bcGltE6QrazEYolwkY9LueMxvJCL7eDHlUuYco
         ZucijjlK3XDHN5p4OFutR+qjpMiOuLpYOafkxRVNDwV1htvZ9XHd+T1m148q4q2dN5rt
         hAISvDZdZavoiVStR4KiWdFYODjwthY7LtG1+Qv/6wchJSBTZ0Mjb7czpWg2y9EcA87g
         qPVL8qlTgMK3qmH1S94tx62jzon1UhmDo3yuxY7QDeINXqv43TYLPZivOivq2SQIflsY
         JBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=gVIM4kdH9NokKpwghbO519hac6rQk+0+42h/FkNtOmc=;
        b=LJ74YdK+16BtRNWLgWNl77PH94SyDL65zvo92NQPGA+3txRfxmr8G0lwxm6EZhGQxE
         q+ukacN53iiinyEsLxgOA4EAZeT1KwjUX+QQ7PaX5/7EMF9UjxxV31LOsaHIYJ7xZ74M
         LikWevcTygN58JT51ssWAPmhS4Om6v0HLQcofjJUulcahBuIRaZVu5Qyty1pSPubz+6F
         p2iW35dyzjnEIQGKPTI4Py3S6kDqM605c0SeGiumXfaqb13fgwFJzgnahi9Y1g86e9BT
         4DdlNjZ2HfIspPhTDcizBNPdW/aHwEAyFkCy7KpOTx+AhkBkVeBpEs+3U+jG+OtgG24y
         Drfw==
X-Gm-Message-State: AOAM530XYzXTxepKhKRd2iIWnSMYs9vYR81bpq1IaUSFRvyvR+YFy7Cf
        Jp8YSPCJ4WxAUIC64HqooMOnfjeRL+7I
X-Google-Smtp-Source: ABdhPJwp2u/D21xwmzwq6NAD7G2DvtD23wewLcS0WtXYTfXCdBdhEV3/tkm4JQwe+UMNfMzo/RXIQNFXG/57
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr3465095pjb.214.1595926656213;
 Tue, 28 Jul 2020 01:57:36 -0700 (PDT)
Date:   Tue, 28 Jul 2020 01:57:29 -0700
Message-Id: <20200728085734.609930-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v2 0/5] Fixes for setting event freq/periods
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some fixes that address issues for regular and pfm4 events with 2
additional perf_event_attr tests. Various authors, David Sharp isn't
currently at Google.

v2. corrects the commit message following Athira Rajeev's suggestion.

David Sharp (1):
  perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Ian Rogers (3):
  perf test: Ensure sample_period is set libpfm4 events
  perf record: Don't clear event's period if set by a term
  perf test: Leader sampling shouldn't clear sample period

Stephane Eranian (1):
  perf record: Prevent override of attr->sample_period for libpfm4
    events

 tools/perf/tests/attr/README                 |  2 ++
 tools/perf/tests/attr/test-record-group2     | 29 ++++++++++++++++++++
 tools/perf/tests/attr/test-record-pfm-period |  9 ++++++
 tools/perf/util/evsel.c                      | 10 +++++--
 tools/perf/util/record.c                     | 28 +++++++++++++------
 5 files changed, 67 insertions(+), 11 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group2
 create mode 100644 tools/perf/tests/attr/test-record-pfm-period

-- 
2.28.0.163.g6104cc2f0b6-goog

