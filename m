Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112FDC33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE36824676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578997003;
	bh=kB1L74TlvDMGZNdZbMZCzMOLo91EZxuBQcBTJaaGIwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHDaw5aOFy9ag/WVJByJRBEIIwdJwYzA3xTE/S3TqrLyf8hUMen+nhlhkag79IHS0
	 z/zB+3NxKn+sRPuXWcijA0ovusdWzPnki8KLZ7dWBsVLH2MXZIzszvP1lykQjDDXir
	 h1U6gjiadSw/K3cIYS/enuCVrsqx049aHD9cSqnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgANKIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731104AbgANKIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4B724679;
        Tue, 14 Jan 2020 10:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996530;
        bh=kB1L74TlvDMGZNdZbMZCzMOLo91EZxuBQcBTJaaGIwY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rs+WLyB4S0wUOBSo8mcjyjoF6Nmn6e4r+i0EVqcvpwwWxSqnGhsVcNhKW7nZLIKD4
         B0C+fIKm2SUa2bJN++w4CFTQV/ww4QcwcTUzQbkL5UtiMaPeAfWOPocQyyoJk8J+4E
         52laClrKp2UMaXEKgfyXqNX3rE12GVR2pEBKq7F8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ganapathi Bhat <gbhat@marvell.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.19 36/46] mwifiex: pcie: Fix memory leak in mwifiex_pcie_alloc_cmdrsp_buf
Date:   Tue, 14 Jan 2020 11:01:53 +0100
Message-Id: <20200114094347.405281500@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
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
@@ -1036,8 +1036,10 @@ static int mwifiex_pcie_alloc_cmdrsp_buf
 	}
 	skb_put(skb, MWIFIEX_UPLD_SIZE);
 	if (mwifiex_map_pci_memory(adapter, skb, MWIFIEX_UPLD_SIZE,
-				   PCI_DMA_FROMDEVICE))
+				   PCI_DMA_FROMDEVICE)) {
+		kfree_skb(skb);
 		return -1;
+	}
 
 	card->cmdrsp_buf = skb;
 


