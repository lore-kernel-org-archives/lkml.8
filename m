Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42201C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EFBB2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DPftL38k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgEDXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:23:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgEDXXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NJIXk097247;
        Mon, 4 May 2020 23:22:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=e/TtFKtMhJ/896wUcLf0LH9xhAEKzCC+QAaSL5idCiQ=;
 b=DPftL38k44J1lz5KHTnniD0E36T6TfnO+3/62pHOLtS1IIdBG+vky+PjTZKkjJVQZ+yX
 tUkrWSceDt+zYZFTz2lkcDvg+Qc1u9nut4z+m8+PzUX2Zb32Ff7DXnlwFkptxYtiO+YJ
 XxrTzgtkzwluVxxQxhUn2lEezHG8+sU8G0XtR47fwBp3epVmUh9c10tm+0Uk/ROmnIbd
 0F4jAIDGIPwE4y3oxMPlRvCPGAZN5WPkcczN8OUzAyhBiqzeGRzvcnW0Cx7XCnHgWKYJ
 rMIAVjxdSRX8Wcpn33P2OwEf84SBFq8tF9ZhrylZ806jyB0XvE3gMD9/mqJntPCr6pSs ig== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30s0tm9t16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NGhiC082611;
        Mon, 4 May 2020 23:22:28 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 30sjdrpec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NMQ0t004107;
        Mon, 4 May 2020 23:22:26 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:26 -0700
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
Subject: [GRUB PATCH RFC 06/18] mmap: Add grub_mmap_get_lowest() and grub_mmap_get_highest()
Date:   Tue,  5 May 2020 01:21:20 +0200
Message-Id: <20200504232132.23570-7-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=2
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions calculate lowest and highest available RAM
addresses respectively.

Both functions are needed to calculate PMR boundaries for
Intel TXT secure launcher introduced by subsequent patches.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/mmap/mmap.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/grub/memory.h |  3 +++
 2 files changed, 67 insertions(+)

diff --git a/grub-core/mmap/mmap.c b/grub-core/mmap/mmap.c
index b569cb23b..cf4b69f56 100644
--- a/grub-core/mmap/mmap.c
+++ b/grub-core/mmap/mmap.c
@@ -340,6 +340,70 @@ grub_mmap_unregister (int handle)
 
 #endif /* ! GRUB_MMAP_REGISTER_BY_FIRMWARE */
 
+typedef struct
+{
+  grub_uint64_t addr;
+  grub_uint64_t limit;
+} addr_limit_t;
+
+/* Helper for grub_mmap_get_lowest().  */
+static int
+lowest_hook (grub_uint64_t addr, grub_uint64_t size, grub_memory_type_t type,
+	     void *data)
+{
+  addr_limit_t *al = data;
+
+  if (type != GRUB_MEMORY_AVAILABLE)
+    return 0;
+
+  if (addr >= al->limit)
+    al->addr = grub_min (al->addr, addr);
+
+  if ((addr < al->limit) && ((addr + size) > al->limit))
+    al->addr = al->limit;
+
+  return 0;
+}
+
+grub_uint64_t
+grub_mmap_get_lowest (grub_uint64_t limit)
+{
+  addr_limit_t al = {~0, limit};
+
+  grub_mmap_iterate (lowest_hook, &al);
+
+  return al.addr;
+}
+
+/* Helper for grub_mmap_get_highest().  */
+static int
+highest_hook (grub_uint64_t addr, grub_uint64_t size, grub_memory_type_t type,
+	      void *data)
+{
+  addr_limit_t *al = data;
+
+  if (type != GRUB_MEMORY_AVAILABLE)
+    return 0;
+
+  if ((addr + size) < al->limit)
+    al->addr = grub_max (al->addr, addr + size);
+
+  if ((addr < al->limit) && ((addr + size) >= al->limit))
+    al->addr = al->limit;
+
+  return 0;
+}
+
+grub_uint64_t
+grub_mmap_get_highest (grub_uint64_t limit)
+{
+  addr_limit_t al = {0, limit};
+
+  grub_mmap_iterate (highest_hook, &al);
+
+  return al.addr;
+}
+
 #define CHUNK_SIZE	0x400
 
 struct badram_entry {
diff --git a/include/grub/memory.h b/include/grub/memory.h
index 6da114a1b..8f22f7525 100644
--- a/include/grub/memory.h
+++ b/include/grub/memory.h
@@ -69,6 +69,9 @@ void *grub_mmap_malign_and_register (grub_uint64_t align, grub_uint64_t size,
 
 void grub_mmap_free_and_unregister (int handle);
 
+extern grub_uint64_t grub_mmap_get_lowest (grub_uint64_t limit);
+extern grub_uint64_t grub_mmap_get_highest (grub_uint64_t limit);
+
 #ifndef GRUB_MMAP_REGISTER_BY_FIRMWARE
 
 struct grub_mmap_region
-- 
2.11.0

