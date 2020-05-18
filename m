Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A01520671
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823915;
	bh=tyPWl9a+CQko/HHoUmFTcDmz8KlCfkitFMDU0Mrw2R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EacgaH8deXdlnUGPm8EEcTdYMwgLQDM4G6814fFARne06boBBUzyyMpyVCeCN1tvY
	 Pb3s5hclEiqJBHb7RjNK1zD1C6olj6KmekmM3DzjTxNf5bUkgJWZEwe2+a4EPddc8I
	 3mIr/9Q2NRHbDgtyAyudAyBl6xiumOz9z+7M9IpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgERRpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbgERRpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:45:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F14BF20715;
        Mon, 18 May 2020 17:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823910;
        bh=tyPWl9a+CQko/HHoUmFTcDmz8KlCfkitFMDU0Mrw2R0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IUYnUxNKrj//z+TEHdWoDbR+6w0y8vrs3Uru+VFrpPBuciiC/Q91pyCzLd5w7xVra
         dJCtrqtrg1q9OkgB7uHFjjzgdJRmYmrR2HDv8eEEudYLu/zqutnWnDcyzV1pDBzSHU
         0jkuokhSKG3SOmjk4QbC+e4Ngm2tDEdL2DoOguJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.9 85/90] usb: gadget: legacy: fix error return code in cdc_bind()
Date:   Mon, 18 May 2020 19:37:03 +0200
Message-Id: <20200518173508.417541477@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit e8f7f9e3499a6d96f7f63a4818dc7d0f45a7783b upstream.

If 'usb_otg_descriptor_alloc()' fails, we must return a
negative error code -ENOMEM, not 0.

Fixes: ab6796ae9833 ("usb: gadget: cdc2: allocate and init otg descriptor by otg capabilities")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/legacy/cdc2.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/legacy/cdc2.c
+++ b/drivers/usb/gadget/legacy/cdc2.c
@@ -183,8 +183,10 @@ static int cdc_bind(struct usb_composite
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail1;
+		}
 		usb_otg_descriptor_init(gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;


