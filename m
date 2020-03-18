Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D17C5ACD8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C5B2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AJXsCP1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCRL3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:29:03 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:4398 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgCRL3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1584530942; x=1616066942;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KKbmZdP/bzj7xd/Z96OBTjD6dd06R7k1zcFdO8AZExk=;
  b=AJXsCP1BGpZ2ImwD481Ygp0deAVDN+5+Z8SH2FSVqfEbftwLEhMvk6uK
   nd3Y2q0K/5dgS+vnNXJD6v44J/cTf6oQCQ4k4X9M5pgMG89STMB7TkYab
   s4Crrejur0kl6stVVilCZKdpDVE3hsyRu+ZntNaG9usra8UUUy3mAntlK
   Y=;
IronPort-SDR: xjowkPUio85p7GWo8Oy3Acibo9IimbZbB35/t95QZvh9iYFFj2F/VmMxSpdnXQFohKKPmDe6kM
 xHHpuHD+egXg==
X-IronPort-AV: E=Sophos;i="5.70,567,1574121600"; 
   d="scan'208";a="33270648"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 18 Mar 2020 11:28:57 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id D0378A2CD1;
        Wed, 18 Mar 2020 11:28:46 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Wed, 18 Mar 2020 11:28:46 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.235) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 18 Mar 2020 11:28:25 +0000
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
        <rostedt@goodmis.org>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 01/15] scripts/spelling: Add a few more typos
Date:   Wed, 18 Mar 2020 12:27:08 +0100
Message-ID: <20200318112722.30143-2-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318112722.30143-1-sjpark@amazon.com>
References: <20200318112722.30143-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.235]
X-ClientProxiedBy: EX13D28UWC001.ant.amazon.com (10.43.162.166) To
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
index 672b5931bc8d..2fcad5dbd9c6 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -57,6 +57,7 @@ actualy||actually
 acumulating||accumulating
 acumulative||accumulative
 acumulator||accumulator
+acutally||actually
 adapater||adapter
 addional||additional
 additionaly||additionally
@@ -241,6 +242,7 @@ calender||calendar
 calescing||coalescing
 calle||called
 callibration||calibration
+callser||caller
 calucate||calculate
 calulate||calculate
 cancelation||cancellation
@@ -988,6 +990,7 @@ partiton||partition
 pased||passed
 passin||passing
 pathes||paths
+pattrns||patterns
 pecularities||peculiarities
 peformance||performance
 peforming||performing
@@ -1338,6 +1341,7 @@ thead||thread
 therfore||therefore
 thier||their
 threds||threads
+threee||three
 threshhold||threshold
 thresold||threshold
 throught||through
-- 
2.17.1

