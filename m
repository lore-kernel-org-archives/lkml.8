Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8DFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2422020675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMMpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:45:42 -0400
Received: from mail.loongson.cn ([114.242.206.163]:39488 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726224AbgHMMpf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:45:35 -0400
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxOMTqNTVftXcIAA--.216S2;
        Thu, 13 Aug 2020 20:45:31 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Eric Biederman <ebiederm@xmission.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kexec: Delete an unnecessary comparison
Date:   Thu, 13 Aug 2020 20:45:30 +0800
Message-Id: <1597322730-3881-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9DxOMTqNTVftXcIAA--.216S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jw1UJryfXF4kJrWDWF4kJFb_yoWxZFX_Ka
        48Z3Wqyr1jv3WDCF47Jw4ayryjgw1q9FWrWwn7W3y8Jr98twnFvrZ3Cr13CrnxW3ykZas5
        Ar93JwnaqrWxujkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2xYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r4j6F4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE14v_Xr1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNBMDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of whether the ret value is zero or non-zero, the trajectory
of the program execution is the same, so there is no need to compare.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 kernel/kexec_file.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 78c0837..3ad0ae2 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -800,8 +800,6 @@ static int kexec_calculate_store_digests(struct kimage *image)
 
 		ret = kexec_purgatory_get_set_symbol(image, "purgatory_sha256_digest",
 						     digest, SHA256_DIGEST_SIZE, 0);
-		if (ret)
-			goto out_free_digest;
 	}
 
 out_free_digest:
-- 
2.1.0

