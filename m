Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A460C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90ED2137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599593772;
	bh=XeKscrXj7WbziYvkv0A54es1/smVegRQF/4zdzIrzso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vh6fxBorQ0nt1X1BAKrzogrIkZUE7lIvJ62XmdbqTOTHD5EDKz1UOHcHWB1HdIjrA
	 qB8IfE8gdyeGeb4S+o7mzbBSM0yTudV2uO3ytYHMHYUCXwlGCJY94gwfNAhyXbVnOs
	 BMxWn1av5F3uSVM35GG+X2LMrnCehmQKXbL9gpWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731297AbgIHTgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730956AbgIHP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:57:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C158A20658;
        Tue,  8 Sep 2020 15:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579332;
        bh=XeKscrXj7WbziYvkv0A54es1/smVegRQF/4zdzIrzso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q/ASt0KL26OFdyUQ/odmnjUz65kCgSINs+nTSWkPVbjjTDUFuwi5K8ANFgNqm4BQV
         8rN85+PDFGVWggzR23r1FPwlJssdxW4kax9pv4ZbUxt12exZ9mbnbewPhtc4DS7WnG
         H9qbIuc8Ol6qjs2vvvbQRkHH9/P9lap+12sMoO3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samson Tam <Samson.Tam@amd.com>,
        Joshua Aberback <Joshua.Aberback@amd.com>,
        Eryk Brol <eryk.brol@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 033/186] drm/amd/display: Fix passive dongle mistaken as active dongle in EDID emulation
Date:   Tue,  8 Sep 2020 17:22:55 +0200
Message-Id: <20200908152243.283196140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samson Tam <Samson.Tam@amd.com>

[ Upstream commit efbde23a3b0164cef27fd394e7d548f46af5b51d ]

[Why]
dongle_type is set during dongle connection but for passive dongles,
dongle_type is not set. If user starts with an active dongle and
then switches to a passive dongle, it will still report as an active
dongle. Trying to emulate the wrong connecter type results in display
not lighting up.

[How]
Set dpcd_caps.dongle_type for passive dongles in detect_dp().

Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Reviewed-by: Joshua Aberback <Joshua.Aberback@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index bdddb46727b1f..885beb0bcc199 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -767,6 +767,7 @@ static bool detect_dp(struct dc_link *link,
 		sink_caps->signal = dp_passive_dongle_detection(link->ddc,
 								sink_caps,
 								audio_support);
+		link->dpcd_caps.dongle_type = sink_caps->dongle_type;
 	}
 
 	return true;
-- 
2.25.1



