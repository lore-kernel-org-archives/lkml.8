Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5196C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49422067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="dJ8ETu0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIGSzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:55:31 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:45272 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729396AbgIGSzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:55:06 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 087IpMOA024433;
        Mon, 7 Sep 2020 18:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=message-id : date : from
 : to : cc : subject : references : mime-version : content-type; s=pps0720;
 bh=H+cdkTz6AIUSAUqLFeeWxJgkuKFgtRS7QFH3d08OKZQ=;
 b=dJ8ETu0Fi3ofa2r/D6y+LlXcJX9Axxu8g0s0rbD/uFOLT0y/Wb+rE4rtcfXQncAwsKmW
 xRNAafIDzpSTvfw9I0AeEVHDkqtPuj6B+nW3U0TXSRBA1eyT5WjiHEgtyvxHMlbMxQ78
 AmLHMZ5yt7bZ6Vzt7lpZ6j4sqWW2HTADr8eysNt5KeaJx3XI0Z7cXR0XtkMNvoJfY+Js
 wqo9zkMQoSuGykomEtOT7mi6Zx79Vflydick2WUsmrtcbFSM+Uo7osOlFYyHtGflsqNY
 EEOi2hIGU2VTxELNMnITJDoOSz4QWBFiIhOn4pANXbL8fGNXk5iWRpEZ8UoQJTsAjGdW /Q== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 33cmd54fdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Sep 2020 18:54:35 +0000
Received: from dog.eag.rdlabs.hpecorp.net (dog.eag.rdlabs.hpecorp.net [128.162.243.181])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id F309058;
        Mon,  7 Sep 2020 18:54:32 +0000 (UTC)
Received: by dog.eag.rdlabs.hpecorp.net (Postfix, from userid 5508)
        id 6B27130060F12; Mon,  7 Sep 2020 13:54:31 -0500 (CDT)
Message-ID: <20200907185431.351814173@hpe.com>
User-Agent: quilt/0.66
Date:   Mon, 07 Sep 2020 13:54:40 -0500
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
Subject: [PATCH 10/12] x86/platform/uv: Update Node Present Counting
References: <20200907185430.363197758@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-07_11:2020-09-07,2020-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009070181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes in the UV5 arch shrunk the NODE PRESENT table to just 2x64
entries (128 total) so are in to 64 bit MMRs instead of a depth of 64
bits in an array.  Adjust references when counting up the nodes present.

Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
---
 arch/x86/kernel/apic/x2apic_uv_x.c |   26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

--- linux.orig/arch/x86/kernel/apic/x2apic_uv_x.c
+++ linux/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -1437,20 +1437,32 @@ static int __init decode_uv_systab(void)
 /* Set up physical blade translations from UVH_NODE_PRESENT_TABLE */
 static __init void boot_init_possible_blades(struct uv_hub_info_s *hub_info)
 {
+	unsigned long np;
 	int i, uv_pb = 0;
 
-	pr_info("UV: NODE_PRESENT_DEPTH = %d\n", UVH_NODE_PRESENT_TABLE_DEPTH);
-	for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
-		unsigned long np;
-
-		np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
-		if (np)
+	if (UVH_NODE_PRESENT_TABLE) {
+		pr_info("UV: NODE_PRESENT_DEPTH = %d\n",
+			UVH_NODE_PRESENT_TABLE_DEPTH);
+		for (i = 0; i < UVH_NODE_PRESENT_TABLE_DEPTH; i++) {
+			np = uv_read_local_mmr(UVH_NODE_PRESENT_TABLE + i * 8);
 			pr_info("UV: NODE_PRESENT(%d) = 0x%016lx\n", i, np);
-
+			uv_pb += hweight64(np);
+		}
+	}
+	if (UVH_NODE_PRESENT_0) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_0);
+		pr_info("UV: NODE_PRESENT_0 = 0x%016lx\n", np);
+		uv_pb += hweight64(np);
+	}
+	if (UVH_NODE_PRESENT_1) {
+		np = uv_read_local_mmr(UVH_NODE_PRESENT_1);
+		pr_info("UV: NODE_PRESENT_1 = 0x%016lx\n", np);
 		uv_pb += hweight64(np);
 	}
 	if (uv_possible_blades != uv_pb)
 		uv_possible_blades = uv_pb;
+
+	pr_info("UV: number nodes/possible blades %d\n", uv_pb);
 }
 
 static void __init build_socket_tables(void)

