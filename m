Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491E9C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC7320777
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564333;
	bh=1qBpWX2t0oeh0WJE2cKpiQ3qh0YLIB52vIQFkwZQpXM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Tg2ZNtpJI8r3c3bLFfajh6fvtalg6liIsb3KHxNNDUztgo3sW8qSLhWJziN0hDm12
	 7uT5P37KcTZs6yVuRe8ECvvsyCRpkOlLmVMOwfFyf504yV/1hC1EdaQwe2ruau4IG6
	 PZ4AcaYpaE6AhT32Wbruw9VEj1QAxYs/jlztjgek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCRUpc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:45:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25266 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726647AbgCRUpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:45:31 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-kcuabduPOgCQd7eUPJdaaA-1; Wed, 18 Mar 2020 16:45:27 -0400
X-MC-Unique: kcuabduPOgCQd7eUPJdaaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D5B5800D5E;
        Wed, 18 Mar 2020 20:45:26 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7F035C545;
        Wed, 18 Mar 2020 20:45:23 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf tools: Unify a bit the build directory output
Date:   Wed, 18 Mar 2020 21:45:22 +0100
Message-Id: <20200318204522.1200981-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the extra 'SUBDIR' line from clean and doc build
output. Because it's annoying.. ;-)

Before:
  $ make clean
  ...
  SUBDIR   Documentation
  CLEAN    Documentation

After:
  $ make clean
  ...
  CLEAN    Documentation

Before:
  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  SUBDIR   Documentation
  ASCIIDOC perf-stat.html
  ...

After:
  $ make doc
  BUILD:   Doing 'make -j8' parallel build
  ASCIIDOC perf-stat.html
  ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 3eda9d4b88e7..a02aca9b21f4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -231,6 +231,7 @@ TRACE_EVENT_DIR = $(srctree)/tools/lib/traceevent/
 BPF_DIR         = $(srctree)/tools/lib/bpf/
 SUBCMD_DIR      = $(srctree)/tools/lib/subcmd/
 LIBPERF_DIR     = $(srctree)/tools/lib/perf/
+DOC_DIR         = $(srctree)/tools/perf/Documentation/
 
 # Set FEATURE_TESTS to 'all' so all possible feature checkers are executed.
 # Without this setting the output feature dump file misses some features, for
@@ -792,7 +793,6 @@ $(LIBSUBCMD): FORCE
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) $(OUTPUT)libsubcmd.a
 
 $(LIBSUBCMD)-clean:
-	$(call QUIET_CLEAN, libsubcmd)
 	$(Q)$(MAKE) -C $(SUBCMD_DIR) O=$(OUTPUT) clean
 
 help:
@@ -832,7 +832,7 @@ INSTALL_DOC_TARGETS += quick-install-doc quick-install-man quick-install-html
 
 # 'make doc' should call 'make -C Documentation all'
 $(DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:doc=all)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:doc=all)
 
 TAG_FOLDERS= . ../lib ../include
 TAG_FILES= ../../include/uapi/linux/perf_event.h
@@ -959,7 +959,7 @@ install-python_ext:
 
 # 'make install-doc' should call 'make -C Documentation install'
 $(INSTALL_DOC_TARGETS):
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) $(@:-doc=)
+	$(Q)$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) $(@:-doc=)
 
 ### Cleaning rules
 
@@ -1008,7 +1008,8 @@ clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clea
 		$(OUTPUT)$(rename_flags_array) \
 		$(OUTPUT)$(arch_errno_name_array) \
 		$(OUTPUT)$(sync_file_range_arrays)
-	$(QUIET_SUBDIR0)Documentation $(QUIET_SUBDIR1) clean
+	$(call QUIET_CLEAN, Documentation) \
+	$(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
 
 #
 # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
-- 
2.25.1

