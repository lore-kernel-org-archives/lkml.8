Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34706C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025D720B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586490556;
	bh=AL4Duf7m5IvoTTD4d2+gCaDhn7bLAW1D0iwX6syCWJw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0ZUacKSHHVthEtDtX02vUNMO+jXk8cx1zAh+Hfo2HpKtmZVrD2nT5l4Ak1rc3nznQ
	 M7ToC5m3C8+6WaXr7pGr4WUGT3yGWj43xiWunp/j6AxAtl9cxOEz2z8lBFpvnk6NuU
	 uyMiKADIz26CDd8BivUGehurqBRYZcDizbJa5opk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDJDtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbgDJDtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:49:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0141D20B1F;
        Fri, 10 Apr 2020 03:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586490551;
        bh=AL4Duf7m5IvoTTD4d2+gCaDhn7bLAW1D0iwX6syCWJw=;
        h=From:To:Cc:Subject:Date:From;
        b=C11nvElXj5YSGfwhWLxC+DA+wtIbf7/gWujF+wP/I7l5h+2RzK+B78BedyNiidszA
         mh92NaDbPEuHJ1bnmI7IHMWxA9WbjKCOSp4M4v6VKTCj+oJA/L/vXx6rwLlQGk7xtn
         O/S25ntSI1FqVH9g0e0cNCDAVqziqpbcx4xmHPoY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 01/46] cpufreq: imx6q: Fixes unwanted cpu overclocking on i.MX6ULL
Date:   Thu,  9 Apr 2020 23:48:24 -0400
Message-Id: <20200410034909.8922-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Niedermaier <cniedermaier@dh-electronics.com>

[ Upstream commit 36eb7dc1bd42fe5f850329c893768ff89b696fba ]

imx6ul_opp_check_speed_grading is called for both i.MX6UL and i.MX6ULL.
Since the i.MX6ULL was introduced to a separate ocotp compatible node
later, it is possible that the i.MX6ULL has also dtbs with
"fsl,imx6ull-ocotp". On a system without nvmem-cell speed grade a
missing check on this node causes a driver fail without considering
the cpu speed grade.

This patch prevents unwanted cpu overclocking on i.MX6ULL with compatible
node "fsl,imx6ull-ocotp" in old dtbs without nvmem-cell speed grade.

Fixes: 2733fb0d0699 ("cpufreq: imx6q: read OCOTP through nvmem for imx6ul/imx6ull")
Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/imx6q-cpufreq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 648a09a1778a3..1fcbbd53a48a2 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -280,6 +280,9 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 		void __iomem *base;
 
 		np = of_find_compatible_node(NULL, NULL, "fsl,imx6ul-ocotp");
+		if (!np)
+			np = of_find_compatible_node(NULL, NULL,
+						     "fsl,imx6ull-ocotp");
 		if (!np)
 			return -ENOENT;
 
-- 
2.20.1

