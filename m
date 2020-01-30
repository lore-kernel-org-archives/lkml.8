Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD5DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B12214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410118;
	bh=9iG22UzrO86NfxLszAS2E7TuX2F/lsc6RrgcOzJYdCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wgQlCt3iggcWUmdhz63S8n+nWAn/bqI1FNzzuwC0zBLF19aDVclPXxjivdRBBxCU4
	 CK1FckqUAQog3z0Q7TWVP688197fkBP6tiRm1OySkAweiAzL73ql+oovNBXjJEK6or
	 EpahLxBMb4PUQfdRHSIpMYKs6sbaxV8B2Bk7aXAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgA3Ssh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbgA3Ssc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D7D62082E;
        Thu, 30 Jan 2020 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410111;
        bh=9iG22UzrO86NfxLszAS2E7TuX2F/lsc6RrgcOzJYdCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2L9APmnoc0P8mDeUoxYbJ5REi70rbcMvbYzW9/5tUbs6s23YSeoZdChF094ObTYA
         Kz4lsif24H2w52VKTkhg7pbOXDyKPqoohumpvjFqJCq3/X2LQLDoqmVTsW4pD/Hzb7
         bZlKbFX5U4ufOOq0MRyvgSf4P5y1m6J5KiWT013Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 49/55] rsi: fix memory leak on failed URB submission
Date:   Thu, 30 Jan 2020 19:39:30 +0100
Message-Id: <20200130183617.390724625@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 47768297481184932844ab01a86752ba31a38861 upstream.

Make sure to free the skb on failed receive-URB submission (e.g. on
disconnect or currently also due to a missing endpoint).

Fixes: a1854fae1414 ("rsi: improve RX packet handling in USB interface")
Cc: stable <stable@vger.kernel.org>     # 4.17
Cc: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -327,8 +327,10 @@ static int rsi_rx_urb_submit(struct rsi_
 			  rx_cb);
 
 	status = usb_submit_urb(urb, GFP_KERNEL);
-	if (status)
+	if (status) {
 		rsi_dbg(ERR_ZONE, "%s: Failed in urb submission\n", __func__);
+		dev_kfree_skb(skb);
+	}
 
 	return status;
 }


