Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95700C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742E320810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=icurse.nl header.i=@icurse.nl header.b="w2O9B+Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgFQAAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:00:49 -0400
Received: from mail.ruun.network ([176.9.184.6]:48057 "EHLO mail.ruun.network"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgFQAAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:00:48 -0400
X-Greylist: delayed 1114 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 20:00:48 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=icurse.nl;
         s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=Evq8MmLfT0oR9H/XsA7WCQZbhdKyJhd3Ipik9wf89lk=; b=w
        2O9B+Siw+aBLgVTR3Hh7VRKzNIaRyu6HLCxeaaUxQwfyDErT+63FjlmjqWKYTppgyBmnQttvYqHl7
        c91bho9kj5M+wkM7ldipu7ilQyPd4RAgQ+k0Jjimgy4AJXkeVOnf0b6judpkzrTZpbLH1ZmmtHFiv
        pcvLqX5+lLQFf+LuTf0ASKgDAhT9jk4Z24uPK1ZJQBrp3lm+4xUY7+gOBbYrLXWqLBR3yxbAH3XG5
        6jLaXXheEGD1GXoARGlMUcddFVi5dbSBJkNIyOGGjc6CzWt9z45oiCry9VkDOcEbUpSwkw3sgqmBN
        a6M4jxQkzg3rAQeXrxuNpZw+4uhOPV3Mw==;
Received: from [23.129.64.201] (helo=localhost.localdomain)
        by birchibald.ruun.network with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93.0.4)
        (envelope-from <jeffrey@icurse.nl>)
        id 1jlLDo-00087A-PA; Wed, 17 Jun 2020 01:42:29 +0200
From:   Jeffrey Lin <jeffrey@icurse.nl>
To:     jdelvare@suse.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Lin <jeffrey@icurse.nl>
Subject: [PATCH] i2c: i801: Register lis3lv02d I2C device on Dell Latitude 5480
Date:   Tue, 16 Jun 2020 19:41:30 -0400
Message-Id: <20200616234130.814499-1-jeffrey@icurse.nl>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: jeffrey@icurse.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Value of /sys/devices/platform/lis3lv02d/position when
    Horizontal:     (36,-108,-1152)
    Left elevated:  (-432,-126,-1062)
    Front elevated: (36,594,-936)
    Upside down:    (-126,-252,1098)

Signed-off-by: Jeffrey Lin <jeffrey@icurse.nl>
---
 drivers/i2c/busses/i2c-i801.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index fea644921a76..d7c802e20ae6 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1268,6 +1268,7 @@ static const struct {
 	/*
 	 * Additional individual entries were added after verification.
 	 */
+	{ "Latitude 5480",      0x29 },
 	{ "Vostro V131",        0x1d },
 };
 
-- 
2.27.0

