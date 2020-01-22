Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42E0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E41124683
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686963;
	bh=VvSxBTUM2iQ3N+zapYL3JW57CkB2JGsoaIGUI7TyPSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ECkM1Yns9wjw9ylrS7yeU+koRMihaWB1XPOZRU+/Q44htvmP1ggbseFoM9S1BLfr8
	 DNLopyP0OY41YNFjnrMigNYDRG7jx1ec9IKcd+xVPW0wf/ss7OqTXzr0Vrftcdava/
	 r8/IGjKe3Cjm8TsZ2Pb5DNuBLkbG0Cb0i25iGGq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgAVJ4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:56:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:44940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729401AbgAVJcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:32:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8039C24698;
        Wed, 22 Jan 2020 09:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685535;
        bh=VvSxBTUM2iQ3N+zapYL3JW57CkB2JGsoaIGUI7TyPSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQQr3RmFt4l3uVlhR+fYgtYR9rj4GQ9m26eYPQKh4XP4pbufik3U6icdBYawV4Cad
         YkXUS5YGJmn2cRDPAbe71kR6vketFK+MDgJc5/xgwdhyhRdCHnFolm3dpv5h+FEalL
         LOQ8pFYQJl/FB7UfEeXttPH20kFQFUEMH+kn9yRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 53/76] net: stmmac: 16KB buffer must be 16 byte aligned
Date:   Wed, 22 Jan 2020 10:29:09 +0100
Message-Id: <20200122092758.756403838@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092751.587775548@linuxfoundation.org>
References: <20200122092751.587775548@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jose Abreu <Jose.Abreu@synopsys.com>

commit 8605131747e7e1fd8f6c9f97a00287aae2b2c640 upstream.

The 16KB RX Buffer must also be 16 byte aligned. Fix it.

Fixes: 7ac6653a085b ("stmmac: Move the STMicroelectronics driver")
Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/stmicro/stmmac/common.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -273,8 +273,8 @@ struct dma_features {
 	unsigned int enh_desc;
 };
 
-/* GMAC TX FIFO is 8K, Rx FIFO is 16K */
-#define BUF_SIZE_16KiB 16384
+/* RX Buffer size must be multiple of 4/8/16 bytes */
+#define BUF_SIZE_16KiB 16368
 #define BUF_SIZE_8KiB 8192
 #define BUF_SIZE_4KiB 4096
 #define BUF_SIZE_2KiB 2048


