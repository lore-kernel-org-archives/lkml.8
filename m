Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31E1C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6E320657
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684726;
	bh=pQ16N8e2LiWEf96sWV/dqGe0lIXWe2ZQI7wtOvW25Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZdTpfqKgZmcHZWecrTQoHiRb6LqYz7jgGMgEfdPWUF/QG+ga+FeFrb0jlk6L1oQOJ
	 3tzHqk8rMf0iG/c3OrFkTt+JyxUrAWR3NNxaLk1FlE32kx0fgMiNXSB0UHPZ8rs5DA
	 vVv0nb0lYNZtr0/KcrGeqD6zF8PmSiFpA4T5v6FY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389699AbgHQRSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:18:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729355AbgHQQPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:15:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34CFA20578;
        Mon, 17 Aug 2020 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680919;
        bh=pQ16N8e2LiWEf96sWV/dqGe0lIXWe2ZQI7wtOvW25Ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qT68V3+RCWZLrg37DPWwd88Ubm4sVsBb01cx3s4wA1VfC6IkeZ2V+gmjlZEGG4l4G
         fzY/dHe9GIL3EO1x2kjJ5ARA/UXeRurD2tHHKVFcqYd4a4D+D3lxe2xeyFd452homF
         sAzi4q3yoodJtESzltt/MqOAwdty4JM1ZSgX6D9A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 111/168] PCI: Release IVRS table in AMD ACS quirk
Date:   Mon, 17 Aug 2020 17:17:22 +0200
Message-Id: <20200817143739.234115972@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hanjun Guo <guohanjun@huawei.com>

[ Upstream commit 090688fa4e448284aaa16136372397d7d10814db ]

The acpi_get_table() should be coupled with acpi_put_table() if the mapped
table is not used at runtime to release the table mapping.

In pci_quirk_amd_sb_acs(), IVRS table is just used for checking AMD IOMMU
is supported, not used at runtime, so put the table after using it.

Fixes: 15b100dfd1c9 ("PCI: Claim ACS support for AMD southbridge devices")
Link: https://lore.kernel.org/r/1595411068-15440-1-git-send-email-guohanjun@huawei.com
Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f856657dac22..9129ccd593d10 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4334,6 +4334,8 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	acpi_put_table(header);
+
 	/* Filter out flags not applicable to multifunction */
 	acs_flags &= (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
 
-- 
2.25.1



