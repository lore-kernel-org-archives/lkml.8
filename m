Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973BDC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D1FE20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272877;
	bh=/dNbojVtO2nJ5mDwyxW1lvQ+BYNWbSmSuinIw8T0NfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uzce5gbGZFkGe4mPemIKjaKfPsxcZb3qI3a+io2jW0vXvi1Saxa/Tj7QF/dpGjcW7
	 iAiU4idqM2qg1iG0lSSamdvQQOiBk4CsdUzLjp3jeirjwPiuHmLdu12vGi9g5gMkST
	 VlT3uyklWXfcAFIGDqBZBQBjKGmT8Ynf1kwWNGFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732766AbgBUIOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733203AbgBUIOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:14:34 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638C624670;
        Fri, 21 Feb 2020 08:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272873;
        bh=/dNbojVtO2nJ5mDwyxW1lvQ+BYNWbSmSuinIw8T0NfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P+KfnjYQilgF6rALjwlZcvL7JtQgVEuJvr+yyljOsP2Jx66T40D3tWhd+/eh5iSWn
         +bjYj77q4EVLFqdrHdfDhS8uaJi2g3zTcw2wW+dFYpAygJJvLV+9ZHaXBvhKN8E41x
         Z33rALIu/5xPHeZ5sjlw8FJw16yQaWHqHxWTefdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 308/344] rbd: work around -Wuninitialized warning
Date:   Fri, 21 Feb 2020 08:41:47 +0100
Message-Id: <20200221072417.950832158@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit a55e601b2f02df5db7070e9a37bd655c9c576a52 ]

gcc -O3 warns about a dummy variable that is passed
down into rbd_img_fill_nodata without being initialized:

drivers/block/rbd.c: In function 'rbd_img_fill_nodata':
drivers/block/rbd.c:2573:13: error: 'dummy' is used uninitialized in this function [-Werror=uninitialized]
  fctx->iter = *fctx->pos;

Since this is a dummy, I assume the warning is harmless, but
it's better to initialize it anyway and avoid the warning.

Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 13527a0b4e448..a67315786db47 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2739,7 +2739,7 @@ static int rbd_img_fill_nodata(struct rbd_img_request *img_req,
 			       u64 off, u64 len)
 {
 	struct ceph_file_extent ex = { off, len };
-	union rbd_img_fill_iter dummy;
+	union rbd_img_fill_iter dummy = {};
 	struct rbd_img_fill_ctx fctx = {
 		.pos_type = OBJ_REQUEST_NODATA,
 		.pos = &dummy,
-- 
2.20.1



