Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6EAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE14621D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587047305;
	bh=WS83ZMqbmaiP+n7ZUVBZyuzfyW0XaIhuQfMBGWKJQ+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qhjfjMD90hoQNaMNrZwN22Tf7ryBmmciA7AemkjW1E1OUuDbj6b1vkRYYuhx5R7L8
	 j70xWOej8DMAnBshgVi8ZUTINk8/AzsYXFSHReUyWpqfiAPF6Q9N8My7Cz8HKDDy9R
	 Z42+Z1fs+n3ag2heklg7a9Y/46LHTy9OSEzrB8gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410110AbgDPO2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730047AbgDPOAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:00:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E3D620732;
        Thu, 16 Apr 2020 14:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045615;
        bh=WS83ZMqbmaiP+n7ZUVBZyuzfyW0XaIhuQfMBGWKJQ+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o570yroOUnw40nG5DsiyKymJqWdFMTctBFBrXfXJT1hT1JjqFS2B0Ng6oCFiw3YJG
         kKyabNu19ppktHTABog0Ch8WsYWw3Q3V1QwdMn/OXOSMlkZDX/CzbmKe42uEF4WCUX
         zeRP4oLS9UdBsgYEsAnUUlC6/myzwqDASOMZgla8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Strauss <michael.strauss@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.6 207/254] drm/amd/display: Check for null fclk voltage when parsing clock table
Date:   Thu, 16 Apr 2020 15:24:56 +0200
Message-Id: <20200416131351.945784577@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Strauss <michael.strauss@amd.com>

commit 72f5b5a308c744573fdbc6c78202c52196d2c162 upstream.

[WHY]
In cases where a clock table is malformed such that fclk entries have
frequencies but not voltages listed, we don't catch the error and set
clocks to 0 instead of using hardcoded values as we should.

[HOW]
Add check for clock tables fclk entry's voltage as well

Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -643,7 +643,7 @@ static void rn_clk_mgr_helper_populate_b
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
 	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->FClocks[i].Freq != 0) {
+		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
 			j = i;
 			break;
 		}


