Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488DCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 237E020663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gBBJka3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEDXXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:23:09 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34004 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgEDXXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:23:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NHnXY096351;
        Mon, 4 May 2020 23:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=jYXt3EJCMiPdjYydXu4t6OC3I4vDqHFJoMB9afpxeEI=;
 b=gBBJka3gKNAbB9T8BSlLnaC7stEyENKaM6etxROEQJ6krYvC4lK063afjI68Qpk6/eNs
 RobDw7fvVadTmP4Ae56yrUbnBVTWcYz8ioXsD0FIZcqH/EAsXUTy2YrBwY/20hCmfTiq
 udwQWjDtolqVYyFQQawYrDYyrLXx4nciOC5JJa8Ll0imjVhuJdfSDWOD0MTIPFwiWv6P
 BZeLxlePa0HlkBm6q7DaONRJmWSoVO5xgdBuowa5pYcDTPuQOF3nFXJwt8m+tJehijM/
 PxB9y9tysMkbz3y3IdJ8WWI8fuOaRHsnG/zWMg9ALNV2WDP9q/vIqMEhBrEw3lipKklJ kQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30s1gn1n5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NLcZP139984;
        Mon, 4 May 2020 23:22:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 30t1r3j11h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:53 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 044NMqa3003613;
        Mon, 4 May 2020 23:22:52 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:50 -0700
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
Subject: [GRUB PATCH RFC 11/18] efi: Add a function to read EFI variables with attributes
Date:   Tue,  5 May 2020 01:21:25 +0200
Message-Id: <20200504232132.23570-12-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=2
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
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

It will be used to properly detect and report UEFI Secure Boot status to
the x86 Linux kernel. The functionality will be added by subsequent patches.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/kern/efi/efi.c | 16 +++++++++++++---
 include/grub/efi/efi.h   |  5 +++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/grub-core/kern/efi/efi.c b/grub-core/kern/efi/efi.c
index 81bc49f84..7eeac6019 100644
--- a/grub-core/kern/efi/efi.c
+++ b/grub-core/kern/efi/efi.c
@@ -223,8 +223,11 @@ grub_efi_set_variable(const char *var, const grub_efi_guid_t *guid,
 }
 
 grub_efi_status_t
-grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
-		       grub_size_t *datasize_out, void **data_out)
+grub_efi_get_variable_with_attributes (const char *var,
+				       const grub_efi_guid_t *guid,
+				       grub_size_t *datasize_out,
+				       void **data_out,
+				       grub_efi_uint32_t *attributes)
 {
   grub_efi_status_t status;
   grub_efi_uintn_t datasize = 0;
@@ -261,7 +264,7 @@ grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
       return GRUB_EFI_OUT_OF_RESOURCES;
     }
 
-  status = efi_call_5 (r->get_variable, var16, guid, NULL, &datasize, data);
+  status = efi_call_5 (r->get_variable, var16, guid, attributes, &datasize, data);
   grub_free (var16);
 
   if (status == GRUB_EFI_SUCCESS)
@@ -275,6 +278,13 @@ grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
   return status;
 }
 
+grub_efi_status_t
+grub_efi_get_variable (const char *var, const grub_efi_guid_t *guid,
+		       grub_size_t *datasize_out, void **data_out)
+{
+  return grub_efi_get_variable_with_attributes (var, guid, datasize_out, data_out, NULL);
+}
+
 #pragma GCC diagnostic ignored "-Wcast-align"
 
 /* Search the mods section from the PE32/PE32+ image. This code uses
diff --git a/include/grub/efi/efi.h b/include/grub/efi/efi.h
index 8b2a0f1f5..83d958f99 100644
--- a/include/grub/efi/efi.h
+++ b/include/grub/efi/efi.h
@@ -74,6 +74,11 @@ grub_err_t EXPORT_FUNC (grub_efi_set_virtual_address_map) (grub_efi_uintn_t memo
 							   grub_efi_uintn_t descriptor_size,
 							   grub_efi_uint32_t descriptor_version,
 							   grub_efi_memory_descriptor_t *virtual_map);
+grub_efi_status_t EXPORT_FUNC (grub_efi_get_variable_with_attributes) (const char *variable,
+								       const grub_efi_guid_t *guid,
+								       grub_size_t *datasize_out,
+								       void **data_out,
+								       grub_efi_uint32_t *attributes);
 grub_efi_status_t EXPORT_FUNC (grub_efi_get_variable) (const char *variable,
 						       const grub_efi_guid_t *guid,
 						       grub_size_t *datasize_out,
-- 
2.11.0

