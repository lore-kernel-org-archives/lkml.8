Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499F9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D322054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923802;
	bh=NF9kcntLa0PLq0NPePJuMziGeFLz7qScJquirh2Md/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xVM0gYnmVdfFr/i6VMPhVpSti87Aofeg+dMTuRjTkiF6GS0f49qLGAGNkESo4Po3N
	 EZcl4m17U88vpXoPidqaZ6KEfh+CUxjjecf6FWX4cOYXwpdEKLjMLE43Rb8VkJZpC3
	 Swh+tnh0PV2JYj9AuzZsXs5CngIDoohbPUNRqQz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgHTLnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbgHTKEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:04:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 217C520738;
        Thu, 20 Aug 2020 10:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917839;
        bh=NF9kcntLa0PLq0NPePJuMziGeFLz7qScJquirh2Md/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJG8A0/Kvf6joVB2q6fSAb/I1GeCagk5xvJ9WAhEHP4E6lsSkVxua5gGUI4/TEDF8
         M2C41MSle7Vl3+lWGz4XVLHXUbJrY3X/nhpaE0vrzKTwAtX1mIATo87dB2akGGuEjV
         cIRjUu3HMAK1hd7uVLmO766/4Nr1TXpYMzmQYoaM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan McDowell <noodles@earth.li>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 177/212] net: ethernet: stmmac: Disable hardware multicast filter
Date:   Thu, 20 Aug 2020 11:22:30 +0200
Message-Id: <20200820091611.330998100@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan McDowell <noodles@earth.li>

commit df43dd526e6609769ae513a81443c7aa727c8ca3 upstream.

The IPQ806x does not appear to have a functional multicast ethernet
address filter. This was observed as a failure to correctly receive IPv6
packets on a LAN to the all stations address. Checking the vendor driver
shows that it does not attempt to enable the multicast filter and
instead falls back to receiving all multicast packets, internally
setting ALLMULTI.

Use the new fallback support in the dwmac1000 driver to correctly
achieve the same with the mainline IPQ806x driver. Confirmed to fix IPv6
functionality on an RB3011 router.

Cc: stable@vger.kernel.org
Signed-off-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -362,6 +362,7 @@ static int ipq806x_gmac_probe(struct pla
 	plat_dat->has_gmac = true;
 	plat_dat->bsp_priv = gmac;
 	plat_dat->fix_mac_speed = ipq806x_gmac_fix_mac_speed;
+	plat_dat->multicast_filter_bins = 0;
 
 	err = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (err)


