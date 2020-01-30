Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4C3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8A72082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409657;
	bh=8UATMqQyxFdcOdbOTav/gmv6dcroZNFWW+ct4tA/x4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F+xHMDsnZdPF5uptRN2FuFN9mGBOQ32VahMXol09H+iAuDEm9nurXbDkEuE24jrcU
	 4sSPryEChHKoCsILaEkDDUfTER+7MiXcNKnHV4Wdmf7nPi0ZcJcO8nWQpl1o5NhRs2
	 LUCqVhGZuuTBeVSQDDwB5JYgvCPgRGq+aEfYM7HQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgA3Sk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgA3Skv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:40:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCCC6214DB;
        Thu, 30 Jan 2020 18:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409651;
        bh=8UATMqQyxFdcOdbOTav/gmv6dcroZNFWW+ct4tA/x4A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NrKe5NZTl42x0yzUZ6UmRGyYKxvbfuD3Nm+yhS51WlgPkf4SciTHiPTPNyFelpRfd
         0MDQzYiUEqHorA2sdvaXxinl3aHN7jpfcAWXxXsrno4dTTm8ccx5GevnDY3mbLk5nm
         wbAxMlUl/kvEbrpGABkWfgd250hSdvPUTLVsHkas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.5 05/56] usb: host: xhci-tegra: set MODULE_FIRMWARE for tegra186
Date:   Thu, 30 Jan 2020 19:38:22 +0100
Message-Id: <20200130183610.020120122@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Robinson <pbrobinson@gmail.com>

commit e1f236efd9c579a29d7df75aa052127d0d975267 upstream.

Set the MODULE_FIRMWARE for tegra186, it's registered for 124/210 and
ensures the firmware is available at the appropriate time such as in
the initrd, else if the firmware is unavailable the driver fails with
the following errors:

tegra-xusb 3530000.usb: Direct firmware load for nvidia/tegra186/xusb.bin failed with error -2
tegra-xusb 3530000.usb: failed to request firmware: -2
tegra-xusb 3530000.usb: failed to load firmware: -2
tegra-xusb: probe of 3530000.usb failed with error -2

Fixes: 5f9be5f3f899 ("usb: host: xhci-tegra: Add Tegra186 XUSB support")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200120141910.116097-1-pbrobinson@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-tegra.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -1432,6 +1432,7 @@ MODULE_FIRMWARE("nvidia/tegra210/xusb.bi
 
 static const char * const tegra186_supply_names[] = {
 };
+MODULE_FIRMWARE("nvidia/tegra186/xusb.bin");
 
 static const struct tegra_xusb_phy_type tegra186_phy_types[] = {
 	{ .name = "usb3", .num = 3, },


