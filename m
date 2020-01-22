Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02B9FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BBD24690
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699360;
	bh=THZTOQTBOsJRrzlwegB7sVd2vR3v8N9OdsvPhENhc5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zIPcKhliaESFK8krngL+rRMz5X4Lvj18pOSGxk22WyRfn7TMwNYRdM5KQ+rKZfvAP
	 nwSykYSwN9s7Ey6p5SiTBg7JHzlgcT23lUwDhJhKit76WSvZOBzoFQbBQwY+LBfLxT
	 f8W0ssgUYzVU5vYChLWrEJMTM498GkBmNLubQgAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730633AbgAVNWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgAVNWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:22:38 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71CCF24690;
        Wed, 22 Jan 2020 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699358;
        bh=THZTOQTBOsJRrzlwegB7sVd2vR3v8N9OdsvPhENhc5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yM2ptP1WXt38YUkHMqz5eeT6rUhN1FAtgiwv5A3hVJP+7JnRss9XSRXvv6vYoPi+E
         B0xjXmbtLcdFfqyMKNnPZNwULURTmX3ek1HH3sYEW6gV+fyEYPCt1T+Ec2J5ev4uTT
         jD+Zq1hjyS7vlwZq0t2aLiqCR4rLSF7V5zfEDyWU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.4 120/222] cfg80211: fix memory leak in cfg80211_cqm_rssi_update
Date:   Wed, 22 Jan 2020 10:28:26 +0100
Message-Id: <20200122092842.331958509@linuxfoundation.org>
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

From: Felix Fietkau <nbd@nbd.name>

commit df16737d438f534d0cc9948c7c5158f1986c5c87 upstream.

The per-tid statistics need to be released after the call to rdev_get_station

Cc: stable@vger.kernel.org
Fixes: 8689c051a201 ("cfg80211: dynamically allocate per-tid stats for station info")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://lore.kernel.org/r/20200108170630.33680-2-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -10834,6 +10834,7 @@ static int cfg80211_cqm_rssi_update(stru
 		if (err)
 			return err;
 
+		cfg80211_sinfo_release_content(&sinfo);
 		if (sinfo.filled & BIT_ULL(NL80211_STA_INFO_BEACON_SIGNAL_AVG))
 			wdev->cqm_config->last_rssi_event_value =
 				(s8) sinfo.rx_beacon_signal_avg;


