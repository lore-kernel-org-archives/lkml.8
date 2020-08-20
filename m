Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76D2E207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597925259;
	bh=Gg+kEkswDRxTKOBGrIllN4zRgEO19H9gT8252jAy1aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PrjJ7YnqQvfWJmWCLepWufBeqXtKssTd7JEwl9xioyrbOf3OwXoCc2sJahuSVIvBg
	 Us/RSiH/lOksNMrGfZ0z2eJZ7AwTVOTWSSKRhfAb1fgLQoNaoH8G05mF6C7rCKPv2E
	 carJVubZ/aqVN4P25HJhoDf7AzvZAsIfqCvmWtAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730420AbgHTMHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:42794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgHTJ63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:58:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B2A207FB;
        Thu, 20 Aug 2020 09:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917509;
        bh=Gg+kEkswDRxTKOBGrIllN4zRgEO19H9gT8252jAy1aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUCwQpc8eXATsEOvC8NvUfiaogGgRAnqKJqo9wirdfItfbADoHcHpTgl/z+OT/fIu
         oqouXl4mZQQXMkV4ZOhxf4bPsllvAkZvqkvFNo8SkvpCdSMGJkm1at4+4ZdyLVyBTd
         V+7vIARfFW0kL8zxdcr8MR+haS8Cb0icl1PYJWt0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 055/212] Bluetooth: Prevent out-of-bounds read in hci_inquiry_result_evt()
Date:   Thu, 20 Aug 2020 11:20:28 +0200
Message-Id: <20200820091605.150679931@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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


