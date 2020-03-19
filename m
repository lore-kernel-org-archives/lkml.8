Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FD3C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5175221655
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623607;
	bh=c1PxxNuJbM5JWkNQ6MLInGeJAXXhBqAFhb4JU8MqEnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q/X11MaP9IjZuUdaQlOByJv0Vk6c4OSgvwv5EANJkGls2gP5eJSg3RSWmxagnh3jE
	 hKNJ/Fd9ZJicvC7Wdwez4g/6uGVJWUVWlKKuBEdbpaJi94RG9IYWcyWn30Pq87PTEP
	 wqt2siAY/ph2ugIAXqCKAOV88IZApWoSsegUlWIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgCSNN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbgCSNNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD733216FD;
        Thu, 19 Mar 2020 13:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623603;
        bh=c1PxxNuJbM5JWkNQ6MLInGeJAXXhBqAFhb4JU8MqEnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yySrYovXzm1bkawBIpm9cs+4oi18YqJwWDptbc9ASazY1acdiz7N7dxQIO9GvgPKP
         62WCELk42cKTn8xhcuQtZ70akveAFMaBnkXxZWQwThjp/Z7bXHbGhu7l4KtyS2hHsh
         TdzFz7vwJ58GmMlRMu5iqMQwKtD+RYd5G3rjc0aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 55/90] batman-adv: Use default throughput value on cfg80211 error
Date:   Thu, 19 Mar 2020 14:00:17 +0100
Message-Id: <20200319123945.376555621@linuxfoundation.org>
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

From: Sven Eckelmann <sven@narfation.org>

commit 3f3f87325dcb3c201076c81490f4da91ad4c09fc upstream.

A wifi interface should never be handled like an ethernet devices. The
parser of the cfg80211 output must therefore skip the ethtool code when
cfg80211_get_station returned an error.

Fixes: f44a3ae9a281 ("batman-adv: refactor wifi interface detection")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Reviewed-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v_elp.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -100,8 +100,10 @@ static u32 batadv_v_elp_get_throughput(s
 				 */
 				return 0;
 			}
-			if (!ret)
-				return sinfo.expected_throughput / 100;
+			if (ret)
+				goto default_throughput;
+
+			return sinfo.expected_throughput / 100;
 		}
 
 		/* unsupported WiFi driver version */


