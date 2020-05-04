Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D948CC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1E392064C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tuvApiS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgEDXYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:24:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35210 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgEDXYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:24:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NO0US112424;
        Mon, 4 May 2020 23:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=MPPembOSo4p+hvWq1J3XvzTbI5YMTahIjxQRGg+UixU=;
 b=tuvApiS6mKrc3cnTYkQuO2btm/Qog7jO46F1uRPHv065C0179Ay3Hk3lakU9QNx4RT4X
 E4VrN5zUxkr0vCTgzR1c40SgsRSPuERZNiBcgDN5jY2P0SicDrVrfq1jhv0j8Lg+tTGB
 eGL1R+iqkDKtSWygLqesrQBMNb69gsLukkzj0b6yBr+rIQR3Vu2dP9kNPCfDIcjpP6ow
 GaBhay8fcKyLkSeubY+w6fnaPBGsOjb1gRsUu0jdhcHaqSfU5JbKpjiMo1NN7crArA4U
 +q9kAIATvd4e79Ted2Wo16w2GV3apR+jk0gPtoj+Rt9X2Y08e0svY1DcFuMWplUyg6m+ Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30s1gn1n8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:24:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044NIU6T013575;
        Mon, 4 May 2020 23:22:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30sjjx5h73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 23:22:08 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044NM7iD010245;
        Mon, 4 May 2020 23:22:07 GMT
Received: from tomti.i.net-space.pl (/10.175.189.148)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 16:22:06 -0700
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
Subject: [GRUB PATCH RFC 02/18] i386/msr: Rename grub_msr_read() and grub_msr_write()
Date:   Tue,  5 May 2020 01:21:16 +0200
Message-Id: <20200504232132.23570-3-daniel.kiper@oracle.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200504232132.23570-1-daniel.kiper@oracle.com>
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9611 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040181
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

.. to grub_rdmsr() and grub_wrmsr() respectively. New names are more
obvious than older ones.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 grub-core/commands/i386/rdmsr.c | 2 +-
 grub-core/commands/i386/wrmsr.c | 2 +-
 include/grub/i386/msr.h         | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/grub-core/commands/i386/rdmsr.c b/grub-core/commands/i386/rdmsr.c
index fa4622f9e..89ece7657 100644
--- a/grub-core/commands/i386/rdmsr.c
+++ b/grub-core/commands/i386/rdmsr.c
@@ -76,7 +76,7 @@ grub_cmd_msr_read (grub_extcmd_context_t ctxt, int argc, char **argv)
   if (*ptr != '\0')
     return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("invalid argument"));
 
-  value = grub_msr_read (addr);
+  value = grub_rdmsr (addr);
 
   if (ctxt->state[0].set)
     {
diff --git a/grub-core/commands/i386/wrmsr.c b/grub-core/commands/i386/wrmsr.c
index 9b7abba7c..e3e9f2ee3 100644
--- a/grub-core/commands/i386/wrmsr.c
+++ b/grub-core/commands/i386/wrmsr.c
@@ -76,7 +76,7 @@ grub_cmd_msr_write (grub_command_t cmd __attribute__ ((unused)), int argc, char
   if (*ptr != '\0')
     return grub_error (GRUB_ERR_BAD_ARGUMENT, N_("invalid argument"));
 
-  grub_msr_write (addr, value);
+  grub_wrmsr (addr, value);
 
   return GRUB_ERR_NONE;
 }
diff --git a/include/grub/i386/msr.h b/include/grub/i386/msr.h
index 7b52b5d61..4fba1b8e0 100644
--- a/include/grub/i386/msr.h
+++ b/include/grub/i386/msr.h
@@ -25,7 +25,7 @@
  */
 
 static inline grub_uint64_t
-grub_msr_read (grub_uint32_t msr_id)
+grub_rdmsr (grub_uint32_t msr_id)
 {
   grub_uint32_t low, high;
 
@@ -35,7 +35,7 @@ grub_msr_read (grub_uint32_t msr_id)
 }
 
 static inline void
-grub_msr_write(grub_uint32_t msr_id, grub_uint64_t msr_value)
+grub_wrmsr (grub_uint32_t msr_id, grub_uint64_t msr_value)
 {
   grub_uint32_t low = msr_value, high = msr_value >> 32;
 
-- 
2.11.0

