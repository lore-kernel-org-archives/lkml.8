Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592EC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC24D20674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410022;
	bh=zUz7+cbvru6J3ZoKSzgkhH/BPMD8HQ9aHJfJ1z6I4/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0AOFDW4sLqa4xo5oZhNKqk8dyCWMQ9CzKZ/Mq9XG5yEMceYW7EHqnNCU0ZRTSK9s
	 bu3uNUYmX3TEassBzM20CQ5AF7ZfR6/yUwIOoJ/yrU7DQG9BSNQ+pDd1FCpabyxK19
	 iSht9vYZ5ku3I+/b2hmyaboIxttKpdZeP23kqTNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgA3Sqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:57092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgA3Sqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238EB205F4;
        Thu, 30 Jan 2020 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410010;
        bh=zUz7+cbvru6J3ZoKSzgkhH/BPMD8HQ9aHJfJ1z6I4/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U058y7nm5OarfZYi4+jktjlK1K1X0Mqs9qx2p9oPJLKmG84AXcUuJgR4QdrPIpq5J
         a354ICggPQd5TbMUkY9wST6eUwPwqIdu2+iDjDMRtWg35Z++pa9dpP51/T8yPag8cA
         yo9xDzgr2ASSMxo6C68SmvDjrfGDBs2ydswe7QtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 4.19 03/55] usb: dwc3: pci: add ID for the Intel Comet Lake -V variant
Date:   Thu, 30 Jan 2020 19:38:44 +0100
Message-Id: <20200130183609.230299776@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit f5ae8869095552e3396ee3e404f9586cc6a828f0 upstream.

There is one more Comet Lake PCH variant, CML-V, that has
its own PCI ID.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200117093033.48616-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/dwc3/dwc3-pci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -34,6 +34,7 @@
 #define PCI_DEVICE_ID_INTEL_GLK			0x31aa
 #define PCI_DEVICE_ID_INTEL_CNPLP		0x9dee
 #define PCI_DEVICE_ID_INTEL_CNPH		0xa36e
+#define PCI_DEVICE_ID_INTEL_CNPV		0xa3b0
 #define PCI_DEVICE_ID_INTEL_ICLLP		0x34ee
 
 #define PCI_INTEL_BXT_DSM_GUID		"732b85d5-b7a7-4a1b-9ba0-4bbd00ffd511"
@@ -340,6 +341,9 @@ static const struct pci_device_id dwc3_p
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPH),
 	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_CNPV),
+	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
+
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ICLLP),
 	  (kernel_ulong_t) &dwc3_pci_intel_properties, },
 


