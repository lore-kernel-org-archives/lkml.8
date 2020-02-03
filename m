Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFC6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC38B2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746917;
	bh=dJ99gQh3O/vojkuYbo/2Mnv1K1SLRfANzJC7ZNyQkx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4gsebEkcWqVKDauOoEKJnnwuRkwKZC+xFOAZyIlbWddijaQu9fK0eEq68XY8p4rw
	 9ukeoB5KM6K6vKFW3sxikIqYCyS3kzYrTmu0tayTlXasCb95EtBr8otJzGGq2n1H4x
	 A7fSCTWS0iBBixEE43UkZVPebcBZufkJA4kET/fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgBCQV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729215AbgBCQVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:21:53 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830632080C;
        Mon,  3 Feb 2020 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746912;
        bh=dJ99gQh3O/vojkuYbo/2Mnv1K1SLRfANzJC7ZNyQkx8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqqODzwRduX1BkNgnriu07IL1/3nvaDJ8FAXbe2dX++Gr5kEAgsUmxl/P+JnhVE3S
         6mJz3g0K2ynvip9kt9zFv/vHYx8R5q75YGnGHSqGoOU3SbuGxG4YIEhQnFXjKxj3BR
         K/lvduHwdgFH/F9oXxYROMF9x3muAez6iaiZJGrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ilja Van Sprundel <ivansprundel@ioactive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 42/53] airo: Fix possible info leak in AIROOLDIOCTL/SIOCDEVPRIVATE
Date:   Mon,  3 Feb 2020 16:19:34 +0000
Message-Id: <20200203161910.324910174@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

[ Upstream commit d6bce2137f5d6bb1093e96d2f801479099b28094 ]

The driver for Cisco Aironet 4500 and 4800 series cards (airo.c),
implements AIROOLDIOCTL/SIOCDEVPRIVATE in airo_ioctl().

The ioctl handler copies an aironet_ioctl struct from userspace, which
includes a command and a length. Some of the commands are handled in
readrids(), which kmalloc()'s a buffer of RIDSIZE (2048) bytes.

That buffer is then passed to PC4500_readrid(), which has two cases.
The else case does some setup and then reads up to RIDSIZE bytes from
the hardware into the kmalloc()'ed buffer.

Here len == RIDSIZE, pBuf is the kmalloc()'ed buffer:

	// read the rid length field
	bap_read(ai, pBuf, 2, BAP1);
	// length for remaining part of rid
	len = min(len, (int)le16_to_cpu(*(__le16*)pBuf)) - 2;
	...
	// read remainder of the rid
	rc = bap_read(ai, ((__le16*)pBuf)+1, len, BAP1);

PC4500_readrid() then returns to readrids() which does:

	len = comp->len;
	if (copy_to_user(comp->data, iobuf, min(len, (int)RIDSIZE))) {

Where comp->len is the user controlled length field.

So if the "rid length field" returned by the hardware is < 2048, and
the user requests 2048 bytes in comp->len, we will leak the previous
contents of the kmalloc()'ed buffer to userspace.

Fix it by kzalloc()'ing the buffer.

Found by Ilja by code inspection, not tested as I don't have the
required hardware.

Reported-by: Ilja Van Sprundel <ivansprundel@ioactive.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/airo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/airo.c b/drivers/net/wireless/airo.c
index 82d24f2b9c190..94df9ddfb7eb1 100644
--- a/drivers/net/wireless/airo.c
+++ b/drivers/net/wireless/airo.c
@@ -7831,7 +7831,7 @@ static int readrids(struct net_device *dev, aironet_ioctl *comp) {
 		return -EINVAL;
 	}
 
-	if ((iobuf = kmalloc(RIDSIZE, GFP_KERNEL)) == NULL)
+	if ((iobuf = kzalloc(RIDSIZE, GFP_KERNEL)) == NULL)
 		return -ENOMEM;
 
 	PC4500_readrid(ai,ridcode,iobuf,RIDSIZE, 1);
-- 
2.20.1



