Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC06C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9789B24954
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Nzmq5SgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgEDXXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:23:01 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38814 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbgEDXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NKu7e189038;
        Mon, 4 May 2020 23:22:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=IVFDwmCRKpBvGrABJz5CAyqYPBoVjx7gsourCU87USE=;
 b=Nzmq5SgFxokVhVmOHipjBmGpg3Xgoxp+rmFm5l3inzWA4NYvRoO5nG5i6rRVi0xC29mS
 FcE+giAoTq8mgi39c3hASXnKhl5csgte+/mhUwhSCrmAC28sLg2KcWto+1WISTN6oJ++
 AHUSjmmpSP893QoUBkG/EADdggT/0gbRiU03Zgfj+jwLwuV3sf4IJNCNv89LAwVp2DEA
 EqgWlkcL6WZe6hWW1QK3vA/ZSvcCBrf16jzPc5C/GzKlnvx+OhzEWAPgL4CqxlFhJiDK
 l+l6fChCtDx9JFC5tgSbGHrbdvOwGQXHYL09uoho4bwJ5xuXJgX9VCcEpCulolh8seKy 2Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30s09r1uyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMTja021598;
        Mon, 4 May 2020 23:22:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30sjjx5hq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NMiaL003551;
        Mon, 4 May 2020 23:22:44 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:41 -0700
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
Subject: [GRUB PATCH RFC 09/18] efi: Make shim_lock GUID and protocol type public
Date:   Tue,  5 May 2020 01:21:23 +0200
Message-Id: <20200504232132.23570-10-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GUID will be used to properly detect and report UEFI Secure Boot
status to the x86 Linux kernel. The functionality will be added by
subsequent patches. The shim_lock protocol type is made public for
completeness.

Additionally, fix formatting of four preceding GUIDs.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/efi/shim_lock.c | 12 ------------
 include/grub/efi/api.h             | 19 +++++++++++++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/grub-core/commands/efi/shim_lock.c b/grub-core/commands/efi/shim_lock.c
index 764098cfc..d8f52d721 100644
--- a/grub-core/commands/efi/shim_lock.c
+++ b/grub-core/commands/efi/shim_lock.c
@@ -27,18 +27,6 @@
 
 GRUB_MOD_LICENSE ("GPLv3+");
 
-#define GRUB_EFI_SHIM_LOCK_GUID \
-  { 0x605dab50, 0xe046, 0x4300, \
-    { 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23 } \
-  }
-
-struct grub_efi_shim_lock_protocol
-{
-  grub_efi_status_t
-  (*verify) (void *buffer, grub_uint32_t size);
-};
-typedef struct grub_efi_shim_lock_protocol grub_efi_shim_lock_protocol_t;
-
 static grub_efi_guid_t shim_lock_guid = GRUB_EFI_SHIM_LOCK_GUID;
 static grub_efi_shim_lock_protocol_t *sl;
 
diff --git a/include/grub/efi/api.h b/include/grub/efi/api.h
index 937058d68..e634afd61 100644
--- a/include/grub/efi/api.h
+++ b/include/grub/efi/api.h
@@ -321,22 +321,27 @@
 
 #define GRUB_EFI_SAL_TABLE_GUID \
   { 0xeb9d2d32, 0x2d88, 0x11d3, \
-      { 0x9a, 0x16, 0x0, 0x90, 0x27, 0x3f, 0xc1, 0x4d } \
+    { 0x9a, 0x16, 0x0, 0x90, 0x27, 0x3f, 0xc1, 0x4d } \
   }
 
 #define GRUB_EFI_HCDP_TABLE_GUID \
   { 0xf951938d, 0x620b, 0x42ef, \
-      { 0x82, 0x79, 0xa8, 0x4b, 0x79, 0x61, 0x78, 0x98 } \
+    { 0x82, 0x79, 0xa8, 0x4b, 0x79, 0x61, 0x78, 0x98 } \
   }
 
 #define GRUB_EFI_DEVICE_TREE_GUID \
   { 0xb1b621d5, 0xf19c, 0x41a5, \
-      { 0x83, 0x0b, 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0 } \
+    { 0x83, 0x0b, 0xd9, 0x15, 0x2c, 0x69, 0xaa, 0xe0 } \
   }
 
 #define GRUB_EFI_VENDOR_APPLE_GUID \
   { 0x2B0585EB, 0xD8B8, 0x49A9,	\
-      { 0x8B, 0x8C, 0xE2, 0x1B, 0x01, 0xAE, 0xF2, 0xB7 } \
+    { 0x8B, 0x8C, 0xE2, 0x1B, 0x01, 0xAE, 0xF2, 0xB7 } \
+  }
+
+#define GRUB_EFI_SHIM_LOCK_GUID \
+  { 0x605dab50, 0xe046, 0x4300, \
+    { 0xab, 0xb6, 0x3d, 0xd8, 0x10, 0xdd, 0x8b, 0x23 } \
   }
 
 struct grub_efi_sal_system_table
@@ -1690,6 +1695,12 @@ struct grub_efi_block_io
 };
 typedef struct grub_efi_block_io grub_efi_block_io_t;
 
+struct grub_efi_shim_lock_protocol
+{
+  grub_efi_status_t (*verify) (void *buffer, grub_uint32_t size);
+};
+typedef struct grub_efi_shim_lock_protocol grub_efi_shim_lock_protocol_t;
+
 #if (GRUB_TARGET_SIZEOF_VOID_P == 4) || defined (__ia64__) \
   || defined (__aarch64__) || defined (__MINGW64__) || defined (__CYGWIN__) \
   || defined(__riscv)
-- 
2.11.0

