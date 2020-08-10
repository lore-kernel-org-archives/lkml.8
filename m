Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD1FB20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073465;
	bh=Vw0NTeXf6g8TD8GJfu8UedAon+JFuYZRwnlsjHwj4qA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O3bQKuyQtn+FQQsbBRl8fVHJhJhahCXbCSNBvoOsRKmbHtEELqAyM+1eLSyveTLeB
	 jRPgWQ9vO8HMrGXuc7OjWB/ckArtntskviL7Wl/tsZjT0NUR665F/Ly0RJnyz1Hayp
	 bp2tUFCJu3veUGlJrr4H5+Iv1gGPGH35rZ4lCvSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgHJPbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:31:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgHJPbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:31:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B95B420791;
        Mon, 10 Aug 2020 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073460;
        bh=Vw0NTeXf6g8TD8GJfu8UedAon+JFuYZRwnlsjHwj4qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xt6QNMGGNqvZ+l7z9au0RSoIFJquwpx5ZNZzhyAoB4GoWUbvUxeX6JhvnttSUcL4G
         gyczGqPBY+2+pY3fDI13cRFAhcUQ063Hj+y1KDu8yc8bhXDCdgxdOT9CQv9JIQpwPj
         XW/1jLaW94IE85VxZSQZ+EeKdDdVymrcihl9GG1w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martyna Szapar <martyna.szapar@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH 4.19 46/48] i40e: Fix of memory leak and integer truncation in i40e_virtchnl.c
Date:   Mon, 10 Aug 2020 17:22:08 +0200
Message-Id: <20200810151806.488530971@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martyna Szapar <martyna.szapar@intel.com>

[ Upstream commit 24474f2709af6729b9b1da1c5e160ab62e25e3a4 ]

Fixed possible memory leak in i40e_vc_add_cloud_filter function:
cfilter is being allocated and in some error conditions
the function returns without freeing the memory.

Fix of integer truncation from u16 (type of queue_id value) to u8
when calling i40e_vc_isvalid_queue_id function.

Fixes: e284fc280473b ("i40e: Add and delete cloud filter")
Signed-off-by: Martyna Szapar <martyna.szapar@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -181,7 +181,7 @@ static inline bool i40e_vc_isvalid_vsi_i
  * check for the valid queue id
  **/
 static inline bool i40e_vc_isvalid_queue_id(struct i40e_vf *vf, u16 vsi_id,
-					    u8 qid)
+					    u16 qid)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = i40e_find_vsi_from_id(pf, vsi_id);
@@ -3345,7 +3345,7 @@ static int i40e_vc_add_cloud_filter(stru
 
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
-		goto err;
+		goto err_out;
 	}
 
 	if (!vf->adq_enabled) {
@@ -3353,15 +3353,15 @@ static int i40e_vc_add_cloud_filter(stru
 			 "VF %d: ADq is not enabled, can't apply cloud filter\n",
 			 vf->vf_id);
 		aq_ret = I40E_ERR_PARAM;
-		goto err;
+		goto err_out;
 	}
 
 	if (i40e_validate_cloud_filter(vf, vcf)) {
 		dev_info(&pf->pdev->dev,
 			 "VF %d: Invalid input/s, can't apply cloud filter\n",
 			 vf->vf_id);
-			aq_ret = I40E_ERR_PARAM;
-			goto err;
+		aq_ret = I40E_ERR_PARAM;
+		goto err_out;
 	}
 
 	cfilter = kzalloc(sizeof(*cfilter), GFP_KERNEL);
@@ -3422,13 +3422,17 @@ static int i40e_vc_add_cloud_filter(stru
 			"VF %d: Failed to add cloud filter, err %s aq_err %s\n",
 			vf->vf_id, i40e_stat_str(&pf->hw, ret),
 			i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
-		goto err;
+		goto err_free;
 	}
 
 	INIT_HLIST_NODE(&cfilter->cloud_node);
 	hlist_add_head(&cfilter->cloud_node, &vf->cloud_filter_list);
+	/* release the pointer passing it to the collection */
+	cfilter = NULL;
 	vf->num_cloud_filters++;
-err:
+err_free:
+	kfree(cfilter);
+err_out:
 	return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ADD_CLOUD_FILTER,
 				       aq_ret);
 }


