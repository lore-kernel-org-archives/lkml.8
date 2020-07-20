Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436BCC4363A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1782722C9D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281137;
	bh=o0bUSa9r+WlA838mzYXVW27gR8YIWsM5ux2NTn9EUyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PLJUlk5FHXuVBkt8WftcwfMIvxlhe+u+au//6kAAsbWspwl6ZY2cDzcp1NaqWU4Iz
	 2ejB28PyYa8ZmW+1hZp3DDcoomExBGzZPVBjdHj94yxSYhgu9KOXluHBpqeGWkCzMO
	 XwxcxXxGRllZoO1p2RT9gKoaUdpLiyMEYPKRo8Cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgGTViz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:38:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgGTVi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:38:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A3022CAF;
        Mon, 20 Jul 2020 21:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281107;
        bh=o0bUSa9r+WlA838mzYXVW27gR8YIWsM5ux2NTn9EUyw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oN9fSIbzRym4Fwto8D9Xc1QWsF6f4DwwOS54tPT1jjB8Z8ILxRkItVX3ADj0ohPcu
         4BuTxd88uqcX253VyANetBqove16d9qj/HTrFQ0O0RgLKT7YJDdZpAT9SK7gje6iuf
         yFgAAbsYMsDXAdOpxGoLYzZzxT7aMHi8J2yGTGCw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 16/34] usb: dwc3: pci: add support for the Intel Jasper Lake
Date:   Mon, 20 Jul 2020 17:37:49 -0400
Message-Id: <20200720213807.407380-16-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213807.407380-1-sashal@kernel.org>
References: <20200720213807.407380-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

[ Upstream commit e25d1e8532c3d84f075deca1580a7d61e0f43ce6 ]

This patch adds the necessary PCI ID for Intel Jasper Lake
devices.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 47b7e83d90626..139474c3e77b1 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -39,6 +39,7 @@
 #define PCI_DEVICE_ID_INTEL_EHLLP		0x4b7e
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
+#define PCI_DEVICE_ID_INTEL_JSP			0x4dee
 
 #define PCI_INTEL_BXT_DSM_GUID		"732b85d5-b7a7-4a1b-9ba0-4bbd00ffd511"
 #define PCI_INTEL_BXT_FUNC_PMU_PWR	4
@@ -362,6 +363,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_TGPH),
 	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
+	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_NL_USB),
 	  (kernel_ulong_t) &dwc3_pci_amd_properties, },
 	{  }	/* Terminating Entry */
-- 
2.25.1

