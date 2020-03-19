Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E861C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FED20409
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624880;
	bh=P4XLEO7Wra/co4h5lqb13rvEA+kkl2hmiKJ2dvmVNZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d8VqQWwuWPpYYUupOyLKmGK9ol5kj3zP5ctKIp3kM7pWWahCRLTbDtFoMeG5aJgrD
	 I2OjrgMUW2bqBKqu+nqGsQ9mRODq6S20I9p45HNH0Ic6tuOKjzSAVtoRcL04vilIGD
	 4G+Jr0hLsS1oWiyl9iCkJ32ZOpKwzulrxT7Ezehw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgCSNMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbgCSNMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:12:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF131208D6;
        Thu, 19 Mar 2020 13:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623562;
        bh=P4XLEO7Wra/co4h5lqb13rvEA+kkl2hmiKJ2dvmVNZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhX6Pw/Te9GxJPWziNfGJOzxw9zZ6JBmLlF9vcv8hd5e9bkn71ejN8Zh4gybWnDF7
         TePUQ72LmlDcaRiUtLWSKnds8cDgbcUFIuxDSnK5ubGE5c9WT7DX4YJTsGAdpPn6ws
         rG2YB4F+zMJ4uRP68S85g/zR18m4chZ76aFCAuoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Leonardo=20M=F6rlein?= <me@irrelefant.net>,
        =?UTF-8?q?Linus=20L=FCssing?= <linus.luessing@c0d3.blue>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 69/90] batman-adv: Fix multicast TT issues with bogus ROAM flags
Date:   Thu, 19 Mar 2020 14:00:31 +0100
Message-Id: <20200319123949.879419690@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Lüssing <linus.luessing@c0d3.blue>

commit a44ebeff6bbd6ef50db41b4195fca87b21aefd20 upstream.

When a (broken) node wrongly sends multicast TT entries with a ROAM
flag then this causes any receiving node to drop all entries for the
same multicast MAC address announced by other nodes, leading to
packet loss.

Fix this DoS vector by only storing TT sync flags. For multicast TT
non-sync'ing flag bits like ROAM are unused so far anyway.

Fixes: 1d8ab8d3c176 ("batman-adv: Modified forwarding behaviour for multicast packets")
Reported-by: Leonardo Mörlein <me@irrelefant.net>
Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/translation-table.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1708,7 +1708,8 @@ static bool batadv_tt_global_add(struct
 		ether_addr_copy(common->addr, tt_addr);
 		common->vid = vid;
 
-		common->flags = flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
 
 		tt_global_entry->roam_at = 0;
 		/* node must store current time in case of roaming. This is
@@ -1772,7 +1773,8 @@ static bool batadv_tt_global_add(struct
 		 * TT_CLIENT_TEMP, therefore they have to be copied in the
 		 * client entry
 		 */
-		common->flags |= flags & (~BATADV_TT_SYNC_MASK);
+		if (!is_multicast_ether_addr(common->addr))
+			common->flags |= flags & (~BATADV_TT_SYNC_MASK);
 
 		/* If there is the BATADV_TT_CLIENT_ROAM flag set, there is only
 		 * one originator left in the list and we previously received a


