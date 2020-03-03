Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E09BC3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199FC2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258571;
	bh=csGExRBkwGzlCGWjK4cPPFMFAbs96bjnmP6x1pCqZ8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=flp3ml8CJ4gHnoLZQWTz9fTniWv5nVusSqNMZA4cYL4GzstLBpQ2/9SVqIy3/+D6e
	 SbS7aPUdN7Aw7+OXh0p7jaUra0zBGVLITqrogxDrzVQ7aXSsR7G9IgSE0skfLwq2sD
	 O9U511zXAdT1EiiP6Ri6iYbCGAzn+OnTDQU7SS2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgCCSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:02:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388227AbgCCSCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:02:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0E02072D;
        Tue,  3 Mar 2020 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258550;
        bh=csGExRBkwGzlCGWjK4cPPFMFAbs96bjnmP6x1pCqZ8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAbmRgh8kkXq6H7vq7rYhZ6ZFC1ETFYmbDI4r2u93oZSAOqUbEsPMSCDEb4IAwVT/
         LZUIu0Wu98tN/lQXhsAHOZbTbCsyJm+gGS8HvQwFGTO62MP4EnBtDiloei7gDU1iF5
         R/GNG1y8gEkzYYpgGrtHqU4bZ9UPD4f/3Aiteqjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anton Blanchard <anton@samba.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        yuzhoujian@didichuxing.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 4.19 74/87] perf stat: Use perf_evsel__is_clocki() for clock events
Date:   Tue,  3 Mar 2020 18:44:05 +0100
Message-Id: <20200303174356.909524760@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

commit eb08d006054e7e374592068919e32579988602d4 upstream.

We already have function to check if a given event is either
SW_CPU_CLOCK or SW_TASK_CLOCK. Utilize it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc: yuzhoujian@didichuxing.com
Link: http://lkml.kernel.org/r/20181115095533.16930-1-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Tommi Rantala <tommi.t.rantala@nokia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/stat-shadow.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -212,8 +212,7 @@ void perf_stat__update_shadow_stats(stru
 
 	count *= counter->scale;
 
-	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
-	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
+	if (perf_evsel__is_clock(counter))
 		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
 		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);


