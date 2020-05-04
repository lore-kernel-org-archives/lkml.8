Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413D4C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B902064C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hw1XT5ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgEDXYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:24:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35376 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:24:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NNr3v105288;
        Mon, 4 May 2020 23:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gzMDHVzQaTOBKqJdHyBiGVZaL4Je1usWIbsSqvU86kU=;
 b=hw1XT5raQN/v3nwWzg6SqUCuMTeK6ZEr7V0mrPrFY0dbAqTJnv6ShB/vY9o1osNBKAew
 2yvBf13bpNMv/Lz+F3Pts/pE5JKDGOvDSxHXWaYBbgTn3lzlTAIe6c0QT60M7Ju2fv+Y
 95a/v593Cqaw5ZEGVlP6dlyV4QIjZfNxsG8+k0JxY3WJUxYcylg4uiSvVR/pltgryC5e
 0uIKbJxegraccJ6qasqc7wo86xfF9Rdq3aSqrbSAsb4jjb3l3hc3xiDb+B/3FvGC6PoH
 4WDHgeV246IWuqhOgaCfF3POkzBUZ/wcCvaEtP7bUASYfE80gN77CLrO9CONevFac5U4 tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gn1n9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:24:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NMTxn021505;
        Mon, 4 May 2020 23:22:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 30sjjx5hje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:32 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NMViW004218;
        Mon, 4 May 2020 23:22:31 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:31 -0700
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
Subject: [GRUB PATCH RFC 07/18] i386/tpm: Rename tpm module to tpm_verifier
Date:   Tue,  5 May 2020 01:21:21 +0200
Message-Id: <20200504232132.23570-8-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 phishscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..to avoid naming collision with TPM TIS and CRB driver introduced
by subsequent patch.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 docs/grub.texi                               | 15 ++++++++-------
 grub-core/Makefile.core.def                  |  4 ++--
 grub-core/commands/{tpm.c => tpm_verifier.c} |  6 +++---
 3 files changed, 13 insertions(+), 12 deletions(-)
 rename grub-core/commands/{tpm.c => tpm_verifier.c} (96%)

diff --git a/docs/grub.texi b/docs/grub.texi
index d6408d242..395431bce 100644
--- a/docs/grub.texi
+++ b/docs/grub.texi
@@ -5940,10 +5940,10 @@ it cannot be unloaded if it was loaded into the memory.
 @node Measured Boot
 @section Measuring boot components
 
-If the tpm module is loaded and the platform has a Trusted Platform Module
-installed, GRUB will log each command executed and each file loaded into the
-TPM event log and extend the PCR values in the TPM correspondingly. All events
-will be logged into the PCR described below with a type of EV_IPL and an
+If the tpm_verifier module is loaded and the platform has a Trusted Platform
+Module installed, GRUB will log each command executed and each file loaded into
+the TPM event log and extend the PCR values in the TPM correspondingly. All
+events will be logged into the PCR described below with a type of EV_IPL and an
 event description as described below.
 
 @multitable @columnfractions 0.3 0.1 0.6
@@ -5968,9 +5968,10 @@ corresponding to the filename.
 
 GRUB will not measure its own @file{core.img} - it is expected that firmware
 will carry this out. GRUB will also not perform any measurements until the
-tpm module is loaded. As such it is recommended that the tpm module be built
-into @file{core.img} in order to avoid a potential gap in measurement between
-@file{core.img} being loaded and the tpm module being loaded.
+tpm_verifier module is loaded. As such it is recommended that the tpm_verifier
+module be built into @file{core.img} in order to avoid a potential gap in
+measurement between @file{core.img} being loaded and the tpm_verifier module
+being loaded.
 
 Measured boot is currently only supported on EFI platforms.
 
diff --git a/grub-core/Makefile.core.def b/grub-core/Makefile.core.def
index 48b82e763..b74a34f0c 100644
--- a/grub-core/Makefile.core.def
+++ b/grub-core/Makefile.core.def
@@ -2497,8 +2497,8 @@ module = {
 };
 
 module = {
-  name = tpm;
-  common = commands/tpm.c;
+  name = tpm_verifier;
+  common = commands/tpm_verifier.c;
   efi = commands/efi/tpm.c;
   enable = x86_64_efi;
 };
diff --git a/grub-core/commands/tpm.c b/grub-core/commands/tpm_verifier.c
similarity index 96%
rename from grub-core/commands/tpm.c
rename to grub-core/commands/tpm_verifier.c
index 1441c494d..6fff17720 100644
--- a/grub-core/commands/tpm.c
+++ b/grub-core/commands/tpm_verifier.c
@@ -85,18 +85,18 @@ grub_tpm_verify_string (char *str, enum grub_verify_string_type type)
 }
 
 struct grub_file_verifier grub_tpm_verifier = {
-  .name = "tpm",
+  .name = "tpm_verifier",
   .init = grub_tpm_verify_init,
   .write = grub_tpm_verify_write,
   .verify_string = grub_tpm_verify_string,
 };
 
-GRUB_MOD_INIT (tpm)
+GRUB_MOD_INIT (tpm_verifier)
 {
   grub_verifier_register (&grub_tpm_verifier);
 }
 
-GRUB_MOD_FINI (tpm)
+GRUB_MOD_FINI (tpm_verifier)
 {
   grub_verifier_unregister (&grub_tpm_verifier);
 }
-- 
2.11.0

