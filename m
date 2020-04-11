Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2E3C2137B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607406;
	bh=zqqPdjzMKrT6Dsh6rmrY0HhxAfJoVgJZbT7J3DgNKKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wg5MX+v4IKabKDNyVS7kJZvjqF5hQWv0v+GHg9Getw+gFCpPNDwhkzOfrhmnPBM2l
	 VQ1yUmsA8OtCI67urm/2hryPxWmRWFsrLScgckLQEYfQpcDQ/2fiuQa+yuJwtZH/no
	 /SD5O15Q2JzNQrt3ezM5lRzr6WVeWfZ2iieHLcV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgDKMQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:51018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgDKMQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35EC20644;
        Sat, 11 Apr 2020 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607402;
        bh=zqqPdjzMKrT6Dsh6rmrY0HhxAfJoVgJZbT7J3DgNKKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aUW9hxMtamTf2BgSL8a2OQoOw93nnt9RvTaVhm4mnBdLmCKvq1ddZm8eicIS3uq/h
         yZcbLmhCjN3tYLNTAiK828BsKESavLQyV/h51rweEysYmEKShlNXJD5Qu0XeW9xQDy
         NJd7UQqJzJHLFXYE82C93By3eiUqpGWU6n8cOOM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 23/54] net: Fix Tx hash bound checking
Date:   Sat, 11 Apr 2020 14:09:05 +0200
Message-Id: <20200411115510.815232090@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amritha Nambiar <amritha.nambiar@intel.com>

commit 6e11d1578fba8d09d03a286740ffcf336d53928c upstream.

Fixes the lower and upper bounds when there are multiple TCs and
traffic is on the the same TC on the same device.

The lower bound is represented by 'qoffset' and the upper limit for
hash value is 'qcount + qoffset'. This gives a clean Rx to Tx queue
mapping when there are multiple TCs, as the queue indices for upper TCs
will be offset by 'qoffset'.

v2: Fixed commit description based on comments.

Fixes: 1b837d489e06 ("net: Revoke export for __skb_tx_hash, update it to just be static skb_tx_hash")
Fixes: eadec877ce9c ("net: Add support for subordinate traffic classes to netdev_pick_tx")
Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/dev.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2854,6 +2854,8 @@ static u16 skb_tx_hash(const struct net_
 
 	if (skb_rx_queue_recorded(skb)) {
 		hash = skb_get_rx_queue(skb);
+		if (hash >= qoffset)
+			hash -= qoffset;
 		while (unlikely(hash >= qcount))
 			hash -= qcount;
 		return hash + qoffset;


