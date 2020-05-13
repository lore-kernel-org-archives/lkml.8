Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A7CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BDF220575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363325;
	bh=2zFgR8b1GyApn0bsSolKNyvqPISgYbhDCtDqlgNZqcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pxiRgHAbt5HDNdwSRlUCXP1sE7FxVbTzR8hZubmehe14f0WTp6e4b4Et6D3tKmWrb
	 7Ep6mNLZqgfsa28elfh37Nml6NFObFKcO2rPBwmeOhu940/NRL5NAA3yZOfE+gESDE
	 nWxdpzCsGQJW0tnShqDDgXGVq4F+ig6EfJOBtfUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733116AbgEMJso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733105AbgEMJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:48:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5088B20575;
        Wed, 13 May 2020 09:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363320;
        bh=2zFgR8b1GyApn0bsSolKNyvqPISgYbhDCtDqlgNZqcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K4BCvh19giMFOvJ139t+/aPbYA1bCsXNUXVr1Wxg56BxZYplbJZ2uAfqkqQ7hUId1
         POeP2ja2NXAnCTNB2CdPKo8RAJ/Ur4EU4AhlytJiV0MQ+xd3lV4UNqa7AmqO8cOxZv
         pmYSNFejPzo7FP8RsEueE9mvWP2CowPgC7Gy5B7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 26/90] nfp: abm: fix a memory leak bug
Date:   Wed, 13 May 2020 11:44:22 +0200
Message-Id: <20200513094411.324178448@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
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
 


