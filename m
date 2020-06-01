Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD05C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7522073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ox2Q7VbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgFARKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgFARK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:10:29 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815D8C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 10:10:28 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x6so540433wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fyn0qs5GSGOuYefLkslJD3CLyO6c5zZi4Yv7PFrSF8k=;
        b=ox2Q7VbAPICKr+xa1H5fIS2632Dbo2pIFif9ozNYWrWD0ze0cHUkwowbJgXSXm9gbw
         e/1pqIeBUgyDwtY/fL4tzaPqmFnnVRwxHWtyVNrtH+dzW0OBAFn9vwAmi44GnWd5FMl1
         YS+5rJw/x938K7Z6FEmBbYK0ppw/UAce3unpGsSIndl+g4wSKNhB7cxh85PZSw0DQOWK
         2nWLLatnTYNgsZJbQK2AF8KL+dyJ8VKfcIZZswYbsIys0fnMukFfRGYce4PlzLnDgqta
         l+dU12mcGQYQDTT+20Q9IVmUlV/tzGwmcQG4Ic9kmkWZMZaBNNx5SFB5e+kBcn1rQ/0/
         PDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fyn0qs5GSGOuYefLkslJD3CLyO6c5zZi4Yv7PFrSF8k=;
        b=BXF9BczK4hiybgil2jxuMTZpB4qpv4+Np3y2A4QBOpjJ/Q/so0w0QN15UTw+yXt/yM
         sHJog2hGTaRQjg9Pg+KS32Pw60P4zrayQe967joMOardkjeemRYKSIs4QSHmxFeooiQ6
         cq1MQ7PSFhRJdA4v2pxbBsP1P9LRfcBZrlb7dkJvkUME2VnrpANIYvqXw1wW128JWyQe
         jiXV9Wq47d3cOCOBFN+UDX95b1tXgILnISh8T5w5Hv6JogLHn1IFy1D7eRbCk0fsKfx3
         VQjMhEuKoDg9tMXMLMMnTHlLnYtLgnb+O0tIqNCq+yA7myR/IpFqKAAIJdV6qCmkPKdu
         AVog==
X-Gm-Message-State: AOAM531/x2kiIaCDRLVp3c+1LI5YUa9FTMzzg2HEPTN6rI4JxOoRyxGV
        fV0QVHpli4ITHSpQU5sTLEHp1yeqLeMCIg==
X-Google-Smtp-Source: ABdhPJxEGuE5CDPz0XXIa1RcR2/I290qzzSPvZEv6D7HX7bxUeS1gnkJiaAaMQzi6xaqVzuqg7/htw==
X-Received: by 2002:adf:f5d0:: with SMTP id k16mr23875174wrp.288.1591031426492;
        Mon, 01 Jun 2020 10:10:26 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.googlemail.com with ESMTPSA id s72sm232716wme.35.2020.06.01.10.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 10:10:25 -0700 (PDT)
From:   Elazar Leibovich <elazarl@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Elazar Leibovich <elazarl@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf timechart: explain the SVG output
Date:   Mon,  1 Jun 2020 20:10:14 +0300
Message-Id: <20200601171015.23868-1-elazarl@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is not immediately clear what the SVG output means
and how is it supposed to be used.

Add links to example SVGs, and to annotated images
explaining what each part in the SVG means.

Signed-off-by: Elazar Leibovich <elazarl@gmail.com>
---
 tools/perf/Documentation/perf-timechart.txt | 22 +++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/Documentation/perf-timechart.txt b/tools/perf/Documentation/perf-timechart.txt
index ef0c7565bd5c..460f3bd65789 100644
--- a/tools/perf/Documentation/perf-timechart.txt
+++ b/tools/perf/Documentation/perf-timechart.txt
@@ -12,6 +12,13 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+The perf-timechart tool will visualize what the system did in a certain timespan.
+Looking at 'perf timechart' output will allow you to see at a glance:
+
+  How much time was a certain process scheduled, when was it waiting for IO?
+  How many CPUs did the process use?
+  Did my process move between CPUs?
+
 There are two variants of perf timechart:
 
   'perf timechart record <command>' to record the system level events
@@ -30,6 +37,15 @@ There are two variants of perf timechart:
   There are also poll bars which show how much time application spent
   in poll/epoll/select syscalls.
 
+See also annotated example of perf-timechart report:
+
+  http://elazarl.github.io/perf-timechart/perf_timechart_wrk_python.png
+  http://elazarl.github.io/perf-timechart/perf_timechart_cpu_chart.png
+
+Or annotated example of perf-timechart record -I:
+
+  http://elazarl.github.io/perf-timechart/perf_timechart_wrk_io.png
+
 TIMECHART OPTIONS
 -----------------
 -o::
@@ -123,6 +139,12 @@ Record system-wide IO events:
 
   $ perf timechart
 
+Example SVGs for the wrk HTTP benchmark testing python3 -m http.server
+can be found here:
+
+  http://elazarl.github.io/perf-timechart/wrk.svg
+  http://elazarl.github.io/perf-timechart/wrk-io.svg
+
 SEE ALSO
 --------
 linkperf:perf-record[1]
-- 
2.25.0

