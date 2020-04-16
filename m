Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E558DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC8352078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045810;
	bh=tRXqSHZ8cQC+9aPAz8WM9CyiqdFKO7LOWNsUqFUbfmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EJLcMJkc3c+E7fSxzjx7+ePulBPTIqV9r4Dcl52YX0nvzOHLv/ke+EzdDoIwZcF4L
	 q/VIDvGSQjA/XXmg9Wt5g8Jb3B7VkJw5sVlSg2f1h3KE0leE6SkDsZ0/X5kf5wv2GY
	 jLFklYh1PmBSv6ahBq9q6hSYzgS2MOevuI029tVE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391989AbgDPOD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDPNmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4148A20732;
        Thu, 16 Apr 2020 13:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044522;
        bh=tRXqSHZ8cQC+9aPAz8WM9CyiqdFKO7LOWNsUqFUbfmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0kUPLg3V6op0UbpTWi78tCraM9y8FTJA2iIxbXsu0ffUbtVpMDBqVJGzE39+o04T9
         FG63WjuX41ljRC/EcHWQURUp6z0HAI7i2zOI/0HXhGNdiQLp5kWy/fdb2r5TlMG5f5
         vFsBihuPwkJgJymecnR3G/v6a3babmRxYVEey474=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Strauss <michael.strauss@amd.com>,
        Eric Yang <eric.yang2@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.5 212/257] drm/amd/display: Check for null fclk voltage when parsing clock table
Date:   Thu, 16 Apr 2020 15:24:23 +0200
Message-Id: <20200416131352.553064905@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
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
@@ -641,7 +641,7 @@ static void rn_clk_mgr_helper_populate_b
 	/* Find lowest DPM, FCLK is filled in reverse order*/
 
 	for (i = PP_SMU_NUM_FCLK_DPM_LEVELS - 1; i >= 0; i--) {
-		if (clock_table->FClocks[i].Freq != 0) {
+		if (clock_table->FClocks[i].Freq != 0 && clock_table->FClocks[i].Vol != 0) {
 			j = i;
 			break;
 		}


