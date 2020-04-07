Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9238C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADCB2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LP5abjiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbgDGH15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:27:57 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45196 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgDGH14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:27:56 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377RaUi026351;
        Tue, 7 Apr 2020 07:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=7tsZqCnPSqTL0O2P1Rr9JutvRVK1YzYVaBpfBhyLAHQ=;
 b=LP5abjiWwG12+awu64RXbfz9bnuLyqYlC4oL/5Qy1WYeg9Q76qmdFS+BJC/MmCJxAYXJ
 TLg7pV6/g+B8QuEXxGoAh3G1YsXN4geK3Vj4aQgOb1WVD4duYi37jGIrfNJ+ggleiRe7
 xLSpEDJPVoJvMoHHCa/0UeGtyVqObo7f+956r0+IH4zHoeiU/ZTpJS2QUFo46JhDP7qC
 duVWO5uA9dwmvuTp0usnC2Gz+oi0VLZDRvX2CEyWuVyQvQhOnwd0JhD1tJo19qgElPLw
 yBVvmZahGUV1deNT1tUkmO6wTYPnlfDmLVnSNq77+xxkauKxc3uh9kgWGmecnjC2hvwZ SQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 306j6mb2m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0377MSJO194109;
        Tue, 7 Apr 2020 07:27:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30839sfr7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 07:27:32 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0377RVuY008151;
        Tue, 7 Apr 2020 07:27:31 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 00:27:30 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH V2 2/9] objtool: UNWIND_HINT_RET_OFFSET should not check registers
Date:   Tue,  7 Apr 2020 09:31:35 +0200
Message-Id: <20200407073142.20659-3-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200407073142.20659-1-alexandre.chartre@oracle.com>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNWIND_HINT_RET_OFFSET will adjust a modified stack. However if a
callee-saved register was pushed on the stack then the stack frame
will still appear modified. So stop checking registers when
UNWIND_HINT_RET_OFFSET is used.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index bbee26de92ec..c7fcaddfaa8a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1390,6 +1390,14 @@ static bool has_modified_stack_frame(struct instruction *insn,
 	if (state->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
+	/*
+	 * If there is a ret offset hint then don't check registers
+	 * because a callee-saved register might have been pushed on
+	 * the stack.
+	 */
+	if (ret_offset)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (state->regs[i].base != initial_func_cfi.regs[i].base ||
 		    state->regs[i].offset != initial_func_cfi.regs[i].offset)
-- 
2.18.2

