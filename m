Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3DC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BE62469E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgBOImD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56782 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgBOImC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:02 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1Q-0005H6-Do; Sat, 15 Feb 2020 09:41:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23D371C205A;
        Sat, 15 Feb 2020 09:41:51 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers UAPI: Sync prctl.h with the kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158175611091.13786.17864955942021040219.tip-bot2@tip-bot2>
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

Commit-ID:     fc9199d46e644e6a978f69195cb849b21d2f485c
Gitweb:        https://git.kernel.org/tip/fc9199d46e644e6a978f69195cb849b21d2f485c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 11 Feb 2020 15:25:21 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 11 Feb 2020 16:41:50 -03:00

tools headers UAPI: Sync prctl.h with the kernel sources

To get the changes in:

  8d19f1c8e193 ("prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim")

Which ends up having this effect in tooling, i.e. the addition of the
support to those prctl's options:

  $ tools/perf/trace/beauty/prctl_option.sh > before
  $ cp include/uapi/linux/prctl.h tools/include/uapi/linux/prctl.h
  $ git diff
  diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
  index 7da1b37b27aa..07b4f8131e36 100644
  --- a/tools/include/uapi/linux/prctl.h
  +++ b/tools/include/uapi/linux/prctl.h
  @@ -234,4 +234,8 @@ struct prctl_mm_map {
   #define PR_GET_TAGGED_ADDR_CTRL                56
   # define PR_TAGGED_ADDR_ENABLE         (1UL << 0)

  +/* Control reclaim behavior when allocating memory */
  +#define PR_SET_IO_FLUSHER              57
  +#define PR_GET_IO_FLUSHER              58
  +
   #endif /* _LINUX_PRCTL_H */
  $ tools/perf/trace/beauty/prctl_option.sh > after
  $ diff -u before after
  --- before	2020-02-11 15:24:35.339289912 -0300
  +++ after	2020-02-11 15:24:56.319711315 -0300
  @@ -51,6 +51,8 @@
   	[54] = "PAC_RESET_KEYS",
   	[55] = "SET_TAGGED_ADDR_CTRL",
   	[56] = "GET_TAGGED_ADDR_CTRL",
  +	[57] = "SET_IO_FLUSHER",
  +	[58] = "GET_IO_FLUSHER",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/prctl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
index 7da1b37..07b4f81 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -234,4 +234,8 @@ struct prctl_mm_map {
 #define PR_GET_TAGGED_ADDR_CTRL		56
 # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
 
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_IO_FLUSHER		57
+#define PR_GET_IO_FLUSHER		58
+
 #endif /* _LINUX_PRCTL_H */
