Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B2824688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699335;
	bh=BBQi5io6JHy/ODYO57lusvam0tlkm6fTswXwRhVaoH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfbZawqlqowKcoYxUvmDw7HcNwzst9R7OHp6NSHyK3C2xge96ljwcaWP3qDalkWox
	 6vVpGo9KXYnF7sC4Ml3MVe4l0JhMT0Y8wSKDznSVInsddaRu37Zgdc8m1Fa92ZW4eM
	 pFnFbPMw31OZvUS3T6E2Lcp0US9JWcEkoBkOnpHY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgAVNWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:22:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:39588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgAVNWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:22:10 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B3922467B;
        Wed, 22 Jan 2020 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699329;
        bh=BBQi5io6JHy/ODYO57lusvam0tlkm6fTswXwRhVaoH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1MhbL4+111HPxDgsG/XqXmXP/B6AIyf4rQd3S3Bbb6d65iBddz2GOsTOvlW8YnuJ2
         qKlLRoKxNc/QlfrO6SI0pYpr2/JzdVU3h0H5j+COFR3mzoCu3s2Yu/b7BXQL0q6ai2
         C9LvQQc4rmw9h7l+Cbncw4vG0i+n1QMC2dqCo3tE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuya Fujita <fujita.yuya@fujitsu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 075/222] perf hists: Fix variable names inconsistency in hists__for_each() macro
Date:   Wed, 22 Jan 2020 10:27:41 +0100
Message-Id: <20200122092839.088051491@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yuya Fujita <fujita.yuya@fujitsu.com>

commit 55347ec340af401437680fd0e88df6739a967f9f upstream.

Variable names are inconsistent in hists__for_each macro().

Due to this inconsistency, the macro replaces its second argument with
"fmt" regardless of its original name.

So far it works because only "fmt" is passed to the second argument.
However, this behavior is not expected and should be fixed.

Fixes: f0786af536bb ("perf hists: Introduce hists__for_each_format macro")
Fixes: aa6f50af822a ("perf hists: Introduce hists__for_each_sort_list macro")
Signed-off-by: Yuya Fujita <fujita.yuya@fujitsu.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/OSAPR01MB1588E1C47AC22043175DE1B2E8520@OSAPR01MB1588.jpnprd01.prod.outlook.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/util/hist.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -339,10 +339,10 @@ static inline void perf_hpp__prepend_sor
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
 
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
 
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
 
 extern struct perf_hpp_fmt perf_hpp__format[];
 


