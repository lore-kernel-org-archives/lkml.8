Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63073C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2780D20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826182;
	bh=ofP+ox0i8hIBVUZOAQQWKyZiQX3MVp0DDqnhSr9Tdu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FDRSTvvmCC6Sfbte1J/3y+xnPCPedLVaCwOTLsF1rswkmxpcsvlnCMpErzWRvQZ8S
	 h16XI2/qK3a6GHZ5xl7j95FHUe2H1rnF22z2oYPGhvopojvhVaBcDiF3Wqtn+Hku4J
	 sgoozntNJeXhW/AZwevd6JFScL/Ex8jgOcdpoYns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbgERSXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730100AbgERRts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:49:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 182EA20671;
        Mon, 18 May 2020 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824187;
        bh=ofP+ox0i8hIBVUZOAQQWKyZiQX3MVp0DDqnhSr9Tdu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7rlVuaZZVo4wNlDsU8/nz5NSzDTQBkMMJ9/pxbOWdkPDF1w5W8dLjRNygiM2hBwi
         suViy9WqyOWjkOmvsR3wSP1azbUr77r9/KcSfFjILED1mFoqfE+xn3Fiej81qsSGm2
         H7qtpIbxUVzZl31BZg6dwSa6UwfwyFog8XQJiVGQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Chen <peter.chen@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.14 105/114] usb: gadget: audio: Fix a missing error return value in audio_bind()
Date:   Mon, 18 May 2020 19:37:17 +0200
Message-Id: <20200518173520.203720337@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 19b94c1f9c9a16d41a8de3ccbdb8536cf1aecdbf upstream.

If 'usb_otg_descriptor_alloc()' fails, we must return an error code, not 0.

Fixes: 56023ce0fd70 ("usb: gadget: audio: allocate and init otg descriptor by otg capabilities")
Reviewed-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/legacy/audio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/gadget/legacy/audio.c
+++ b/drivers/usb/gadget/legacy/audio.c
@@ -303,8 +303,10 @@ static int audio_bind(struct usb_composi
 		struct usb_descriptor_header *usb_desc;
 
 		usb_desc = usb_otg_descriptor_alloc(cdev->gadget);
-		if (!usb_desc)
+		if (!usb_desc) {
+			status = -ENOMEM;
 			goto fail;
+		}
 		usb_otg_descriptor_init(cdev->gadget, usb_desc);
 		otg_desc[0] = usb_desc;
 		otg_desc[1] = NULL;


