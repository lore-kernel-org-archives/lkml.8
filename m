Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D23C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51B024684
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996277;
	bh=jifw3t86RPlobOIv0GBU83DATCCEB+SoFTw7iSeOiZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxpqOuvb2KLN58rgUcLN2QIHjN8GwnYyUTJDHuIx+EnjXwNowqdvg9dD+4HH1zoq3
	 HAv8dR46TsasscK2BY1IWICPzVjGXpzn+7RCuN8fQDREzsWXo3nuTltGgCmpCKrWfp
	 5jBvgV3gQHUkgjWxQG0tLFIrDJKKcquEIWE5DKv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgANKEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:04:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgANKEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:04:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2F0F2465B;
        Tue, 14 Jan 2020 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996272;
        bh=jifw3t86RPlobOIv0GBU83DATCCEB+SoFTw7iSeOiZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nhXr5hT2OA/D0+WGtI2UKKB7RlpzySN/hIXDMcDjl40ACwkKkOuKav6vHk5br3H3d
         u4x9l2yHzxTJRs8RcIs5gu/DOhlSp2tJvir9aKipTzlEW+VkpPzRptflSslW8LBFH3
         wamTDp0jxVnAIaOLAhTTsQ5/Oyh7ZCOd3fj+/DBU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.4 19/78] HID: hidraw: Fix returning EPOLLOUT from hidraw_poll
Date:   Tue, 14 Jan 2020 11:00:53 +0100
Message-Id: <20200114094356.291519748@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Holtmann <marcel@holtmann.org>

commit 9f3b61dc1dd7b81e99e7ed23776bb64a35f39e1a upstream.

When polling a connected /dev/hidrawX device, it is useful to get the
EPOLLOUT when writing is possible. Since writing is possible as soon as
the device is connected, always return it.

Right now EPOLLOUT is only returned when there are also input reports
are available. This works if devices start sending reports when
connected, but some HID devices might need an output report first before
sending any input reports. This change will allow using EPOLLOUT here as
well.

Fixes: 378b80370aa1 ("hidraw: Return EPOLLOUT from hidraw_poll")
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hidraw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -252,10 +252,10 @@ static __poll_t hidraw_poll(struct file
 
 	poll_wait(file, &list->hidraw->wait, wait);
 	if (list->head != list->tail)
-		return EPOLLIN | EPOLLRDNORM | EPOLLOUT;
+		return EPOLLIN | EPOLLRDNORM;
 	if (!list->hidraw->exist)
 		return EPOLLERR | EPOLLHUP;
-	return 0;
+	return EPOLLOUT | EPOLLWRNORM;
 }
 
 static int hidraw_open(struct inode *inode, struct file *file)


