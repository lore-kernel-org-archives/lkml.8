Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2266AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9401420791
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 23:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="NC+tzliV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHZX2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 19:28:35 -0400
Received: from crapouillou.net ([89.234.176.41]:60572 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgHZX2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 19:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1598484512; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=9IhOZgojiePxOK2i3ya4CQ9LZAzQUUMo/sGirn8ceyk=;
        b=NC+tzliVdS45MRTxA4JeE746Op3HsKSvd1HCHPWC7e+qJJbEkoT7aUwYAeXlCb5zkbG+mG
        +GNq0nAvynouzhARUlVXjVYacj9ILMnyECQWA0TozfVwF0wc1adFM6LKOKxdbv0bs2aKsv
        rLBGbOUbBVo6EcBZ+tzIvjTOmSEtY7Q=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: [PATCH] usb: musb: Fix NULL check on struct musb_request field
Date:   Thu, 27 Aug 2020 01:28:20 +0200
Message-Id: <20200826232820.137193-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'request' variable is a pointer to the 'request' field of the
struct musb_request 'req' pointer. It only worked until now because
the 'request' field is the first one in the musb_request structure, but
as soon as that changes, the check will be invalid.

Fix it preventively by doing the NULL-check on the 'req' pointer
instead.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
---
 drivers/usb/musb/musb_gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index f62ffaede1ab..ef374d4dd94a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -451,7 +451,7 @@ void musb_g_tx(struct musb *musb, u8 epnum)
 		return;
 	}
 
-	if (request) {
+	if (req) {
 
 		trace_musb_req_tx(req);
 
-- 
2.28.0

