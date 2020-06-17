Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD53C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2107721789
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592419679;
	bh=d7ylVfQ7C8f2oiLX16FaR4UvGdVUfh/XyCv910N2yMQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=WYtKtD9GeSYFNDeyo3th7GP7X3BZ7A8pTpU5kcNJkhG5IA0LaRduFQETVJ4knqbng
	 cSCV5augmecHwTcSGyOpMkSOSDxlmmwgEbnK16h0tWRRocWwn0cKV3l+hdO2+8Qxg/
	 42puKddhELMY3rT5BH40/LXkAPT0ZgtSrQ4BSauQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgFQSr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:47:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727015AbgFQSr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:47:57 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB3DC206DB;
        Wed, 17 Jun 2020 18:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592419677;
        bh=d7ylVfQ7C8f2oiLX16FaR4UvGdVUfh/XyCv910N2yMQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Oe3lqD5tc7ICJ0ZaE02Nynb15FVm8s2kKNBfgWHYI4crwrnNU5QtTFNXiQtTRro1L
         48d81RfPM9qt5MLMGAkP+DgIWYaEI6CendR2lnGRBP+b071ivNt8pZszGY+J4Lxg4R
         C4YNp14OmGBjB+7yNFngyvJxeZD3+k5LmUwrVFbo=
Date:   Wed, 17 Jun 2020 13:53:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] enetc: Use struct_size() helper in kzalloc()
Message-ID: <20200617185317.GA623@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 298c55786fd9..61dbf19075fb 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1687,7 +1687,7 @@ int enetc_ioctl(struct net_device *ndev, struct ifreq *rq, int cmd)
 int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 {
 	struct pci_dev *pdev = priv->si->pdev;
-	int size, v_tx_rings;
+	int v_tx_rings;
 	int i, n, err, nvec;
 
 	nvec = ENETC_BDR_INT_BASE_IDX + priv->bdr_int_num;
@@ -1702,15 +1702,13 @@ int enetc_alloc_msix(struct enetc_ndev_priv *priv)
 
 	/* # of tx rings per int vector */
 	v_tx_rings = priv->num_tx_rings / priv->bdr_int_num;
-	size = sizeof(struct enetc_int_vector) +
-	       sizeof(struct enetc_bdr) * v_tx_rings;
 
 	for (i = 0; i < priv->bdr_int_num; i++) {
 		struct enetc_int_vector *v;
 		struct enetc_bdr *bdr;
 		int j;
 
-		v = kzalloc(size, GFP_KERNEL);
+		v = kzalloc(struct_size(v, tx_ring, v_tx_rings), GFP_KERNEL);
 		if (!v) {
 			err = -ENOMEM;
 			goto fail;
-- 
2.27.0

