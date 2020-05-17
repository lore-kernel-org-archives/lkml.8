Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD493C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824DD206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 00:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YnG6kEfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgEQAZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 20:25:14 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16124 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgEQAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 20:25:12 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec0845b0000>; Sat, 16 May 2020 17:24:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 16 May 2020 17:25:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 16 May 2020 17:25:12 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 17 May
 2020 00:25:11 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 17 May 2020 00:25:11 +0000
Received: from sandstorm.nvidia.com (Not Verified[10.2.48.175]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ec084670001>; Sat, 16 May 2020 17:25:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Brian Geffon <bgeffon@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] selftests/vm/.gitignore: add khugepaged, mremap_dontunmap
Date:   Sat, 16 May 2020 17:25:09 -0700
Message-ID: <20200517002509.362401-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517002509.362401-1-jhubbard@nvidia.com>
References: <20200517002509.362401-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589675099; bh=hLSvN+wnL0qj4RxGnT+ilPGcckAlLs8+Gg8Y7Cvm3mQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=YnG6kEfas4ZWgZtiO4kw8K+46zWqo3PS2sBL2FGm2fHgt8ZbYp3QZz4njTQoIlJQU
         nTLGj1w972+J7SVQit8Snisv2HLTqOoCu9JUxbjRfvgr8LKNtOBfOYkxSYEzvetr06
         nyYi4sod+is+26aZn2ORYRI++qzWLL7gtJi9VgAiwxLTSR16a2kJAiw1+qI0IYI6IK
         Y2jUAygzlSGWf52kmRt4A09iSpksfY9Wf/XGpZhXrSHCO2kKA0skgKFuaYdHJUWNCE
         m1UwDS/eRjzI9zDkNjdiml+wpuGgBRYh35ld37ZO2Lw5OlXSFOYARvGBhwyYNAGlmK
         9xARmjFST8Jvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mremap_dontunmap and khugepaged to .gitignore.

Fixes: 6582dba23f8b ("khugepaged: add self test")
Fixes: 0c28759ee3c9 ("selftests: add MREMAP_DONTUNMAP selftest")
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftest=
s/vm/.gitignore
index 4ff9708277fb..ddf5426416fa 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+mremap_dontunmap
 hugepage-mmap
 hugepage-shm
 map_hugetlb
@@ -18,3 +19,4 @@ va_128TBswitch
 map_fixed_noreplace
 write_to_hugetlbfs
 hmm-tests
+khugepaged
--=20
2.26.2

