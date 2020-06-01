Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E7BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7755206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037893;
	bh=nbCUBTl7HqOmBiS2sxRiN0u3YMvEJ2dEag755at0zUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WzSUguzr2cEWB4VEBmpNI0m376JJ58FFL4/caFkeLJ4Gxs6XBZ64scI/LuZNy7OIs
	 USPqXvq9vkKaBLmExfM7GcX4rXohAGkf3iN+lMdf+dzVLMD7kL0wczt8oTkPWfMB5R
	 JWvr2Hnln3CnaIobpklekxEOuXr1EQwRpk4IJIww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFAS6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:58:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgFAR7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:59:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC0F207D0;
        Mon,  1 Jun 2020 17:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034364;
        bh=nbCUBTl7HqOmBiS2sxRiN0u3YMvEJ2dEag755at0zUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKSXCs0wxhMaEfXLA6fbve2018hZO6nhj3M9qqzldzJDU/HHyhC4TTozqedPUliLh
         /00LOojGRImiLdJpONvv+vuQ8AE4TDTK7hbzrnCdqlfvzjrBuqNboaiog88rPNpYh2
         6OiKUTXIH5Zqi+i1V2ctOwS4EQNRCHFzc1kOe/ZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 61/61] net: hns: Fixes the missing put_device in positive leg for roce reset
Date:   Mon,  1 Jun 2020 19:54:08 +0200
Message-Id: <20200601174022.719789295@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174010.316778377@linuxfoundation.org>
References: <20200601174010.316778377@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Salil Mehta <salil.mehta@huawei.com>

commit 4d96e13ee9cd1f7f801e8c7f4b12f09d1da4a5d8 upstream.

This patch fixes the missing device reference release-after-use in
the positive leg of the roce reset API of the HNS DSAF.

Fixes: c969c6e7ab8c ("net: hns: Fix object reference leaks in hns_dsaf_roce_reset()")
Reported-by: John Garry <john.garry@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2867,6 +2867,9 @@ int hns_dsaf_roce_reset(struct fwnode_ha
 		dsaf_set_bit(credit, DSAF_SBM_ROCEE_CFG_CRD_EN_B, 1);
 		dsaf_write_dev(dsaf_dev, DSAF_SBM_ROCEE_CFG_REG_REG, credit);
 	}
+
+	put_device(&pdev->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(hns_dsaf_roce_reset);


