Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C9CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BA522D2B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073531;
	bh=GdpXVV8DMlKmH9TVZ8I3srjFaDu0mJ60QwCti/S4+20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mMMoNiqTe6o2BgZ/WBbNAw6/jQloPYUI/JcLGVqOa54dTDhPRoSbtbZzsbC+pSW8P
	 W5qMEhERcgvmzPPCXvQGHaO1/3B8YUyzS5akUHMTjgA6cS/NxU0ACEwTKw6BTIWcaM
	 wTk+Z/v8AfGgI7xRccmFXMxfOzVH4CtcYHsZP+3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgHJPcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728906AbgHJPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E24B020791;
        Mon, 10 Aug 2020 15:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073454;
        bh=GdpXVV8DMlKmH9TVZ8I3srjFaDu0mJ60QwCti/S4+20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHBQ6lp/t61vspWIyPtRIcwL0xCP9SIrYw2XdBXbfUSxnA9irHdZ5pH/Xk8B7/qKR
         vIF3N4ZHrtPfp1PrsTJY12CqCpezGDXRoK/l7yPlVLg7SpN7ivXL5BwCFQLqJkDyDw
         pBOUDEcc8sYNCHcoaxTkxkviavTGgmlSRkvs6am4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Nemov <sergey.nemov@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: [PATCH 4.19 44/48] i40e: add num_vectors checker in iwarp handler
Date:   Mon, 10 Aug 2020 17:22:06 +0200
Message-Id: <20200810151806.389164727@linuxfoundation.org>
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

From: Sergey Nemov <sergey.nemov@intel.com>

[ Upstream commit 7015ca3df965378bcef072cca9cd63ed098665b5 ]

Field num_vectors from struct virtchnl_iwarp_qvlist_info should not be
larger than num_msix_vectors_vf in the hw struct.  The iwarp uses the
same set of vectors as the LAN VF driver.

Fixes: e3219ce6a7754 ("i40e: Add support for client interface for IWARP driver")
Signed-off-by: Sergey Nemov <sergey.nemov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -442,6 +442,16 @@ static int i40e_config_iwarp_qvlist(stru
 	u32 next_q_idx, next_q_type;
 	u32 msix_vf, size;
 
+	msix_vf = pf->hw.func_caps.num_msix_vectors_vf;
+
+	if (qvlist_info->num_vectors > msix_vf) {
+		dev_warn(&pf->pdev->dev,
+			 "Incorrect number of iwarp vectors %u. Maximum %u allowed.\n",
+			 qvlist_info->num_vectors,
+			 msix_vf);
+		goto err;
+	}
+
 	size = sizeof(struct virtchnl_iwarp_qvlist_info) +
 	       (sizeof(struct virtchnl_iwarp_qv_info) *
 						(qvlist_info->num_vectors - 1));


