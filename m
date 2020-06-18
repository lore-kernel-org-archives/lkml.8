Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F61C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B5721927
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448260;
	bh=xC3ut97fD0MLy+ms/mdfMJmo3sbdH9ILWuWNS4B9O7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JLHkmMcVOHvUm0UlwM5bV9Gyedpxktqck4xI9QsE/EqCeIcJrwoR6Kmbu466qg/bk
	 uFlpCWEfAct1MLssbFa7qVXyYvwMk8Pe98wb4gBRK7CurC3kLbG2DZ1hF2PQtngz70
	 oH/KZJJZU2PPaMM+g5+7rwbYOVktQ2APe+CitNyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbgFRCoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgFRBLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:11:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C5C21924;
        Thu, 18 Jun 2020 01:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442676;
        bh=xC3ut97fD0MLy+ms/mdfMJmo3sbdH9ILWuWNS4B9O7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WleStMkcanoz3earSaN8IuNkZTyFu60xn9H0akxxLdKXDPOGHnffoS1NCmqFkCE83
         8IictTTZ5wH0BfCUK92TgtjeSPCFUDtcWBfBNlwMb/gAh121/54th0XYRnRXUmpd5L
         b76epCNtZwGnXDjbIkLS9Sbe8+kak8YsPMMRj0V0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 5.7 144/388] staging: wfx: fix overflow in frame counters
Date:   Wed, 17 Jun 2020 21:04:01 -0400
Message-Id: <20200618010805.600873-144-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Pouiller <jerome.pouiller@silabs.com>

[ Upstream commit 87066173e34b0ca5d041d5519e6bb030b1958184 ]

It has been reported that trying to send small packets of data could
produce a "inconsistent notification" warning.

It seems that in some circumstances, the number of frame queued in the
driver could greatly increase and exceed UCHAR_MAX. So the field
"buffered" from struct sta_priv can overflow.

Just increase the size of "bueffered" to fix the problem.

Fixes: 7d2d2bfdeb82 ("staging: wfx: relocate "buffered" information to sta_priv")
Signed-off-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Link: https://lore.kernel.org/r/20200427134031.323403-10-Jerome.Pouiller@silabs.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wfx/sta.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wfx/sta.h b/drivers/staging/wfx/sta.h
index cf99a8a74a81..ace845f9ed14 100644
--- a/drivers/staging/wfx/sta.h
+++ b/drivers/staging/wfx/sta.h
@@ -37,7 +37,7 @@ struct wfx_grp_addr_table {
 struct wfx_sta_priv {
 	int link_id;
 	int vif_id;
-	u8 buffered[IEEE80211_NUM_TIDS];
+	int buffered[IEEE80211_NUM_TIDS];
 	// Ensure atomicity of "buffered" and calls to ieee80211_sta_set_buffered()
 	spinlock_t lock;
 };
-- 
2.25.1

