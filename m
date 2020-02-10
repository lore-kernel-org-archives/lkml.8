Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E6620708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339100;
	bh=tn8iULpUIvmQKMZEkhnFrvgQdiV4OGiwhWmDd32Pi2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aFg8Hgq2zKuXbBpfXwSWVGv5lE3uwEuB8Avhk/BKqurok8+1/ud98614yBb8Os2s/
	 1bk5I+dUMp/Mb46MY7ZjlRIn8GgomyrcpkydxjYjZhGMT+Vr/0KOxZPrw9D7RW/IGK
	 nYz+MWsvLwLBu2ckTJTRHxZKnt08TJj9JjnUGupk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgBJMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:43:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbgBJMj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:39:56 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A82F020873;
        Mon, 10 Feb 2020 12:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338395;
        bh=tn8iULpUIvmQKMZEkhnFrvgQdiV4OGiwhWmDd32Pi2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTe2IcT5nAV3JGzdR1x2IX/Jn57/HMk0YcxTFjSj/jg7zOqQBp+sEXYEYj7f5faPG
         i8HyIKuZ9FSWW5fiN8AuDxjM4ifXoALhm6c+yROfsg+9MtDkNBSLzZED4/mCYR9J3z
         M7dIpn2Tsf3seycSKouNOjAslvIh6tQ81/ebA/1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Engraf <david.engraf@sysgo.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>
Subject: [PATCH 5.5 090/367] PCI: tegra: Fix return value check of pm_runtime_get_sync()
Date:   Mon, 10 Feb 2020 04:30:03 -0800
Message-Id: <20200210122432.684435154@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Engraf <david.engraf@sysgo.com>

commit 885199148442f56b880995d703d2ed03b6481a3c upstream.

pm_runtime_get_sync() returns the device's usage counter. This might
be >0 if the device is already powered up or CONFIG_PM is disabled.

Abort probe function on real error only.

Fixes: da76ba50963b ("PCI: tegra: Add power management support")
Link: https://lore.kernel.org/r/20191216111825.28136-1-david.engraf@sysgo.com
Signed-off-by: David Engraf <david.engraf@sysgo.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Andrew Murray <andrew.murray@arm.com>
Cc: stable@vger.kernel.org	# v4.17+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/controller/pci-tegra.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2798,7 +2798,7 @@ static int tegra_pcie_probe(struct platf
 
 	pm_runtime_enable(pcie->dev);
 	err = pm_runtime_get_sync(pcie->dev);
-	if (err) {
+	if (err < 0) {
 		dev_err(dev, "fail to enable pcie controller: %d\n", err);
 		goto teardown_msi;
 	}


