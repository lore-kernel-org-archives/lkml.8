Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB7CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303A020829
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824195;
	bh=JLwt2QAOm1wDlWCfZPVnnYPNnyM3OYsA0xWfyD8tsvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GMNn6yCUVCK7jBJ+5NqckcEzxRptGlPbaDGIXOYNfqRLIhg71/0WBg4ai72W1lYyh
	 PCP+pBYUT2HtmFudggQhR0/sHF31AnE/9vgNT5VUwsZaE85/W6G7X0S77G+AOkfB4+
	 4SlVGR5j4Y4gxE+PkEKDP0vcNDU3kQfDy7gbvAXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730594AbgERRty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbgERRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87087207C4;
        Mon, 18 May 2020 17:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824190;
        bh=JLwt2QAOm1wDlWCfZPVnnYPNnyM3OYsA0xWfyD8tsvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgRuZbE4RX08kfB/wBEuLl1xO9euuWlVwr0bpMIfUdSa7TNTKKNMjrM25gwvsKL79
         9/g8qdOMEc8MaFavaW/nVk8lzBkeSPQOmPpcsgW3kEsLs0Teo58UhMOJ0vlMvjN60d
         4vbhAjfwmd1/T/QduY/zz0Obo6uVmq/ciIM9gKis=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.14 106/114] usb: gadget: legacy: fix error return code in gncm_bind()
Date:   Mon, 18 May 2020 19:37:18 +0200
Message-Id: <20200518173520.323695243@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit e27d4b30b71c66986196d8a1eb93cba9f602904a upstream.

If 'usb_otg_descriptor_alloc()' fails, we must return a
negative error code -ENOMEM, not 0.

Fixes: 1156e91dd7cc ("usb: gadget: ncm: allocate and init otg descriptor by otg capabilities")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/legacy/ncm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/legacy/ncm.c
+++ b/drivers/usb/gadget/legacy/ncm.c
@@ -162,8 +162,10 @@ static int gncm_bind(struct usb_composit
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail;
+		}
 		usb_otg_descriptor_init(gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;


