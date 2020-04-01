Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81007C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F3920BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759400;
	bh=nhJQxQCFLz20+3m0GlqbdNdv+16PiSrAntecgskSFgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2dI32mwTa2ENabMSr9xnHOERvtF8mojxDeX0qybpeexSMoaEwLMV+BXAwqO5NiPMk
	 zmvhQ+/kzl9WKT0jic/OjLoBhr9mhn/9UWtkImvuMtMUHVZDNa32suuoNtZ/muuEyK
	 cqiMycNkkQtMP11FBGEwSrTOYb3KwwYg+HU4D1yw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbgDAQnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:43:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388059AbgDAQnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:43:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B873520787;
        Wed,  1 Apr 2020 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759396;
        bh=nhJQxQCFLz20+3m0GlqbdNdv+16PiSrAntecgskSFgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTD8gst1Y0uWQqF7QRBMRZIZvCZLbOWfxwsdpSkNN0h1wmmCIOje6X9ZWpyLfGkzt
         x3bHtfh4OHNbCEtwaRvNmn20zq6l8ZqOIClsyAOATTyAn2tMD8lJ2yHyCwSdBTsOM8
         z/QHcuPa5S2VGAs2wuPdtomFgK3wjCPIKyPe9Pfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, yangerkun <yangerkun@huawei.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 066/148] slcan: not call free_netdev before rtnl_unlock in slcan_open
Date:   Wed,  1 Apr 2020 18:17:38 +0200
Message-Id: <20200401161559.991409909@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

[ Upstream commit 2091a3d42b4f339eaeed11228e0cbe9d4f92f558 ]

As the description before netdev_run_todo, we cannot call free_netdev
before rtnl_unlock, fix it by reorder the code.

This patch is a 1:1 copy of upstream slip.c commit f596c87005f7
("slip: not call free_netdev before rtnl_unlock in slip_open").

Reported-by: yangerkun <yangerkun@huawei.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/slcan.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -621,7 +621,10 @@ err_free_chan:
 	tty->disc_data = NULL;
 	clear_bit(SLF_INUSE, &sl->flags);
 	slc_free_netdev(sl->dev);
+	/* do not call free_netdev before rtnl_unlock */
+	rtnl_unlock();
 	free_netdev(sl->dev);
+	return err;
 
 err_exit:
 	rtnl_unlock();


