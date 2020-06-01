Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF35C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172D020679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591037774;
	bh=v0C1Z9ww9x+pvRa/lCYtmJtx83bS0uWaaBktRdlhRdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0KFb08b8wHY/6xJsl+9U1ACjw+b+GXR8Bxb6jEjz3wtZsiHyg4AQxr8NhZcVVg6a
	 174Fd/bWZgqKuDfDdFqakI+d07/avooKyq4Au03UC5Wu5F0eVrPws2gvdXO0XIBc0Q
	 31B3Lrdk5ID6AMuc0aOokZpoJ/1cbZwTlIeWmrlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgFASAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:43044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgFASAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 803F92074B;
        Mon,  1 Jun 2020 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034421;
        bh=v0C1Z9ww9x+pvRa/lCYtmJtx83bS0uWaaBktRdlhRdI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aHEaCYMPpkivbTgB8kmKug7PQPF9AMQKGAZM+9gUK2TGxmJtMT9C3D4BmHduYnCE0
         N6pJtgnOCvEiFk8uBOQn+dW2dzZ4bxulPeNATP7sDfuOHCZFwLlDEnWFbgWI0yV4hU
         BJhlHQuuRG+E3oLU0TLPpCggQt1awZdysSeEEGck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 09/77] net: qrtr: Fix passing invalid reference to qrtr_local_enqueue()
Date:   Mon,  1 Jun 2020 19:53:14 +0200
Message-Id: <20200601174018.099237527@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174016.396817032@linuxfoundation.org>
References: <20200601174016.396817032@linuxfoundation.org>
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
@@ -660,7 +660,7 @@ static int qrtr_bcast_enqueue(struct qrt
 	}
 	mutex_unlock(&qrtr_node_lock);
 
-	qrtr_local_enqueue(node, skb);
+	qrtr_local_enqueue(NULL, skb);
 
 	return 0;
 }


