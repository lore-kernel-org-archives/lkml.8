Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD09C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E19A32054F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596457837;
	bh=iAGyPGM4lSTLZk9iRrkFiQnLYnmPbVi5L3xtgaUb3aQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YmcBlqtznbVQNG60lu/P84/pBl6lHlQOaEiZjOqsWcdG7dnATO70oqR8IMWs89mtF
	 aBRKFlLUN9EVfBExPetdfdHmrh4sFXBlcZe+J4IE4OyXB5Qican+rTfqrNEI4SU6Tk
	 vtsaUTevYcB6edF0czzrVpkP7w407UXXyQAZ09Qc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgHCMag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:30:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729069AbgHCMad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:30:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C982054F;
        Mon,  3 Aug 2020 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596457832;
        bh=iAGyPGM4lSTLZk9iRrkFiQnLYnmPbVi5L3xtgaUb3aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MiphkTw/LfdaW2m0T1Q3BrZCn4ZnZUanrxUIZ+V2to2UoX5Yjp/abv42vzYvdoJ3J
         hW325QLmyCobCyZL3YZE3Bx+F8G9s3vbY85SViIcTN2oxevSxXYxtQQyZzfgzdtj5+
         nZv/biAlS1pWiIq2L6Fa4DfBhwkoF1CRFdPzy/lw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 5.4 88/90] perf tests bp_account: Make global variable static
Date:   Mon,  3 Aug 2020 14:19:50 +0200
Message-Id: <20200803121901.844033863@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803121857.546052424@linuxfoundation.org>
References: <20200803121857.546052424@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

commit cff20b3151ccab690715cb6cf0f5da5cccb32adf upstream.

To fix the build with newer gccs, that without this patch exit with:

    LD       /tmp/build/perf/tests/perf-in.o
  ld: /tmp/build/perf/tests/bp_account.o:/git/perf/tools/perf/tests/bp_account.c:22: multiple definition of `the_var'; /tmp/build/perf/tests/bp_signal.o:/git/perf/tools/perf/tests/bp_signal.c:38: first defined here
  make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/tests/perf-in.o] Error 1

First noticed in fedora:rawhide/32 with:

  [perfbuilder@a5ff49d6e6e4 ~]$ gcc --version
  gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8)

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/tests/bp_account.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -23,7 +23,7 @@
 #include "../perf-sys.h"
 #include "cloexec.h"
 
-volatile long the_var;
+static volatile long the_var;
 
 static noinline int test_function(void)
 {


