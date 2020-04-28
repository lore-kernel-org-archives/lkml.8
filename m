Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5492BC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3565C206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD1CpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:45:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgD1CpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:45:12 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S2UpXs071983;
        Mon, 27 Apr 2020 22:45:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30metvwydm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 22:45:04 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S2bMC1089232;
        Mon, 27 Apr 2020 22:45:03 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30metvwydf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 22:45:03 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S2f8FL024956;
        Tue, 28 Apr 2020 02:45:02 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 30mcu6pafq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 02:45:02 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S2j22m50725228
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 02:45:02 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E876AC05B;
        Tue, 28 Apr 2020 02:45:02 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10130AC059;
        Tue, 28 Apr 2020 02:44:52 +0000 (GMT)
Received: from LeoBras.aus.stglabs.ibm.com (unknown [9.85.174.1])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 02:44:51 +0000 (GMT)
From:   Leonardo Bras <leobras.c@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Chao Yu <chao@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Quentin Perret <qperret@qperret.net>,
        Jayachandran C <c.jayachandran@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Paul Burton <paulburton@kernel.org>
Cc:     Leonardo Bras <leobras.c@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mailmap: Add entry for Leonardo Bras
Date:   Mon, 27 Apr 2020 23:44:40 -0300
Message-Id: <20200428024439.215806-1-leobras.c@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_17:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=793
 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1034 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry to connect my email addresses.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index db3754a41018..4600dcfed0d3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -152,6 +152,7 @@ Krzysztof Kozlowski <krzk@kernel.org> <k.kozlowski.k@gmail.com>
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
+Leonardo Bras <leobras.c@gmail.com> <leonardo@linux.ibm.com>
 Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
-- 
2.25.4

