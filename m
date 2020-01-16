Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E8EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68643206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200689;
	bh=/BomwU7BzLsXWZlAm+sEkga800aiL6dN51sInZMjMYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v5J6apbIPF901aO291yjKmAgimbHEdJd7IzevhB+cw+unEiFQUh50uDd8lWcMzZz4
	 3//1ccH7oN+RG6wMDVd6mUzwZE0k6eWjiwZS5KM3cUEh9vMXKI6xv4ruuZRmvMkyQ9
	 uoAl0XQ5EhbCoG4jX+U6Ei5D/sFCWJ5NQIk2cD/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389496AbgAPRIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:08:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387629AbgAPRIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:08:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB36A21D56;
        Thu, 16 Jan 2020 17:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194523;
        bh=/BomwU7BzLsXWZlAm+sEkga800aiL6dN51sInZMjMYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fz3UzSrtMtDse0uHaTXmbLOeu7d/LcJ2y8gxiwegxJ2cvlM2ZgzoGpSwmcCy8C59n
         LZzpilmkAPkLH6n1D0NwRq3q68uEcj6e8WeMZb7PW//6seGYdm+75IF1HRGa737tE9
         lKuXrZ8+W3uj3E5VbH1eIdFVgeFRVHHU/ILth5J8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <ariel.elior@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 414/671] qed: iWARP - fix uninitialized callback
Date:   Thu, 16 Jan 2020 12:00:52 -0500
Message-Id: <20200116170509.12787-151-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Kalderon <michal.kalderon@marvell.com>

[ Upstream commit 43cf40d93fadbb0d3edf0942a4612f8ff67478a1 ]

Fix uninitialized variable warning by static checker.

Fixes: ae3488ff37dc ("qed: Add ll2 connection for processing unaligned MPA packets")
Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_iwarp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
index c77babd0ef95..39787bb885c8 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_iwarp.c
@@ -2641,6 +2641,7 @@ qed_iwarp_ll2_start(struct qed_hwfn *p_hwfn,
 	cbs.rx_release_cb = qed_iwarp_ll2_rel_rx_pkt;
 	cbs.tx_comp_cb = qed_iwarp_ll2_comp_tx_pkt;
 	cbs.tx_release_cb = qed_iwarp_ll2_rel_tx_pkt;
+	cbs.slowpath_cb = NULL;
 	cbs.cookie = p_hwfn;
 
 	memset(&data, 0, sizeof(data));
-- 
2.20.1

