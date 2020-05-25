Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB591C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7CAE208A7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fudan.edu.cn header.i=@fudan.edu.cn header.b="bqPjER1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390895AbgEYOO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:14:56 -0400
Received: from mail.fudan.edu.cn ([202.120.224.10]:46377 "EHLO fudan.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388825AbgEYOO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=wV+8GWHmlPLsGH6pV0dZ1EqATUh15qtb0QrL9XQq63E=; b=b
        qPjER1LjiSCRAX2iFQiqDmvRgFlNgmzB2XZcJHwD5XE16wnKoTtYw1nnY/kMdvND
        X5fntiruuOcJGMEBy6o3OCdgowJtdWiBPpMTaOEacWqZQ/y7vnXKjqVoxxv8CSrl
        NXBrZKkOuCzfovzwF5EbdNHwpXkWGpxg88/g5LHdYQ=
Received: from localhost.localdomain (unknown [223.73.184.21])
        by app1 (Coremail) with SMTP id XAUFCgBXXaHV0stehMwwAg--.41775S3;
        Mon, 25 May 2020 22:14:46 +0800 (CST)
From:   Xiyu Yang <xiyuyang19@fudan.edu.cn>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: [PATCH] dax: Fix dax_region refcnt leak when creating dev_dax
Date:   Mon, 25 May 2020 22:14:13 +0800
Message-Id: <1590416053-52476-1-git-send-email-xiyuyang19@fudan.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: XAUFCgBXXaHV0stehMwwAg--.41775S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr47GrW3Ww4xKw4DKFyUZFb_yoW8Jr48pa
        15Wayj9rZ8KF1UZw45Aw45uF15AwsrK3y8CFW7X3y3urs3X3sFyrySqa42qFyY9r95A345
        XF1qqry09asrCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2
        z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbPEfUUUUUU==
X-CM-SenderInfo: irzsiiysuqikmy6i3vldqovvfxof0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__devm_create_dev_dax() invokes kref_get(), which increases the refcount
of the "dax_region".

The reference counting issue happens in several exception handling paths
of __devm_create_dev_dax(). When those error scenarios occur such as add
device failed, the function forgets to decrease the refcnt increased by
kref_get(), causing a refcnt leak.

Fix this issue by calling kref_put() when those error scenarios occur.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 drivers/dax/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index df238c8b6ef2..1a861d90321f 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -452,12 +452,15 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	if (rc) {
 		kill_dev_dax(dev_dax);
 		put_device(dev);
+		kref_put(&dax_region->kref, dax_region_free);
 		return ERR_PTR(rc);
 	}
 
 	rc = devm_add_action_or_reset(dax_region->dev, unregister_dev_dax, dev);
-	if (rc)
+	if (rc) {
+		kref_put(&dax_region->kref, dax_region_free);
 		return ERR_PTR(rc);
+	}
 
 	return dev_dax;
 
-- 
2.7.4

