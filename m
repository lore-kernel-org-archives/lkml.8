Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216BAC3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC19E24686
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581609048;
	bh=itWkoEn71T71AO/soIL9Y/hO0hjGCrgB5AHWBByO/GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G3itzni4HsyxHixdNg/gVvmXrZqNyDmhZiHeG5Y0d/wucD4PY/3NCbqRl8KfDrPdG
	 rU8CTdBhPqmoAzHvRFQqtmk3ZsfT4JV/G9NTpQDYmvuphpAYtNsN87I9p3eS6YDqGm
	 BxznyBKHsKZITBDXiiChLCquVAHrHIajpFkMlBFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387541AbgBMP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgBMPY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:29 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0031E246B5;
        Thu, 13 Feb 2020 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607469;
        bh=itWkoEn71T71AO/soIL9Y/hO0hjGCrgB5AHWBByO/GU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2a5ZPWaTHDiPzPvbxJo3aqTrOaDC8KB0mtwn8S2JK/sZiX6McdHMSfV16PYKWSaEF
         64mAtaiKmk6QODhDx8fa5zVcX8oEa+p7uAqy53BpQfAQh9dC0Vg7iRGD3HLhwXISqt
         C+04wRy4ApZHlV7F4XBDZIevIHJsy4/VcYqlRhgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolai Stange <nstange@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 115/116] libertas: dont exit from lbs_ibss_join_existing() with RCU read lock held
Date:   Thu, 13 Feb 2020 07:20:59 -0800
Message-Id: <20200213151926.470618981@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolai Stange <nstange@suse.de>

[ Upstream commit c7bf1fb7ddca331780b9a733ae308737b39f1ad4 ]

Commit e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss
descriptor") introduced a bounds check on the number of supplied rates to
lbs_ibss_join_existing().

Unfortunately, it introduced a return path from within a RCU read side
critical section without a corresponding rcu_read_unlock(). Fix this.

Fixes: e5e884b42639 ("libertas: Fix two buffer overflows at parsing bss descriptor")
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 3eab802c7d3f3..0b61942fedd90 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1859,6 +1859,7 @@ static int lbs_ibss_join_existing(struct lbs_private *priv,
 		rates_max = rates_eid[1];
 		if (rates_max > MAX_RATES) {
 			lbs_deb_join("invalid rates");
+			rcu_read_unlock();
 			goto out;
 		}
 		rates = cmd.bss.rates;
-- 
2.20.1



