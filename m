Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEE6C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C522B208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646231;
	bh=+1xLu4UM8eC0DtDYdw0C89iwUWF2tSN4pL1u48vjWDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p8i+d2OkbVYtk1cAJHjQHJ2Y+21K1Hz8UA2Wexrn6VjxymUZV8GHL47yrEyZrFbji
	 IyZyuHMG7xhw78HUK7o3ywQZRVqoMLBSlJ71y3yZNumEUH//sRv1E3IXV4HAeQxI/w
	 vDLroATxLNHhEwTkHZ0JxCTRpOVbEaZ4jShNMQBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgCaJRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732012AbgCaJRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:17:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84B8E208E0;
        Tue, 31 Mar 2020 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646227;
        bh=+1xLu4UM8eC0DtDYdw0C89iwUWF2tSN4pL1u48vjWDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X7sGWK+vEzhr74ST8CJw8vY76bQETDH4gJfjAnTok/FTgeFoDO97tKHjXZeE3kxp0
         IXyUzkxvwkVYciZnwQZAHqGkcCD5bGw2Qh7+JYLWhCD7eFrCYn5nplVlQ3R0ua+hTV
         WVojnp5608N0oDB2bqQat7hQ1q7/4YbRa3rOsGGI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 122/155] ieee80211: fix HE SPR size calculation
Date:   Tue, 31 Mar 2020 10:59:22 +0200
Message-Id: <20200331085432.059735760@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 575a97acc3b7446094b0dcaf6285c7c6934c2477 upstream.

The he_sr_control field is just a u8, so le32_to_cpu()
shouldn't be applied to it; this was evidently copied
from ieee80211_he_oper_size(). Fix it, and also adjust
the type of the local variable.

Fixes: ef11a931bd1c ("mac80211: HE: add Spatial Reuse element parsing support")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/r/20200325090918.dfe483b49e06.Ia53622f23b2610a2ae6ea39a199866196fe946c1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/ieee80211.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2102,14 +2102,14 @@ ieee80211_he_spr_size(const u8 *he_spr_i
 {
 	struct ieee80211_he_spr *he_spr = (void *)he_spr_ie;
 	u8 spr_len = sizeof(struct ieee80211_he_spr);
-	u32 he_spr_params;
+	u8 he_spr_params;
 
 	/* Make sure the input is not NULL */
 	if (!he_spr_ie)
 		return 0;
 
 	/* Calc required length */
-	he_spr_params = le32_to_cpu(he_spr->he_sr_control);
+	he_spr_params = he_spr->he_sr_control;
 	if (he_spr_params & IEEE80211_HE_SPR_NON_SRG_OFFSET_PRESENT)
 		spr_len++;
 	if (he_spr_params & IEEE80211_HE_SPR_SRG_INFORMATION_PRESENT)


