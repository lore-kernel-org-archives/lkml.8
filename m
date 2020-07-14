Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3DB22AAB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753620;
	bh=3/Q1jaPtpTUlQgW8NkxVr5NTJaMr/ySX7hLpClT93mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JjtmUNHFcNyCdvNFIc9+kRbjYlJYBHh/7wvsU654gOFnYbSB+Z02IPUaTxmQIW+Ae
	 X3EeO7SkNVzC6vY50uX12GPEvrkDUYGa11nkTOIUq8F9wj1YxnFDueIDD+6HBLHMG3
	 Df355Ov4aZRymcFvHdr7lMegFjVrIwhNq5O4j5f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgGNTG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730576AbgGNSxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73DAF22B4B;
        Tue, 14 Jul 2020 18:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752781;
        bh=3/Q1jaPtpTUlQgW8NkxVr5NTJaMr/ySX7hLpClT93mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZE4I61517Iyn3RrOp1ZidWELFpehIJxR7kW5lNe0x38avsXCAJTR+rY8p3zZk2kgk
         Kq94dJI0oGN5FbtUUx68vrzJS8K4D7HMKaT4mggoh1ijSyWRc0vIRMwD0vo/LF6000
         PbojoiH95WxnUk8Gw9tI++oYPV65Jut0BkURt+QU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.4 106/109] perf scripts python: exported-sql-viewer.py: Fix zero id in call graph Find result
Date:   Tue, 14 Jul 2020 20:44:49 +0200
Message-Id: <20200714184110.642174452@linuxfoundation.org>
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

commit 7ff520b0a71dd2db695b52ad117d81b7eaf6ff9d upstream.

Using ctrl-F ('Find') would not find 'unknown' because it matches id zero.
Fix by excluding id zero from selection.

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

  Select: Reports -> Context-Sensitive Call Graph
  Press: Ctrl-F
  Enter: unknown
  Press: Enter

Before: gets stuck
After: tree is expanded to line showing 'unknown'

Fixes: 254c0d820b86d ("perf scripts python: exported-sql-viewer.py: Factor out CallGraphModelBase")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200629091955.17090-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/scripts/python/exported-sql-viewer.py |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -756,7 +756,8 @@ class CallGraphModel(CallGraphModelBase)
 						" FROM calls"
 						" INNER JOIN call_paths ON calls.call_path_id = call_paths.id"
 						" INNER JOIN symbols ON call_paths.symbol_id = symbols.id"
-						" WHERE symbols.name" + match +
+						" WHERE calls.id <> 0"
+						" AND symbols.name" + match +
 						" GROUP BY comm_id, thread_id, call_path_id"
 						" ORDER BY comm_id, thread_id, call_path_id")
 


