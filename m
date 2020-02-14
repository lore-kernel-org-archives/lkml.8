Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E58DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2002F24670
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707521;
	bh=lTtf4GYL5+57hOJVNnzM3vEIIxBaNx0w5DPQG4XdfEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BwtqBZ0ewY/g4SUDpK1X/L1t266L40ZSWJJqEW9VbIYcYpxZAKq8pXpl7WkUq4KGd
	 2Eoy7PeoyCfp9IW3vrtz7vgcUAN7s72M4ORb3eb7pAfjUJy5IwxXvihsX3BRdeTGRh
	 oN/2EookdFAIvljMgTdxQUzTaiXq9JXQ0Nl18erU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbgBNTMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388610AbgBNTLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:55 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2223206D7;
        Fri, 14 Feb 2020 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707515;
        bh=lTtf4GYL5+57hOJVNnzM3vEIIxBaNx0w5DPQG4XdfEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eAvkh/cd4HoJybExUTCKlRFbGEkYzUBIIPBaFquYHN9GcuXvlNhjyULbujJTfmltO
         dTE9sA22xlZtuBaQeXqLymDhUzf8YTKdExhgVOJ12xA6cWgVDbAPscdnoPSubaHwtL
         D8fkj0AKUyyuTYBRgrfjNK5k+Zjt6e8aLWoVaP7E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Amanieu d'Antras <amanieu@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 09/23] tools headers UAPI: Sync copy of arm64's asm/unistd.h with the kernel sources
Date:   Fri, 14 Feb 2020 16:10:43 -0300
Message-Id: <20200214191057.26266-10-acme@kernel.org>
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

  3e3c8ca5a351 ("arm64: Move __ARCH_WANT_SYS_CLONE3 definition to uapi headers")

Silencing this tools/perf/ build warning:

  Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/unistd.h' differs from latest version at 'arch/arm64/include/uapi/asm/unistd.h'
  diff -u tools/arch/arm64/include/uapi/asm/unistd.h arch/arm64/include/uapi/asm/unistd.h

Which will probably end up enabling the use of "clone3" in 'perf trace -e',
haven't checked the build with this change on an arm64 system.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Amanieu d'Antras <amanieu@gmail.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/arch/arm64/include/uapi/asm/unistd.h b/tools/arch/arm64/include/uapi/asm/unistd.h
index 4703d218663a..f83a70e07df8 100644
--- a/tools/arch/arm64/include/uapi/asm/unistd.h
+++ b/tools/arch/arm64/include/uapi/asm/unistd.h
@@ -19,5 +19,6 @@
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYS_CLONE3
 
 #include <asm-generic/unistd.h>
-- 
2.21.1

