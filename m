Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9EFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E09205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409734;
	bh=OXgomte17JlearWZZPYbnhxS7XtT85qARK8YQ6+sZWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PdQbVyAvlO9VXOYjwGU8R51VpjIQbw0mg1B25fu/+QYi3CIbzrrj3jZhxxcnlp4eZ
	 A8Qm3v3C9pvQf7ps+QMiHvGcTxKhwxcYiU4CN/lUYjeU1pwo6gimEFfhS6HzH9coaG
	 vSMNDG086Nz9VfCB3Kz4blu//r2gOQ80gP9LJz5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgA3SmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:42:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:50258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728032AbgA3SmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:42:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E12DA205F4;
        Thu, 30 Jan 2020 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409725;
        bh=OXgomte17JlearWZZPYbnhxS7XtT85qARK8YQ6+sZWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCMJf4GVNewgA8woerUmoJBjpJDLuvhUEGiUnW2IBXNbl8TvJElpUfi2sAufxSXIn
         E+Z3FsPmrAiLhiG7iV+ld5ga4wh2bzCX+TXWEKnZj2grxVgT9K4gKnRFAqEKCRU9Uy
         Z9pAaH35dMXpWOJwPMVBZ/r8oif5Antk3M6cPC9k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.4 001/110] Bluetooth: btusb: fix non-atomic allocation in completion handler
Date:   Thu, 30 Jan 2020 19:37:37 +0100
Message-Id: <20200130183614.048238705@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 22cc6b7a1dbb58da4afc539d9b7d470b23a25eea upstream.

USB completion handlers are called in atomic context and must
specifically not allocate memory using GFP_KERNEL.

Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
Cc: stable <stable@vger.kernel.org>     # 5.3
Cc: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2585,7 +2585,7 @@ static void btusb_mtk_wmt_recv(struct ur
 		 * and being processed the events from there then.
 		 */
 		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
-			data->evt_skb = skb_clone(skb, GFP_KERNEL);
+			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
 			if (!data->evt_skb)
 				goto err_out;
 		}


