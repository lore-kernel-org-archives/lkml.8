Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F123CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19442168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583477;
	bh=kKtW0cysQMlch9BesHXTmU1o6qmP2t/pjypcyBdwX8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G81lL0dMvsBwKnECSlKXZgzltSNuBlT+GrCz0ue7lQ0P9LOY6Fwamob9fLqWypuvH
	 tYUF0jbRAuxWvVrDmg3qI/IIYshXQrvn+JYQvwA/0ESXCFwpez/c/XXjJrGCCnxfOR
	 0vEhHx1NEZf8S0E9x1/m38SFAqnLGECf4atoZ0go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390809AbgFSQRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390800AbgFSPCL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B952186A;
        Fri, 19 Jun 2020 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578931;
        bh=kKtW0cysQMlch9BesHXTmU1o6qmP2t/pjypcyBdwX8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4X1PjBfEl1la10x3+touqYlT4MtFJw2QXTtL54OZT1JB4Nl1ikjVWS0Xwr7o5krO
         3zHE4vmPdCWsYqogRyuwvlgRUIlA6sETSGIY2lu4YGjw57OcxIKDuYmyYFBe96hrHq
         o+CeozRjnw704M2iwsa9iOhlr6baz+fJ6Yu1wne8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Minghuan Lian <minghuan.lian@nxp.com>,
        Zhiqiang Hou <zhiqiang.hou@nxp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 211/267] misc: pci_endpoint_test: Add the layerscape EP device support
Date:   Fri, 19 Jun 2020 16:33:16 +0200
Message-Id: <20200619141658.857876166@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

[ Upstream commit 85cef374d0ba93b8a2bd24850b97c1b34c666ccb ]

Add the layerscape EP device support in pci_endpoint_test driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
Reviewed-by: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 727dc6ec427d..2b3d61d565f0 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -795,6 +795,7 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
 	{ }
 };
-- 
2.25.1



