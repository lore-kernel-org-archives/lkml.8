Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6919DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30BC724673
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707525;
	bh=9IbIjKbgM14LeFmDUWry9gH42JeWfVCMQ1psxr4QCuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PTedbz58/7l1Nku8YmoywCpT8tjbvJZjdf8B96uyLYrVkFS85uhAd1/NTkuZhFREX
	 mb2l3OxqyMpi6rk5NUD9S3fViSycP0qAzJmQL2UuzR4P7vVwLrHbnfeNQSD8DaNz10
	 aSRooHfmn87Xd9y4xZG8E8pjStyuyowOlqQOHKN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbgBNTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:49688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbgBNTL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:59 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F26222314;
        Fri, 14 Feb 2020 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707518;
        bh=9IbIjKbgM14LeFmDUWry9gH42JeWfVCMQ1psxr4QCuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OclfMBevA0KH2YKsvrf50t9H8Hv714+Hvh5Z2JQZF/PkVZt9MTWpEgxSxo+Qj+SS7
         OM+PpgvU8Mb8CRCbl+L8UzVU/KT5p6YvDjJRQKHCpoOJ61HtzwM6YSlKKXWeGJshNz
         XPTkShmHScmhch+L78o4YYX/WAXqHp9RUEInzkTM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mike Christie <mchristi@redhat.com>
Subject: [PATCH 10/23] tools headers UAPI: Sync prctl.h with the kernel sources
Date:   Fri, 14 Feb 2020 16:10:44 -0300
Message-Id: <20200214191057.26266-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 7da1b37b27aa..07b4f8131e36 100644
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
-- 
2.21.1

