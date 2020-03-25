Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDC8C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 504EB2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140157;
	bh=XcSAFmz7j9h/ld+mxI8Ru5nGyAyH8L4LiHQo9b4qTV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLcg6I9VfiAfKO3SfiZe4DvYqz++IzKI1w5rfKKUYqW0Qm1XT+PzSGca4lsQY7kb7
	 9Or9yI0uxz3dpuIiDkZNwwznSldZImTxDmVLFCXF5VR/CbN6uCm3wZB2keh5657p3h
	 QH5PovLcwH6NG5r0zH1qU94zn7UVfZzCqGzuzEhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCYMmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbgCYMma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:42:30 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535F12078A;
        Wed, 25 Mar 2020 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140149;
        bh=XcSAFmz7j9h/ld+mxI8Ru5nGyAyH8L4LiHQo9b4qTV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PzuC1BA2hirqc39BNQhc5Yxm3HK7Xh0/P/HXxaqdnqg3VE5MbzEI4ZFnJXPFT9Ec5
         FLB72aWfLWHaE9n25vXq8xdiAEgo8TRmv9MjzY/eX8z/kVL05qS2vLerPA4e2jDdgJ
         AXnz/Q7dQmXp3Fw0IFHeZFt8fccL++d5qd0iRaII=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Paolo Lungaroni <paolo.lungaroni@cnit.it>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 14/24] tools headers uapi: Update linux/in.h copy
Date:   Wed, 25 Mar 2020 09:41:14 -0300
Message-Id: <20200325124124.32648-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 1521073b6348..8533bf07450f 100644
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
-- 
2.21.1

