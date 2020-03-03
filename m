Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8194D20728
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257860;
	bh=7tV0NVotmzh0q+KwNJ3XzdXzL+Cvualt8ZjzXVFz42E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qh5sOS9capHeGuPOEcQABVXWea2EgGhpmQld+YqwS2SpKl8qurly/Is89Jo4Inav3
	 OklkwDbSnkfHsvTR4LRmDIGeW7DLgcaTStkbl8P8+tpvutEPiGvGURR7oG0vvBadkl
	 VH4r8vzESBUL5/VV2ryF4v/+ggN2qYXrbDcutKGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgCCRu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:50:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgCCRuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:50:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5463F214D8;
        Tue,  3 Mar 2020 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257854;
        bh=7tV0NVotmzh0q+KwNJ3XzdXzL+Cvualt8ZjzXVFz42E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cc6aQspJSFs9Is4znkvy9u5H/8E84/7S0z7hZrByBSmZVWfhpfpwPyTWvJbYtYrt9
         WhhXq6T77eyqSldyZ5wxYvLG1j8f8YjwDENiW+59rchM1V3QDYWBay4sEsfKgz23Zt
         eKvT3soz8mXMTCnsNsuPan8KJV//TFgBKd2+czWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.5 154/176] perf ui gtk: Add missing zalloc object
Date:   Tue,  3 Mar 2020 18:43:38 +0100
Message-Id: <20200303174322.347019598@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

commit 604e2139a1026793b8c2172bd92c7e9d039a5cf0 upstream.

When we moved zalloc.o to the library we missed gtk library which needs
it compiled in, otherwise the missing __zfree symbol will cause the
library to fail to load.

Adding the zalloc object to the gtk library build.

Fixes: 7f7c536f23e6 ("tools lib: Adopt zalloc()/zfree() from tools/perf")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200113104358.123511-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/ui/gtk/Build |    5 +++++
 1 file changed, 5 insertions(+)

--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -7,3 +7,8 @@ gtk-y += util.o
 gtk-y += helpline.o
 gtk-y += progress.o
 gtk-y += annotate.o
+gtk-y += zalloc.o
+
+$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)


