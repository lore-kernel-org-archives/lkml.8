Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF38C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868B620738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHSHRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:17:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:63090 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgHSHRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:17:37 -0400
IronPort-SDR: NoCcE/ad+/IbK1OYuQ88Dht7WGJdyfiscaODGxbBlQDK6RHwR3lySfFMdYJBzmUB8dEcB+9ZJy
 hI+HRSL945qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="142692063"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="142692063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 00:17:36 -0700
IronPort-SDR: kAnD5hiFxA+G9ZksDKNhYRSKyPdnnVRP2RVqX4CQ6Xa0jbNF7D/8UGZIQO53bYO1BPu27nCVYy
 H8Q99ILBowEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="400741461"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 19 Aug 2020 00:17:34 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: usb: move to tools buildsystem
Date:   Wed, 19 Aug 2020 10:17:33 +0300
Message-Id: <20200819071733.60028-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converting the Makefile to use the new tools buildsystem.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 tools/usb/Build    |  2 ++
 tools/usb/Makefile | 53 +++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 47 insertions(+), 8 deletions(-)
 create mode 100644 tools/usb/Build

diff --git a/tools/usb/Build b/tools/usb/Build
new file mode 100644
index 0000000000000..2ad6f97458168
--- /dev/null
+++ b/tools/usb/Build
@@ -0,0 +1,2 @@
+testusb-y += testusb.o
+ffs-test-y += ffs-test.o
diff --git a/tools/usb/Makefile b/tools/usb/Makefile
index 01d758d73b6db..1b128e551b2e4 100644
--- a/tools/usb/Makefile
+++ b/tools/usb/Makefile
@@ -1,14 +1,51 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for USB tools
+include ../scripts/Makefile.include
 
-PTHREAD_LIBS = -lpthread
-WARNINGS = -Wall -Wextra
-CFLAGS = $(WARNINGS) -g -I../include
-LDFLAGS = $(PTHREAD_LIBS)
+bindir ?= /usr/bin
 
-all: testusb ffs-test
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+override CFLAGS += -O2 -Wall -Wextra -g -D_GNU_SOURCE -I$(OUTPUT)include -I$(srctree)/tools/include
+override LDFLAGS += -lpthread
+
+ALL_TARGETS := testusb ffs-test
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+TESTUSB_IN := $(OUTPUT)testusb-in.o
+$(TESTUSB_IN): FORCE
+	$(Q)$(MAKE) $(build)=testusb
+$(OUTPUT)testusb: $(TESTUSB_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
+
+FFS_TEST_IN := $(OUTPUT)ffs-test-in.o
+$(FFS_TEST_IN): FORCE
+	$(Q)$(MAKE) $(build)=ffs-test
+$(OUTPUT)ffs-test: $(FFS_TEST_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
 
 clean:
-	$(RM) testusb ffs-test
+	rm -f $(ALL_PROGRAMS)
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete -o -name '\.*.o.cmd' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
-- 
2.28.0

