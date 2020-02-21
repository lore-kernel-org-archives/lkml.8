Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21011C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBD220722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgBUKTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:19:36 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:48384 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726989AbgBUKTg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:19:36 -0500
X-Greylist: delayed 485 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 05:19:35 EST
Received: from ubuntu.localdomain (unknown [117.136.87.108])
        by APP-05 (Coremail) with SMTP id zQCowAB3f9PArE9emU7DBA--.49465S2;
        Fri, 21 Feb 2020 18:11:14 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] Intel: Skylake: Fix inconsistent IS_ERR and PTR_ERR
Date:   Fri, 21 Feb 2020 18:11:12 +0800
Message-Id: <20200221101112.3104-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAB3f9PArE9emU7DBA--.49465S2
X-Coremail-Antispam: 1UD129KBjvdXoWrury3Gw13XFWxtw4UCrykXwb_yoW3uFbEgw
        4rG3y8Wry5G3yrZr1qyF9rCF13JanxuFy0g34jqw4YyasxZrs8GayvgF47uFsrW3y8tryI
        v3ZFg397C34xJjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2Iq
        xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7
        xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcVWlDUUUU
X-Originating-IP: [117.136.87.108]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMNA1z4ixYqcgABsh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTR_ERR should access the value just tested by IS_ERR.
In skl_clk_dev_probe(),it is inconsistent.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/intel/skylake/skl-ssp-clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-ssp-clk.c b/sound/soc/intel/skylake/skl-ssp-clk.c
index 1c0e5226cb5b..f7aae10b629b 100644
--- a/sound/soc/intel/skylake/skl-ssp-clk.c
+++ b/sound/soc/intel/skylake/skl-ssp-clk.c
@@ -384,7 +384,7 @@ static int skl_clk_dev_probe(struct platform_device *pdev)
 				&clks[i], clk_pdata, i);
 
 		if (IS_ERR(data->clk[data->avail_clk_cnt])) {
-			ret = PTR_ERR(data->clk[data->avail_clk_cnt++]);
+			ret = PTR_ERR(data->clk[data->avail_clk_cnt]);
 			goto err_unreg_skl_clk;
 		}
 	}
-- 
2.17.1

