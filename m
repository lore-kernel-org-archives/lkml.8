Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDEB0C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940F92469E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845211;
	bh=u2lUNrirYBonZIr3b9gfUwQfPMZ/nmwTHmgNbLZ2ZPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SJ3a5J/3Jm82b1CG/kyDUh2vPpdTI7gImPb+JlLIEs2H5N5vmwdluwDNXOVcW3udv
	 oQJrs5p+KVOEZItZhY1Ixeuao1fhGuKui0630+9WDBnL0sFq0AiJYgeeFD37Ea1gTL
	 wcE3SN2/v6pvj3+TolwNujB9pRJIXcUz/y0IpSXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgCJNAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbgCJNAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377A52467D;
        Tue, 10 Mar 2020 13:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845207;
        bh=u2lUNrirYBonZIr3b9gfUwQfPMZ/nmwTHmgNbLZ2ZPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FRFfbs+7v5S5CMfTRuhFjnYcz4BCja/GC8hxBADu/pbd/CxQdNxP9N7hUrLCLszbk
         Uz1gVfSixcPy3S9RYB6PYngLTsh7NK/VI3+YGQygB8QMyfwsyykBsxuWfJ9mmgWozN
         i8/kbRLaeMnMCIFg0nmN02GC975hWQWQ+hNLXyek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Li <liwei391@huawei.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.5 100/189] perf intel-bts: Fix endless record after being terminated
Date:   Tue, 10 Mar 2020 13:38:57 +0100
Message-Id: <20200310123649.811330568@linuxfoundation.org>
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

From: Wei Li <liwei391@huawei.com>

commit 783fed2f35e2a6771c8dc6ee29b8c4b9930783ce upstream.

In __cmd_record(), when receiving SIGINT(ctrl + c), a 'done' flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be
endless.

If the intel_bts event is disabled, we don't enable it again here.

Note: This patch is NOT tested since i don't have such a machine with
intel_bts feature, but the code seems buggy same as arm-spe and
intel-pt.

Signed-off-by: Wei Li <liwei391@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: stable@vger.kernel.org # 5.4+
Link: http://lore.kernel.org/lkml/20200214132654.20395-3-adrian.hunter@intel.com
[ahunter: removed redundant 'else' after 'return']
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/x86/util/intel-bts.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -420,9 +420,12 @@ static int intel_bts_read_finish(struct
 	struct evsel *evsel;
 
 	evlist__for_each_entry(btsr->evlist, evsel) {
-		if (evsel->core.attr.type == btsr->intel_bts_pmu->type)
+		if (evsel->core.attr.type == btsr->intel_bts_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(btsr->evlist,
 							     evsel, idx);
+		}
 	}
 	return -EINVAL;
 }


