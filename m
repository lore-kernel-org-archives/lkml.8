Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B64DC35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A13120728
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580544239;
	bh=qOfoLiOeqAqdHIVfPcC7EzJ1Pl9jOAmAjqJ7fF32yDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y4qfRim34FuxYXkLGUpH/7lWtloGo00pPOzEsftF5QtQNYjN0251/9edvUiLaT3T6
	 B6fi0kq9BJMpB+GPXCFWKLnufH4qPPDJW0DZYxBjcC4pAheaL88X+T1/KTqvUaxNE4
	 I0HC5oMGNi1Qa15Dl6GjUVDaykGDp68Tql67XF0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBAID6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:03:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAID4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:03:56 -0500
Received: from quaco.parlament.guest (catv-212-96-54-169.catv.broadband.hu [212.96.54.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B39E20679;
        Sat,  1 Feb 2020 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580544236;
        bh=qOfoLiOeqAqdHIVfPcC7EzJ1Pl9jOAmAjqJ7fF32yDo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0wxnudoJkC87m1ME0au3JVOGUZJGGFImEQNC8njs5KEoCP4IY3iLh2s/CzqO1nws2
         BE+ycyPEtI4ijknydOOd6JD2kXpupARZO8nO7ctzNMWHZq+JsLXohpfpSeSiuMA120
         siqWTXxtSFnNVZgKjSY6ku1RcjQ5W3znW3AKd87s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf: Make perf able to build with latest libbfd
Date:   Sat,  1 Feb 2020 09:03:28 +0100
Message-Id: <20200201080330.13211-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200201080330.13211-1-acme@kernel.org>
References: <20200201080330.13211-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

libbfd has changed the bfd_section_* macros to inline functions
bfd_section_<field> since 2019-09-18. See below two commits:
  o http://www.sourceware.org/ml/gdb-cvs/2019-09/msg00064.html
  o https://www.sourceware.org/ml/gdb-cvs/2019-09/msg00072.html

This fix make perf able to build with both old and new libbfd.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200128152938.31413-1-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 6ccf6f6d09df..5b7d6c16d33f 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -193,16 +193,30 @@ static void find_address_in_section(bfd *abfd, asection *section, void *data)
 	bfd_vma pc, vma;
 	bfd_size_type size;
 	struct a2l_data *a2l = data;
+	flagword flags;
 
 	if (a2l->found)
 		return;
 
-	if ((bfd_get_section_flags(abfd, section) & SEC_ALLOC) == 0)
+#ifdef bfd_get_section_flags
+	flags = bfd_get_section_flags(abfd, section);
+#else
+	flags = bfd_section_flags(section);
+#endif
+	if ((flags & SEC_ALLOC) == 0)
 		return;
 
 	pc = a2l->addr;
+#ifdef bfd_get_section_vma
 	vma = bfd_get_section_vma(abfd, section);
+#else
+	vma = bfd_section_vma(section);
+#endif
+#ifdef bfd_get_section_size
 	size = bfd_get_section_size(section);
+#else
+	size = bfd_section_size(section);
+#endif
 
 	if (pc < vma || pc >= vma + size)
 		return;
-- 
2.21.1

