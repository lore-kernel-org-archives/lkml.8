Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D8C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAD12076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587046195;
	bh=loUU20ztwIoFz/Mxs45552YufFMlx6rhP2yuxWPAxAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q38d6rhiLKFufEsuWGNDZ5fgF99ayqVyEVr7XAoN2SWJqCiqE1lfCmHMQOhtuIVWy
	 71CVslJWfaSIH+LMlMFHDt7QFDp/S362odgeNvcqekDiyKATQ98HE2DIo8YXpz8afJ
	 9w/sF8vYrtsuycn/scCzr8aFlaNPLWxb13xbnpvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393330AbgDPOJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898575AbgDPNqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:46:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91F1021974;
        Thu, 16 Apr 2020 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044782;
        bh=loUU20ztwIoFz/Mxs45552YufFMlx6rhP2yuxWPAxAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WXFKGAcA2PBAEt4z4SJhdtqINc8aiyWqhGBdf55jPFL87sAFswlOUEc9zIF5VS/r6
         WsrCE0TshpOZ6JONMLjPOpNWjJ7aRnZUjEXc6dTxn2zcw4OxbbOuyC8eAZHjZ7bF2V
         Tlm0jJ5TdYgAIubB7xQxT4VmH7GR1o2NraLWwYco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yicong Yang <yangyicong@hisilicon.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.4 100/232] PCI/ASPM: Clear the correct bits when enabling L1 substates
Date:   Thu, 16 Apr 2020 15:23:14 +0200
Message-Id: <20200416131327.565734635@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

commit 58a3862a10a317a81097ab0c78aecebabb1704f5 upstream.

In pcie_config_aspm_l1ss(), we cleared the wrong bits when enabling ASPM L1
Substates.  Instead of the L1.x enable bits (PCI_L1SS_CTL1_L1SS_MASK, 0xf), we
cleared the Link Activation Interrupt Enable bit (PCI_L1SS_CAP_L1_PM_SS,
0x10).

Clear the L1.x enable bits before writing the new L1.x configuration.

[bhelgaas: changelog]
Fixes: aeda9adebab8 ("PCI/ASPM: Configure L1 substate settings")
Link: https://lore.kernel.org/r/1584093227-1292-1-git-send-email-yangyicong@hisilicon.com
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: stable@vger.kernel.org	# v4.11+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/pcie/aspm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -742,9 +742,9 @@ static void pcie_config_aspm_l1ss(struct
 
 	/* Enable what we need to enable */
 	pci_clear_and_set_dword(parent, up_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 	pci_clear_and_set_dword(child, dw_cap_ptr + PCI_L1SS_CTL1,
-				PCI_L1SS_CAP_L1_PM_SS, val);
+				PCI_L1SS_CTL1_L1SS_MASK, val);
 }
 
 static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)


