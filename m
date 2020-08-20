Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9756C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF7D42078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597922679;
	bh=Gg+kEkswDRxTKOBGrIllN4zRgEO19H9gT8252jAy1aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lSABu0fRxx1MoeMo8Ap/tsM+I9B/PNsq0lPylgnXApwO1knPjlZVyZIue+qYcxrzh
	 03a87SAwCWR11q0CKWSFPanKpFHUWwu8K4m3AlnAEo+6HYbvQ1+7XU6LPWnBQ+w33n
	 lmUF3yfWjTI0P21NTr3AppGrdM1j5QU/cgIPHQEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgHTLYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:24:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729816AbgHTKHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:07:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37882067C;
        Thu, 20 Aug 2020 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918021;
        bh=Gg+kEkswDRxTKOBGrIllN4zRgEO19H9gT8252jAy1aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TddyxOz3FucClvMpbdhlj64ndBXlEP0ttwPyVi0pDy9DbQP14PeqGpZSpcCouk3Mb
         UvEqoFESSaoL9CPHuSpZo6K/bdjytujGgFvqJq8uFSPfuSI0W3+Dv3HUdEpPb1tLuN
         VQsLOiKS7hq23mGviGCtck7+XqJ893+cYOJHIzsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 009/228] Bluetooth: Prevent out-of-bounds read in hci_inquiry_result_evt()
Date:   Thu, 20 Aug 2020 11:19:44 +0200
Message-Id: <20200820091607.989638176@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
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
@@ -2094,7 +2094,7 @@ static void hci_inquiry_result_evt(struc
 
 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
 
-	if (!num_rsp)
+	if (!num_rsp || skb->len < num_rsp * sizeof(*info) + 1)
 		return;
 
 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))


