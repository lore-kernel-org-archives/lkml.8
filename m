Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE33C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5162E24683
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgBYFPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:15:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:61438 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgBYFPJ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:15:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 21:15:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,482,1574150400"; 
   d="scan'208";a="350074468"
Received: from kbl.sh.intel.com ([10.239.159.24])
  by fmsmga001.fm.intel.com with ESMTP; 24 Feb 2020 21:15:07 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 0/2] perf report: Support annotation of code without symbols
Date:   Tue, 25 Feb 2020 13:14:36 +0800
Message-Id: <20200225051438.16253-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For perf report on stripped binaries it is currently impossible to do
annotation. The annotation state is all tied to symbols, but there are
either no symbols, or symbols are not covering all the code.

We should support the annotation functionality even without symbols.

The first patch uses al_addr to print because it's easy to dump
the instructions from this address in binary for branch mode.

The second patch supports the annotation on stripped binary.

 v4:
 ---
 1. Support the hotkey 'a'. When we press 'a' on address,
    now it supports the annotation.

 2. Change the patch title from
    "Support interactive annotation of code without symbols" to
    "perf report: Support interactive annotation of code without symbols"

 v3:
 ---
 Keep just the ANNOTATION_DUMMY_LEN, and remove the
 opts->annotate_dummy_len since it's the "maybe in future
 we will provide" feature.

 v2:
 ---
 Fix a crash issue when annotating an address in "unknown" object.

Jin Yao (2):
  perf util: Print al_addr when symbol is not found
  perf report: Support interactive annotation of code without symbols

 tools/perf/ui/browsers/hists.c | 83 ++++++++++++++++++++++++++--------
 tools/perf/util/annotate.h     |  1 +
 tools/perf/util/sort.c         |  6 ++-
 3 files changed, 70 insertions(+), 20 deletions(-)

-- 
2.17.1

