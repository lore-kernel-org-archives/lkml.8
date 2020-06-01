Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FA7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 678082065C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035189;
	bh=RSAkl/Gbqg263gmGhygdvLWNJJd3t04fVa8TLbsyjjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLG1hOwxjz5oqcqvpmzu54H3bL3CjHvlUTaHXRVHhjVHLAu7cYnpe/afJHsDAGJRH
	 VTOj0qKY3bkh7anwPd0AwVXEvzC+EqsCYa5CvCRq3qcCTPryx2Z/JuZ3vHoL2hjkR0
	 cu+C6F6ftzE+8ew3KnRQKeaTfwTRtF9/ebiPx96U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbgFASNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731289AbgFASM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:12:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B272065C;
        Mon,  1 Jun 2020 18:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035177;
        bh=RSAkl/Gbqg263gmGhygdvLWNJJd3t04fVa8TLbsyjjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xj0YMrV9xwIb68C+m/ZC2VyYirRz+NAmWFY90MjRaAuO/8RrL3oOEOvyo06nzjdtA
         VuMSGqDDCKYAn7j/PQxATAbyeutsgmF+4jDlpTDmbxM+zNrjofDeDaRVARDSblPWdf
         hyhXpVgUajvM0KlpCTDK+bKtKrkmlmUhFfVqe6Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 007/177] net: ethernet: ti: cpsw: fix ASSERT_RTNL() warning during suspend
Date:   Mon,  1 Jun 2020 19:52:25 +0200
Message-Id: <20200601174049.192949405@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit 4c64b83d03f4aafcdf710caad994cbc855802e74 ]

vlan_for_each() are required to be called with rtnl_lock taken, otherwise
ASSERT_RTNL() warning will be triggered - which happens now during System
resume from suspend:
  cpsw_suspend()
  |- cpsw_ndo_stop()
    |- __hw_addr_ref_unsync_dev()
      |- cpsw_purge_all_mc()
         |- vlan_for_each()
            |- ASSERT_RTNL();

Hence, fix it by surrounding cpsw_ndo_stop() by rtnl_lock/unlock() calls.

Fixes: 15180eca569b ("net: ethernet: ti: cpsw: fix vlan mcast")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1752,11 +1752,15 @@ static int cpsw_suspend(struct device *d
 	struct cpsw_common *cpsw = dev_get_drvdata(dev);
 	int i;
 
+	rtnl_lock();
+
 	for (i = 0; i < cpsw->data.slaves; i++)
 		if (cpsw->slaves[i].ndev)
 			if (netif_running(cpsw->slaves[i].ndev))
 				cpsw_ndo_stop(cpsw->slaves[i].ndev);
 
+	rtnl_unlock();
+
 	/* Select sleep pin state */
 	pinctrl_pm_select_sleep_state(dev);
 


