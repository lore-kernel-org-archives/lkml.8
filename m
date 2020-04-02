Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C09C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3C92080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yo0Eyhag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387796AbgDBISn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:18:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39206 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387705AbgDBISl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:18:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328HfDr196549;
        Thu, 2 Apr 2020 08:18:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=MPDVtlakEiOSQRPk/nmtrNp/UKM5ykm3de68LlZszp8=;
 b=Yo0Eyhag2YJGU264sdIMgp2QzQunzTeQo/PuUNxArQrjlTPwWIoZijLiIIVHwjA1RUV5
 FHYrHVm9gmNOSuX8eH5pOkOeef688kC+UzIqZIiQp0QBYr8IsOQ8SKMQqcuwlwKtRjMu
 J1RtVdwFyAUkm4IpuMJvOyZ12cflmNGNO5RmXDXLc54MuorLXJwX5oLUvJelT2lmiADN
 +XrizNA9rMEBKRALczu+eWjly4upP9vpppAACknG6vkg5PwENSHflxYAu7KG38kaxOYY
 rU8Af4l/WXeXQOLZ2fRQBj31zQELVRjiqXPZGJ5o8yO0EYEtXr3FsFWfg00EW1RJ1gUH RA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yunce45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0328H8nR126379;
        Thu, 2 Apr 2020 08:18:12 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 304sjnsshn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Apr 2020 08:18:12 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0328IBL7003402;
        Thu, 2 Apr 2020 08:18:11 GMT
Received: from linux-1.home (/92.157.90.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Apr 2020 01:18:11 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        peterz@infradead.org, jthierry@redhat.com, tglx@linutronix.de,
        alexandre.chartre@oracle.com
Subject: [PATCH 1/7] objtool: is_fentry_call() crashes if call has no destination
Date:   Thu,  2 Apr 2020 10:22:14 +0200
Message-Id: <20200402082220.808-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200402082220.808-1-alexandre.chartre@oracle.com>
References: <20200402082220.808-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=1 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9578 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=1 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004020075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix is_fentry_call() so that it works if a call has no destination
set (call_dest). This needs to be done in order to support intra-
function calls.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 4768d91c6d68..708562fb89e1 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1363,7 +1363,7 @@ static int decode_sections(struct objtool_file *file)
 
 static bool is_fentry_call(struct instruction *insn)
 {
-	if (insn->type == INSN_CALL &&
+	if (insn->type == INSN_CALL && insn->call_dest &&
 	    insn->call_dest->type == STT_NOTYPE &&
 	    !strcmp(insn->call_dest->name, "__fentry__"))
 		return true;
-- 
2.18.2

