Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBB1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F8120663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HL9sjNfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgEDXZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:25:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35850 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:25:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NNnwo100523;
        Mon, 4 May 2020 23:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=NiarZKa69oUi1NvVuk0h+UlmNa0jOEv+wrs0Cjog1e4=;
 b=HL9sjNfKZL1iZUZmh/Y3orCMLs2epS0sakfuqaEKRoYLJLsk7UvypkDGvjDQB4s3475B
 G9d/VpiwfRR4EB40DCPo8KuHNUldlsM3vUlQbfaV53FI9gW/llMVzJv/9q7FyntkDn7F
 avflE/TtKMuwGCeTF1zsGd+/1WIiFwxUlTq1WGkqJlNngz6rbI/lmK/oQDaYwt+lZ7YY
 c1+Z8jYr4P8seZwR2qTJK/9cMzJtsn65jg7dlWAdlpB5hFQsTeimVMqx5Lslu94rL275
 30g/vBLyu0AwVq1Xe3wlvkdL5OlK4bkXumNTGBMXDinDKEOI6Y6dLzpXUdwCxFCDMrE7 OQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 30s1gn1naw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:24:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMm5Q092911;
        Mon, 4 May 2020 23:22:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 30sjdrpev1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:58 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NMvom010711;
        Mon, 4 May 2020 23:22:57 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:56 -0700
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
Subject: [GRUB PATCH RFC 12/18] i386/efi: Report UEFI Secure Boot status to the Linux kernel
Date:   Tue,  5 May 2020 01:21:26 +0200
Message-Id: <20200504232132.23570-13-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=2 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the kernel does not know its state and cannot enable various
security features depending on UEFI Secure Boot.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/loader/i386/linux.c | 86 ++++++++++++++++++++++++++++++++++++++++++-
 include/grub/i386/linux.h     | 14 ++++++-
 2 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/grub-core/loader/i386/linux.c b/grub-core/loader/i386/linux.c
index ac1fae72e..952eb1191 100644
--- a/grub-core/loader/i386/linux.c
+++ b/grub-core/loader/i386/linux.c
@@ -397,6 +397,87 @@ grub_linux_boot_mmap_fill (grub_uint64_t addr, grub_uint64_t size,
   return 0;
 }
 
