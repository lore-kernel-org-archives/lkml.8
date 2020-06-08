Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CAAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C492072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661484;
	bh=9lHRliieVBRuhWpIfnInKTM3rDQgHHFvUgGFx4dSJ7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UDOEzlYqGzSMhsNyX9LWWiGttEKEl80ThstkKDe3sz0Z8O1YxLTgYOxzRNUgvP+zL
	 9VwWghLZ9bIJFyLozUlKICDroshvTmn4jUv/y759uNmZB1WOq2v/hlXHhnd9IUdmag
	 oZkTHnX3ixamm8qA4w88FUqXTixfIWNQ8+ZcUKWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbgFIALX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgFHXTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99C7D2085B;
        Mon,  8 Jun 2020 23:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658395;
        bh=9lHRliieVBRuhWpIfnInKTM3rDQgHHFvUgGFx4dSJ7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+MkOtyPr/YKKUX+Z1885QbipjQP5V8QdncXAb5RdF/a53x7ZPMjVfgFz/DnCpDus
         r6biYXcqgcWlLar//kd2Ib0ABOaA7LFrOECSEZtB4wyLAoOoLjz0skYsy3gcPYGQoJ
         jsKsYC5xnjI2TbcrMI2RZPq3ngIR/Hzumnz44vCo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Surabhi Boob <surabhi.boob@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 052/175] ice: Fix memory leak
Date:   Mon,  8 Jun 2020 19:16:45 -0400
Message-Id: <20200608231848.3366970-52-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Surabhi Boob <surabhi.boob@intel.com>

[ Upstream commit 1aaef2bc4e0a5ce9e4dd86359e6a0bf52c6aa64f ]

Handle memory leak on filter management initialization failure.

Signed-off-by: Surabhi Boob <surabhi.boob@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 171f0b625407..d68b8aa31b19 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -436,6 +436,7 @@ static void ice_init_flex_flds(struct ice_hw *hw, enum ice_rxdid prof_id)
 static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 {
 	struct ice_switch_info *sw;
+	enum ice_status status;
 
 	hw->switch_info = devm_kzalloc(ice_hw_to_dev(hw),
 				       sizeof(*hw->switch_info), GFP_KERNEL);
@@ -446,7 +447,12 @@ static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 
 	INIT_LIST_HEAD(&sw->vsi_list_map_head);
 
-	return ice_init_def_sw_recp(hw);
+	status = ice_init_def_sw_recp(hw);
+	if (status) {
+		devm_kfree(ice_hw_to_dev(hw), hw->switch_info);
+		return status;
+	}
+	return 0;
 }
 
 /**
-- 
2.25.1

