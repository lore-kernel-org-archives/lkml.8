Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B303C2D10F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB38207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595281259;
	bh=+q7cNL8nubsUkd3S1vAFyX0UrHh5Xf8jgK0R45mIHSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AEcwvfDea2To07L5iBqPZ7Mw4vJIKjgbfaoIPFPtLARjfWeuia/r7UuTsBrSJNoMp
	 IAmJCo28+jM6H5Irn6GIwmDmF7j6BdHD1+hF07CG41FOc93/H6lYAkpW4TjXpNVkQl
	 LSp5AfwSFrMyvkDnTaWMKzF1eH0L9RsWgiwAufaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGTVk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:40:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728559AbgGTVjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:39:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27C8A22C9D;
        Mon, 20 Jul 2020 21:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595281186;
        bh=+q7cNL8nubsUkd3S1vAFyX0UrHh5Xf8jgK0R45mIHSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dhb3vGPBrw4w3Y8obg07c0lP1H2IZi01mGQo6NvTpbqnpXvIGTuExo3SoYuXHUbmu
         hlPUnpcBwKpkkcYsfZHpT4MR8Sw7/TepNByQ/Fdn6HPmkg1ur6is9jyj17hXC1AyAF
         8qLl7TWFlB90p8lpKD+5cp54SKi+Oql8vvwgmgAM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 2/4] usb: gadget: udc: gr_udc: fix memleak on error handling path in gr_ep_init()
Date:   Mon, 20 Jul 2020 17:39:41 -0400
Message-Id: <20200720213944.408226-2-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720213944.408226-1-sashal@kernel.org>
References: <20200720213944.408226-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

[ Upstream commit c8f8529e2c4141afa2ebb487ad48e8a6ec3e8c99 ]

gr_ep_init() does not assign the allocated request anywhere if allocation
of memory for the buffer fails. This is a memory leak fixed by the given
patch.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/gr_udc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 594639e5cbf82..78168e1827b5e 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2001,9 +2001,12 @@ static int gr_ep_init(struct gr_udc *dev, int num, int is_in, u32 maxplimit)
 
 	if (num == 0) {
 		_req = gr_alloc_request(&ep->ep, GFP_ATOMIC);
+		if (!_req)
+			return -ENOMEM;
+
 		buf = devm_kzalloc(dev->dev, PAGE_SIZE, GFP_DMA | GFP_ATOMIC);
-		if (!_req || !buf) {
-			/* possible _req freed by gr_probe via gr_remove */
+		if (!buf) {
+			gr_free_request(&ep->ep, _req);
 			return -ENOMEM;
 		}
 
-- 
2.25.1

