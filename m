Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9371C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC15624680
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996647;
	bh=j4koRJ49R9/AKxvnyrRZo35HoCjp+RRH2+npINBK69E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qNJ+lU4Ckelz2tGbg3kpqMhrXKQK0B0yV/7hJ03M0/nB0/75ssvA+cttTCemsRPCD
	 ekM4yRawpURs1c8vo/wT30YQ3/oIrYhadCeyi85oZe2P3l0QtCX5FYUR5FlNGhZmV/
	 8ED/SbtiNeFMAzNBB8e+oDsvKfckG4ytUAi3phhs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgANKKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:10:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:44792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731677AbgANKKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6624320678;
        Tue, 14 Jan 2020 10:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996637;
        bh=j4koRJ49R9/AKxvnyrRZo35HoCjp+RRH2+npINBK69E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2LQCHhEf6Ck2I/27gcIhFY83X70+WzatRWzKKiqe5a48B3iUj8SdVFdYl7KGepKr
         e2NhMg8YPyaXNHORPNrV/gHrtdieNCH/x2yBOezNE/BiNo0kldleBxCDS23LEY878I
         vZ+s9mWRea7SYAcTYsa9eRJv5i3cDzCJiVTB64zM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 29/39] mwifiex: pcie: Fix memory leak in mwifiex_pcie_alloc_cmdrsp_buf
Date:   Tue, 14 Jan 2020 11:02:03 +0100
Message-Id: <20200114094345.309549224@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit db8fd2cde93227e566a412cf53173ffa227998bc upstream.

In mwifiex_pcie_alloc_cmdrsp_buf, a new skb is allocated which should be
released if mwifiex_map_pci_memory() fails. The release is added.

Fixes: fc3314609047 ("mwifiex: use pci_alloc/free_consistent APIs for PCIe")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Acked-by: Ganapathi Bhat <gbhat@marvell.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/marvell/mwifiex/pcie.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -1022,8 +1022,10 @@ static int mwifiex_pcie_alloc_cmdrsp_buf
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE))
+				   PCI_DMA_FROMDEVICE)) {
+		kfree_skb(skb);
 		return -1;
+	}
 
 	card->cmdrsp_buf = skb;
 


