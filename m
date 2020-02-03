Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54726C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2753F2080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746926;
	bh=IIUnMaUqh3pkUmL/O720khsx3RBbmq2tEFSIgjjRU10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epJ4JUIFF/YaqXDJrV9X9J+a7JuCempEwVGOae+ob4jT9RX+oW9gS2KLj8YGKGFYK
	 wT7Dta2TQ5O+Fjhky0K9bBpIzrB37St2+IFixF/0KqFYnPfC3RDmrLAnfLI3kFRkLn
	 1cUlvvKe8hcRbxQDPsEyo2VstJQ/d5KxidpN7InI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgBCQWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729236AbgBCQV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:59 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A89912082E;
        Mon,  3 Feb 2020 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746919;
        bh=IIUnMaUqh3pkUmL/O720khsx3RBbmq2tEFSIgjjRU10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wY+vUmVhDybJvkkIuDJXctKbg0uY1gP90A9Jl/upD4FIRQe69rrdSdScRHdboUVtl
         wCL8dA8kdIVSRadvF7EV4VedQo3YD2+tahTwC/I29D8tI24IxiwOdAPqkpPXOl1eTq
         54AMjt8/oUxeqltiMhjeC35BQGXJ/idd9CacC2q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Radoslaw Tyl <radoslawx.tyl@intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 35/53] ixgbevf: Remove limit of 10 entries for unicast filter list
Date:   Mon,  3 Feb 2020 16:19:27 +0000
Message-Id: <20200203161909.294400175@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Radoslaw Tyl <radoslawx.tyl@intel.com>

[ Upstream commit aa604651d523b1493988d0bf6710339f3ee60272 ]

Currently, though the FDB entry is added to VF, it does not appear in
RAR filters. VF driver only allows to add 10 entries. Attempting to add
another causes an error. This patch removes limitation and allows use of
all free RAR entries for the FDB if needed.

Fixes: 46ec20ff7d ("ixgbevf: Add macvlan support in the set rx mode op")
Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 723bda33472a7..0fa94ebf0411b 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1861,11 +1861,6 @@ static int ixgbevf_write_uc_addr_list(struct net_device *netdev)
 	struct ixgbe_hw *hw = &adapter->hw;
 	int count = 0;
 
-	if ((netdev_uc_count(netdev)) > 10) {
-		pr_err("Too many unicast filters - No Space\n");
-		return -ENOSPC;
-	}
-
 	if (!netdev_uc_empty(netdev)) {
 		struct netdev_hw_addr *ha;
 
-- 
2.20.1



