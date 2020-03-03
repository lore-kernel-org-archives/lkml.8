Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE33C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB0E2073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583259002;
	bh=r0ZJdfrHlvlMG27ltDw0FNuypu2jAgNIjY5mo1BSf+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T6GlGeOT+l/VzlUMBC4ZEcITCxpuz2f2XEjs7ia/Zc/n1fpEfAOjFG39WfFP/Qy3+
	 86+6EMim6Qx6VkXQL4QruHIWqUZn2RAvvjSocjX3b+a7bnmXhawCgy7FOZsH1e5IhT
	 urGu0wzjtZJNfHLUYCMRgD0jmAH/96MD+tW9rPKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733272AbgCCSKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:10:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732012AbgCCRvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:51:37 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59E8720870;
        Tue,  3 Mar 2020 17:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257896;
        bh=r0ZJdfrHlvlMG27ltDw0FNuypu2jAgNIjY5mo1BSf+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0nBh1yAOo4EjEMLwyMXPSohc7uURyz6LykH2ZicIiN/66qw+cCuUIkOKjhV+8zgX
         RIxwF9Y5AgQ3A3nb/we16xtrn4qjQnBTbwqRuoD+/2u+SifHFnvXs9O1x65vyOz8r4
         DYMtQng5WsFTLA0T3pK1CQY5ArWujm3cTxl5/VTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 132/176] net: atlantic: fix out of range usage of active_vlans array
Date:   Tue,  3 Mar 2020 18:43:16 +0100
Message-Id: <20200303174320.024538918@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dbogdanov@marvell.com>

commit 5a292c89a84d49b598f8978f154bdda48b1072c0 upstream.

fix static checker warning:
 drivers/net/ethernet/aquantia/atlantic/aq_filters.c:166 aq_check_approve_fvlan()
 error: passing untrusted data to 'test_bit()'

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 7975d2aff5af: ("net: aquantia: add support of rx-vlan-filter offload")
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/aquantia/atlantic/aq_filters.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -163,7 +163,7 @@ aq_check_approve_fvlan(struct aq_nic_s *
 	}
 
 	if ((aq_nic->ndev->features & NETIF_F_HW_VLAN_CTAG_FILTER) &&
-	    (!test_bit(be16_to_cpu(fsp->h_ext.vlan_tci),
+	    (!test_bit(be16_to_cpu(fsp->h_ext.vlan_tci) & VLAN_VID_MASK,
 		       aq_nic->active_vlans))) {
 		netdev_err(aq_nic->ndev,
 			   "ethtool: unknown vlan-id specified");


