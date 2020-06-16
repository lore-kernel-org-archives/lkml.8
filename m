Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F80214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322402;
	bh=G3+7YwfmCftXoGAKSqvknHj6X2bwZy+Mwn8MdcTJ/ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GHk0fJM9D5IVBM/jj6sDEt49JbSNnbQlMA82TtH3eBuOldCGLCV/ZoS3EDE1dbStr
	 gxlkGA7AfSiywtwD82LmcpOI45qGx4qFsL7z2QV9ufWd/VNipmDtxncuzPlGPUKjxP
	 5Ii+kiDgDHtXEvTl/w+aAuUwLdDg9cK/YQBEKlOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgFPPqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbgFPPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:46:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 122E121473;
        Tue, 16 Jun 2020 15:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322391;
        bh=G3+7YwfmCftXoGAKSqvknHj6X2bwZy+Mwn8MdcTJ/ak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b/nF4PE+seUdkgnNgvsp46MpVVX9YIDELl2DL+DuhlNpNSlURC0v8W5jtznoSw36N
         yUFhv08hjNv5RqTP+0a6ohfJ/s5ASdON7bXJj5oYAZ9NXlHF8bhrupme10jVShaMrT
         zP5rFYghg3U8i7HPZ94wFW/E8We5e4ceOFw99G94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Valentin Longchamp <valentin@longchamp.me>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.7 113/163] net: sched: export __netdev_watchdog_up()
Date:   Tue, 16 Jun 2020 17:34:47 +0200
Message-Id: <20200616153112.216801135@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Valentin Longchamp <valentin@longchamp.me>

[ Upstream commit 1a3db27ad9a72d033235b9673653962c02e3486e ]

Since the quiesce/activate rework, __netdev_watchdog_up() is directly
called in the ucc_geth driver.

Unfortunately, this function is not available for modules and thus
ucc_geth cannot be built as a module anymore. Fix it by exporting
__netdev_watchdog_up().

Since the commit introducing the regression was backported to stable
branches, this one should ideally be as well.

Fixes: 79dde73cf9bc ("net/ethernet/freescale: rework quiesce/activate for ucc_geth")
Signed-off-by: Valentin Longchamp <valentin@longchamp.me>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_generic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -464,6 +464,7 @@ void __netdev_watchdog_up(struct net_dev
 			dev_hold(dev);
 	}
 }
+EXPORT_SYMBOL_GPL(__netdev_watchdog_up);
 
 static void dev_watchdog_up(struct net_device *dev)
 {


