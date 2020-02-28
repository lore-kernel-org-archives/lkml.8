Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8DDC3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 840F224672
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582882600;
	bh=gVgu6L6Vwn6S99VHEVuBpcuLUd4rbMMPj5+7iSpEZMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVFl/tppTatBkTNfhu8s8SKJgOAVRjXKEaXp5UR0pfFwZH7w4bgeGGo06DNMS0bQ6
	 3dE7MLCmqDLxyKxx97uEg6OCeqyFPnhhnC/OxBE0qBeZDIOyQnT9QoIGYZcUJEMtfW
	 q1npwJUCfe4ji7op/zdf2s5r5NUlk5jZ08qgnvdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgB1Jgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:36:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46880 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726810AbgB1Jgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:36:37 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-tkhBY-Q3M0-pRVQXy6JC3g-1; Fri, 28 Feb 2020 04:36:32 -0500
X-MC-Unique: tkhBY-Q3M0-pRVQXy6JC3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3A021083E80;
        Fri, 28 Feb 2020 09:36:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.36.118.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C39928AC3F;
        Fri, 28 Feb 2020 09:36:27 +0000 (UTC)
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
Subject: [PATCH 3/5] perf expr: Increase EXPR_MAX_OTHER
Date:   Fri, 28 Feb 2020 10:36:14 +0100
Message-Id: <20200228093616.67125-4-jolsa@kernel.org>
In-Reply-To: <20200228093616.67125-1-jolsa@kernel.org>
References: <20200228093616.67125-1-jolsa@kernel.org>
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

We have metrics that define more than 15 variables, like
Branch_Misprediction_Cost. Increasing the allowed variables
count to 20.

As Andy pointed out, we can't go too high in here, because
some of the code has O(n^2) complexity (already_seen) and
we might want to do some other changes (like using hash
tables) before increasing the maximum even more.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9332796e6649..df0a17df0cef 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 15
+#define EXPR_MAX_OTHER 20
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct parse_id {
-- 
2.24.1

