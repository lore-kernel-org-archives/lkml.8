Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77096C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8FF21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595182417;
	bh=GVZqzTi4T+bxY3KDbtPZaqq6hLyYFh3F2lMP9hSmXNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hphf9D5YV4OXCFiSBHtl7xfsT9FrCJ5etIlVPOQvv2hYKoKjKX2hJBoXUpninxuhY
	 zgG5CsxAU4WLtbwWGrxa5cAvfwhqHZVoJ+/ynWJW456rzQjkBfyrlOT53PXOX8YVD6
	 u73EafnH4RBFmtVz+PiGTQsY/h7eLZ3KNtGe5wuw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgGSSNg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 14:13:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36564 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgGSSNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 14:13:35 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-XWumo4xSPyKHprVaz3_1yg-1; Sun, 19 Jul 2020 14:13:30 -0400
X-MC-Unique: XWumo4xSPyKHprVaz3_1yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D828015F3;
        Sun, 19 Jul 2020 18:13:28 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 32CA774F6C;
        Sun, 19 Jul 2020 18:13:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 01/19] perf metric: Fix memory leak in expr__add_id function
Date:   Sun, 19 Jul 2020 20:13:02 +0200
Message-Id: <20200719181320.785305-2-jolsa@kernel.org>
In-Reply-To: <20200719181320.785305-1-jolsa@kernel.org>
References: <20200719181320.785305-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo found that we don't release value data in case the
hashmap__set fails. Releasing it in case of an error.

Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index 5d05f9765ed8..578a173d4873 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -47,6 +47,8 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
 	}
 	ret = hashmap__set(&ctx->ids, id, data_ptr,
 			   (const void **)&old_key, (void **)&old_data);
+	if (ret)
+		free(data_ptr);
 	free(old_key);
 	free(old_data);
 	return ret;
-- 
2.25.4

