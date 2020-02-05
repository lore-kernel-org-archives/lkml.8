Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26983C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044E72192A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgBEPpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:45:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBEPpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:45:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1izMrS-0004Qh-27; Wed, 05 Feb 2020 16:45:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B03061C1EC4;
        Wed,  5 Feb 2020 16:45:05 +0100 (CET)
Date:   Wed, 05 Feb 2020 15:45:05 -0000
From:   "tip-bot2 for Changbin Du" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Make perf able to build with latest libbfd
Cc:     Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200128152938.31413-1-changbin.du@gmail.com>
References: <20200128152938.31413-1-changbin.du@gmail.com>
MIME-Version: 1.0
Message-ID: <158091750550.411.12440680363367163439.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0ada120c883d4f1f6aafd01cf0fbb10d8bbba015
Gitweb:        https://git.kernel.org/tip/0ada120c883d4f1f6aafd01cf0fbb10d8bbba015
Author:        Changbin Du <changbin.du@gmail.com>
AuthorDate:    Tue, 28 Jan 2020 23:29:38 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 30 Jan 2020 11:55:26 +01:00

perf: Make perf able to build with latest libbfd

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
index 6ccf6f6..5b7d6c1 100644
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
