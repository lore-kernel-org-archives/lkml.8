Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9393C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8878E206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="STO4UMrd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgFCM7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:59:10 -0400
Received: from www413.your-server.de ([88.198.28.140]:59804 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:59:09 -0400
X-Greylist: delayed 1518 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 08:59:08 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WLXbW7eXUFsbHAU7HjXMcrh7C07cQvd1bw2Aquc/MMQ=; b=STO4UMrdwTubX7v2omyrFeJGM
        qq1ZY5ooXteqYoYSLnmjaa26PlLavdzZlWh+u8ynyZLVI3Q0Uaxf402CkZy/RE4ZV18Od2J2uywZL
        0B1rHQHjfnHHqiKmwIQUqAiEY2G1DFCmNHqEkClSgIVtDaUl7JOuXXw/PE64bbxZMJNcUEKZW0nmg
        pWFa9cHKM35fG6Czz9iSJcJUasT2242nsmibkiyGYkBZnDBs8dKH+356OK5Ea5pSGrX0D4tO+G9VV
        vXtnD3cxWfSWGQHS08JTJ9+oCPvGgxMazUqgZxj8wjIXX0mWAqPmTQ0ufTVzJaFMBwt5o5FVOQ7J+
        8AQnbtzRA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1jgSaZ-0000IJ-Jk; Wed, 03 Jun 2020 14:33:48 +0200
Received: from [2001:16b8:5718:c600:5706:3182:8b16:9ba] (helo=linux.fritz.box)
        by sslproxy01.your-server.de with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.92)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1jgSaZ-000LTO-DG; Wed, 03 Jun 2020 14:33:47 +0200
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        Thomas Prescher <thomas.prescher@cyberus-technology.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH] drm/i915/gvt: print actionable error message when gm runs out
Date:   Wed,  3 Jun 2020 14:33:21 +0200
Message-Id: <20200603123321.263895-1-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25831/Tue Jun  2 14:41:03 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a user tries to allocate too many or too big vGPUs and runs out
of graphics memory, the resulting error message is not actionable and
looks like an internal error.

Change the error message to clearly point out what actions a user can
take to resolve this situation.

Cc: Thomas Prescher <thomas.prescher@cyberus-technology.de>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 drivers/gpu/drm/i915/gvt/aperture_gm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i915/gvt/aperture_gm.c
index 0d6d598713082..5c5c8e871dae2 100644
--- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
+++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
@@ -69,9 +69,12 @@ static int alloc_gm(struct intel_vgpu *vgpu, bool high_gm)
 				  start, end, flags);
 	mmio_hw_access_post(gt);
 	mutex_unlock(&gt->ggtt->vm.mutex);
-	if (ret)
-		gvt_err("fail to alloc %s gm space from host\n",
-			high_gm ? "high" : "low");
+	if (ret) {
+		gvt_err("vgpu%d: failed to allocate %s gm space from host\n",
+			vgpu->id, high_gm ? "high" : "low");
+		gvt_err("vgpu%d: destroying vGPUs, decreasing vGPU memory size or increasing GPU aperture size may resolve this\n",
+			vgpu->id);
+	}
 
 	return ret;
 }
-- 
2.26.2

