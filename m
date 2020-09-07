Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76A1C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2C02067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LElVZFxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIGS40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:56:26 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:39010 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729923AbgIGS4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:56:10 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IriMh016001;
        Mon, 7 Sep 2020 18:54:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=7k8IOMYoc1gVXN/TSihaTk/xr+vpjX1M0UAUzXmxFys=;
 b=LElVZFxDlhc9UPV8f7/9doJzeSoTI6VTDBXlmBUEMzV6X0gJItLI4NOMBJBO064C53zz
 hoNlGFdnE3kBPXfCJXkfIIa3vz6+NM98vILNdpyyrkN7A9itYr/tHSNfZ5naB2c9cYWG
 WsxT00eTKDaxvvMQL4q9oi2zKtomc8+BAMbLgi0tAFZs1a9IeHqwS8fxdnoJCZCm5IAD
 TYqCEighSqsWYkRcni5TVNybH9MDcDMYoUVXvvf9zffAfLOg/5BRdS02iB1uBK6i1e6u
 GDqIOr8Mr29j1oNGJ4ERkyoe87jIWJQxygfE7OlPLztyS4Z+TgeIY8IRQyscCTQM6aIJ Xg== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0a-002e3701.pphosted.com with ESMTP id 33cmj44mxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:34 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F2FD055;
        Mon,  7 Sep 2020 18:54:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 53DBE30060F11; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185431.257694099@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:39 -0500
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
Subject: [PATCH 09/12] x86/platform/uv: Update UV5 MMR references in UV GRU
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make modifications to the GRU mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -83,6 +83,9 @@ static unsigned long __init uv_early_rea
 
 static inline bool is_GRU_range(u64 start, u64 end)
 {
+	if (!gru_start_paddr)
+		return false;
+
 	return start >= gru_start_paddr && end <= gru_end_paddr;
 }
 
@@ -914,13 +917,24 @@ static __init void map_high(char *id, un
 static __init void map_gru_high(int max_pnode)
 {
 	union uvh_rh_gam_gru_overlay_config_u gru;
-	int shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
-	unsigned long mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
-	unsigned long base;
+	unsigned long mask, base;
+	int shift;
+
+	if (UVH_RH_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else if (UVH_RH10_GAM_GRU_OVERLAY_CONFIG) {
+		gru.v = uv_read_local_mmr(UVH_RH10_GAM_GRU_OVERLAY_CONFIG);
+		shift = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_SHFT;
+		mask = UVH_RH10_GAM_GRU_OVERLAY_CONFIG_BASE_MASK;
+	} else {
+		pr_err("UV: GRU unavailable (no MMR)\n");
+		return;
+	}
 
-	gru.v = uv_read_local_mmr(UVH_RH_GAM_GRU_OVERLAY_CONFIG);
 	if (!gru.s.enable) {
-		pr_info("UV: GRU disabled\n");
+		pr_info("UV: GRU disabled (by BIOS)\n");
 		return;
 	}
 
@@ -1289,7 +1303,11 @@ static void __init uv_init_hub_info(stru
 	/* Show system specific info: */
 	pr_info("UV: N:%d M:%d m_shift:%d n_lshift:%d\n", hi->n_val, hi->m_val, hi->m_shift, hi->n_lshift);
 	pr_info("UV: gpa_mask/shift:0x%lx/%d pnode_mask:0x%x apic_pns:%d\n", hi->gpa_mask, hi->gpa_shift, hi->pnode_mask, hi->apic_pnode_shift);
-	pr_info("UV: mmr_base/shift:0x%lx/%ld gru_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift, hi->global_gru_base, hi->global_gru_shift);
+	pr_info("UV: mmr_base/shift:0x%lx/%ld\n", hi->global_mmr_base, hi->global_mmr_shift);
+	if (hi->global_gru_base)
+		pr_info("UV: gru_base/shift:0x%lx/%ld\n",
+			hi->global_gru_base, hi->global_gru_shift);
+
 	pr_info("UV: gnode_upper:0x%lx gnode_extra:0x%x\n", hi->gnode_upper, hi->gnode_extra);
 }
 

