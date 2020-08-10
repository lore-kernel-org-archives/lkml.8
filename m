Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9517BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA1C22D07
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073417;
	bh=kBMYDFhRnChutM/t5d6Xdcinvd6tqSpoUz7KNV5h4G0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmCyDWITynHqQ8qaE9XKHuh8fi4w3bESOLZ1WyEVLcoVqC3Q8CrJ7RnWqlTvoeZH5
	 o+BFzGwMIrSoNZRJ3gmDmjbr3rSGd7oBJtfFxTxt4Q+aUrWMuP7JlAMAENdG4gxckG
	 ufF/AmPceZKn/RXznKDF8YycgKOhwSyAN9F9k3Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgHJPaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgHJPaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 609D022D08;
        Mon, 10 Aug 2020 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073404;
        bh=kBMYDFhRnChutM/t5d6Xdcinvd6tqSpoUz7KNV5h4G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIAK9XlJbOSJjykCdMIKxjl21muabZUWXBn31Bkas2Cg//w+CFLltJ9hbel6NpwB3
         ctF1PQm152yjaxP0XzY4VhtwvJjlbGnUpy0Gq+sQMJItHpjhcvQc66seUTOKElpZEs
         zp48D/dvNtkgoGgKesi2ryHPn9CCQm4FMtfhCpJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 08/48] Bluetooth: Fix slab-out-of-bounds read in hci_extended_inquiry_result_evt()
Date:   Mon, 10 Aug 2020 17:21:30 +0200
Message-Id: <20200810151804.617146256@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peilin Ye <yepeilin.cs@gmail.com>

commit 51c19bf3d5cfaa66571e4b88ba2a6f6295311101 upstream.

Check upon `num_rsp` is insufficient. A malformed event packet with a
large `num_rsp` number makes hci_extended_inquiry_result_evt() go out
of bounds. Fix it.

This patch fixes the following syzbot bug:

    https://syzkaller.appspot.com/bug?id=4bf11aa05c4ca51ce0df86e500fce486552dc8d2

Reported-by: syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4151,7 +4151,7 @@ static void hci_extended_inquiry_result_
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))


