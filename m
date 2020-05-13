Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644ABCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EA6206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363568;
	bh=2zFgR8b1GyApn0bsSolKNyvqPISgYbhDCtDqlgNZqcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uiREZ1xW7jXbQIjsjaw+dCeFVz+xbrJo00iOuBORH0SGsxsmqznYYST2E6DN713G6
	 96UcIJoQy/A00SxNL59iB/N0VnuUnelzsIWc7nZXlUXzHXSqhDinPQMjkVNDyCrT9O
	 ndUy0nHpQ7NdDP3Zbjf/xU9VnRakCLksdNzGyPOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387841AbgEMJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:52:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387822AbgEMJwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:52:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9FE206D6;
        Wed, 13 May 2020 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363560;
        bh=2zFgR8b1GyApn0bsSolKNyvqPISgYbhDCtDqlgNZqcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvnFgPe9P5leh2BfFV/9XNwjEsbHl2ssL9rKCI4tldpVqn9cMRk7y7G8CdO5Y1uSS
         Ac5CxLfW1c7fwfVJpwqcSuJRXp0k5aU1CqDCVkDegbsxCwqTdsNnxcZu03gWsnGdVH
         vC+60OsqVNA968441Eh1uEzxzMUWHFHSZ941PTX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 034/118] nfp: abm: fix a memory leak bug
Date:   Wed, 13 May 2020 11:44:13 +0200
Message-Id: <20200513094420.468071956@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

[ Upstream commit bd4af432cc71b5fbfe4833510359a6ad3ada250d ]

In function nfp_abm_vnic_set_mac, pointer nsp is allocated by nfp_nsp_open.
But when nfp_nsp_has_hwinfo_lookup fail, the pointer is not released,
which can lead to a memory leak bug. Fix this issue by adding
nfp_nsp_close(nsp) in the error path.

Fixes: f6e71efdf9fb1 ("nfp: abm: look up MAC addresses via management FW")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/abm/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/netronome/nfp/abm/main.c
+++ b/drivers/net/ethernet/netronome/nfp/abm/main.c
@@ -283,6 +283,7 @@ nfp_abm_vnic_set_mac(struct nfp_pf *pf,
 	if (!nfp_nsp_has_hwinfo_lookup(nsp)) {
 		nfp_warn(pf->cpp, "NSP doesn't support PF MAC generation\n");
 		eth_hw_addr_random(nn->dp.netdev);
+		nfp_nsp_close(nsp);
 		return;
 	}
 


