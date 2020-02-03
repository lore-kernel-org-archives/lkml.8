Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED51BC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CD1217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747563;
	bh=gmdhob6KOz5MnFgokEv9xP6qg2mwuk7AnCDlJ8CzVGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PQCeiCLfsyCqGwOD4QXQyil4AZPjuRDqWkAbzFhlKDMHHrhsphv3L3wQV/mLUgd9I
	 IVt9bw5zv34KQYtkw6aKh6fcV59rTCXKfAaGQD5Qc4QdyTR1ejQqiLe+W9Mhm6H5bb
	 eTKfEzGuCzt8ocLDo+BNHLMb0qT8QaSQJLO+X5Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgBCQcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730446AbgBCQch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:32:37 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E8AB218AC;
        Mon,  3 Feb 2020 16:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747556;
        bh=gmdhob6KOz5MnFgokEv9xP6qg2mwuk7AnCDlJ8CzVGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oO1YoOI2BFlDxN0RoZL5B7b33gmtdC+vs/K1KfK083OjW9esmboGdfQ2dY1caHzRM
         gnVqalBZporGbrQZvZDVkvZlE9vISxxbLy9X7yLaZEvrW2s6IZNB6atnwdPzpUNBAX
         53rOOOpEsvIpy3Z7Fiy/0L4GqKjMHhSqEh/E0wrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cathy Luo <xiaohua.luo@nxp.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 42/70] wireless: fix enabling channel 12 for custom regulatory domain
Date:   Mon,  3 Feb 2020 16:19:54 +0000
Message-Id: <20200203161918.472611354@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161912.158976871@linuxfoundation.org>
References: <20200203161912.158976871@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ganapathi Bhat <ganapathi.bhat@nxp.com>

[ Upstream commit c4b9d655e445a8be0bff624aedea190606b5ebbc ]

Commit e33e2241e272 ("Revert "cfg80211: Use 5MHz bandwidth by
default when checking usable channels"") fixed a broken
regulatory (leaving channel 12 open for AP where not permitted).
Apply a similar fix to custom regulatory domain processing.

Signed-off-by: Cathy Luo <xiaohua.luo@nxp.com>
Signed-off-by: Ganapathi Bhat <ganapathi.bhat@nxp.com>
Link: https://lore.kernel.org/r/1576836859-8945-1-git-send-email-ganapathi.bhat@nxp.com
[reword commit message, fix coding style, add a comment]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/reg.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 5643bdee7198f..4c3c8a1c116da 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2254,14 +2254,15 @@ static void update_all_wiphy_regulatory(enum nl80211_reg_initiator initiator)
 
 static void handle_channel_custom(struct wiphy *wiphy,
 				  struct ieee80211_channel *chan,
-				  const struct ieee80211_regdomain *regd)
+				  const struct ieee80211_regdomain *regd,
+				  u32 min_bw)
 {
 	u32 bw_flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
 	const struct ieee80211_power_rule *power_rule = NULL;
 	u32 bw;
 
-	for (bw = MHZ_TO_KHZ(20); bw >= MHZ_TO_KHZ(5); bw = bw / 2) {
+	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
 		reg_rule = freq_reg_info_regd(MHZ_TO_KHZ(chan->center_freq),
 					      regd, bw);
 		if (!IS_ERR(reg_rule))
@@ -2317,8 +2318,14 @@ static void handle_band_custom(struct wiphy *wiphy,
 	if (!sband)
 		return;
 
+	/*
+	 * We currently assume that you always want at least 20 MHz,
+	 * otherwise channel 12 might get enabled if this rule is
+	 * compatible to US, which permits 2402 - 2472 MHz.
+	 */
 	for (i = 0; i < sband->n_channels; i++)
-		handle_channel_custom(wiphy, &sband->channels[i], regd);
+		handle_channel_custom(wiphy, &sband->channels[i], regd,
+				      MHZ_TO_KHZ(20));
 }
 
 /* Used by drivers prior to wiphy registration */
-- 
2.20.1



