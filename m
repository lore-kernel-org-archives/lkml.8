Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BA6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE66C2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LiHD1yrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgAYQLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:11:00 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35150 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726657AbgAYQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:11:00 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id D30B22E12DF;
        Sat, 25 Jan 2020 19:10:57 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id NwgGFh7MeS-AvYCYgC3;
        Sat, 25 Jan 2020 19:10:57 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1579968657; bh=VwUKNE4MBNBXizgbo7p5VSIVg6CvHHXnXRk0TqHT/I4=;
        h=Message-ID:Date:To:From:Subject;
        b=LiHD1yrPXDUMQp1AxD2kyFcQU0jxkKQO/+zPHomDFkzVXQFiy225WCMdDbwgHoEHm
         coWYZMLjxVTxfBuanfEjyDL66fr/Sj9s5JFSzV84IvSpR8Cc+QHgOU4SMau0fvaPk+
         4sfDENazre51tng8DKkfdcW2gLiXQv9gYRmz8AP8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6910::1:5])
        by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4gg4lG1mYs-AvVuGWrF;
        Sat, 25 Jan 2020 19:10:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 1/2] perf report: apply --cpu filter before
 --switch-on/--switch-off
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Sat, 25 Jan 2020 19:10:57 +0300
Message-ID: <157996865709.8036.5145089242955353200.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If report focus on particular cpus then event switch should see only them.
Perf script/trace/top already works in this way.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: ef4b1a539f4b ("perf report: Add --switch-on/--switch-off events")
---
 tools/perf/builtin-report.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index de988589d99b..f03120c641c0 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -258,6 +258,9 @@ static int process_sample_event(struct perf_tool *tool,
 		return 0;
 	}
 
+	if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
+		return 0;
+
 	if (evswitch__discard(&rep->evswitch, evsel))
 		return 0;
 
@@ -270,9 +273,6 @@ static int process_sample_event(struct perf_tool *tool,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		goto out_put;
 
-	if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
-		goto out_put;
-
 	if (sort__mode == SORT_MODE__BRANCH) {
 		/*
 		 * A non-synthesized event might not have a branch stack if

