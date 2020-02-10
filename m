Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF1DC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7292B20715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340989;
	bh=BSn5R7azljg7e9o9BU85gK//ULJ7l3w8oNS873dz39k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xWDuEFdTYFiNUO13UHz93ivcIo/YAlmLeoeHwZTc3AFgha/lYoU/IPYNVYFU0O0XG
	 w2CpEDaxlmG0XOQ4FE4n6NAeMMnSqGY4OT9aNce2ddrVTK5Lpy3cFR6F4gStSQZcWg
	 Yd5AH3PTUnvL81x09TfpT9sFhix2r55v6VCxTGP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731162AbgBJNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:23:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:58588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728693AbgBJMhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:37:16 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A4B02080C;
        Mon, 10 Feb 2020 12:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338236;
        bh=BSn5R7azljg7e9o9BU85gK//ULJ7l3w8oNS873dz39k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7FtrD83TyQiU2A8KmkEIvicQKBM6AXV5izQ+mhZGHovJ703x9xWklcc3OF0DPwp5
         wX3PLwzCe4poKC3U2juRiIdkprre07Ld5CaJs/RhdUqeAZScK0XUMuPfwRJlCVJgFG
         EleJ/gFwDvYggveClEndVVGcBFtLtNZHRW//Q9Wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yurii Monakov <monakov.y@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 5.4 083/309] PCI: keystone: Fix link training retries initiation
Date:   Mon, 10 Feb 2020 04:30:39 -0800
Message-Id: <20200210122413.814917714@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yurii Monakov <monakov.y@gmail.com>

commit 6df19872d881641e6394f93ef2938cffcbdae5bb upstream.

ks_pcie_stop_link() function does not clear LTSSM_EN_VAL bit so
link training was not triggered more than once after startup.
In configurations where link can be unstable during early boot,
for example, under low temperature, it will never be established.

Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
Signed-off-by: Yurii Monakov <monakov.y@gmail.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Andrew Murray <andrew.murray@arm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/dwc/pci-keystone.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -510,7 +510,7 @@ static void ks_pcie_stop_link(struct dw_
 	/* Disable Link training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
-	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+	ks_pcie_app_writel(ks_pcie, CMD_STATUS, val);
 }
 
 static int ks_pcie_start_link(struct dw_pcie *pci)


