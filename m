Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF33C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35917215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409586;
	bh=1Lk7hPEkOLOEcPqJfFAlWYzJ+zQGDXWu3g8dnRXH9yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pAKhSBylgg1uIEfXAgmhBWPfRzF+ICfeGJr8nceXN47rfvF+4mz47LjF6DZqH5xxy
	 UCG0HVmOtVDowQ5aEihB+JbGB/jQnf2gBFeA1KqZDxxz9nhzTQ/PRPE+sereqOw5bt
	 m1f7yC37Iq1D43VJbXrEkjqbNUsR6VVA/Jv5KkTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgA3Sjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:39:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbgA3Sjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:39:45 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E4A520702;
        Thu, 30 Jan 2020 18:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409584;
        bh=1Lk7hPEkOLOEcPqJfFAlWYzJ+zQGDXWu3g8dnRXH9yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpveTHkIYfK5N+LOUue45QZv1KHo1dW29N4w5ZrvQv0ROxkw8rM3hFYXnDldOSWci
         US16yV75qI9rCBeUsECLOhLOZHyVFBEDeS1MBoffR5dwT65SiQVxvFlGHgGjN9cFyu
         mVZ2wyYCR+1oV8iMefVnr2mFdKNhlTnK+RCfAbco=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 5.5 01/56] Bluetooth: btusb: fix non-atomic allocation in completion handler
Date:   Thu, 30 Jan 2020 19:38:18 +0100
Message-Id: <20200130183609.173830396@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
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
@@ -2602,7 +2602,7 @@ static void btusb_mtk_wmt_recv(struct ur
 		 * and being processed the events from there then.
 		 */
 		if (test_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags)) {
-			data->evt_skb = skb_clone(skb, GFP_KERNEL);
+			data->evt_skb = skb_clone(skb, GFP_ATOMIC);
 			if (!data->evt_skb)
 				goto err_out;
 		}


