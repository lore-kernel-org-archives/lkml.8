Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E7DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15CEB206B9
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944000;
	bh=JBZn2eZWhVoMDMqiSBAAvAthotH6EXetLCwAy9dZPuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SmM5SfXczHczgXjxRcxCKUnx/Xej5peJJH/EeX/NEzgBMCz0rdFtKusyuafOgR9PT
	 UWDFCEDjD6x8Vn7zMhheRkBbslt7DdXdekXAx+zrRwoPYWJUZfOv99FqJe+oUw7XT2
	 d9R7h6+n5+bBsQ3mTm6KJml5JJZn+p5uggJrabPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgEHNT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:19:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgEHMlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:41:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9B4121835;
        Fri,  8 May 2020 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941680;
        bh=JBZn2eZWhVoMDMqiSBAAvAthotH6EXetLCwAy9dZPuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ou6Z07ov7WRslRFB0eUuw+4k24AxUAA06EVrFf7tw0UHyG5nvVUAEIGTtVy2wf0qs
         yBizTmuPVI+sADUZFPhrEcF3m69/jeTjSaBXW6f4d7bp8G19DxPMmpcy5tJ8QnUXpZ
         9Y/d9MXpy1iVYSRtflR0OPVk71mKw8h7morGKmz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 129/312] mac80211: Fix BW upgrade for TDLS peers
Date:   Fri,  8 May 2020 14:32:00 +0200
Message-Id: <20200508123133.579725395@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

commit 4b559ec0bfc3a9f41a127cea6964f38b2b4bb323 upstream.

It is possible that the station is connected to an AP
with bandwidth of 80+80MHz or 160MHz. In such cases
there is no need to perform an upgrade as the maximal
supported bandwidth is 80MHz.

In addition, when upgrading and setting center_freq1
and bandwidth to 80MHz also set center_freq2 to 0.

Fixes: 0fabfaafec3a ("mac80211: upgrade BW of TDLS peers when possible"
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/mac80211/tdls.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -314,7 +314,7 @@ ieee80211_tdls_chandef_vht_upgrade(struc
 	if (max_width > NL80211_CHAN_WIDTH_80)
 		max_width = NL80211_CHAN_WIDTH_80;
 
-	if (uc.width == max_width)
+	if (uc.width >= max_width)
 		return;
 	/*
 	 * Channel usage constrains in the IEEE802.11ac-2013 specification only
@@ -325,6 +325,7 @@ ieee80211_tdls_chandef_vht_upgrade(struc
 	for (i = 0; i < ARRAY_SIZE(centers_80mhz); i++)
 		if (abs(uc.chan->center_freq - centers_80mhz[i]) <= 30) {
 			uc.center_freq1 = centers_80mhz[i];
+			uc.center_freq2 = 0;
 			uc.width = NL80211_CHAN_WIDTH_80;
 			break;
 		}


