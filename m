Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA79C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C6F6206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733597;
	bh=Tn2A2c36t2FBdyNgSKrOhlfCuK1uYRcatybz6cgblfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1rt4/HPqB+3igkiVyh5tD4G8NSWQtCIw+W4BFo/HWyeiNlOYNwtS0bs+ITQlOk+ld
	 Q/vNEkek1BMIVh4LgfWgJPX2/sumugwUpeARJb1DdbUZg0Q3SKavLg3FgRh6M+7w/6
	 Qodzy9yJ1948s+mo3JCQwFtOjUrIjrX4H4Dl1jhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbgIJK0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730707AbgIJKYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:22 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CDA21D92;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=Tn2A2c36t2FBdyNgSKrOhlfCuK1uYRcatybz6cgblfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjVME75ZicrZ7i+fLnSjRSlJ4l9ifRx/yyCGeg0qnvCu6ifcbZtzDegCQYuOfleyq
         o/mesT4zH6M+Y5artvHqWg1h92fGiT0UVMYPKnErIHuASED2Hl2Xvl8rSkYD0H9m+d
         RFELvMO3fOHL7c/IWoZ0N2iLuX/yqtw3z4GebVsk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EIOC-OV; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/14] drm: kernel-doc: drm_dp_helper.h: fix a typo
Date:   Thu, 10 Sep 2020 12:24:06 +0200
Message-Id: <938dd50bb14edaaa162781f86579502ef5fb9919.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1599732764.git.mchehab+huawei@kernel.org>
References: <cover.1599732764.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, kernel-doc generates a warning:
	./include/drm/drm_dp_helper.h:1786: warning: Function parameter or member 'hbr2_reset' not described in 'drm_dp_phy_test_params'

This is due to a typo:

	@hb2_reset -> @hbr2_reset

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/drm/drm_dp_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 5e41e15cb5a1..53fc41e6719e 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1771,7 +1771,7 @@ static inline void drm_dp_cec_unset_edid(struct drm_dp_aux *aux)
  * @link_rate: Requested Link rate from DPCD 0x219
  * @num_lanes: Number of lanes requested by sing through DPCD 0x220
  * @phy_pattern: DP Phy test pattern from DPCD 0x248
- * @hb2_reset: DP HBR2_COMPLIANCE_SCRAMBLER_RESET from DCPD 0x24A and 0x24B
+ * @hbr2_reset: DP HBR2_COMPLIANCE_SCRAMBLER_RESET from DCPD 0x24A and 0x24B
  * @custom80: DP Test_80BIT_CUSTOM_PATTERN from DPCDs 0x250 through 0x259
  * @enhanced_frame_cap: flag for enhanced frame capability.
  */
-- 
2.26.2

