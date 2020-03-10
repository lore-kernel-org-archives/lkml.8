Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B210C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521292468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844725;
	bh=EHNki9bHxweFzOgJkJJEZ+SL42Ct+SmSQmOaBVzZRsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R/dIfJL/4wBQOsZGe0Svd9YUeYaNJwILT2rJuYm4A88w9COAgF4IMRiwYCgaUthUM
	 bSnopPEC1W1ic9PN1jcqaNMT8JIE8Mr5gcDvapW/8uQZ8ev/janfNHw5VI4IOQ7Qu9
	 mKKevvpq3PqsyIXNIVyR6tMFr1PeO3MWuwVDjGj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgCJMwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbgCJMwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3D82253D;
        Tue, 10 Mar 2020 12:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844720;
        bh=EHNki9bHxweFzOgJkJJEZ+SL42Ct+SmSQmOaBVzZRsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K15GwxkAFwJzHdSPEeMuhE8kiZ45IUHw/Tou3WLHMVTKkmiPSgKGyVu27a0ts4plJ
         yAJQb7Sy4ftbY6T6PAWT4N9zpAEykpie595k6dpatXdFiYRXltOquIQ8fTJbVUAxIK
         8DqdG1By4UzSyT3gM4pnjkQfbp0G4j8ptcq46pgs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Li <liwei391@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 094/168] perf cs-etm: Fix endless record after being terminated
Date:   Tue, 10 Mar 2020 13:39:00 +0100
Message-Id: <20200310123644.831751726@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

commit c9f2833cb472cf9e0a49b7bcdc210a96017a7bfd upstream.

In __cmd_record(), when receiving SIGINT(ctrl + c), a 'done' flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be
endless.

If the cs_etm event is disabled, we don't enable it again here.

Note: This patch is NOT tested since i don't have such a machine with
coresight feature, but the code seems buggy same as arm-spe and
intel-pt.

Tester notes:

Thanks for looping, Adrian.  Applied this patch and tested with
CoreSight on juno board, it works well.

Signed-off-by: Wei Li <liwei391@huawei.com>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: stable@vger.kernel.org # 5.4+
Link: http://lore.kernel.org/lkml/20200214132654.20395-4-adrian.hunter@intel.com
[ahunter: removed redundant 'else' after 'return']
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/arch/arm/util/cs-etm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -865,9 +865,12 @@ static int cs_etm_read_finish(struct aux
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
+		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
+			if (evsel->disabled)
+				return 0;
 			return perf_evlist__enable_event_idx(ptr->evlist,
 							     evsel, idx);
+		}
 	}
 
 	return -EINVAL;


