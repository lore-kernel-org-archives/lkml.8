Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86ACFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDDE2240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753600;
	bh=t38cKROaW5bZm5m83DpUpizQxSlDQDkFXo+98nVCCqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mFjm9SHyAyqT57MzrVk43BPSn1kmip2fFxHaBwZwpufQUQWli45p0CI26+/BYFSxj
	 RosjMPC8L07ep34yq24/elcTDPDuR0KzrxEVDJD3ENVRbmdgL+SdSJxvzQ2xxuyyQh
	 yb6Aw/wUC203aWLZuTClpILGY2a4sMjjbMfp/Z0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgGNSxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730156AbgGNSxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3155022BED;
        Tue, 14 Jul 2020 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752783;
        bh=t38cKROaW5bZm5m83DpUpizQxSlDQDkFXo+98nVCCqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LtFTcZW8LiNux8IypoXf3IoZCG+LSRHkHccxhsF0C5m6gVn5QXzqMx4hKIhGJv02K
         yecpSsxN2Jw+R9EPSE3J6vM6nLo6UxgHHVTm5Wwf3dTn7B1Lm0qw7lZdTsL7apExKO
         n6u5tcimALMm8gR6vRlQtnl5WKRo9gzcyIB56vK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 107/109] perf scripts python: exported-sql-viewer.py: Fix zero id in call tree Find result
Date:   Tue, 14 Jul 2020 20:44:50 +0200
Message-Id: <20200714184110.688231384@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

commit 031c8d5edb1ddeb6d398f7942ce2a01a1a51ada9 upstream.

Using ctrl-F ('Find') would not find 'unknown' because it matches id
zero.  Fix by excluding id zero from selection.

Example:

   $ perf record -e intel_pt//u uname
   Linux
   [ perf record: Woken up 1 times to write data ]
   [ perf record: Captured and wrote 0.034 MB perf.data ]
   $ perf script --itrace=bep -s ~/libexec/perf-core/scripts/python/export-to-sqlite.py perf.data.db branches calls
   2020-06-26 15:32:14.928997 Creating database ...
   2020-06-26 15:32:14.933971 Writing records...
   2020-06-26 15:32:15.535251 Adding indexes
   2020-06-26 15:32:15.542993 Dropping unused tables
   2020-06-26 15:32:15.549716 Done
   $ python3 ~/libexec/perf-core/scripts/python/exported-sql-viewer.py perf.data.db

   Select: Reports -> Call Tree
   Press: Ctrl-F
   Enter: unknown
   Press: Enter

Before: displays 'unknown' not found
After: tree is expanded to line showing 'unknown'

Fixes: ae8b887c00d3f ("perf scripts python: exported-sql-viewer.py: Add call tree")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200629091955.17090-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/scripts/python/exported-sql-viewer.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -951,7 +951,8 @@ class CallTreeModel(CallGraphModelBase):
 						" FROM calls"
 						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
+						" WHERE calls.id <> 0"
+						" AND symbols.name" + match +
 						" ORDER BY comm_id, thread_id, call_time, calls.id")
 
 	def FindPath(self, query):


