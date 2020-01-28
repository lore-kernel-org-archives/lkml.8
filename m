Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A259C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4045B24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 13:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580219913;
	bh=+87kAnNydczXb7BW97pURPntkWjZgoBlJtHDxJHMwDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1kFlB13ddOgVYe1rivTVpzz5y+EGWGyLHI71FjDdCQ44X/vPBJOyYOEnvWqIiuxxy
	 km5eJtTQzgZ+Jng+6t5WFNYSxRpowRm+DpcVYIXgxGAwOD0w5gAIWZcASLBOyk64Fq
	 oTvH5EKBRszNZnYOoo7C0xK4I3eN9s3UI+dIuDnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgA1N6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgA1N6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 08:58:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B22924685;
        Tue, 28 Jan 2020 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580219910;
        bh=+87kAnNydczXb7BW97pURPntkWjZgoBlJtHDxJHMwDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UAO2ZyYhi5VTuo0o2ntWn0NxBAgZWmDYEjFQxKWxqWV1/nIG5rjaV408pK62KsGzM
         2wu0v9wpHOzGmB10dCxanlOHoHid0YhNFFXLgwEoGtE1GUxuywx/nynbPbm7sWUhqG
         6KTiK5+ziISBYMrEd0nhR++5oGcvvnsOIKlhywf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wenwen Wang <wenwen@cs.uga.edu>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/46] firestream: fix memory leaks
Date:   Tue, 28 Jan 2020 14:57:36 +0100
Message-Id: <20200128135750.449405658@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135749.822297911@linuxfoundation.org>
References: <20200128135749.822297911@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit fa865ba183d61c1ec8cbcab8573159c3b72b89a4 ]

In fs_open(), 'vcc' is allocated through kmalloc() and assigned to
'atm_vcc->dev_data.' In the following execution, if an error occurs, e.g.,
there is no more free channel, an error code EBUSY or ENOMEM will be
returned. However, 'vcc' is not deallocated, leading to memory leaks. Note
that, in normal cases where fs_open() returns 0, 'vcc' will be deallocated
in fs_close(). But, if fs_open() fails, there is no guarantee that
fs_close() will be invoked.

To fix this issue, deallocate 'vcc' before the error code is returned.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/atm/firestream.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/atm/firestream.c
+++ b/drivers/atm/firestream.c
@@ -927,6 +927,7 @@ static int fs_open(struct atm_vcc *atm_v
 			}
 			if (!to) {
 				printk ("No more free channels for FS50..\n");
+				kfree(vcc);
 				return -EBUSY;
 			}
 			vcc->channo = dev->channo;
@@ -937,6 +938,7 @@ static int fs_open(struct atm_vcc *atm_v
 			if (((DO_DIRECTION(rxtp) && dev->atm_vccs[vcc->channo])) ||
 			    ( DO_DIRECTION(txtp) && test_bit (vcc->channo, dev->tx_inuse))) {
 				printk ("Channel is in use for FS155.\n");
+				kfree(vcc);
 				return -EBUSY;
 			}
 		}
@@ -950,6 +952,7 @@ static int fs_open(struct atm_vcc *atm_v
 			    tc, sizeof (struct fs_transmit_config));
 		if (!tc) {
 			fs_dprintk (FS_DEBUG_OPEN, "fs: can't alloc transmit_config.\n");
+			kfree(vcc);
 			return -ENOMEM;
 		}
 


