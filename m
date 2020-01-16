Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F827C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BAD2176D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182537;
	bh=XJdPkxlzjGhZSqONy4w61NO5BWiTHihZeKClbwaUdos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJkalq11e59JjCR0adCADf9DW96O++ZZeyR+/VteZAsatAA1afhmFN0FtocvV5ZmP
	 AtMhuYLUqevB38TNOEG+WSRK476hYrXGMW/qTdlK/4wlpFLefvsuqceOFQ2mKPuI4d
	 3goWvHZ8ONcOVjE0lQ5bw1LVnAbt6haq4C90YtUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAPNs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:50238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:55 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9212087E;
        Thu, 16 Jan 2020 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182535;
        bh=XJdPkxlzjGhZSqONy4w61NO5BWiTHihZeKClbwaUdos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QxBT6WH7VH3N92C2MMdkPtebbHR/DNienCAjO4MiJc+R2g9xIn4ko5MnGv8QTWTYi
         QukzGmu2hq1ikq2g+3Zfv2THaHWhNIqWwwIJmnS+8m6wPkp7dMBuwfgwJGKcMJL3nC
         jAIXGBuNB8773bk+9vHkx5Tm/HHSDCSpDm2G7lPc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/12] perf/ui/gtk: Fix gtk2 build
Date:   Thu, 16 Jan 2020 10:48:11 -0300
Message-Id: <20200116134814.8811-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Ravi Bangoria reported an issue when doing the gtk2 feature detection on
Fedora 31, where some types got deprecated:

  /usr/include/gtk-2.0/gtk/gtktypeutils.h:236:1: error: ‘GTypeDebugFlags’ is deprecated [-Werror=deprecated-declarations]
    236 | void            gtk_type_init   (GTypeDebugFlags    debug_flags);

Fix this for perf by allowing the compile to pass with deprecated
symbols via the -Wno-deprecated-declarations compiler directive.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jelle van der Waa <jelle@vdwaa.nl>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200113104358.123511-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/Makefile | 2 +-
 tools/perf/ui/gtk/Build      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f30a89046aa3..7ac0d8088565 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -197,7 +197,7 @@ $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
 
 $(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -Wno-deprecated-declarations
 
 $(OUTPUT)test-gtk2-infobar.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index 9b5d5cbb7af7..eef708c502f4 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -1,4 +1,4 @@
-CFLAGS_gtk += -fPIC $(GTK_CFLAGS)
+CFLAGS_gtk += -fPIC $(GTK_CFLAGS) -Wno-deprecated-declarations
 
 gtk-y += browser.o
 gtk-y += hists.o
-- 
2.21.1

