Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA88C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E9820774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663723;
	bh=MPww2KMiIHzg/oIztqFpjBj3n/wGtvouVkgda4QhFYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoidA4bWL2KDPDXR1+eezaom9dMtTHcmXQYyLQZqddox91URCOk1Zg+whedN//RWY
	 wKJNAJzGWlZk1SNKvO4zU/dpaqpXHVa0KaOPk2xaqUopjtFr+tVMtFsNF+e3WAmRwK
	 87ossN0tUa0K5Oz3qQTw9c/DPZWIAAfsU8f+59NI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbgFIAsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgFHXKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:10:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D184220CC7;
        Mon,  8 Jun 2020 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657853;
        bh=MPww2KMiIHzg/oIztqFpjBj3n/wGtvouVkgda4QhFYo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I9wOBa9ZTR/vP1qyv2pEKKq1gRtfBmoOOpNPOflBPsxfkqYGYxOEw8rxViCPb1Ko6
         5ge1DU9i2n1IMVH4muN2paWlfqjKzkY6M0MkcE4GLzBLQYigHyZtjmce0Cp5ZVK38j
         yb4GE1ctCKX+/cIQbIXX2iry+r8Wn68JiDZFRwpg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Joyner <eric.joyner@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 218/274] ice: Fix resource leak on early exit from function
Date:   Mon,  8 Jun 2020 19:05:11 -0400
Message-Id: <20200608230607.3361041-218-sashal@kernel.org>
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

From: Eric Joyner <eric.joyner@intel.com>

[ Upstream commit 857a4f0e9f4956fffc0cedcaa2ba187a2e987153 ]

Memory allocated in the ice_add_prof_id_vsig() function wasn't being
properly freed if an error occurred inside the for-loop in the function.

In particular, 'p' wasn't being freed if an error occurred before it was
added to the resource list at the end of the for-loop.

Signed-off-by: Eric Joyner <eric.joyner@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
index e7a2671222d2..abfec38bb483 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
@@ -3705,8 +3705,10 @@ ice_add_prof_id_vsig(struct ice_hw *hw, enum ice_block blk, u16 vsig, u64 hdl,
 					      t->tcam[i].prof_id,
 					      t->tcam[i].ptg, vsig, 0, 0,
 					      vl_msk, dc_msk, nm_msk);
-		if (status)
+		if (status) {
+			devm_kfree(ice_hw_to_dev(hw), p);
 			goto err_ice_add_prof_id_vsig;
+		}
 
 		/* log change */
 		list_add(&p->list_entry, chg);
-- 
2.25.1

