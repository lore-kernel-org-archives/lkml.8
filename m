Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11142C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D655921569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="EDyvM+N3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgAURTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:19:19 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.45]:49870 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728829AbgAURTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:19:18 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8D9B1101943
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:19:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id txBNiLu4kkeyDtxBNiP20h; Tue, 21 Jan 2020 11:19:17 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HBcOh+dLtm/eUohjCzZcCezxliKeVHsKGPx7IKN2rUM=; b=EDyvM+N3dy33CEBvSIFwEH/Rm0
        Hgn2C+T6quHP+TYnjrdVrkJsViIh3U/7Q2lcmqK+e48Va96UTGXvc9zC4a2kYQvwqMkhDGnpcxVc8
        00wK7cszW4ryte3Leby7qQm6tFOxlVnh9a8oI0d8uYeyO3hDQpHiNhwJ8bj+XDS6h3Cw/YRDz0suD
        zBD4k///mlR8evyQw7imZhVKvdqJBcpn4VwAzs8aTWTh8Km3dfEBtpKQz66nbI6lhL0dqQTx04tAi
        +5b9HHUUetqWx9xaJUrO60PSxKfe+y0W9jyDdmxO+gF8x3I7sZxt6v92ImB0gl5iBUI6R9Ml5pLCU
        xXIXma1A==;
Received: from [189.152.234.38] (port=59220 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1itxBL-001nYT-OH; Tue, 21 Jan 2020 11:19:15 -0600
Date:   Tue, 21 Jan 2020 11:21:38 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikael Magnusson <mikachu@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] tty: n_hdlc: Use flexible-array member and struct_size()
 helper
Message-ID: <20200121172138.GA3162@embeddedor>
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
X-Source-IP: 189.152.234.38
X-Source-L: No
X-Exim-ID: 1itxBL-001nYT-OH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.152.234.38]:59220
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Old code in the kernel uses 1-byte and 0-byte arrays to indicate the
presence of a "variable length array":

struct something {
    int length;
    u8 data[1];
};

struct something *instance;

instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
instance->length = size;
memcpy(instance->data, source, size);

There is also 0-byte arrays. Both cases pose confusion for things like
sizeof(), CONFIG_FORTIFY_SOURCE, etc.[1] Instead, the preferred mechanism
to declare variable-length types such as the one above is a flexible array
member[2] which need to be the last member of a structure and empty-sized:

struct something {
        int stuff;
        u8 data[];
};

Also, by making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertenly introduced[3] to the codebase from now on.

Lastly, make use of the struct_size() helper to safely calculate the
allocation size for instances of struct n_hdlc_buf and avoid any potential
type mistakes[4][5].

[1] https://github.com/KSPP/linux/issues/21
[2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
[4] https://lore.kernel.org/lkml/60e14fb7-8596-e21c-f4be-546ce39e7bdb@embeddedor.com/
[5] commit 553d66cb1e86 ("iommu/vt-d: Use struct_size() helper")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Make use of struct_size() helper.
 - Update subject and changelog text.

 drivers/tty/n_hdlc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 98361acd3053..27b506bf03ce 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -115,11 +115,9 @@
 struct n_hdlc_buf {
 	struct list_head  list_item;
 	int		  count;
-	char		  buf[1];
+	char		  buf[];
 };
 
-#define	N_HDLC_BUF_SIZE	(sizeof(struct n_hdlc_buf) + maxframe)
-
 struct n_hdlc_buf_list {
 	struct list_head  list;
 	int		  count;
@@ -524,7 +522,8 @@ static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
 		/* no buffers in free list, attempt to allocate another rx buffer */
 		/* unless the maximum count has been reached */
 		if (n_hdlc->rx_buf_list.count < MAX_RX_BUF_COUNT)
-			buf = kmalloc(N_HDLC_BUF_SIZE, GFP_ATOMIC);
+			buf = kmalloc(struct_size(buf, buf, maxframe),
+				      GFP_ATOMIC);
 	}
 	
 	if (!buf) {
@@ -853,7 +852,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 
 	/* allocate free rx buffer list */
 	for(i=0;i<DEFAULT_RX_BUF_COUNT;i++) {
-		buf = kmalloc(N_HDLC_BUF_SIZE, GFP_KERNEL);
+		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->rx_free_buf_list,buf);
 		else if (debuglevel >= DEBUG_LEVEL_INFO)	
@@ -862,7 +861,7 @@ static struct n_hdlc *n_hdlc_alloc(void)
 	
 	/* allocate free tx buffer list */
 	for(i=0;i<DEFAULT_TX_BUF_COUNT;i++) {
-		buf = kmalloc(N_HDLC_BUF_SIZE, GFP_KERNEL);
+		buf = kmalloc(struct_size(buf, buf, maxframe), GFP_KERNEL);
 		if (buf)
 			n_hdlc_buf_put(&n_hdlc->tx_free_buf_list,buf);
 		else if (debuglevel >= DEBUG_LEVEL_INFO)	
-- 
2.23.0

