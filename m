Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D570CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B278B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgHXWPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:15:01 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:28880 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgHXWPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:15:00 -0400
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07OMBwlX003004;
        Mon, 24 Aug 2020 22:14:43 GMT
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 333d3543rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Aug 2020 22:14:43 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id DEFA04F;
        Mon, 24 Aug 2020 22:14:41 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.32.129])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 7823A46;
        Mon, 24 Aug 2020 22:14:40 +0000 (UTC)
Date:   Mon, 24 Aug 2020 17:14:39 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] MAINTAINERS: Add entry for HPE Superdome Flex (UV)
 maintainers
Message-ID: <20200824221439.GA52810@swahl-home.5wahls.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry and email addresses for people at HPE who are supporting
linux on the Superdome Flex (a.k.a) UV platform.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..4c2143d8ae45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18874,6 +18874,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
 F:	arch/x86/platform
 
+X86 PLATFORM UV HPE SUPERDOME FLEX
+M:	Steve Wahl <steve.wahl@hpe.com>
+R:	Dimitri Sivanich <dimitri.sivanich@hpe.com>
+R:	Russ Anderson <russ.anderson@hpe.com>
+S:	Supported
+F:	arch/x86/include/asm/uv/
+F:	arch/x86/kernel/apic/x2apic_uv_x.c
+F:	arch/x86/platform/uv/
+
 X86 VDSO
 M:	Andy Lutomirski <luto@kernel.org>
 L:	linux-kernel@vger.kernel.org
-- 
2.12.3

