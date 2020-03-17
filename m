Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4E1C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06115206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443268;
	bh=vvhw3zUYuauoWRuICUncsXxSsiBSGqh0Z5VoZbtqKJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rwbw5w1aiS+XAOf/m7acHwYZWIKBOWPoFiamhiLDln5nD/SneVBD76J95Xzy83pVr
	 3Gxba0c/t6qd6PfOuTKM5nSxOMEX9wTbAQV3vFdsI8sz3Za0Cx5v9+LJ2JtFd7gbbz
	 H/7tWrv1f5/sdnApZIEhVtQfP6ZUyj/qNV/1eaGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgCQLHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbgCQLHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:07:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11423206EC;
        Tue, 17 Mar 2020 11:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443263;
        bh=vvhw3zUYuauoWRuICUncsXxSsiBSGqh0Z5VoZbtqKJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWEYMBJL3hq/nRPQvmZcX4NqMS6qUi3ISbnp42CBcpKXQDFElWmmg9ujKOrs82E6v
         vU4FhFFmYRctapTwKukU/t58sVAMBxytrKEVeRZ6RpyU4zFqt2JchszLZ+9y0jL8Bw
         C0WiWtUpC1dNmE4GT8BFOXm3RqjkJdJBbG5GM6VY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 028/151] net: systemport: fix index check to avoid an array out of bounds access
Date:   Tue, 17 Mar 2020 11:53:58 +0100
Message-Id: <20200317103328.705036294@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c0368595c1639947839c0db8294ee96aca0b3b86 ]

Currently the bounds check on index is off by one and can lead to
an out of bounds access on array priv->filters_loc when index is
RXCHK_BRCM_TAG_MAX.

Fixes: bb9051a2b230 ("net: systemport: Add support for WAKE_FILTER")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bcmsysport.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -2135,7 +2135,7 @@ static int bcm_sysport_rule_set(struct b
 		return -ENOSPC;
 
 	index = find_first_zero_bit(priv->filters, RXCHK_BRCM_TAG_MAX);
-	if (index > RXCHK_BRCM_TAG_MAX)
+	if (index >= RXCHK_BRCM_TAG_MAX)
 		return -ENOSPC;
 
 	/* Location is the classification ID, and index is the position


