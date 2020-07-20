Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D8C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C4B2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261742;
	bh=rEkJa8togNuzByIF4RXCuzp7Dg6DRSWpXP+C8+adn5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EzKWcacTMDYKbWQaI+6D2FCdlvcF0+YF0usHhhdv/p8PYihyhg2zQatb4liQLI5l+
	 tjSbABjHfel3Wzz2Jjd0DhMRmfPle8u763RaTcoaGhmi7mHrNwUfzED+qRMDWKGb8c
	 08cBePteDwqJQpGQaNApQaA7zOYaNcSNPssAeny8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388447AbgGTQPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:15:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388435AbgGTQPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:15:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E81C2064B;
        Mon, 20 Jul 2020 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261736;
        bh=rEkJa8togNuzByIF4RXCuzp7Dg6DRSWpXP+C8+adn5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URGMf83tegk9yWI2RhBqEMtm41NP3Cue0TDg9+5TtFnP3zZkabn5k5ErjkP5iLrlw
         gXS75Jy1BXar9oFlkiTZQXqr4+Ysti8yKUTTtR4DF9kRclwTA2mpo5epXIc72kcMYd
         yOFLHsuOVj/qU4NVpQ/q2E5/oGUN2Bz4Gb1kdn0s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, chen gong <curry.gong@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 224/244] drm/amdgpu/powerplay: Modify SMC message name for setting power profile mode
Date:   Mon, 20 Jul 2020 17:38:15 +0200
Message-Id: <20200720152836.505811922@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chen gong <curry.gong@amd.com>

commit 98a34cf931e848f8489d3fb15a8f5fc03802ad65 upstream.

I consulted Cai Land(Chuntian.Cai@amd.com), he told me corresponding smc
message name to fSMC_MSG_SetWorkloadMask() is
"PPSMC_MSG_ActiveProcessNotify" in firmware code of Renoir.

Strange though it may seem, but it's a fact.

Signed-off-by: chen gong <curry.gong@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -687,7 +687,7 @@ static int renoir_set_power_profile_mode
 		return -EINVAL;
 	}
 
-	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadMask,
+	ret = smu_send_smc_msg_with_param(smu, SMU_MSG_ActiveProcessNotify,
 				    1 << workload_type,
 				    NULL);
 	if (ret) {


