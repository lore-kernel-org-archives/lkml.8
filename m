Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C279C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48EFB2067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="GfQSDiq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbgIGSzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:55:20 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:59492 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729380AbgIGSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:06 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IoIdG010963;
        Mon, 7 Sep 2020 18:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=ro4ZAqeOnHR3lzQkikBbBEUFxDztTDjIlN4qdvN2XtI=;
 b=GfQSDiq5E35Pi6hw4pIwEtuG8Bbzv3HRPyA6B94dkhbKhlDhbk3hALcfGLD/oOiZjLCt
 ZjcapUTzM9w4dLwU69n/1gLobkLI9t8aBIfK9L9nUMRHF02xN1aUmu3GY9CIAkhFSSkl
 HQR8nqQl9svoyMXE3GIJhExQLJWy+58ibnLP9MsBE+8TCYvIrI+BPWdweL/LlDLJnqtZ
 iw69s13VNab/0rfQZvowvh2eK0fWwpCBwonmrNGjU59sCBSRua3BIz0+HKRCYaXReBNn
 LFn68sjAG1kuf478eQP3vuL7U02r0z8ifghIOZDBIJq9tvs01qEreBAD2SP8o7RFnVH+ oQ== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cm1x4r5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:33 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id D5D8DB5;
        Mon,  7 Sep 2020 18:54:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 3CF1C30060F10; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185431.162991006@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:38 -0500
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
Subject: [PATCH 08/12] x86/platform/uv: Adjust GAM MMR references affected by UV5 updates
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=792
 bulkscore=0 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make modifications to the GAM MMR mappings to accommodate changes for UV5.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -932,12 +932,32 @@ static __init void map_gru_high(int max_
 
 static __init void map_mmr_high(int max_pnode)
 {
-	union uvh_rh_gam_mmr_overlay_config_u mmr;
-	int shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	unsigned long base;
+	int shift;
+	bool enable;
 
-	mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
-	if (mmr.s.enable)
-		map_high("MMR", mmr.s.base, shift, shift, max_pnode, map_uc);
+	if (UVH_RH10_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh10_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH10_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH10_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else if (UVH_RH_GAM_MMR_OVERLAY_CONFIG) {
+		union uvh_rh_gam_mmr_overlay_config_u mmr;
+
+		mmr.v = uv_read_local_mmr(UVH_RH_GAM_MMR_OVERLAY_CONFIG);
+		enable = mmr.s.enable;
+		base = mmr.s.base;
+		shift = UVH_RH_GAM_MMR_OVERLAY_CONFIG_BASE_SHFT;
+	} else {
+		pr_err("UV:%s:RH_GAM_MMR_OVERLAY_CONFIG MMR undefined?\n",
+			__func__);
+		return;
+	}
+
+	if (enable)
+		map_high("MMR", base, shift, shift, max_pnode, map_uc);
 	else
 		pr_info("UV: MMR disabled\n");
 }

