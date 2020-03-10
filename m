Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB4CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A61F020674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845217;
	bh=L3YiocDpEzYv1QW8WI6JYlW/c5kgKuS3/yf2buhgVc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lfsl8cO/OAuEQwN856OQ8JlcMXUcThv7ArxRzrJdgcAyaIrzoT9+QTLLxUrEY/CJa
	 gQdPbGSk0VzgROLZD3UAkP4krnX68BLXSPH92u2kAoQFQHjQOqhBFibw/6o23y4Su1
	 TWMHa7e2QBxwX2k68zRc3D2xTN4M7k23udE6jYQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgCJNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730096AbgCJNAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40FAB2468C;
        Tue, 10 Mar 2020 13:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845212;
        bh=L3YiocDpEzYv1QW8WI6JYlW/c5kgKuS3/yf2buhgVc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wSCngUBXQt0kzzQkA8cexqga8rMlx2zPYtf1XdfRqw8GZuuPBpV8OErZRVqCQ3nNO
         6mL9UL1AoJDhjk9hvYxfqCzPwbFWCVCC1TVvT5jpRLFuUxCDBxeXymhMp3ebkQK79p
         qFDAMRc9kr0tBDAs+D/daeJ5NzkD7sKYZNMjLFF8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Wei Li <liwei391@huawei.com>
Subject: [PATCH 5.5 102/189] perf arm-spe: Fix endless record after being terminated
Date:   Tue, 10 Mar 2020 13:38:59 +0100
Message-Id: <20200310123650.013021076@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit d6bc34c5ec18c3544c4b0d85963768dfbcd24184 upstream.

In __cmd_record(), when receiving SIGINT(ctrl + c), a 'done' flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be
endless.

If the event is disabled, don't enable it again here.

Based-on-patch-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: stable@vger.kernel.org # 5.4+
Link: http://lore.kernel.org/lkml/20200214132654.20395-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/arm64/util/arm-spe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -165,9 +165,12 @@ static int arm_spe_read_finish(struct au
 	struct evsel *evsel;
 
 	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type)
+		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(sper->evlist,
 							     evsel, idx);
+		}
 	}
 	return -EINVAL;
 }


