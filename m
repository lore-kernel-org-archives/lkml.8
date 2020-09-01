Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E0C7206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974838;
	bh=gwf4wWC0vORa2uGQfb3OiUSJDKLfwwSQvhew2ikLsvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bo4QERLgHCK6uAGXQ52TH4iJAYOOxZW4wZvszz0zkeJba/I9wj6XioRwgMnglHuyO
	 4MYd9EgKzlgh+5XGLHQ2MvtxCw9myalLOqPywZj25zPd+dHuNxynMBL8PgZOxfeZGq
	 u4uCJxsu2mRzKja3RG7cy8TVWXt2ytupHeoh5JAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgIAPkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:48138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731414AbgIAPiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:38:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C53120866;
        Tue,  1 Sep 2020 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974728;
        bh=gwf4wWC0vORa2uGQfb3OiUSJDKLfwwSQvhew2ikLsvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUzB/yg1X9RzeBsOM8LJ1aJU7pqbuk9dS1Xc3V8Bs9HJOZZhq7SHw0Ftna6hMYgb8
         cWTlftY6jNxrQ/ZXSeNTm6A7L6DToFIfjJfMUvFAWDRCTVo0V+yO1/0Da3XMnE05QQ
         nO33px790AR1GL88y4bnf0Q4jVygd0bF3Pg/YuvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Changming Liu <charley.ashbringer@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 071/255] USB: sisusbvga: Fix a potential UB casued by left shifting a negative value
Date:   Tue,  1 Sep 2020 17:08:47 +0200
Message-Id: <20200901151004.133937256@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
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



