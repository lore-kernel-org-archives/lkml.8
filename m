Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5980FC33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2662724684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686101;
	bh=FKEdR/JXp9pHm5Szs+22yLYnGjAVtBoILz9tVXODj3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PGJlws5qTKOlSKBQGJIOSf5OOejrJ910tlmMUPceT7q0rqe/uIXauXdkb2nf6uR3J
	 uokljBZkzJG8ZOnTd+Z3hWQl94XQ+vjuyRVfMJ/7U4fSZ7hOM6YXmmYU+5aTgm7ChM
	 U2DMgus5gLjZk+5J2SIzqjFH2qEj2mrOQldIhqqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387598AbgAVJlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:41:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:60886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387430AbgAVJlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:41:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFA892467B;
        Wed, 22 Jan 2020 09:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686085;
        bh=FKEdR/JXp9pHm5Szs+22yLYnGjAVtBoILz9tVXODj3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsPycQ+Dh9THaguFle/ExIFsXWyMRreDkF6+wZhjMx/FTIwFCx6V8NDG/fTGkrNJC
         n8h8k4mF4loHD37i7GbRPtp8z5TwWtaxITRe5AGsUJY+uW6fJ/RC1CESNtbDIzoMRC
         VbUknUwsxvk0HoK7EdL553w1UmZPvKDgT+dIbt4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuya Fujita <fujita.yuya@fujitsu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4.19 038/103] perf hists: Fix variable names inconsistency in hists__for_each() macro
Date:   Wed, 22 Jan 2020 10:28:54 +0100
Message-Id: <20200122092809.637885442@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
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
@@ -324,10 +324,10 @@ static inline void perf_hpp__prepend_sor
 	list_for_each_entry_safe(format, tmp, &(_list)->sorts, sort_list)
 
 #define hists__for_each_format(hists, format) \
-	perf_hpp_list__for_each_format((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_format((hists)->hpp_list, format)
 
 #define hists__for_each_sort_list(hists, format) \
-	perf_hpp_list__for_each_sort_list((hists)->hpp_list, fmt)
+	perf_hpp_list__for_each_sort_list((hists)->hpp_list, format)
 
 extern struct perf_hpp_fmt perf_hpp__format[];
 


