Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6541C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA73A20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJlMEgwA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgEDXWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:22:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33632 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:22:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHrFj096452;
        Mon, 4 May 2020 23:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gqmnmYEdLwW0dpD7E5S6sJLnEfYnWZTdHQ/H3M0hDkk=;
 b=LJlMEgwAjQhiDmpbVDapxNbMPuWpZCO1oHOgJwpRr910DVcaELccK7j0YT4O4RR4gbKJ
 RXrQbIsAR7SvFCtBT7V0OX4o50qAi/JvDPB5QfEmT7jCsnlPBUyAyFBfUo+XwAasGufy
 U6V+sNKkaaOYz5FAVfnN0VYfNcRMz3XwB/ibFwW3OnZAk3J7iOYtqEB6BdvSkgeLZxQ0
 FFrKlMATLtMK3SDkVTTIsmqKpOZAOv92aqu1brpfq9MCYKL8dRzxJFdevcdC/M9SHB8q
 5cytDOWHPCBHqwexLcOINuyBNQ+3wwlrcuRwy2+9dLSekvISlD7aW4g5LdLxikO0Q52i RQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 30s1gn1n3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHKdR030657;
        Mon, 4 May 2020 23:22:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjncbb6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NMCge010253;
        Mon, 4 May 2020 23:22:12 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:11 -0700
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
Subject: [GRUB PATCH RFC 03/18] i386/msr: Extract and improve MSR support detection code
Date:   Tue,  5 May 2020 01:21:17 +0200
Message-Id: <20200504232132.23570-4-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently rdmsr and wrmsr commands have own MSR support detection code.
This code is the same. So, it is duplicated. Additionally, this code
cannot be reused by others. Hence, extract this code to a function and
make it public. By the way, improve a code a bit.

Additionally, use GRUB_ERR_BAD_DEVICE instead of GRUB_ERR_BUG to signal
an error because errors encountered by this new routine are not bugs.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/i386/rdmsr.c | 21 +++++----------------
 grub-core/commands/i386/wrmsr.c | 21 +++++----------------
 include/grub/i386/msr.h         | 29 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 32 deletions(-)

diff --git a/grub-core/commands/i386/rdmsr.c b/grub-core/commands/i386/rdmsr.c
index 89ece7657..2e42f6197 100644
--- a/grub-core/commands/i386/rdmsr.c
+++ b/grub-core/commands/i386/rdmsr.c
@@ -42,27 +42,16 @@ static const struct grub_arg_option options[] =
 static grub_err_t
 grub_cmd_msr_read (grub_extcmd_context_t ctxt, int argc, char **argv)
 {
-  grub_uint32_t manufacturer[3], max_cpuid, a, b, c, features, addr;
+  grub_err_t err;
+  grub_uint32_t addr;
   grub_uint64_t value;
   const char *ptr;
   char buf[sizeof("1122334455667788")];
 
-  /*
-   * The CPUID instruction should be used to determine whether MSRs
-   * are supported. (CPUID.01H:EDX[5] = 1)
-   */
-  if (! grub_cpu_is_cpuid_supported ())
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
+  err = grub_cpu_is_msr_supported ();
 
-  grub_cpuid (0, max_cpuid, manufacturer[0], manufacturer[2], manufacturer[1]);
-
-  if (max_cpuid < 1)
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
-
-  grub_cpuid (1, a, b, c, features);
-
-  if (!(features & (1 << 5)))
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
+  if (err != GRUB_ERR_NONE)
+    return grub_error (err, N_("RDMSR is unsupported"));
 
   if (argc != 1)
     return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("one argument expected"));
diff --git a/grub-core/commands/i386/wrmsr.c b/grub-core/commands/i386/wrmsr.c
index e3e9f2ee3..d14bb3176 100644
--- a/grub-core/commands/i386/wrmsr.c
+++ b/grub-core/commands/i386/wrmsr.c
@@ -35,26 +35,15 @@ static grub_command_t cmd_write;
 static grub_err_t
 grub_cmd_msr_write (grub_command_t cmd __attribute__ ((unused)), int argc, char **argv)
 {
-  grub_uint32_t manufacturer[3], max_cpuid, a, b, c, features, addr;
+  grub_err_t err;
+  grub_uint32_t addr;
   grub_uint64_t value;
   const char *ptr;
 
-  /*
-   * The CPUID instruction should be used to determine whether MSRs
-   * are supported. (CPUID.01H:EDX[5] = 1)
-   */
-  if (!grub_cpu_is_cpuid_supported ())
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
+  err = grub_cpu_is_msr_supported ();
 
-  grub_cpuid (0, max_cpuid, manufacturer[0], manufacturer[2], manufacturer[1]);
-
-  if (max_cpuid < 1)
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
-
-  grub_cpuid (1, a, b, c, features);
-
-  if (!(features & (1 << 5)))
-    return grub_error (GRUB_ERR_BUG, N_("unsupported instruction"));
+  if (err != GRUB_ERR_NONE)
+    return grub_error (err, N_("WRMSR is unsupported"));
 
   if (argc != 2)
     return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("two arguments expected"));
diff --git a/include/grub/i386/msr.h b/include/grub/i386/msr.h
index 4fba1b8e0..1e838c022 100644
--- a/include/grub/i386/msr.h
+++ b/include/grub/i386/msr.h
@@ -19,6 +19,35 @@
 #ifndef GRUB_I386_MSR_H
 #define GRUB_I386_MSR_H 1
 
+#include <grub/err.h>
+#include <grub/i386/cpuid.h>
+#include <grub/types.h>
+
+static inline grub_err_t
+grub_cpu_is_msr_supported (void)
+{
+  grub_uint32_t eax, ebx, ecx, edx;
+
+  /*
+   * The CPUID instruction should be used to determine whether MSRs
+   * are supported, CPUID.01H:EDX[5] = 1.
+   */
+  if (!grub_cpu_is_cpuid_supported ())
+    return GRUB_ERR_BAD_DEVICE;
+
+  grub_cpuid (0, eax, ebx, ecx, edx);
+
+  if (eax < 1)
+    return GRUB_ERR_BAD_DEVICE;
+
+  grub_cpuid (1, eax, ebx, ecx, edx);
+
+  if (!(edx & (1 << 5)))
+    return GRUB_ERR_BAD_DEVICE;
+
+  return GRUB_ERR_NONE;
+}
+
 /*
  * TODO: Add a general protection exception handler.
  *       Accessing a reserved or unimplemented MSR address results in a GP#.
-- 
2.11.0

