Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0280C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805F820738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="aWwZGeRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCMsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:48:13 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17637 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbgFCMsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:48:12 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 08:48:09 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1591187561; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=WNpWJM/pUsoWS83gHJZYdrrzTQYep7WeEETFLQ36uxTHn/SI31eRl9ADfPx+GbpjHsIZL0w/L0yjK9+gqRbrQYUUHHOZPIjyfaPmVU/sNe8/lWsSmmjJOv1uyt7O4Xc6FHU4I0UgSZHT7xjBzJurmW0jVvmhNNWPvCd4OynAeHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1591187561; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=0YrPcEjGR9/k4S5xx47qrbacHYqwp5zgeRisGJY47GI=; 
        b=KjQ3wfYz0d1wFdNCV3JRsmyon2sG+pn+PuasQf8G3E9wOJFgPZFZ7T6/sqIXvXXP3XHBll9cBlbcT5mhAgyO6pQlt6muW3Yf5H7dKsr6owWSyPsdyczWQ6vQKI2WZsvRsnurR76pqip4Xu+24UJczm8DbzhzCk40WK+AHMhIkAM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591187561;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=0YrPcEjGR9/k4S5xx47qrbacHYqwp5zgeRisGJY47GI=;
        b=aWwZGeRHY7bYu8JttB+e2OFn0CPjsVjkx51BukM0WksT4gfr9yLoFeOhGRExj07c
        mUuHaULwshbklPSJkgzx014odRJhYdmNGJzIEsVFdbrurQFTjFpapSJi/6uPvTgD2dp
        gq0/XMJ7Uz5ISuNvF2bCBm0N5LFM8hm8pom7nwl4=
Received: from localhost (54.239.6.187 [54.239.6.187]) by mx.zoho.com.cn
        with SMTPS id 1591187559100493.5928590328281; Wed, 3 Jun 2020 20:32:39 +0800 (CST)
From:   fam@euphon.net
To:     linux-kernel@vger.kernel.org
Cc:     fam@euphon.net, famzheng@amazon.com,
        Jiri Kosina <trivial@kernel.org>
Subject: [PATCH] perf: Fix opt help text for --no-bpf-event
Date:   Wed,  3 Jun 2020 13:32:34 +0100
Message-Id: <20200603123234.10494-1-fam@euphon.net>
X-Mailer: git-send-email 2.17.1
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fam Zheng <famzheng@amazon.com>

The opt name was once inverted but the help text didn't reflect the
change.

Fixes: 71184c6ab7e60fd59d8dbc8fed62a1c753dc4934
Signed-off-by: Fam Zheng <famzheng@amazon.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e4efdbf1a81e..9b92072b0965 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2368,7 +2368,7 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "tail-synthesize", &record.opts.tail_synthesize,
 		    "synthesize non-sample events at the end of output"),
 	OPT_BOOLEAN(0, "overwrite", &record.opts.overwrite, "use overwrite mode"),
-	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "record bpf events"),
+	OPT_BOOLEAN(0, "no-bpf-event", &record.opts.no_bpf_event, "do not record bpf events"),
 	OPT_BOOLEAN(0, "strict-freq", &record.opts.strict_freq,
 		    "Fail if the specified frequency can't be used"),
 	OPT_CALLBACK('F', "freq", &record.opts, "freq or 'max'",
-- 
2.17.1

