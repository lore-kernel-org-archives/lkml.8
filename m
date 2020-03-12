Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEC8C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47D6920724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TPFkUlGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCLK5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:57:12 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50366 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCLK5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:57:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CAqmUY193383;
        Thu, 12 Mar 2020 10:56:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=bkTFwY/qkC759TzSl4/piySpqybsugf2XPINCYC//uQ=;
 b=TPFkUlGE55eqlOfEjmgMk6Y5fEgFjP3XiS0HxMLRgvhemaZGv69xf48ebj6Vs4EYTqxn
 XtNOgN9w9NUbOTFDz8SMhn0MynqGz3wuoU0tEhuLs1iitTpWNVg0SRkf16ZTmRn1AdUq
 Hs0AXoipTxPVcrtM9u1pA4wiNdJMM5Lfdc22yump9vGmJbI9qu26PcVPOQxVsMr2OQRA
 tUg5nUrb62GEBUoi/NKZNdXzg2J19tuFAUNQ8PpvzGqFCn1jIkLwVSJrlKg47a59M8up
 kjxrZwr1AP8NENWtjyR21aJkQCNl1JPzOLXtFnRELHQh+l5f5u3mYgjPevCFgQQHvdoQ hg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ym31urwb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 10:56:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02CAq7Sj143760;
        Thu, 12 Mar 2020 10:56:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2yqgvcnj54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Mar 2020 10:56:47 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02CAujKB029016;
        Thu, 12 Mar 2020 10:56:45 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Mar 2020 03:56:44 -0700
Date:   Thu, 12 Mar 2020 13:56:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] perf/core: Fix reversed NULL check in
 perf_event_groups_less()
Message-ID: <20200312105637.GA8960@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120059
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This NULL check is reversed so it leads to a Smatch warning and
presumably a NULL dereference.

    kernel/events/core.c:1598 perf_event_groups_less()
    error: we previously assumed 'right->cgrp->css.cgroup' could be null
	(see line 1590)

Fixes: 95ed6c707f26 ("perf/cgroup: Order events in RB tree by cgroup id")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6a47c3e54fe9..607c04ec7cfa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1587,7 +1587,7 @@ perf_event_groups_less(struct perf_event *left, struct perf_event *right)
 			 */
 			return true;
 		}
-		if (!right->cgrp || right->cgrp->css.cgroup) {
+		if (!right->cgrp || !right->cgrp->css.cgroup) {
 			/*
 			 * Right has no cgroup but left does, no cgroups come
 			 * first.
-- 
2.20.1

