Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87919C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C1B24964
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588943871;
	bh=roUaHz8MHMjmDB9ObLTQQ6lZmhETEMG/5A079nKtApI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LnMiNTndNgowdzBOPTKheyd3GcgPKvOueys7gScgcEjAKHxuNFOhEzCokI+CJnrQK
	 OKlBVBAMk7QNH9+Dxuc1RYQ/uPEJ6FvQgQ4Ts67gaB5pTLm5vjFqa5zy4HKz1W+NO8
	 k4onIltC22pxVceRek75aYc4NRbaJmtrgX3tZ2LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgEHMnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:43:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbgEHMna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:43:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA85324973;
        Fri,  8 May 2020 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941810;
        bh=roUaHz8MHMjmDB9ObLTQQ6lZmhETEMG/5A079nKtApI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdWsxKupw5ZJdVEkFUg19w60ZUJ/aN4UySMcHKlnHJqAB7YUwJz6HBkTVjYgCaHxi
         l2+tk4lwzyfpyCMa8vcwR6c2DP3joyCKCEPGyhfJKkFUVi/kyXf9IPkYDOZHQL0hjr
         Fm0X2hPv89dXCfwE/hV07xhFyxTTWmgS11ONCU4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 180/312] qede: uninitialized variable in qede_start_xmit()
Date:   Fri,  8 May 2020 14:32:51 +0200
Message-Id: <20200508123137.148201955@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

commit 810810ffb2f6d46365d0790bbe77698a5534393a upstream.

"data_split" was never set to false.  It's just uninitialized.

Fixes: 2950219d87b0 ('qede: Add basic network device support')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/qlogic/qede/qede_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -400,7 +400,7 @@ netdev_tx_t qede_start_xmit(struct sk_bu
 	u8 xmit_type;
 	u16 idx;
 	u16 hlen;
-	bool data_split;
+	bool data_split = false;
 
 	/* Get tx-queue context and netdev index */
 	txq_index = skb_get_queue_mapping(skb);


