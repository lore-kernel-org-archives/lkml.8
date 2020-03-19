Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F78C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5464620663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625114;
	bh=NjDtdMyGhV1PjDxXEszjBKSlYA/uWjw5FVglPfxVC6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cpn4KbzhSXBg2uz7IFXm1Y4yIXaX5ovczsONXpP+FYRtTHM9FgveWc/w8f5XqiO7
	 OQvAuAj9pVgEkNSk0/xi08rEwwF/sB7KTdSiP1mNxMREZgsvONZ2eXZ7RyjC+p2/le
	 iClkzEoSbUvAbG6+9JnKGELwgV3G4NX7unCQkVng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCSNid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:38:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbgCSNGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:06:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A807207FC;
        Thu, 19 Mar 2020 13:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623165;
        bh=NjDtdMyGhV1PjDxXEszjBKSlYA/uWjw5FVglPfxVC6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rsw3nNz+aSmqiiYW+cO5hc7CELMWOgdDrPYQS3ML9H32kKHaBQouVMIYsbQscWbKX
         gJVDDSLtqlbCGCbAj9lSb302Q0XznbSq4ZGjkyCEtExzmec/x9f2GCyDxh2kGDCMmE
         rJ8QGwEhxmDA1fLPfxPTYLI3sj4l0Fl+tkLELwk4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.4 30/93] nl80211: add missing attribute validation for critical protocol indication
Date:   Thu, 19 Mar 2020 13:59:34 +0100
Message-Id: <20200319123934.629726211@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123924.795019515@linuxfoundation.org>
References: <20200319123924.795019515@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>

commit 0e1a1d853ecedc99da9d27f9f5c376935547a0e2 upstream.

Add missing attribute validation for critical protocol fields
to the netlink policy.

Fixes: 5de17984898c ("cfg80211: introduce critical protocol indication from user-space")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Link: https://lore.kernel.org/r/20200303051058.4089398-2-kuba@kernel.org
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/wireless/nl80211.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -404,6 +404,8 @@ static const struct nla_policy nl80211_p
 	[NL80211_ATTR_MDID] = { .type = NLA_U16 },
 	[NL80211_ATTR_IE_RIC] = { .type = NLA_BINARY,
 				  .len = IEEE80211_MAX_DATA_LEN },
+	[NL80211_ATTR_CRIT_PROT_ID] = { .type = NLA_U16 },
+	[NL80211_ATTR_MAX_CRIT_PROT_DURATION] = { .type = NLA_U16 },
 	[NL80211_ATTR_PEER_AID] = { .type = NLA_U16 },
 	[NL80211_ATTR_CH_SWITCH_COUNT] = { .type = NLA_U32 },
 	[NL80211_ATTR_CH_SWITCH_BLOCK_TX] = { .type = NLA_FLAG },


