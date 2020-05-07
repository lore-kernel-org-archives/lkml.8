Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3F7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07F2A21841
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588845040;
	bh=2I4ittdPLUaEpy3T8MCfQB1ZCP75N3B0YCTRhdn/HaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xfENtnSEFi+K8T1FOZWflP2sEMNdpNOkFKVFNFrziSJFPRFtEtFf4/YK8CapSDu+1
	 NRy5D0W3L2Iq13lME1v6sQEHEcP+CsRyAMUFvGHgsKwpSCHEde9Q8ssA4qO9T6fIs5
	 13tL6ZLvAuqm3YXiiPury720BZvTfkabWV6iGQLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGJui convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:50:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60275 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgEGJuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:50:37 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-zb60KkUBMi2TdjXxK_AgFg-1; Thu, 07 May 2020 05:50:31 -0400
X-MC-Unique: zb60KkUBMi2TdjXxK_AgFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26EF180183C;
        Thu,  7 May 2020 09:50:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA12810013BD;
        Thu,  7 May 2020 09:50:27 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 1/5] perf tools: Do not display extra info when there is nothing to build
Date:   Thu,  7 May 2020 11:50:20 +0200
Message-Id: <20200507095024.2789147-2-jolsa@kernel.org>
In-Reply-To: <20200507095024.2789147-1-jolsa@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even with fully built tree, we still display extra output
when make is invoked, like:

  $ make
    BUILD:   Doing 'make -j8' parallel build
    DESCEND  plugins
  make[3]: Nothing to be done for 'plugins/libtraceevent-dynamic-list'.

Changing the make descend directly to plugins directory,
which quiets those messages down.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Makefile.perf | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 94a495594e99..30e41dcd4095 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -278,6 +278,7 @@ strip-libs = $(filter-out -l%,$(1))
 
 ifneq ($(OUTPUT),)
   TE_PATH=$(OUTPUT)
+  PLUGINS_PATH=$(OUTPUT)
   BPF_PATH=$(OUTPUT)
   SUBCMD_PATH=$(OUTPUT)
   LIBPERF_PATH=$(OUTPUT)
@@ -288,6 +289,7 @@ else
 endif
 else
   TE_PATH=$(TRACE_EVENT_DIR)
+  PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
   API_PATH=$(LIB_DIR)
   BPF_PATH=$(BPF_DIR)
   SUBCMD_PATH=$(SUBCMD_DIR)
@@ -297,7 +299,7 @@ endif
 LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
 export LIBTRACEEVENT
 
-LIBTRACEEVENT_DYNAMIC_LIST = $(TE_PATH)plugins/libtraceevent-dynamic-list
+LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
 
 #
 # The static build has no dynsym table, so this does not work for
@@ -756,10 +758,10 @@ $(LIBTRACEEVENT): FORCE
 	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
 
 libtraceevent_plugins: FORCE
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
 
 $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
-	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)plugins/libtraceevent-dynamic-list
+	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent-dynamic-list
 
 $(LIBTRACEEVENT)-clean:
 	$(call QUIET_CLEAN, libtraceevent)
-- 
2.25.4

