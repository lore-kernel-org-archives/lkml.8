Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEE2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD8624676
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707570;
	bh=VvzISHogKJQu911aKASynf4Etjn/cTsgXOLLa8E7gIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V6xLANUywiEeAARly+5fnvSQkxTo7CGg9RUxDxSlURKR3r94TuLpxMUbgK3h7yQmR
	 SwC/4tE8SrhUQhdaaffcfEYORZWU2QIwYMvyWy2vcV53TvmKZK8XXSUsjN5prW1N5b
	 u+tskHbfWfiX9aNP+v+RnuKcT80uynbxg7aLi+N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389219AbgBNTMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389144AbgBNTMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:45 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A0F9206D7;
        Fri, 14 Feb 2020 19:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707565;
        bh=VvzISHogKJQu911aKASynf4Etjn/cTsgXOLLa8E7gIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJlYMyPGkJXB+SHyGa+HYOpYKqxt3z61+IO5BfnWH5zuOlC9ErN1tvCsM6ybyBPhe
         B8wnIKqUr52iWm6KBuM4UYggPtNMeVe2G4BqFP8uPNaVPuco6Xz0I3BzLEShF7jmeH
         ibpfLRK8t0enPLJ2xfd9Idp3NHxoHRwKXRGEZCec=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 19/23] tools headers x86: Sync disabled-features.h
Date:   Fri, 14 Feb 2020 16:10:53 -0300
Message-Id: <20200214191057.26266-20-acme@kernel.org>
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

To silence the following tools/perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
  diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h

Picking up the changes in:

  45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")

that didn't entail any functionality change in the tooling side.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/disabled-features.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index 8e1d0bb46361..4ea8584682f9 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -10,12 +10,6 @@
  * cpu_feature_enabled().
  */
 
-#ifdef CONFIG_X86_INTEL_MPX
-# define DISABLE_MPX	0
-#else
-# define DISABLE_MPX	(1<<(X86_FEATURE_MPX & 31))
-#endif
-
 #ifdef CONFIG_X86_SMAP
 # define DISABLE_SMAP	0
 #else
@@ -74,7 +68,7 @@
 #define DISABLED_MASK6	0
 #define DISABLED_MASK7	(DISABLE_PTI)
 #define DISABLED_MASK8	0
-#define DISABLED_MASK9	(DISABLE_MPX|DISABLE_SMAP)
+#define DISABLED_MASK9	(DISABLE_SMAP)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	0
 #define DISABLED_MASK12	0
-- 
2.21.1

