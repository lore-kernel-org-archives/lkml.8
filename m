Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E565C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668FE229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752966;
	bh=R6f4U+OYaJFFxN9ZSs50CqruOxIj0i8N5fkIQB0UPt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dAjLBTG6NA3wX/McXEsBkyFbnSA0H3iL6D5ow5hAQg8bdHKDZN5zE2X2+FxZ7SdTz
	 QHXSMD5JJZZDcwEMqxRBab6kwxLt0Cs6f7xGhDGsaNLhP7q1XGejhj/ZANUBSZ/mrE
	 QZaPX6cYKZyq96mVOk859Z26VfEcz31I9g89q0dM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730939AbgGNS4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:56:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730927AbgGNSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:55:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3FF0229CA;
        Tue, 14 Jul 2020 18:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752957;
        bh=R6f4U+OYaJFFxN9ZSs50CqruOxIj0i8N5fkIQB0UPt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsCrNNLtskVrQlzsGm0qc7WaIWjWzrxF6LPPPYWXcuTNYc+EISoFrQXF59S0JurGR
         FBaFAgiK54cLkydb/gtiPyCDn7/aAxoxts7cc4Nw8mmbnwBhvofV8V26LFHXDTVEbu
         dYsGZckQMRW8V/TVXwIsDLJIdxcCqsHYTEbbpv3s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 057/166] nl80211: fix memory leak when parsing NL80211_ATTR_HE_BSS_COLOR
Date:   Tue, 14 Jul 2020 20:43:42 +0200
Message-Id: <20200714184118.604391839@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

[ Upstream commit 60a0121f8fa64b0f4297aa6fef8207500483a874 ]

If there is an error when parsing the NL80211_ATTR_HE_BSS_COLOR
attribute, we return immediately without freeing param.acl.  Fit it by
using goto out instead of returning immediately.

Fixes: 5c5e52d1bb96 ("nl80211: add handling for BSS color")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Link: https://lore.kernel.org/r/iwlwifi.20200626124931.7ad2a3eb894f.I60905fb70bd20389a3b170db515a07275e31845e@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index a56ede64e70fc..7ae6b90e0d264 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5013,7 +5013,7 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
 					info->attrs[NL80211_ATTR_HE_BSS_COLOR],
 					&params.he_bss_color);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	nl80211_calculate_ap_params(&params);
-- 
2.25.1



