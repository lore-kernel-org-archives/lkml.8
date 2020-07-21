Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F84FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF71A2065E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730612AbgGUQrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:47:08 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:41450 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgGUQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:47:05 -0400
Received: from [78.134.114.177] (port=54080 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1jxvPx-0009Zq-RO; Tue, 21 Jul 2020 18:47:02 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-clk@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Subject: [PATCH v3 2/4] MAINTAINERS: take over IDT VersaClock 5 clock driver
Date:   Tue, 21 Jul 2020 18:46:53 +0200
Message-Id: <20200721164655.422-2-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200721164655.422-1-luca@lucaceresoli.net>
References: <20200721164655.422-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek has been the primary developer of this driver (thanks!). Now as
he is not working on it anymore he suggested I take over maintainership.

Cc: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes in v3: none
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 931c78a5e035..8e323ffddea0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8325,7 +8325,7 @@ W:	https://github.com/o2genum/ideapad-slidebar
 F:	drivers/input/misc/ideapad_slidebar.c
 
 IDT VersaClock 5 CLOCK DRIVER
-M:	Marek Vasut <marek.vasut@gmail.com>
+M:	Luca Ceresoli <luca@lucaceresoli.net>
 S:	Maintained
 F:	drivers/clk/clk-versaclock5.c
 
-- 
2.27.0

