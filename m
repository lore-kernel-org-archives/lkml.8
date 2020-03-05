Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC772070E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 23:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEXdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:33:31 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55496 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726145AbgCEXdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 18:33:31 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 025NVkwZ005883;
        Thu, 5 Mar 2020 18:33:00 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yhs0w15hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 18:33:00 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 025NUPx3012605;
        Thu, 5 Mar 2020 23:33:00 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 2yffk82ruh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Mar 2020 23:32:59 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 025NWwIa14418624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Mar 2020 23:32:58 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33EEBBE04F;
        Thu,  5 Mar 2020 23:32:58 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27088BE051;
        Thu,  5 Mar 2020 23:32:55 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.18.235.147])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  5 Mar 2020 23:32:54 +0000 (GMT)
From:   Leonardo Bras <leonardo@linux.ibm.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Anderson <andmike@linux.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        bharata.rao@in.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/1] powerpc/kernel: Enables memory hot-remove after reboot on pseries guests
Date:   Thu,  5 Mar 2020 20:32:31 -0300
Message-Id: <20200305233231.174082-1-leonardo@linux.ibm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-05_08:2020-03-05,2020-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003050132
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While providing guests, it's desirable to resize it's memory on demand.

By now, it's possible to do so by creating a guest with a small base
memory, hot-plugging all the rest, and using 'movable_node' kernel
command-line parameter, which puts all hot-plugged memory in
ZONE_MOVABLE, allowing it to be removed whenever needed.

But there is an issue regarding guest reboot:
If memory is hot-plugged, and then the guest is rebooted, all hot-plugged
memory goes to ZONE_NORMAL, which offers no guaranteed hot-removal.
It usually prevents this memory to be hot-removed from the guest.

It's possible to use device-tree information to fix that behavior, as
it stores flags for LMB ranges on ibm,dynamic-memory-vN.
It involves marking each memblock with the correct flags as hotpluggable
memory, which mm/memblock.c puts in ZONE_MOVABLE during boot if
'movable_node' is passed.

For carrying such information, the new flag DRCONF_MEM_HOTPLUGGED is
proposed, which should be true if memory was hot-plugged on guest, and
false if it's base memory.

During boot, guest kernel reads the device-tree, early_init_drmem_lmb()
is called for every added LMBs. Here, checking for this new flag and
marking memblocks as hotplugable memory is enough to get the desirable
behavior.

This should cause no change if 'movable_node' parameter is not passed
in kernel command-line.

Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>

---
The new flag was already proposed on Power Architecture documentation,
and it's waiting for approval.

I would like to get your comments on this change, but it's still not
ready for being merged.

I will send the matching qemu change as a reply later.

Changes since v1:
- Adds new flag, so PowerVM is compatible with the change.
- Fixes mistakes in code
---
 arch/powerpc/include/asm/drmem.h | 1 +
 arch/powerpc/kernel/prom.c       | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 3d76e1c388c2..92083b4565f6 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -65,6 +65,7 @@ struct of_drconf_cell_v2 {
 #define DRCONF_MEM_ASSIGNED	0x00000008
 #define DRCONF_MEM_AI_INVALID	0x00000040
 #define DRCONF_MEM_RESERVED	0x00000080
+#define DRCONF_MEM_HOTPLUGGED	0x00000100
 
 static inline u32 drmem_lmb_size(void)
 {
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 6620f37abe73..9c5cb2e8049e 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -515,9 +515,14 @@ static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
 				size = 0x80000000ul - base;
 		}
 
+		if (!validate_mem_limit(base, &size))
+			continue;
+
 		DBG("Adding: %llx -> %llx\n", base, size);
-		if (validate_mem_limit(base, &size))
-			memblock_add(base, size);
+		memblock_add(base, size);
+
+		if (lmb->flags & DRCONF_MEM_HOTPLUGGED)
+			memblock_mark_hotplug(base, size);
 	} while (--rngs);
 }
 #endif /* CONFIG_PPC_PSERIES */
-- 
2.24.1

