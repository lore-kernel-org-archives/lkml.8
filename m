Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25738C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4F10246FB
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697133;
	bh=ybrmC2rHhdfkY7gVnF0IU5j4QPB1DHBHoIR7OzmC2is=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IvbBDnCEUWuVF+bMekTrbSxq5Ppx+NKrKpkcw62XsRcb3V4mLxAJEaRmAMPejoi+q
	 yT3VWz4hCunbGfgJOq9vjgUqG4nXaiiWDAXQI+49499R7SxTLHtmQ4PgxRdQSsUm7t
	 qXBCFH028u7lexL6t4BFcVTI+fOIEvsHFg2rgHk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404228AbgBNQSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:18:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:49930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392729AbgBNQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 988FC2470A;
        Fri, 14 Feb 2020 16:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697087;
        bh=ybrmC2rHhdfkY7gVnF0IU5j4QPB1DHBHoIR7OzmC2is=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQAtDq4sj9cuPW3pppWEL4QpF2nciZpqYZVOAyGwJBgiFKAp6VwXcyupwK3XL4Hg9
         c7fNTkhCJQRF4/0ql7qK1l2qHbZlSIXSYUzgFhGPjKGmXP9ojHIBC3nv+J/5cwRDEF
         a75FSU78KRh/qe/3WPHxByjwbeFYryGMnXk5fV1Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolai Stange <nstange@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 040/186] libertas: don't exit from lbs_ibss_join_existing() with RCU read lock held
Date:   Fri, 14 Feb 2020 11:14:49 -0500
Message-Id: <20200214161715.18113-40-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 4ffc188d2ffd3..a2874f111d122 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1788,6 +1788,7 @@ static int lbs_ibss_join_existing(struct lbs_private *priv,
 		rates_max = rates_eid[1];
 		if (rates_max > MAX_RATES) {
 			lbs_deb_join("invalid rates");
+			rcu_read_unlock();
 			goto out;
 		}
 		rates = cmd.bss.rates;
-- 
2.20.1

