Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1C4C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F18921734
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kRri0apn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgBMAzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:55:31 -0500
Received: from gateway36.websitewelcome.com ([192.185.197.22]:24105 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727065AbgBMAzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:55:31 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id B7C3440202775
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 18:09:33 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 22mvj6lt7RP4z22mvjYMKA; Wed, 12 Feb 2020 18:55:29 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hqjhoUQv+EY20/Nx26UEQj1s5SdWkNkvsRNYkR8wtW4=; b=kRri0apnQfzr8jDn1LQ/1qqf6S
        uUy2K5PghegCKCHnDYe5axuyvoF68R2tS5MSoimOy1eNA+sePzJCPjEndQg8KWK+er4OCmmaPCWhY
        qaDOoNmLPLuLnqDtiDXELFBZE2YIpymIWzur9IM7mDPsBsAgqcyKzBwCaVRVx8OEkzb9rNbPKHmoh
        WJ3v5QeeVJC5d8ANAMBkFXNaxWbMJh8cKUcJXZfE5OFYnCn7XjbjxcHqsRfZRKgasYY7qLFdZJgiX
        PG+GRzH6xrFeDkzPVd/O6ANDaO7RyzSm0jWOUpI6YVKlMuTvE5G/ory+e9TlxJw7ggQy3nouiYz/S
        nsP++9zA==;
Received: from [200.68.141.42] (port=17615 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j22mt-003o7A-Jg; Wed, 12 Feb 2020 18:55:28 -0600
Date:   Wed, 12 Feb 2020 18:55:25 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] platform/x86: i2c-multi-instantiate: Replace zero-length
 array with flexible-array member
Message-ID: <20200213005525.GA11420@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.68.141.42
X-Source-L: No
X-Exim-ID: 1j22mt-003o7A-Jg
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.141.42]:17615
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 81
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/platform/x86/i2c-multi-instantiate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index ffb8d5d1eb5f..6acc8457866e 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -28,7 +28,7 @@ struct i2c_inst_data {
 
 struct i2c_multi_inst_data {
 	int num_clients;
-	struct i2c_client *clients[0];
+	struct i2c_client *clients[];
 };
 
 static int i2c_multi_inst_count(struct acpi_resource *ares, void *data)
-- 
2.23.0

