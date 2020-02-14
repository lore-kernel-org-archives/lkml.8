Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A65BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BAF20637
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700924;
	bh=ONxDg8UBSF0eZbElzoFn8SmqwlRSm4oFuWTBHP90bZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nzVz/tivTreQSUM/57Ex2JHX/8rxeUifQUtE9ipTUK+3q5mZonETM3NIybcbQ1Md/
	 p4FXojQUJhwwfUeNnuwIsMdLJXBzXSakigLkVnE+06wPSh4OOVFuvd3LIQTCNiX/2N
	 nciSYpJeyfqgE8uqfuZ82t3/J1CoZy94+Y6B5uX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392030AbgBNRWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391423AbgBNQKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:10:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ECA02468E;
        Fri, 14 Feb 2020 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696611;
        bh=ONxDg8UBSF0eZbElzoFn8SmqwlRSm4oFuWTBHP90bZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7LhNgIGUJaCufgKXjtk/q4x7Dn2JMm77Bx9bBkD9IWXV6I8X24sTELRau92EQ4c0
         51+KDzeH+uQxEGesWFRUjz6Nm3FADv75xtwULQvuGn+k2ZoEq/bGVW12pUGAmxbA+b
         /23X90yo1v9+HgLL5ob7s+yC3HVIzs79adGqouA8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongdong Liu <liudongdong3@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 394/459] PCI/AER: Initialize aer_fifo
Date:   Fri, 14 Feb 2020 11:00:44 -0500
Message-Id: <20200214160149.11681-394-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongdong Liu <liudongdong3@huawei.com>

[ Upstream commit d95f20c4f07020ebc605f3b46af4b6db9eb5fc99 ]

Previously we did not call INIT_KFIFO() for aer_fifo.  This leads to
kfifo_put() sometimes returning 0 (queue full) when in fact it is not.

It is easy to reproduce the problem by using aer-inject:

  $ aer-inject -s :82:00.0 multiple-corr-nonfatal

The content of the multiple-corr-nonfatal file is as below:

  AER
  COR RCVR
  HL 0 1 2 3
  AER
  UNCOR POISON_TLP
  HL 4 5 6 7

Fixes: 27c1ce8bbed7 ("PCI/AER: Use kfifo for tracking events instead of reimplementing it")
Link: https://lore.kernel.org/r/1579767991-103898-1-git-send-email-liudongdong3@huawei.com
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe4..271aecfbc3bf3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1387,6 +1387,7 @@ static int aer_probe(struct pcie_device *dev)
 		return -ENOMEM;
 
 	rpc->rpd = port;
+	INIT_KFIFO(rpc->aer_fifo);
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-- 
2.20.1

