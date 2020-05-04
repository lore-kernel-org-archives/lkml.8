Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DECFD2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GKNVC3hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgEDXWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:22:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgEDXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:22:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHoS9096401;
        Mon, 4 May 2020 23:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=x2DdCgYgo85a9r6JrhuziQmOVlc5I8xwmNNe0/g5MQg=;
 b=GKNVC3hrmyJhfj16BnkpHfQykaCtkD8xM6Fy1axK1f3KL8NDVclVLOuascc9j8fmOXQJ
 fzM4RINAgZ8GFBHdF45At1Jts6aRrwN49HQ62mBPDc3eCUfLZVWvFdJaw35635/Du0Ss
 aEpr0PdBbuWAwmze+eezc4zWC67renEIzI7HkieK1WTgtr1/v0Yu0H712S6hHAjFeij/
 iTTvhQ0AfrQhXdisay30c4c4ODCbH/ErWuChHzXW95tKYQfKhvZoufA2WZRggU5ZcrTM
 hHulhxn4CMDDdtEVKheHn/3JrmZMFXmdyAprGg0sbN9kFFGKcNw1VsRCdXt1ElQ3QBoL yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gn1n3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NGgTb082515;
        Mon, 4 May 2020 23:22:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdrpdr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:04 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NM2Gw010238;
        Mon, 4 May 2020 23:22:02 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:01 -0700
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org
Cc:     alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, phcoder@gmail.com,
        pirot.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Subject: [GRUB PATCH RFC 01/18] i386/msr: Merge rdmsr.h and wrmsr.h into msr.h
Date:   Tue,  5 May 2020 01:21:15 +0200
Message-Id: <20200504232132.23570-2-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It does not make sense to have separate headers for separate static
functions. Additionally, we have to add some constants with MSR addresses
in subsequent patches. So, make one common place to store them.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/i386/rdmsr.c      |  2 +-
 grub-core/commands/i386/wrmsr.c      |  2 +-
 include/grub/i386/{wrmsr.h => msr.h} | 16 +++++++++++++---
 include/grub/i386/rdmsr.h            | 37 ------------------------------------
 4 files changed, 15 insertions(+), 42 deletions(-)
 rename include/grub/i386/{wrmsr.h => msr.h} (78%)
 delete mode 100644 include/grub/i386/rdmsr.h

diff --git a/grub-core/commands/i386/rdmsr.c b/grub-core/commands/i386/rdmsr.c
index 46c4346da..fa4622f9e 100644
--- a/grub-core/commands/i386/rdmsr.c
+++ b/grub-core/commands/i386/rdmsr.c
@@ -26,7 +26,7 @@
 #include <grub/extcmd.h>
 #include <grub/i18n.h>
 #include <grub/i386/cpuid.h>
-#include <grub/i386/rdmsr.h>
+#include <grub/i386/msr.h>
 
 GRUB_MOD_LICENSE("GPLv3+");
 
diff --git a/grub-core/commands/i386/wrmsr.c b/grub-core/commands/i386/wrmsr.c
index fa76f5aed..9b7abba7c 100644
--- a/grub-core/commands/i386/wrmsr.c
+++ b/grub-core/commands/i386/wrmsr.c
@@ -26,7 +26,7 @@
 #include <grub/extcmd.h>
 #include <grub/i18n.h>
 #include <grub/i386/cpuid.h>
-#include <grub/i386/wrmsr.h>
+#include <grub/i386/msr.h>
 
 GRUB_MOD_LICENSE("GPLv3+");
 
diff --git a/include/grub/i386/wrmsr.h b/include/grub/i386/msr.h
similarity index 78%
rename from include/grub/i386/wrmsr.h
rename to include/grub/i386/msr.h
index dea60aed1..7b52b5d61 100644
--- a/include/grub/i386/wrmsr.h
+++ b/include/grub/i386/msr.h
@@ -16,14 +16,24 @@
  *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#ifndef GRUB_WRMSR_H
-#define GRUB_WRMSR_H 1
+#ifndef GRUB_I386_MSR_H
+#define GRUB_I386_MSR_H 1
 
 /*
  * TODO: Add a general protection exception handler.
  *       Accessing a reserved or unimplemented MSR address results in a GP#.
  */
 
+static inline grub_uint64_t
+grub_msr_read (grub_uint32_t msr_id)
+{
+  grub_uint32_t low, high;
+
+  asm volatile ("rdmsr" : "=a" (low), "=d" (high) : "c" (msr_id));
+
+  return ((grub_uint64_t) high << 32) | low;
+}
+
 static inline void
 grub_msr_write(grub_uint32_t msr_id, grub_uint64_t msr_value)
 {
@@ -32,4 +42,4 @@ grub_msr_write(grub_uint32_t msr_id, grub_uint64_t msr_value)
   asm volatile ("wrmsr" : : "c" (msr_id), "a" (low), "d" (high));
 }
 
-#endif /* GRUB_WRMSR_H */
+#endif /* GRUB_I386_MSR_H */
diff --git a/include/grub/i386/rdmsr.h b/include/grub/i386/rdmsr.h
deleted file mode 100644
index c0a0c717a..000000000
--- a/include/grub/i386/rdmsr.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/*
- *  GRUB  --  GRand Unified Bootloader
- *  Copyright (C) 2019  Free Software Foundation, Inc.
- *
- *  GRUB is free software: you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation, either version 3 of the License, or
- *  (at your option) any later version.
- *
- *  GRUB is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with GRUB.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#ifndef GRUB_RDMSR_H
-#define GRUB_RDMSR_H 1
-
-/*
- * TODO: Add a general protection exception handler.
- *       Accessing a reserved or unimplemented MSR address results in a GP#.
- */
-
-static inline grub_uint64_t
-grub_msr_read (grub_uint32_t msr_id)
-{
-  grub_uint32_t low, high;
-
-  asm volatile ("rdmsr" : "=a" (low), "=d" (high) : "c" (msr_id));
-
-  return ((grub_uint64_t)high << 32) | low;
-}
-
-#endif /* GRUB_RDMSR_H */
-- 
2.11.0

