Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFCFC35669
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E5924650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582327206;
	bh=LqKbNPN3zMwYTYeGUPsUj7PNanBRk0XG1R51/qmMyc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rAS675D25QjjPv7Otbrb0YsrgM5nv35VK6bR/L0Y/uINxEd8RHjAKbTfSKGzBZsGJ
	 YikjFRCukYbrhBz2+f+W7qoV2prphPzRq1PLO1dxZMxO7iyja3Sri6DY9V3pxnDMFx
	 i1kpenFcBAFabQd5DRzir52KTCrlGL7yW4OatGNo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgBUXUE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:20:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26544 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726290AbgBUXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:20:01 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-2sQIm3pYMCqNTV7twjxW0w-1; Fri, 21 Feb 2020 18:19:56 -0500
X-MC-Unique: 2sQIm3pYMCqNTV7twjxW0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DEF8801E7A;
        Fri, 21 Feb 2020 23:19:55 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-57.brq.redhat.com [10.40.204.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C52160499;
        Fri, 21 Feb 2020 23:19:49 +0000 (UTC)
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
Subject: [PATCH 3/4] perf expr: Increase EXPR_MAX_OTHER
Date:   Sat, 22 Feb 2020 00:19:34 +0100
Message-Id: <20200221231935.735145-4-jolsa@kernel.org>
In-Reply-To: <20200221231935.735145-1-jolsa@kernel.org>
References: <20200221231935.735145-1-jolsa@kernel.org>
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

There's no need to be greedy on allowed variables, also
when some of the metrics define more than 15 variables,
like Branch_Misprediction_Cost.

Increasing the maximum to 100.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 9332796e6649..01e1529bdfd9 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1
 
-#define EXPR_MAX_OTHER 15
+#define EXPR_MAX_OTHER 100
 #define MAX_PARSE_ID EXPR_MAX_OTHER
 
 struct parse_id {
-- 
2.24.1

