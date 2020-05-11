Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6DC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45862206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 12:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="raAND24w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgEKMeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 08:34:24 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:32910 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgEKMeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 08:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589200462; x=1620736462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=iUKxsyy8EDqa4LYd6lWomJlLTmy2039pJ+ilYaUf9pk=;
  b=raAND24w/jqMX7z5rfUmI5qxTXptDGqcOQtHGb0WgEL2+sx4yR5vVOoC
   rxuhoiJu2BSPEhpl1FP4PW6B5zrcvmgdWxlA4wn9sEcmlXjn8KXryW3Jx
   sN94J+OMYdiew78oTyc3693MsGRE7A0dlKKaZmcMDX1dvQpIHIN8LEL6O
   c=;
IronPort-SDR: E1P0Scvi08EA1KBg+AP79GvCMQ4zXEhWJj7Kr1t/jNEwZ8qxaUVujEfDLgh8Bts7/n6ARyfyDm
 81iceauew21g==
X-IronPort-AV: E=Sophos;i="5.73,379,1583193600"; 
   d="scan'208";a="29802095"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 May 2020 12:34:09 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id 7BD62A2462;
        Mon, 11 May 2020 12:33:57 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:33:56 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.253) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 11 May 2020 12:33:41 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <irogers@google.com>, <jolsa@redhat.com>, <kirill@shutemov.name>,
        <mark.rutland@arm.com>, <mgorman@suse.de>, <minchan@kernel.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 01/16] scripts/spelling: Add a few more typos
Date:   Mon, 11 May 2020 14:32:47 +0200
Message-ID: <20200511123302.12520-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511123302.12520-1-sjpark@amazon.com>
References: <20200511123302.12520-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.253]
X-ClientProxiedBy: EX13D06UWC001.ant.amazon.com (10.43.162.91) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit adds typos found from DAMON patchset.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 scripts/spelling.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ffa838f3a2b5..a8214d8e8e4b 100644
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
@@ -664,6 +666,7 @@ hanlde||handle
 hanled||handled
 happend||happened
 harware||hardware
+havind||having
 heirarchically||hierarchically
 helpfull||helpful
 hexdecimal||hexadecimal
@@ -835,6 +838,7 @@ logile||logfile
 loobpack||loopback
 loosing||losing
 losted||lost
+maangement||management
 machinary||machinery
 maibox||mailbox
 maintainance||maintenance
@@ -999,6 +1003,7 @@ partiton||partition
 pased||passed
 passin||passing
 pathes||paths
+pattrns||patterns
 pecularities||peculiarities
 peformance||performance
 peforming||performing
@@ -1238,6 +1243,7 @@ shoule||should
 shrinked||shrunk
 siginificantly||significantly
 signabl||signal
+significanly||significantly
 similary||similarly
 similiar||similar
 simlar||similar
@@ -1352,6 +1358,7 @@ thead||thread
 therfore||therefore
 thier||their
 threds||threads
+threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
@@ -1391,6 +1398,7 @@ tyep||type
 udpate||update
 uesd||used
 uknown||unknown
+usccess||success
 usupported||unsupported
 uncommited||uncommitted
 unconditionaly||unconditionally
-- 
2.17.1

