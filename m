Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF5EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6432320715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825574;
	bh=xKyfeEiHGfJHW6bGppshms0IL7S4z485dpab60U8Bt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gQ3LC2mp1nD3x1FaySr/iv7S2fDzg9jzZ/gjXv3h/oC18r80o5q9/GV6FzVnAZuVR
	 i0IzD3y6vECtEedlFthWIbWpMqSnbTYx9poM2rwRZdLOIk+x9YMKlHGWbufTwuhRUl
	 RgdihR4v1FK5QEQFLxC2361vTvjTmFNVSYD5NqaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733115AbgERSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:12:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbgERSCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:02:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFCA20715;
        Mon, 18 May 2020 18:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824968;
        bh=xKyfeEiHGfJHW6bGppshms0IL7S4z485dpab60U8Bt4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYzFPv3CrjJNGRrkwRrvRa+fzCVFs9RfmZbX+GBgGt3O4ugBas6NR4NQKjPpjV4GA
         T9LMzupi6ulUmWE/vZvCpnzmnqbbn6cFlXDbug2t6ZjYwHL6URWgrnOwr2bXezpu+x
         ONc4kJVOGY2847KguXoGEnv0k8NuMW3yw8IdUFR0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 075/194] pinctrl: sunrisepoint: Fix PAD lock register offset for SPT-H
Date:   Mon, 18 May 2020 19:36:05 +0200
Message-Id: <20200518173538.046214538@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 6b7275c87717652daace4c0b8131eb184c7d7516 ]

It appears that SPT-H variant has different offset for PAD locking registers.
Fix it here.

Fixes: 551fa5801ef1 ("pinctrl: intel: sunrisepoint: Add Intel Sunrisepoint-H support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
index 330c8f077b73a..4d7a86a5a37b0 100644
--- a/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
+++ b/drivers/pinctrl/intel/pinctrl-sunrisepoint.c
@@ -15,17 +15,18 @@
 
 #include "pinctrl-intel.h"
 
-#define SPT_PAD_OWN	0x020
-#define SPT_PADCFGLOCK	0x0a0
-#define SPT_HOSTSW_OWN	0x0d0
-#define SPT_GPI_IS	0x100
-#define SPT_GPI_IE	0x120
+#define SPT_PAD_OWN		0x020
+#define SPT_H_PADCFGLOCK	0x090
+#define SPT_LP_PADCFGLOCK	0x0a0
+#define SPT_HOSTSW_OWN		0x0d0
+#define SPT_GPI_IS		0x100
+#define SPT_GPI_IE		0x120
 
 #define SPT_COMMUNITY(b, s, e)				\
 	{						\
 		.barno = (b),				\
 		.padown_offset = SPT_PAD_OWN,		\
-		.padcfglock_offset = SPT_PADCFGLOCK,	\
+		.padcfglock_offset = SPT_LP_PADCFGLOCK,	\
 		.hostown_offset = SPT_HOSTSW_OWN,	\
 		.is_offset = SPT_GPI_IS,		\
 		.ie_offset = SPT_GPI_IE,		\
@@ -47,7 +48,7 @@
 	{						\
 		.barno = (b),				\
 		.padown_offset = SPT_PAD_OWN,		\
-		.padcfglock_offset = SPT_PADCFGLOCK,	\
+		.padcfglock_offset = SPT_H_PADCFGLOCK,	\
 		.hostown_offset = SPT_HOSTSW_OWN,	\
 		.is_offset = SPT_GPI_IS,		\
 		.ie_offset = SPT_GPI_IE,		\
-- 
2.20.1



