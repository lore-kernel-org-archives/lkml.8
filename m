Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEA9C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35034206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707542;
	bh=PUNSJqawvXAXdreRH7sjKCISsTSQZAL/4cfSYu8rwAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tGccRIwikOKdx/yrbkQKv3y9No7ymg+xmr+HpmGqWY76Xw7iNJydJahOkUbOUGjv/
	 7Wxi32nH2XaK5c9wRPVaWEyhwy9erT4aZzhogXZXHslCold6T+IjStKZ2Lysd8B3Wp
	 0lhFcytVnZnykQ7b5IJLY9985cGeC6ASepKxjs64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbgBNTMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388832AbgBNTMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:17 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8468A24649;
        Fri, 14 Feb 2020 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707536;
        bh=PUNSJqawvXAXdreRH7sjKCISsTSQZAL/4cfSYu8rwAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRi1IyAGxEcENtURSnbq1ApYG0PVLyV2xtqAUu+hhpjy9X4EBl7HfszXEpuOQ5Hcg
         NJkgMmKOVKuRJZCIkweKuj00V3uFReU161xHSQ7lytFLtaWnt2NEKIOexQyiJU8v32
         aNoch9+wLxFBH3B+sR26Pc09ve4gTTsZ1vPSQZic=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: [PATCH 14/23] tools headers uapi: Sync linux/fscrypt.h with the kernel sources
Date:   Fri, 14 Feb 2020 16:10:48 -0300
Message-Id: <20200214191057.26266-15-acme@kernel.org>
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

To pick the changes from:

  e933adde6f97 ("fscrypt: include <linux/ioctl.h> in UAPI header")
  93edd392cad7 ("fscrypt: support passing a keyring key to FS_IOC_ADD_ENCRYPTION_KEY")

That don't trigger any changes in tooling.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fscrypt.h' differs from latest version at 'include/uapi/linux/fscrypt.h'
  diff -u tools/include/uapi/linux/fscrypt.h include/uapi/linux/fscrypt.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fscrypt.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
index 1beb174ad950..0d8a6f47711c 100644
--- a/tools/include/uapi/linux/fscrypt.h
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -8,6 +8,7 @@
 #ifndef _UAPI_LINUX_FSCRYPT_H
 #define _UAPI_LINUX_FSCRYPT_H
 
+#include <linux/ioctl.h>
 #include <linux/types.h>
 
 /* Encryption policy flags */
@@ -109,11 +110,22 @@ struct fscrypt_key_specifier {
 	} u;
 };
 
+/*
+ * Payload of Linux keyring key of type "fscrypt-provisioning", referenced by
+ * fscrypt_add_key_arg::key_id as an alternative to fscrypt_add_key_arg::raw.
+ */
+struct fscrypt_provisioning_key_payload {
+	__u32 type;
+	__u32 __reserved;
+	__u8 raw[];
+};
+
 /* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
 struct fscrypt_add_key_arg {
 	struct fscrypt_key_specifier key_spec;
 	__u32 raw_size;
-	__u32 __reserved[9];
+	__u32 key_id;
+	__u32 __reserved[8];
 	__u8 raw[];
 };
 
-- 
2.21.1

