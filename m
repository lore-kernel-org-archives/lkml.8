Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B09C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE2424692
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699431;
	bh=Bw8ZGxJXZ1WFo1MtttC8xFlL7eSGqbHYNSdsB62/luU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zEkiW6P3Nd+Y9uKHbhbsfMqkM6PDsRVXswivRj+6r6U6vefOQOc5Qeei79tg3HF7Q
	 jSfVsFb4FiFr8L0VuMRzkeEKUMoSS+bpjMeIKmgX4tAiWRVdhecM/Qu/izbvWOCCyk
	 4njRppUl64R+XrY03FHpDIVhaKxcAFqWEaXo5mCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgAVNXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:42144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730350AbgAVNXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:44 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44EFB2467B;
        Wed, 22 Jan 2020 13:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699423;
        bh=Bw8ZGxJXZ1WFo1MtttC8xFlL7eSGqbHYNSdsB62/luU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVqcjz2CoOwW0aSDzWo3tBqNH9vEeUE4sG8fGxixm08+mVFbeEhYOIgDm8Q8JKj2e
         oVMoZ18E3mHBNpMsR4Lnmu+q6mN105+iQXF2hEqfWDDfz9npybnQuvBbWdbE65sojR
         63l5cpsMZnOQssTN6DLyt4j4YKOeAM33HkCvJDII=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 139/222] net: dsa: tag_qca: fix doubled Tx statistics
Date:   Wed, 22 Jan 2020 10:28:45 +0100
Message-Id: <20200122092843.689580438@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Lobakin <alobakin@dlink.ru>

[ Upstream commit bd5874da57edd001b35cf28ae737779498c16a56 ]

DSA subsystem takes care of netdev statistics since commit 4ed70ce9f01c
("net: dsa: Refactor transmit path to eliminate duplication"), so
any accounting inside tagger callbacks is redundant and can lead to
messing up the stats.
This bug is present in Qualcomm tagger since day 0.

Fixes: cafdc45c949b ("net-next: dsa: add Qualcomm tag RX/TX handler")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Alexander Lobakin <alobakin@dlink.ru>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/tag_qca.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/dsa/tag_qca.c
+++ b/net/dsa/tag_qca.c
@@ -33,9 +33,6 @@ static struct sk_buff *qca_tag_xmit(stru
 	struct dsa_port *dp = dsa_slave_to_port(dev);
 	u16 *phdr, hdr;
 
-	dev->stats.tx_packets++;
-	dev->stats.tx_bytes += skb->len;
-
 	if (skb_cow_head(skb, 0) < 0)
 		return NULL;
 


