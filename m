Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58767C2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356EA20752
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDDIn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:43:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgDDImO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNP-0001EW-R3; Sat, 04 Apr 2020 10:42:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 915B31C07F3;
        Sat,  4 Apr 2020 10:41:58 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:58 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers uapi: Update linux/in.h copy
Cc:     "David S. Miller" <davem@davemloft.net>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158598971810.28353.6797716304200717885.tip-bot2@tip-bot2>
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

Commit-ID:     29f36c168813f1beaf59812cc79ef46fb33c669a
Gitweb:        https://git.kernel.org/tip/29f36c168813f1beaf59812cc79ef46fb33c669a
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 19 Mar 2020 11:42:56 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:58 -03:00

tools headers uapi: Update linux/in.h copy

To get the changes in:

  267762538705 ("seg6: fix SRv6 L2 tunnels to use IANA-assigned protocol number")

That ends up automatically adding the new IPPROTO_ETHERNET to the socket
args beautifiers:

  $ tools/perf/trace/beauty/socket_ipproto.sh > before

Apply this patch:

  $ tools/perf/trace/beauty/socket_ipproto.sh > after
  $ diff -u before after
  --- before	2020-03-19 11:48:36.876673819 -0300
  +++ after	2020-03-19 11:49:00.148541377 -0300
  @@ -6,6 +6,7 @@
   	[132] = "SCTP",
   	[136] = "UDPLITE",
   	[137] = "MPLS",
  +	[143] = "ETHERNET",
   	[17] = "UDP",
   	[1] = "ICMP",
   	[22] = "IDP",
  $

Addresses this tools/perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
  diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h

Cc: David S. Miller <davem@davemloft.net>
Cc: Paolo Lungaroni <paolo.lungaroni@cnit.it>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/in.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/uapi/linux/in.h b/tools/include/uapi/linux/in.h
index 1521073..8533bf0 100644
--- a/tools/include/uapi/linux/in.h
+++ b/tools/include/uapi/linux/in.h
@@ -74,6 +74,8 @@ enum {
 #define IPPROTO_UDPLITE		IPPROTO_UDPLITE
   IPPROTO_MPLS = 137,		/* MPLS in IP (RFC 4023)		*/
 #define IPPROTO_MPLS		IPPROTO_MPLS
+  IPPROTO_ETHERNET = 143,	/* Ethernet-within-IPv6 Encapsulation	*/
+#define IPPROTO_ETHERNET	IPPROTO_ETHERNET
   IPPROTO_RAW = 255,		/* Raw IP packets			*/
 #define IPPROTO_RAW		IPPROTO_RAW
   IPPROTO_MPTCP = 262,		/* Multipath TCP connection		*/
