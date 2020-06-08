Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3E020814
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664601;
	bh=OMuK4o8Ehu5BM1rbVHdg6XjAxzAvk11aTBSgHZG4xWE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jCBeAVXAzO+Yk8eUTEwHHlgWWmUgspl3IFQB8bnX/7w524xWs62Ft1ge4PT394fDe
	 YIHwNKzV9NBSSeA6fDNv3yBUnvt13IyzRjM083z/NXuO4oDcB98Mcn9xCXpoh0+CZr
	 7xgsqsCWH75O9b5Bdeo1O/vB1mGtdM/oB8mPyG78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388150AbgFIBDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727782AbgFHXHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:07:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F168B20812;
        Mon,  8 Jun 2020 23:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657661;
        bh=OMuK4o8Ehu5BM1rbVHdg6XjAxzAvk11aTBSgHZG4xWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOcUicxbWPqUUYKN5PeJmbO32sBIZ4EjKJrjBK16ph77l9IRAWA8H2lpozGwwz1vE
         rf2EdE+GLXLMkje/ma1tZDiqtQ+76zRmYGr8XkNPjcj96Sf6WIcEgI667YjJOSQ/Ah
         yJuNbfZn9Wo/EaFw4MczkLXFRQLnWtESy1s4qPfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Surabhi Boob <surabhi.boob@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 073/274] ice: Fix memory leak
Date:   Mon,  8 Jun 2020 19:02:46 -0400
Message-Id: <20200608230607.3361041-73-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
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
index 2c0d8fd3d5cd..09b374590ffc 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -322,6 +322,7 @@ ice_aq_get_link_info(struct ice_port_info *pi, bool ena_lse,
 static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 {
 	struct ice_switch_info *sw;
+	enum ice_status status;
 
 	hw->switch_info = devm_kzalloc(ice_hw_to_dev(hw),
 				       sizeof(*hw->switch_info), GFP_KERNEL);
@@ -332,7 +333,12 @@ static enum ice_status ice_init_fltr_mgmt_struct(struct ice_hw *hw)
 
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

