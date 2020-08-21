Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0D0C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810FF20738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030460;
	bh=6AiJeu8UD5jdIPklU0UJ85alxQ5UPRtJBuOG4bUtfxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M/gukSIs5PMhvEhmu83GVlvMtz9y/p+zpPPcgNDIrUNETxAMDRFSBZXCVEK7zmK0T
	 Wjnujff2MX73F+pAkRls12Ppd+R+HztL1UtjBUaXKMDF9rC2i8JZfZFPsU4ilfNIDO
	 Rt21yiuJ3nd8djndO+NWn/VW1ODuE/+5eND175+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHURUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:20:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgHUQQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B4192224D;
        Fri, 21 Aug 2020 16:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026565;
        bh=6AiJeu8UD5jdIPklU0UJ85alxQ5UPRtJBuOG4bUtfxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1euNR5PjkRU24lbvLimBY0gknEh8yFfcH8p80Oc5BbuMfHQWxQGMZme7S/dRoSC71
         RTAnybr45WRBKhSlqt9dbSSYj/faK0bTteoJQYC9FleDx6Xf/I0S18tTCvrRYtoDKw
         Ds0EgRPBdxs/juoFI8sKM1vphT3XeeXWyU1qpgCw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 16/61] staging: rts5208: fix memleaks on error handling paths in probe
Date:   Fri, 21 Aug 2020 12:15:00 -0400
Message-Id: <20200821161545.347622-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit 11507bf9a8832741db69efd32bf09a2ab26426bf ]

rtsx_probe() allocates host, but does not free it on error handling
paths. The patch adds missed scsi_host_put().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Link: https://lore.kernel.org/r/20200623141230.7258-1-novikov@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rts5208/rtsx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index be0053c795b7a..937f4e732a75c 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -972,6 +972,7 @@ static int rtsx_probe(struct pci_dev *pci,
 	kfree(dev->chip);
 chip_alloc_fail:
 	dev_err(&pci->dev, "%s failed\n", __func__);
+	scsi_host_put(host);
 scsi_host_alloc_fail:
 	pci_release_regions(pci);
 	return err;
-- 
2.25.1

