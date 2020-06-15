Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB312078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgFODxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:53:46 -0400
Received: from mail.loongson.cn ([114.242.206.163]:58610 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbgFODxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:53:46 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxj93E8OZeiUBDAA--.4278S2;
        Mon, 15 Jun 2020 11:53:41 +0800 (CST)
From:   Xingxing Su <suxingxing@loongson.cn>
To:     dhowells@redhat.com, dwmw2@infradead.org
Cc:     keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangtiezhu@loongson.cn, lixuefeng@loongson.cn
Subject: [PATCH] certs/blacklist_hashes.c: Use __initconst for const init definition 
Date:   Mon, 15 Jun 2020 11:53:40 +0800
Message-Id: <1592193220-7460-1-git-send-email-suxingxing@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxj93E8OZeiUBDAA--.4278S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyUZw1kGr1rGF43uF13XFb_yoW3WwbEq3
        y3tr4UCrW8ArWjyr4aqFy8Jr95K34xZrnrGFn7KF13Ka4YkF13WFyv9w4ftFykWa13WF95
        tFZ0gw4rCr45XjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbT8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
        xwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr4l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRiKs1UUUUU
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAIC13QvLy3rgABsX
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: Use of const init definition must use __initconst
#4: FILE: certs/blacklist_hashes.c:4:
+const char __initdata *const blacklist_hashes[] = {

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
---
 certs/blacklist_hashes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
index 3448923..d5961aa 100644
--- a/certs/blacklist_hashes.c
+++ b/certs/blacklist_hashes.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "blacklist.h"
 
-const char __initdata *const blacklist_hashes[] = {
+const char __initconst *const blacklist_hashes[] = {
 #include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 	, NULL
 };
-- 
2.1.0

