Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC96C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 463EE20706
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733146AbgFWRHr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:07:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7610 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728916AbgFWRHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:07:47 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NGoKxT012000
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:07:46 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31uk2ugyu7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:07:46 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 10:07:44 -0700
Received: by devvm1828.vll1.facebook.com (Postfix, from userid 172786)
        id 1C8A73D84E272; Tue, 23 Jun 2020 10:07:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
Smtp-Origin-Hostname: devvm1828.vll1.facebook.com
To:     <linux-kernel@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: vll1c12
Subject: [PATCH] linux/log2.h: enclose macro arg in parens
Date:   Tue, 23 Jun 2020 10:07:39 -0700
Message-ID: <20200623170739.3151706-1-jonathan.lemon@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=790
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0 suspectscore=1
 adultscore=0 clxscore=1034 phishscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230122
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Lemon <bsd@fb.com>

roundup_pow_of_two uses its arg without enclosing it in parens.

A call of the form:

   roundup_pow_of_two(boolval ? PAGE_SIZE : frag_size)

resulted in an compile warning:

warning: ?: using integer constants in boolean context [-Wint-in-bool-context]
              PAGE_SIZE :
../include/linux/log2.h:176:4: note: in definition of macro ‘roundup_pow_of_two’
   (n == 1) ? 1 :  \
    ^
And the resulting code used '1' as the result of the operation.

Fixes: 312a0c170945 ("[PATCH] LOG2: Alter roundup_pow_of_two() so that it can use a ilog2() on a constant")

Signed-off-by: Jonathan Lemon <jonathan.lemon@gmail.com>
---
 include/linux/log2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 83a4a3ca3e8a..c619ec6eff4a 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -173,7 +173,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define roundup_pow_of_two(n)			\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n == 1) ? 1 :			\
+		((n) == 1) ? 1 :		\
 		(1UL << (ilog2((n) - 1) + 1))	\
 				   ) :		\
 	__roundup_pow_of_two(n)			\
-- 
2.24.1

