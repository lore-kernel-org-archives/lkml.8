Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C632C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AED20787
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="gaOuF2uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbgEASwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:52:02 -0400
Received: from gateway33.websitewelcome.com ([192.185.146.195]:46512 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729767AbgEASwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:52:01 -0400
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 9E5043549
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 13:52:00 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id UalUjkymQVQh0UalUjryl8; Fri, 01 May 2020 13:52:00 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FomgKemsxSQOPPsglc8VE0B4GO1rp6G2EJ9gCbZ2nas=; b=gaOuF2uzZoFMUvAVrJE2McUX34
        C/oeo/Z/GK7YoSfkM5a5Lx09qTZ7ZEnwZ6g9jiKRxGCvEi6b70xjxYisRA1xDeNQ1eJyGhCBd8tjq
        p9fIVk6rQ+hMlBPTQnf9D9uK8wiiEZaS8A7pMU7DDFvWISaMrrDwO1owbVKzXwAWw9QwMYPIvMTE7
        ay2grDRwpR+dfKjDB3IT19ouxU8ls4prbzjqbjq585YEbRuIk1M3WhUefHHjaL9GBRrzHmpniKpCH
        Kb9I7dZD5CD5dXWiB2sHdwcK9cKRdAwBRHLLBTsaqi1tk5vnsgTyJmeGQi5J5IVVTweLm8ozAanYf
        Gck1BJbg==;
Received: from [189.207.59.248] (port=52120 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jUalU-001fON-42; Fri, 01 May 2020 13:52:00 -0500
Date:   Fri, 1 May 2020 13:56:21 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mukul Joshi <mukul.joshi@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdkfd: Remove logically dead code in kfd_procfs_show
Message-ID: <20200501185621.GA17880@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.207.59.248
X-Source-L: No
X-Exim-ID: 1jUalU-001fON-42
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.207.59.248]:52120
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of is never null, so the null check on pdd is unnecessary.

If the null check is removed, function kfd_procfs_show()
will always return before reaching "return 0", hence
such return is logically dead. So, remove it, as well.

Addresses-Coverity-ID: 1492793 ("Logically dead code")
Fixes: d4566dee849e ("drm/amdkfd: Track GPU memory utilization per process")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 598296034b43..63dcd30b2cdc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -87,14 +87,11 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 	} else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
-		if (pdd)
-			return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
+		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage));
 	} else {
 		pr_err("Invalid attribute");
 		return -EINVAL;
 	}
-
-	return 0;
 }
 
 static void kfd_procfs_kobj_release(struct kobject *kobj)
-- 
2.26.0

