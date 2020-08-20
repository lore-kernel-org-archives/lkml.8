Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B8D20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597918752;
	bh=6rfEhDzx06p0ulhrsLXqxxJSYwz8iUODLjDUxrMxFOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rvT+pEhA5zK/6i9MIUTyvg05XWf5TOKxbRDCmh3+oor9dT3OMKG2R83TlUxIBMoN6
	 pwk4OCbr0E6/127T6RzIyBEItjdjRhcgpWeaNZDYhQDyv+W8/vr9Wyb3GjOD09PhFf
	 Qmvf7gTWUmBek0/10rLBNkmrxsf1loZxyZXeHeW8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731360AbgHTKTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgHTKSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:18:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9784020658;
        Thu, 20 Aug 2020 10:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918704;
        bh=6rfEhDzx06p0ulhrsLXqxxJSYwz8iUODLjDUxrMxFOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ys6lzK1chFnBcXN73wtiRti1d3ayrnUf/IGSKTYdnjrIg36Y0Y6d7JLD7am0Qfe7u
         07cy8HaC8M4ss41TMTTeY/4A5tMooYbvG6A9LrwzmsAdRewqgElkNCH5PAe7MMBI5N
         QI2DkUhb+obCM2UxbtcUo+26XmGszMp89mO8F5X8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+d8489a79b781849b9c46@syzkaller.appspotmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.4 035/149] Bluetooth: Fix slab-out-of-bounds read in hci_extended_inquiry_result_evt()
Date:   Thu, 20 Aug 2020 11:21:52 +0200
Message-Id: <20200820092127.433888379@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820092125.688850368@linuxfoundation.org>
References: <20200820092125.688850368@linuxfoundation.org>
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
@@ -3812,7 +3812,7 @@ static void hci_extended_inquiry_result_
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))


