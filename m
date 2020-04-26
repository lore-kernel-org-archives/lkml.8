Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7D0C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D59D206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgDZNSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:18:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:59692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgDZNSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:18:25 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F0527690B6900E72B260;
        Sun, 26 Apr 2020 21:18:22 +0800 (CST)
Received: from huawei.com (10.175.105.27) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Sun, 26 Apr 2020
 21:18:13 +0800
From:   Wu Bo <wubo40@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <libin.yang@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <nmahale@nvidia.com>,
        <aplattner@nvidia.com>, <pierre-louis.bossart@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>,
        <wubo40@huawei.com>
Subject: [PATCH] sound:hdmi:fix without unlocked before return
Date:   Sun, 26 Apr 2020 21:17:22 +0800
Message-ID: <1587907042-694161-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
sound/pci/hda/patch_hdmi.c:1852:2-8: preceding lock on line 1846

After add sanity check to pass klockwork check,
The spdif_mutex should be unlock before return true
in check_non_pcm_per_cvt().

Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 sound/pci/hda/patch_hdmi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 4eff1605..c24832b 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1848,8 +1848,10 @@ static bool check_non_pcm_per_cvt(struct hda_codec *codec, hda_nid_t cvt_nid)
 	/* Add sanity check to pass klockwork check.
 	 * This should never happen.
 	 */
-	if (WARN_ON(spdif == NULL))
+	if (WARN_ON(spdif == NULL)) {
+		mutex_unlock(&codec->spdif_mutex);
 		return true;
+	}
 	non_pcm = !!(spdif->status & IEC958_AES0_NONAUDIO);
 	mutex_unlock(&codec->spdif_mutex);
 	return non_pcm;
-- 
1.8.3.1

