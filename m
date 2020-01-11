Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5749BC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD34205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737774;
	bh=0xQ8P7yf+V4sMgR1H+CJZnw+jxrvwqav9Q7bf4FpDVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jqOJh1+u5lHprJuRv82q/KE1Rh4mm7P9IojaDWp8WzJQgVExY0KHrqAb4lAgG0Tqo
	 TuQm2uIx7b1Rjjo+14jOIlo/jul4/nnSvQ+Tz9tlMGAUvg3gpTpMNmu9+4vvTLT/dX
	 zM9Te94Y1seZh2zQOUBz1GoWLfxcUIhoWXTeNwyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgAKKQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729748AbgAKKQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:16:07 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 131D1205F4;
        Sat, 11 Jan 2020 10:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737766;
        bh=0xQ8P7yf+V4sMgR1H+CJZnw+jxrvwqav9Q7bf4FpDVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHHXZ18cXZ1t2hkV+8y8MZLnWKnWecpYhsR3VV4SBJjHQ/Y3qjivvJ+dIFQvd0yMT
         9k2dcfktxlxWde+/IhdrAktUWEmfYRDrGR5mEOiSP7YVGhAfizNzzICQjd0HR8vm3M
         gmnPfKe/Sw2NMQisgJiYNqf5Dwwn91XCKZU7SlJI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 41/84] rfkill: Fix incorrect check to avoid NULL pointer dereference
Date:   Sat, 11 Jan 2020 10:50:18 +0100
Message-Id: <20200111094901.927519712@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 6fc232db9e8cd50b9b83534de9cd91ace711b2d7 ]

In rfkill_register, the struct rfkill pointer is first derefernced
and then checked for NULL. This patch removes the BUG_ON and returns
an error to the caller in case rfkill is NULL.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Link: https://lore.kernel.org/r/20191215153409.21696-1-pakki001@umn.edu
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/core.c b/net/rfkill/core.c
index 7fbc8314f626..d6467cbf5c4f 100644
--- a/net/rfkill/core.c
+++ b/net/rfkill/core.c
@@ -1014,10 +1014,13 @@ static void rfkill_sync_work(struct work_struct *work)
 int __must_check rfkill_register(struct rfkill *rfkill)
 {
 	static unsigned long rfkill_no;
-	struct device *dev = &rfkill->dev;
+	struct device *dev;
 	int error;
 
-	BUG_ON(!rfkill);
+	if (!rfkill)
+		return -EINVAL;
+
+	dev = &rfkill->dev;
 
 	mutex_lock(&rfkill_global_mutex);
 
-- 
2.20.1



