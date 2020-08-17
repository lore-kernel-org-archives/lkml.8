Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B8AC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F3932072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688019;
	bh=8KpMLRgKy4V9J9Bkhv6V9BT6iD7AHSDPSUWIhzo9AOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EWAZW69bsVOV1cY/ZAg1Czr3Q3HXj5mvrnRnWPe9ownR2Dbq8zxESviA1PBlMbO5
	 Ui+XZN6eL4UIIysPIgL9AjizEK0TJ21nh3wWlssj1px0kt92jS8Q9aPj4JuYkNqVfi
	 9JEKJjHsb4RXbvV4s+eAem6KQCfN1BqR192nhN5U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390520AbgHQSMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388405AbgHQQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:07:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08E0E20658;
        Mon, 17 Aug 2020 16:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680432;
        bh=8KpMLRgKy4V9J9Bkhv6V9BT6iD7AHSDPSUWIhzo9AOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RdTwWcmyOvc3yLv+gqiShI/3mkaQRF/mBbLgN6CbPw+XRfge+dnhDaK6T7Lywqmao
         mHrwJ9SXtdQFOSSdUuCFvrkf/eLQO81jhzxNBDdSaX1mKnz/dim0OKJg6GUy4zdm00
         rlzvsygLSXsdwEw4iObdJuiKEoVicQ4aG+M2hxG4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 184/270] PCI: Release IVRS table in AMD ACS quirk
Date:   Mon, 17 Aug 2020 17:16:25 +0200
Message-Id: <20200817143804.973769828@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index 4ac4b28e0ebbf..9bc0f321aaf0e 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4446,6 +4446,8 @@ static int pci_quirk_amd_sb_acs(struct pci_dev *dev, u16 acs_flags)
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
+	acpi_put_table(header);
+
 	/* Filter out flags not applicable to multifunction */
 	acs_flags &= (PCI_ACS_RR | PCI_ACS_CR | PCI_ACS_EC | PCI_ACS_DT);
 
-- 
2.25.1



