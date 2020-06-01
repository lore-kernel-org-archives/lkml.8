Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE497C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B9E1206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037363;
	bh=C/vHkEeZS1FOzuTQz/0tUmDTh6yIWmzBzLmT+UcVceY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CHVRWkVg4ycsHHjq7voacza1AfChdTnPAfRF2naUTxz+8DZfECLWr04YdkGhRbhdt
	 P1LKIe/Z0+Q2NmHL+mk5NzUbWE8xPUiBrlZfXSMxdECKI6WWrcmneR1j/Pw4qwdf/R
	 AjMKYIfciSv2fXbFNtKFZtqVPsgSM15ckaSHflHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgFASHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:07:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730455AbgFASGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B8F52068D;
        Mon,  1 Jun 2020 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034783;
        bh=C/vHkEeZS1FOzuTQz/0tUmDTh6yIWmzBzLmT+UcVceY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSslXKC3xNrqqf1NM/GvjBRXft5mgQJcUa/3H7wDW6hSM9qivd424xcLftmKmZp1s
         bxgyKa9wCzygL3XaFU4tjekLqeTIy8RXDiER4K9vKbnllaE1gQO/sJ5dUeBDtKExQw
         XnoipscdTE9x+kyH5VoV9fmfC7A849WBixoJXY3o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 012/142] net: qrtr: Fix passing invalid reference to qrtr_local_enqueue()
Date:   Mon,  1 Jun 2020 19:52:50 +0200
Message-Id: <20200601174039.230722484@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit d28ea1fbbf437054ef339afec241019f2c4e2bb6 ]

Once the traversal of the list is completed with list_for_each_entry(),
the iterator (node) will point to an invalid object. So passing this to
qrtr_local_enqueue() which is outside of the iterator block is erroneous
eventhough the object is not used.

So fix this by passing NULL to qrtr_local_enqueue().

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/qrtr/qrtr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/qrtr/qrtr.c
+++ b/net/qrtr/qrtr.c
@@ -711,7 +711,7 @@ static int qrtr_bcast_enqueue(struct qrt
 	}
 	mutex_unlock(&qrtr_node_lock);
 
-	qrtr_local_enqueue(node, skb, type, from, to);
+	qrtr_local_enqueue(NULL, skb, type, from, to);
 
 	return 0;
 }


