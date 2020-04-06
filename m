Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95374C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD6122403
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="o1r35bhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbgDFNKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:10:52 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:2335 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgDFNKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:10:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1586178651; x=1617714651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qsgkH9CXCaAbAkXmfnln9g/ecylhr8r1kPk/wPRQKhM=;
  b=o1r35bhvJLWd02PGaKemm3W2+jv5KAmcRe1+f9to+empgVQIR/EapfUm
   HpLHEWeLKdSxU+Dk2y+W15IPhjn8zNwsjUu809ImXB3B/5Z6XDu30yAQH
   zj+HAEpQKuIxo5ngY81ClWhmkDI7u0xIl3L4lBd5eK8YoRBkJ3eHLh6/M
   M=;
IronPort-SDR: KDlBE2RHGY0kML72K9uGfBKhGQaAjjgKRsV80H3PRfDt+g/cw03EdkafAN7std2Uzux1R1EWop
 CAHi+nrVjDVQ==
X-IronPort-AV: E=Sophos;i="5.72,351,1580774400"; 
   d="scan'208";a="25727858"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 06 Apr 2020 13:10:36 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id 9DFC5A244D;
        Mon,  6 Apr 2020 13:10:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:10:33 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.65) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 6 Apr 2020 13:10:19 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <brendan.d.gregg@gmail.com>, <brendanhiggins@google.com>,
        <cai@lca.pw>, <colin.king@canonical.com>, <corbet@lwn.net>,
        <dwmw@amazon.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 01/15] scripts/spelling: Add a few more typos
Date:   Mon, 6 Apr 2020 15:09:24 +0200
Message-ID: <20200406130938.14066-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406130938.14066-1-sjpark@amazon.com>
References: <20200406130938.14066-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.65]
X-ClientProxiedBy: EX13D11UWB003.ant.amazon.com (10.43.161.206) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds typos found from DAMON patchset.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/spelling.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ffa838f3a2b5..181cd1b40912 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -59,6 +59,7 @@ actualy||actually
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
+acutally||actually
 adapater||adapter
 addional||additional
 additionaly||additionally
@@ -245,6 +246,7 @@ calescing||coalescing
 calle||called
 callibration||calibration
 callled||called
+callser||caller
 calucate||calculate
 calulate||calculate
 cancelation||cancellation
@@ -999,6 +1001,7 @@ partiton||partition
 pased||passed
 passin||passing
 pathes||paths
+pattrns||patterns
 pecularities||peculiarities
 peformance||performance
 peforming||performing
@@ -1352,6 +1355,7 @@ thead||thread
 therfore||therefore
 thier||their
 threds||threads
+threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
-- 
2.17.1

