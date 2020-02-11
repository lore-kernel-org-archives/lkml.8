Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C925C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3355A206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="iqggwRpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgBKXWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:22:47 -0500
Received: from gateway20.websitewelcome.com ([192.185.52.45]:32343 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbgBKXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:22:46 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id A0988400C81E2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 16:09:11 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 1erdjA7kTEfyq1erdjK4T2; Tue, 11 Feb 2020 17:22:45 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=d45YxL3ZVwmUXRXXaNk1DepB3rRpGpao2lxAWUtx6bM=; b=iqggwRpX32grupnHhcMZ8HGQP6
        +vewtQpKtwwjgKiIYlS8OkZgst6U7rTXLHzQpFHADvx0KzIYhXTpTDCwkQYWad6YzUVVBcafCftkF
        iOJmwV9P/q/LuaYLY+x2Tcxnh1RwvuwaNGFDM4tBRs1oIIdw02z2bvDRfuI3RGO9zn5mbJGcl603K
        WHQbBwLclwpPQmrwSksRJg08d/+qFP2/WiuGbio5wQyOlqCzVPrIsIb6HbFiGok8KX/kICrdx8qwp
        McG5drN6KRJXlHhw3PoBJzDhkeey1sYigSbXD1z9xsspkwCRhgE6fzpcMnQvn+eTUTZtTvZua3qX/
        h43smIaQ==;
Received: from [200.68.140.36] (port=25379 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j1erc-003arP-Hs; Tue, 11 Feb 2020 17:22:44 -0600
Date:   Tue, 11 Feb 2020 17:25:19 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] USB: musb: Replace zero-length array with flexible-array
 member
Message-ID: <20200211232519.GA23263@embeddedor>
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
X-Source-IP: 200.68.140.36
X-Source-L: No
X-Exim-ID: 1j1erc-003arP-Hs
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.68.140.36]:25379
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 48
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
inadvertenly introduced[3] to the codebase from now on.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/usb/musb/musb_host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index eb308ec35c66..3dab821c1b30 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2576,7 +2576,7 @@ static int musb_bus_resume(struct usb_hcd *hcd)
 struct musb_temp_buffer {
 	void *kmalloc_ptr;
 	void *old_xfer_buffer;
-	u8 data[0];
+	u8 data[];
 };
 
 static void musb_free_temp_buffer(struct urb *urb)
-- 
2.25.0

