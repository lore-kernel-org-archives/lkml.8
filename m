Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4F5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A686E207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073570;
	bh=fDdYFq/SQe2tJ7vYWkAx0BlXX8llaz1+AgIZh/1gISc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=peuwIS8b2lMX+dlA9Mxpae6ueIMGGm5ReCyD3hqpS5g+wMLKcyK0NwDBPyleasg38
	 LlOki0Ejpx4sxuQ2lYpZ+B7ZJK05sUP/3PV6eZJZrSChdhjXFn8AF4S985Ywem4HYL
	 2l2ypdf9lOH8QIjrrls7TR2k+Yya/Ys/wWuaCbf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgHJPaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729057AbgHJPaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515B422D02;
        Mon, 10 Aug 2020 15:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073407;
        bh=fDdYFq/SQe2tJ7vYWkAx0BlXX8llaz1+AgIZh/1gISc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zIe6me2XlaAiUAcFWPB5+gykGIT//42FfXXcGT86GLgoNVjRfrEhCWFbB/Cy4Do8w
         Zh6VNOCdxni+ecHp6HkUgMNnkipWq0Y7QpDoRXee8KbjadIGsEfuLgYgnPIEEhWM/j
         5D9sosqB9hfke3LWeJbXY2IRLmQXuQtWSb1EUzBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.19 09/48] Bluetooth: Prevent out-of-bounds read in hci_inquiry_result_evt()
Date:   Mon, 10 Aug 2020 17:21:31 +0200
Message-Id: <20200810151804.669737314@linuxfoundation.org>
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

commit 75bbd2ea50ba1c5d9da878a17e92eac02fe0fd3a upstream.

Check `num_rsp` before using it as for-loop counter.

Cc: stable@vger.kernel.org
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/bluetooth/hci_event.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2360,7 +2360,7 @@ static void hci_inquiry_result_evt(struc
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))


