Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12459C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB4D2068E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1yrPkXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgEDXXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:23:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33918 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgEDXXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:02 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHswF096514;
        Mon, 4 May 2020 23:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=rmP4AsmrDa/bV19nIhQuXGWicvxuoWR4lXg8c0w7Lg0=;
 b=b1yrPkXKtL+y9zTEWHJ/s8gDQkCk658l4K0m364MMdc8WM3fNKK1bNtTx8BLgPxMnxcG
 I7ufHj8E2DVLzeRaOFLX1HykgyUjDFr1NESSuAV5FEuEvhrARUTIAAYeqsEgwLPw1uRG
 o1FKs+1CQ2yMlnzxwRmDvy1bb3P3a1E+ReL6Cb4TDiks2AQuGPiN6d26yIEJ6guo7RzB
 1fl2LDQiL7ljt8e0H1HOJ109hj/mmE/rGiqey1JEKu8UtP2BssowLjxEHQDC5muIy+WD
 SgAAfhuFFintQvjYpy0gTh9Lw+kJ92zy7p9Aga7T65AHEHu29Iisj202TdWgatWw3klK UQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gn1n52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMTsq021564;
        Mon, 4 May 2020 23:22:47 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjx5hqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:47 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NMksW004235;
        Mon, 4 May 2020 23:22:46 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:45 -0700
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
Subject: [GRUB PATCH RFC 10/18] efi: Return grub_efi_status_t from grub_efi_get_variable()
Date:   Tue,  5 May 2020 01:21:24 +0200
Message-Id: <20200504232132.23570-11-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
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

This is needed to properly detect and report UEFI Secure Boot status
to the x86 Linux kernel. The functionality will be added by subsequent
patches.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/efi/efifwsetup.c |  8 ++++----
 grub-core/kern/efi/efi.c            | 16 +++++++++-------
 grub-core/video/efi_gop.c           |  2 +-
 include/grub/efi/efi.h              |  7 ++++---
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/grub-core/commands/efi/efifwsetup.c b/grub-core/commands/efi/efifwsetup.c
index 7a137a72a..eaca03283 100644
--- a/grub-core/commands/efi/efifwsetup.c
+++ b/grub-core/commands/efi/efifwsetup.c
@@ -38,8 +38,8 @@ grub_cmd_fwsetup (grub_command_t cmd __attribute__ ((unused)),
   grub_size_t oi_size;
   grub_efi_guid_t global = GRUB_EFI_GLOBAL_VARIABLE_GUID;
 
-  old_os_indications = grub_efi_get_variable ("OsIndications", &global,
-					      &oi_size);
+  grub_efi_get_variable ("OsIndications", &global, &oi_size,
+			 (void **) &old_os_indications);
 
   if (old_os_indications != NULL && oi_size == sizeof (os_indications))
     os_indications |= *old_os_indications;
@@ -63,8 +63,8 @@ efifwsetup_is_supported (void)
   grub_size_t oi_size = 0;
   grub_efi_guid_t global = GRUB_EFI_GLOBAL_VARIABLE_GUID;
 
-  os_indications_supported = grub_efi_get_variable ("OsIndicationsSupported",
-						    &global, &oi_size);
+  grub_efi_get_variable ("OsIndicationsSupported", &global, &oi_size,
+			 (void **) &os_indications_supported);
 
   if (!os_indications_supported)
     return 0;
diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
index 3a708ed72..81bc49f84 100644
--- a/grub-core/kern/efi/efi.c
+++ b/grub-core/kern/efi/efi.c
@@ -222,9 +222,9 @@ grub_efi_set_variable(const char *var, const grub_efi_guid_t *guid,
   return grub_error (GRUB_ERR_IO, "could not set EFI variable `%s'", var);
 }
 
-void *
+grub_efi_status_t
 grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
-		       grub_size_t *datasize_out)
+		       grub_size_t *datasize_out, void **data_out)
 {
   grub_efi_status_t status;
   grub_efi_uintn_t datasize = 0;
@@ -233,13 +233,14 @@ grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
   void *data;
   grub_size_t len, len16;
 
+  *data_out = NULL;
   *datasize_out = 0;
 
   len = grub_strlen (var);
   len16 = len * GRUB_MAX_UTF16_PER_UTF8;
   var16 = grub_malloc ((len16 + 1) * sizeof (var16[0]));
   if (!var16)
-    return NULL;
+    return GRUB_EFI_OUT_OF_RESOURCES;
   len16 = grub_utf8_to_utf16 (var16, len16, (grub_uint8_t *) var, len, NULL);
   var16[len16] = 0;
 
@@ -250,14 +251,14 @@ grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
   if (status != GRUB_EFI_BUFFER_TOO_SMALL || !datasize)
     {
       grub_free (var16);
-      return NULL;
+      return status;
     }
 
   data = grub_malloc (datasize);
   if (!data)
     {
       grub_free (var16);
-      return NULL;
+      return GRUB_EFI_OUT_OF_RESOURCES;
     }
 
   status = efi_call_5 (r->get_variable, var16, guid, NULL, &datasize, data);
@@ -265,12 +266,13 @@ grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
 
   if (status == GRUB_EFI_SUCCESS)
     {
+      *data_out = data;
       *datasize_out = datasize;
-      return data;
+      return status;
     }
 
   grub_free (data);
-  return NULL;
+  return status;
 }
 
 #pragma GCC diagnostic ignored "-Wcast-align"
diff --git a/grub-core/video/efi_gop.c b/grub-core/video/efi_gop.c
index be446f8d2..7fe0cdabf 100644
--- a/grub-core/video/efi_gop.c
+++ b/grub-core/video/efi_gop.c
@@ -316,7 +316,7 @@ grub_video_gop_get_edid (struct grub_video_edid_info *edid_info)
       char edidname[] = "agp-internal-edid";
       grub_size_t datasize;
       grub_uint8_t *data;
-      data = grub_efi_get_variable (edidname, &efi_var_guid, &datasize);
+      grub_efi_get_variable (edidname, &efi_var_guid, &datasize, (void **) &data);
       if (data && datasize > 16)
 	{
 	  copy_size = datasize - 16;
diff --git a/include/grub/efi/efi.h b/include/grub/efi/efi.h
index e90e00dc4..8b2a0f1f5 100644
--- a/include/grub/efi/efi.h
+++ b/include/grub/efi/efi.h
@@ -74,9 +74,10 @@ grub_err_t EXPORT_FUNC (grub_efi_set_virtual_address_map) (grub_efi_uintn_t memo
 							   grub_efi_uintn_t descriptor_size,
 							   grub_efi_uint32_t descriptor_version,
 							   grub_efi_memory_descriptor_t *virtual_map);
-void *EXPORT_FUNC (grub_efi_get_variable) (const char *variable,
-					   const grub_efi_guid_t *guid,
-					   grub_size_t *datasize_out);
+grub_efi_status_t EXPORT_FUNC (grub_efi_get_variable) (const char *variable,
+						       const grub_efi_guid_t *guid,
+						       grub_size_t *datasize_out,
+						       void **data_out);
 grub_err_t
 EXPORT_FUNC (grub_efi_set_variable) (const char *var,
 				     const grub_efi_guid_t *guid,
-- 
2.11.0

