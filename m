Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26927C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C2F82074D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 07:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgEPHWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 03:22:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44510 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725807AbgEPHWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 03:22:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A2557B10F7855F44BA83;
        Sat, 16 May 2020 15:22:49 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 May 2020
 15:22:42 +0800
Subject: [PATCH 2/2] lib: 842 - Remove useless checking in check_template()
From:   Yunfeng Ye <yeyunfeng@huawei.com>
To:     <haren@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
References: <e46137c5-6bdd-59bd-1a20-59752f2bb8c2@huawei.com>
Message-ID: <74705394-8f7c-9635-12c0-10fed1fe8f8f@huawei.com>
Date:   Sat, 16 May 2020 15:22:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e46137c5-6bdd-59bd-1a20-59752f2bb8c2@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning was found by smatch tool:
  "check_template() error: testing array offset 'c' after use."

Fix it by removing the useless checking in check_template().

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 lib/842/842_compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index 18255d25781b..8d25345b4b49 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -379,9 +379,6 @@ static bool check_template(struct sw842_param *p, u8 c)
 	u8 *t = comp_ops[c];
 	int i, match, b = 0;

-	if (c >= OPS_MAX)
-		return false;
-
 	for (i = 0; i < 4; i++) {
 		if (t[i] & OP_ACTION_INDEX) {
 			if (t[i] & OP_AMOUNT_2)
-- 
1.8.3.1

