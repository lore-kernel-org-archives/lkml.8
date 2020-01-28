Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63211C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE2B2468E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221152;
	bh=ew8TtFAbGh0YDWog97CRPrqFZI6pcvWQx7snqRfgzCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=02lr+l8pETFFMaMrXYSk2WXo8zHJICYei1tb8/nUUAy8c2EgZw3fy5HyxVkHeoiLm
	 bKYqZmxRzWojPnUe4Sa89qGKUHiYavJ7lOJmpcubfdIdjHwu4jCPi2F/Nk5evdlTKM
	 etWw3mOTDOzfaE4c5WmYY8HsaDTBv3PRqsLzm+iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgA1OTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:19:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730795AbgA1OTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:19:07 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B091421739;
        Tue, 28 Jan 2020 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221147;
        bh=ew8TtFAbGh0YDWog97CRPrqFZI6pcvWQx7snqRfgzCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qDZDVz19ulTXIiQjsw7HQ1nCjcXc0Osg6ahc9WLH03+ImbZW5UQLqGltxOBcASRaO
         METQo1WyhmaHzFXYZ3RJB+b8OXgD0sBYq3JdKINzcNV36ozem/T9gd2rOXP2SA1le0
         OT1UPqMBqEINgIqNVuEZgWI/JB77hvoYy/Ema5tg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Walmsley <paul@pwsan.com>,
        Tero Kristo <t-kristo@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 106/271] ARM: OMAP2+: Fix potentially uninitialized return value for _setup_reset()
Date:   Tue, 28 Jan 2020 15:04:15 +0100
Message-Id: <20200128135900.475700264@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 7f0d078667a494466991aa7133f49594f32ff6a2 ]

Commit 747834ab8347 ("ARM: OMAP2+: hwmod: revise hardreset behavior") made
the call to _enable() conditional based on no oh->rst_lines_cnt. This
caused the return value to be potentially uninitialized. Curiously we see
no compiler warnings for this, probably as this gets inlined.

We call _setup_reset() from _setup() and only _setup_postsetup() if the
return value is zero. Currently the return value can be uninitialized for
cases where oh->rst_lines_cnt is set and HWMOD_INIT_NO_RESET is not set.

Fixes: 747834ab8347 ("ARM: OMAP2+: hwmod: revise hardreset behavior")
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bfc74954540ce..9421b78f869d3 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2588,7 +2588,7 @@ static void _setup_iclk_autoidle(struct omap_hwmod *oh)
  */
 static int _setup_reset(struct omap_hwmod *oh)
 {
-	int r;
+	int r = 0;
 
 	if (oh->_state != _HWMOD_STATE_INITIALIZED)
 		return -EINVAL;
-- 
2.20.1



