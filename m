Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE7DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224C9206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977468;
	bh=gwf4wWC0vORa2uGQfb3OiUSJDKLfwwSQvhew2ikLsvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TONPfigdUwKcA8WkNuKoH2mGuudEBXMX5WigXl9oAegKOa6r1SUzCkIYpqs0FFP2v
	 cDkfsr2nepsQnjlzNBkTEEyZnkSgd4hDBjRxn4axjXiRBQ7/RvJESJuN6I4DaBG0jD
	 jNv4R2w0FCiyeXWfBlsvUC+a1UcOOAIXCtJVcFaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbgIAPcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgIAPa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:30:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15B2206C0;
        Tue,  1 Sep 2020 15:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974225;
        bh=gwf4wWC0vORa2uGQfb3OiUSJDKLfwwSQvhew2ikLsvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqGQpLPdLRCATD8XbKESYA4F1z/NC/p/9xoYL+fAhh68a0xKbB/F8Y13eXcDBtLxq
         9GfjIu/ZyBmdGBKcpn5GhqvStkxUDO+xaTkWDbKQ4O+ifvZGiG/dmXTWPur82lVd6f
         tYTzdqjcpLhNia8WUQCX1AQ4rcVdnVz8VtHjsWgU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Changming Liu <charley.ashbringer@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 063/214] USB: sisusbvga: Fix a potential UB casued by left shifting a negative value
Date:   Tue,  1 Sep 2020 17:09:03 +0200
Message-Id: <20200901150955.997013862@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changming Liu <charley.ashbringer@gmail.com>

[ Upstream commit 2b53a19284f537168fb506f2f40d7fda40a01162 ]

The char buffer buf, receives data directly from user space,
so its content might be negative and its elements are left
shifted to form an unsigned integer.

Since left shifting a negative value is undefined behavior, thus
change the char to u8 to elimintate this UB.

Signed-off-by: Changming Liu <charley.ashbringer@gmail.com>
Link: https://lore.kernel.org/r/20200711043018.928-1-charley.ashbringer@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/sisusbvga/sisusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb.c b/drivers/usb/misc/sisusbvga/sisusb.c
index fc8a5da4a07c9..0734e6dd93862 100644
--- a/drivers/usb/misc/sisusbvga/sisusb.c
+++ b/drivers/usb/misc/sisusbvga/sisusb.c
@@ -761,7 +761,7 @@ static int sisusb_write_mem_bulk(struct sisusb_usb_data *sisusb, u32 addr,
 	u8   swap8, fromkern = kernbuffer ? 1 : 0;
 	u16  swap16;
 	u32  swap32, flag = (length >> 28) & 1;
-	char buf[4];
+	u8 buf[4];
 
 	/* if neither kernbuffer not userbuffer are given, assume
 	 * data in obuf
-- 
2.25.1



