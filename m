Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C85C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2920838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xJ3P1GrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgCaL2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:28:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58098 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730418AbgCaL2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:28:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VBRSSD082719;
        Tue, 31 Mar 2020 11:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=CmjhbKGL3UgHlnlsAZ5WOFChMBQYcpnp75M2BI5GcX0=;
 b=xJ3P1GrTv8jFUMMToH5kBgrA5nkBvl7gC3ssjYnvTy4//itw0jIiJZr5CtFReloA88Hz
 Mxz0OVX1FsJI7XDeKumemYENOay5UU4iNP28KD0O8/cWBORfUBR6ZHNTdjS+DAjFnQSK
 FoXj4lkqFNh7pLn0s4tbBnQao9+cNF0QG4fWkAIU9TdtQmHfF51QgBTLnK5urXbmMqf/
 hfxc96UZTnBsUbqZKvD38iCdwWZBMGd/Z4dKpUVIE5QI9jmH/kkRKbIoZFi48QRuQeBD
 LtcfGVgwSawBmqIyVeJGnM6DLrp5jvD3gorwQE1PZfEJ7nVg05BW8EoaxZpJAG7mTU/j Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 303ceuxytk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 11:28:40 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VBMJVw034538;
        Tue, 31 Mar 2020 11:28:40 GMT
Received: from t460.home (dhcp-10-175-15-184.vpn.oracle.com [10.175.15.184])
        by aserp3030.oracle.com with ESMTP id 302g4re0sx-1;
        Tue, 31 Mar 2020 11:28:39 +0000
From:   Vegard Nossum <vegard.nossum@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
Date:   Tue, 31 Mar 2020 13:26:37 +0200
Message-Id: <20200331112637.25047-1-vegard.nossum@oracle.com>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compiletime_assert() uses __LINE__ to create a unique function name.
This means that if you have more than one BUILD_BUG_ON() in the same
source line (which can happen if they appear e.g. in a macro), then
the error message from the compiler might output the wrong condition.

For this source file:

	#include <linux/build_bug.h>

	#define macro() \
		BUILD_BUG_ON(1); \
		BUILD_BUG_ON(0);

	void foo()
	{
		macro();
	}

gcc would output:

./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_9’ declared with attribute error: BUILD_BUG_ON failed: 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)

However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
each BUILD_BUG_ON() gets a different function name and the correct
condition is printed:

./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_0’ declared with attribute error: BUILD_BUG_ON failed: 1
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Cc: Daniel Santos <daniel.santos@pobox.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ian Abbott <abbotti@mev.co.uk>
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 5e88e7e33abec..034b0a644efcc 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
  * compiler has support to do so.
  */
 #define compiletime_assert(condition, msg) \
-	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
 
 #define compiletime_assert_atomic_type(t)				\
 	compiletime_assert(__native_word(t),				\
-- 
2.16.1.72.g5be1f00a9.dirty