+#ifdef GRUB_MACHINE_EFI
+/*
+ * Determine whether we're in secure boot mode.
+ *
+ * Please keep the logic in sync with the Linux kernel,
+ * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
+ */
+static grub_uint8_t
+grub_efi_get_secureboot (void)
+{
+  grub_efi_guid_t efi_variable_guid = GRUB_EFI_GLOBAL_VARIABLE_GUID;
+  grub_efi_guid_t efi_shim_lock_guid = GRUB_EFI_SHIM_LOCK_GUID;
+  grub_efi_status_t status;
+  grub_efi_uint32_t attr = 0;
+  grub_size_t size = 0;
+  grub_uint8_t *secboot = NULL;
+  grub_uint8_t *setupmode = NULL;
+  grub_uint8_t *moksbstate = NULL;
+  grub_uint8_t secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_UNKNOWN;
+  const char *secureboot_str = "UNKNOWN";
+
+  status = grub_efi_get_variable ("SecureBoot", &efi_variable_guid,
+				  &size, (void **) &secboot);
+
+  if (status == GRUB_EFI_NOT_FOUND)
+    {
+      secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_DISABLED;
+      goto out;
+    }
+
+  if (status != GRUB_EFI_SUCCESS)
+    goto out;
+
+  status = grub_efi_get_variable ("SetupMode", &efi_variable_guid,
+				  &size, (void **) &setupmode);
+
+  if (status != GRUB_EFI_SUCCESS)
+    goto out;
+
+  if ((*secboot == 0) || (*setupmode == 1))
+    {
+      secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_DISABLED;
+      goto out;
+    }
+
+  /*
+   * See if a user has put the shim into insecure mode. If so, and if the
+   * variable doesn't have the runtime attribute set, we might as well
+   * honor that.
+   */
+  status = grub_efi_get_variable_with_attributes ("MokSBState", &efi_shim_lock_guid,
+						  &size, (void **) &moksbstate, &attr);
+
+  /* If it fails, we don't care why. Default to secure. */
+  if (status != GRUB_EFI_SUCCESS)
+    {
+      secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_ENABLED;
+      goto out;
+    }
+
+  if (!(attr & GRUB_EFI_VARIABLE_RUNTIME_ACCESS) && *moksbstate == 1)
+    secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_DISABLED;
+
+  secureboot = GRUB_LINUX_EFI_SECUREBOOT_MODE_ENABLED;
+
+ out:
+  grub_free (moksbstate);
+  grub_free (setupmode);
+  grub_free (secboot);
+
+  if (secureboot == GRUB_LINUX_EFI_SECUREBOOT_MODE_DISABLED)
+    secureboot_str = "Disabled";
+  else if (secureboot == GRUB_LINUX_EFI_SECUREBOOT_MODE_ENABLED)
+    secureboot_str = "Enabled";
+
+  grub_dprintf ("linux", "UEFI Secure Boot state: %s\n", secureboot_str);
+
+  return secureboot;
+}
+#endif
+
 static grub_err_t
 grub_linux_boot (void)
 {
@@ -579,6 +660,9 @@ grub_linux_boot (void)
     grub_efi_uintn_t efi_desc_size;
     grub_size_t efi_mmap_target;
     grub_efi_uint32_t efi_desc_version;
+
+    ctx.params->secure_boot = grub_efi_get_secureboot ();
+
     err = grub_efi_finish_boot_services (&efi_mmap_size, efi_mmap_buf, NULL,
 					 &efi_desc_size, &efi_desc_version);
     if (err)
@@ -790,7 +874,7 @@ grub_cmd_linux (grub_command_t cmd __attribute__ ((unused)),
 
   linux_params.code32_start = prot_mode_target + lh.code32_start - GRUB_LINUX_BZIMAGE_ADDR;
   linux_params.kernel_alignment = (1 << align);
-  linux_params.ps_mouse = linux_params.padding10 = 0;
+  linux_params.ps_mouse = linux_params.padding11 = 0;
   linux_params.type_of_loader = GRUB_LINUX_BOOT_LOADER_TYPE;
 
   /* These two are used (instead of cmd_line_ptr) by older versions of Linux,
diff --git a/include/grub/i386/linux.h b/include/grub/i386/linux.h
index ce30e7fb0..6aea73ddb 100644
--- a/include/grub/i386/linux.h
+++ b/include/grub/i386/linux.h
@@ -49,6 +49,12 @@
 /* Maximum number of MBR signatures to store. */
 #define EDD_MBR_SIG_MAX			16
 
+/* Possible values for Linux secure_boot kernel parameter. */
+#define GRUB_LINUX_EFI_SECUREBOOT_MODE_UNSET	0
+#define GRUB_LINUX_EFI_SECUREBOOT_MODE_UNKNOWN	1
+#define GRUB_LINUX_EFI_SECUREBOOT_MODE_DISABLED	2
+#define GRUB_LINUX_EFI_SECUREBOOT_MODE_ENABLED	3
+
 #ifdef __x86_64__
 
 #define GRUB_LINUX_EFI_SIGNATURE	\
@@ -275,7 +281,11 @@ struct linux_kernel_params
 
   grub_uint8_t mmap_size;		/* 1e8 */
 
-  grub_uint8_t padding9[0x1f1 - 0x1e9];
+  grub_uint8_t padding9[0x1ec - 0x1e9];
+
+  grub_uint8_t secure_boot;             /* 1ec */
+
+  grub_uint8_t padding10[0x1f1 - 0x1ed];
 
   /* Linux setup header copy - BEGIN. */
   grub_uint8_t setup_sects;		/* The size of the setup in sectors */
@@ -286,7 +296,7 @@ struct linux_kernel_params
   grub_uint16_t vid_mode;		/* Video mode control */
   grub_uint16_t root_dev;		/* Default root device number */
 
-  grub_uint8_t padding10;		/* 1fe */
+  grub_uint8_t padding11;		/* 1fe */
   grub_uint8_t ps_mouse;		/* 1ff */
 
   grub_uint16_t jump;			/* Jump instruction */
-- 
2.11.0

