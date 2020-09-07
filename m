Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CEEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0BB2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Oy4DFTrq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgIGSzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:55:24 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:47792 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729446AbgIGSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:06 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087ImqFG026414;
        Mon, 7 Sep 2020 18:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=44ezGx9xoJR9KmSJvezKkdXC7SRoSyd4qvEbeCtaU88=;
 b=Oy4DFTrqRq28Vygs15CPlbZUVIlygGvNXSNyILAUI/Bj8wmmhjSDwUmLf0mWL0Tp9N26
 X59iEVQUlsQVSY+HzufK1FMOmVUS1upqqrzeUyvdlhbI1wFya8+pUYoUy2+zpevnWPkU
 MZvF902Ltn+Id45oUUt2/fl+YaF0auoDwdYL86NAEsyJEQ72cqoHVe77lyWcsFzLMoWs
 9DMA4W8wqEmiLl/pMVL6oJjrOVp7pszJ138r8KHrzIZF5A34PTDly2u2O+Rr7l4EjX6J
 E7qz83WhkhINkd2OcxU5cBrHzyJcvGryvmrpuYI3efHJMySstSrWAKILcQwQdXkO/ZWE 8Q== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 33cmremq9d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:34 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 1AC4DB4;
        Mon,  7 Sep 2020 18:54:33 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 8199D30060F13; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185431.445769235@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:41 -0500
From:   Mike Travis <mike.travis@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@suse.de>
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 11/12] x86/platform/uv: Update UV5 TSC Checking
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update check of BIOS TSC sync status to include both possible "invalid"
states provided by newer UV5 BIOS.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/include/asm/uv/uv_hub.h   |    2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c |   24 ++++++++++--------------
 2 files changed, 11 insertions(+), 15 deletions(-)

--- linux.orig/arch/x86/include/asm/uv/uv_hub.h
+++ linux/arch/x86/include/asm/uv/uv_hub.h
@@ -727,7 +727,7 @@ extern void uv_nmi_setup_hubless(void);
 #define UVH_TSC_SYNC_SHIFT_UV2K	16	/* UV2/3k have different bits */
 #define UVH_TSC_SYNC_MASK	3	/* 0011 */
 #define UVH_TSC_SYNC_VALID	3	/* 0011 */
-#define UVH_TSC_SYNC_INVALID	2	/* 0010 */
+#define UVH_TSC_SYNC_UNKNOWN	0	/* 0000 */
 
 /* BMC sets a bit this MMR non-zero before sending an NMI */
 #define UVH_NMI_MMR		UVH_BIOS_KERNEL_MMR
--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -200,36 +200,32 @@ static void __init uv_tsc_check_sync(voi
 	int sync_state;
 	int mmr_shift;
 	char *state;
-	bool valid;
 
-	/* Accommodate different UV arch BIOSes */
+	/* Different returns from different UV BIOS versions */
 	mmr = uv_early_read_mmr(UVH_TSC_SYNC_MMR);
 	mmr_shift =
 		is_uv2_hub() ? UVH_TSC_SYNC_SHIFT_UV2K : UVH_TSC_SYNC_SHIFT;
 	sync_state = (mmr >> mmr_shift) & UVH_TSC_SYNC_MASK;
 
+	/* Check if TSC is valid for all sockets */
 	switch (sync_state) {
 	case UVH_TSC_SYNC_VALID:
 		state = "in sync";
-		valid = true;
+		mark_tsc_async_resets("UV BIOS");
 		break;
 
-	case UVH_TSC_SYNC_INVALID:
-		state = "unstable";
-		valid = false;
+	/* If BIOS state unknown, don't do anything */
+	case UVH_TSC_SYNC_UNKNOWN:
+		state = "unknown";
 		break;
+
+	/* Otherwise, BIOS indicates problem with TSC */
 	default:
-		state = "unknown: assuming valid";
-		valid = true;
+		state = "unstable";
+		mark_tsc_unstable("UV BIOS");
 		break;
 	}
 	pr_info("UV: TSC sync state from BIOS:0%d(%s)\n", sync_state, state);
-
-	/* Mark flag that says TSC != 0 is valid for socket 0 */
-	if (valid)
-		mark_tsc_async_resets("UV BIOS");
-	else
-		mark_tsc_unstable("UV BIOS");
 }
 
 /* Selector for (4|4A|5) structs */

