Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D68C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7B124693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583838973;
	bh=S/93m6Z+weTn2qXhVPQeetodWMLR6feM3oOuj3/0ig8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dedJqzxr4FIu6sbf9WiwurfSuF9vsehNY+kPC9ebjRbSCdpbnGYw8pcgiB0a8XWWT
	 VWXVW/+pz8SenfSiv3TFOQxXe5FJeRgRqtjaFMFrObmmQMEjupf6HBiN5n0G8CLUs5
	 XEXlyDI4pTgvqfMRAGCw73HEcstKY4ibTdtDEQQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCJLQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:16:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:53876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgCJLQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:16:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08B552468C;
        Tue, 10 Mar 2020 11:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583838970;
        bh=S/93m6Z+weTn2qXhVPQeetodWMLR6feM3oOuj3/0ig8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o/DjjTx6Q6EnSNv9vwdKfs+j7D6QS0wNOiWLhj8D1rvceXT/+0kcnn7iVgPSSrd/N
         BBuYUkDzwDnVLazg4y3ps8k1DGaKtAtlrsFbiv1cYIUefy/zX/5zmc66ag3+s9c031
         loKM5e27rYXfXsnrXE7Qw9oJ8Li1jCZ5fZZkvjBY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 03/19] perf llvm: Add debug hint message about missing kernel-devel package
Date:   Tue, 10 Mar 2020 08:15:35 -0300
Message-Id: <20200310111551.25160-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200310111551.25160-1-acme@kernel.org>
References: <20200310111551.25160-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help in debugging, add this extra message:

  detect_kbuild_dir: Couldn't find "/lib/modules/5.4.20-200.fc31.x86_64/build/include/generated/autoconf.h", missing kernel-devel package?.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index b5af680fc667..dbdffb6673fe 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -265,6 +265,8 @@ static int detect_kbuild_dir(char **kbuild_dir)
 			return -ENOMEM;
 		return 0;
 	}
+	pr_debug("%s: Couldn't find \"%s\", missing kernel-devel package?.\n",
+		 __func__, autoconf_path);
 	free(autoconf_path);
 	return -ENOENT;
 }
-- 
2.21.1

