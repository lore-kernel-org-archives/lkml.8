Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80278C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524FA2193E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580604;
	bh=uqtwbsRdgA9KQ1Qk38D0uiKsZpvjs6cUPkTcF18vUNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZAAmbX7noeOjuvrkLzgzxqcyK6knnL+7MmA6rD67pchL/5p8CGQvQPpkfmL1G3FA2
	 V4qjZNMvfWynrOUhHCU8l/QHaiONsjAmsRZfHYIld5Ne/GHcs9aGfoiBTR2mvDCCnk
	 o//9BTp9DFjIzIek2keHKhEp/poGkF5ys/V8x0tc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404760AbgFSPaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404736AbgFSP34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:29:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A272193E;
        Fri, 19 Jun 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580595;
        bh=uqtwbsRdgA9KQ1Qk38D0uiKsZpvjs6cUPkTcF18vUNM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKl1wQaFMNX4MrVd2dAqaCRRV2H9EYd4fcoexDIjylMRNX7SAJkPcf4HHInwfwP+y
         8Fj4SMl2bJaNArdEEdVdtN85JAA+qFSWQ7VuhzEZBg8lb/iDho5xofoUqCd01+vVeQ
         JTIcc4Dd5IT4ABSv70u3rzLDs4mMW5f0uuBUgNnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>,
        Min Guo <min.guo@mediatek.com>, Bin Liu <b-liu@ti.com>
Subject: [PATCH 5.7 308/376] usb: musb: mediatek: add reset FADDR to zero in reset interrupt handle
Date:   Fri, 19 Jun 2020 16:33:46 +0200
Message-Id: <20200619141724.917772203@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit 402bcac4b25b520c89ba60db85eb6316f36e797f upstream.

When receiving reset interrupt, FADDR need to be reset to zero in
peripheral mode. Otherwise ep0 cannot do enumeration when re-plugging USB
cable.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Acked-by: Min Guo <min.guo@mediatek.com>
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200525025049.3400-5-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/mediatek.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -208,6 +208,12 @@ static irqreturn_t generic_interrupt(int
 	musb->int_rx = musb_clearw(musb->mregs, MUSB_INTRRX);
 	musb->int_tx = musb_clearw(musb->mregs, MUSB_INTRTX);
 
+	if ((musb->int_usb & MUSB_INTR_RESET) && !is_host_active(musb)) {
+		/* ep0 FADDR must be 0 when (re)entering peripheral mode */
+		musb_ep_select(musb->mregs, 0);
+		musb_writeb(musb->mregs, MUSB_FADDR, 0);
+	}
+
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
 


