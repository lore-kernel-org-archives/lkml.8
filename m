Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104C6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24992075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920264;
	bh=J56mPR7oQ8513EtmCO8rcounAcUp4cDDY4KfNZJ+gQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eUGHcrIawPJeAW890CN5su4qCdDdl8ycFn5s2zwRH7obFIdZfedKs79fUdbLYSBe3
	 DoX9cp7QO3eESBlIQSQmbFjNabnGNHBjapvZ8StxYvclTzl1qvrylaqf5oLwGK2jAa
	 YToebJkvAi3o6WEAWKnlkJ15MpKYl0RE93dyGFoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731799AbgHTKoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730673AbgHTKQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:16:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B2920658;
        Thu, 20 Aug 2020 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918573;
        bh=J56mPR7oQ8513EtmCO8rcounAcUp4cDDY4KfNZJ+gQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6GOZ59F9Up/neWCj+Nf7qZZIjiJ3FdoBGN0cec/SSTB4mICxK9khyd6njxY9FYYc
         EbcMQPasnwjPktWqqFCsdktnhcIriDh6yGSnfAaftEDYcEYpZGCzwSTYxT6W14dGXD
         alNVfGt0938HY+bb8jt8Qnm2PLOCAroAJQ/IRmjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 4.14 189/228] watchdog: f71808e_wdt: indicate WDIOF_CARDRESET support in watchdog_info.options
Date:   Thu, 20 Aug 2020 11:22:44 +0200
Message-Id: <20200820091617.017255435@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit e871e93fb08a619dfc015974a05768ed6880fd82 upstream.

The driver supports populating bootstatus with WDIOF_CARDRESET, but so
far userspace couldn't portably determine whether absence of this flag
meant no watchdog reset or no driver support. Or-in the bit to fix this.

Fixes: b97cb21a4634 ("watchdog: f71808e_wdt: Fix WDTMOUT_STS register read")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200611191750.28096-3-a.fatoum@pengutronix.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/f71808e_wdt.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -690,7 +690,8 @@ static int __init watchdog_init(int sioa
 	watchdog.sioaddr = sioaddr;
 	watchdog.ident.options = WDIOC_SETTIMEOUT
 				| WDIOF_MAGICCLOSE
-				| WDIOF_KEEPALIVEPING;
+				| WDIOF_KEEPALIVEPING
+				| WDIOF_CARDRESET;
 
 	snprintf(watchdog.ident.identity,
 		sizeof(watchdog.ident.identity), "%s watchdog",


