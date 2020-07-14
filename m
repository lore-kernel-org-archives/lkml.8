Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC91BC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7E822513
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgGNOPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:15:14 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgGNOPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:15:11 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 910DE2CB5F75DC939DEF;
        Tue, 14 Jul 2020 22:15:09 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Jul 2020 22:15:01 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        "glider@google.com" <glider@google.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] bootconfig: Make symbol 'xbc_namebuf' static
Date:   Tue, 14 Jul 2020 22:25:04 +0800
Message-ID: <20200714142504.34803-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warning:

init/main.c:305:6: warning:
 symbol 'xbc_namebuf' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 init/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 9127b240fd26..6a24981c727f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -302,7 +302,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 #ifdef CONFIG_BOOT_CONFIG
 
-char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
+static char xbc_namebuf[XBC_KEYLEN_MAX] __initdata;
 
 #define rest(dst, end) ((end) > (dst) ? (end) - (dst) : 0)
 

