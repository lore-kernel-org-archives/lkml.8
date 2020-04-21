Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFE1C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A7A3206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587492847;
	bh=6huj4mmIlJBkPfGFW9vY9nUtSYLnzE7IR70Viouldjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PfHoc6wbVnNPxhAaHx5lD5sZfBYR8I+wgNRVWXKW9MOBqliHJuWIumruar8K9YSe6
	 hjURDT4jdHbeF21zW9hMdGvEDWFdSIpOPzciTWN+feCUk2ppQ+6glR25JuUzaynYGV
	 j4M036W3KMlRo3Y/OAfBsrrN3OMB7AkO3vA/77LI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgDUSOC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:14:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54991 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbgDUSN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:13:57 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-36cRdr2xOFu80gjgFgFA5A-1; Tue, 21 Apr 2020 14:13:54 -0400
X-MC-Unique: 36cRdr2xOFu80gjgFgFA5A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB5A21005509;
        Tue, 21 Apr 2020 18:13:52 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F23F9B3A7B;
        Tue, 21 Apr 2020 18:13:49 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] perf expr: Allow comments in custom metric file
Date:   Tue, 21 Apr 2020 20:13:35 +0200
Message-Id: <20200421181337.988681-3-jolsa@kernel.org>
In-Reply-To: <20200421181337.988681-1-jolsa@kernel.org>
References: <20200421181337.988681-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding support to use comments within the custom metric file
with both the shell '# ... ' and C '/* ... */ styles.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.l | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/util/expr.l b/tools/perf/util/expr.l
index 5561c360cd27..99547182ef79 100644
--- a/tools/perf/util/expr.l
+++ b/tools/perf/util/expr.l
@@ -69,6 +69,8 @@ static int str(yyscan_t scanner, int token)
 %}
 
 %x custom
+%x comment_C
+%x comment_sh
 
 number		[0-9]+
 
@@ -103,6 +105,16 @@ else		{ return ELSE; }
 #smt_on		{ return SMT_ON; }
 {number}	{ return value(yyscanner, 10); }
 {symbol}	{ return str(yyscanner, ID); }
+
+"/*"		{ BEGIN(comment_C); }
+<comment_C>"*/"	{ BEGIN(INITIAL); }
+<comment_C>\n	{ }
+<comment_C>.	{ }
+
+"#"		{ BEGIN(comment_sh); }
+<comment_sh>\n	{ BEGIN(INITIAL); }
+<comment_sh>.	{ }
+
 "|"		{ return '|'; }
 "^"		{ return '^'; }
 "&"		{ return '&'; }
-- 
2.25.3

