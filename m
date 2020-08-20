Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5322122BF3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597931171;
	bh=qODI7FfI8D79fxtK+8MRpGep8DMuZaOYzP9AJdDA99k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MU6CWXjS1JkZvgLUaE3CFeOmPo6Iz9+5ZCelQYbdhBkc3KWTiu0ANaY6Tptbth8F/
	 Xe2ONcCkwbxxX9CJzBEqyzESVL1mmprZ0PR1Giw9pO2bgRRTj+ugyikyuBb12SNOdi
	 r9eEwqVWGzzkL7rEiMKOIa03KviHWuJZZVM6saCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgHTNqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727899AbgHTJ2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:28:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E471522CB1;
        Thu, 20 Aug 2020 09:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915718;
        bh=qODI7FfI8D79fxtK+8MRpGep8DMuZaOYzP9AJdDA99k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kby8K5Ffht2g/QF0thXRp/4kZGSl9FkHezrFigR3nCq8HvcnTpJ+nzbq6KvtXeq+p
         S79WneX2D7pOSx/gCkadr2oJNEsGrEioaDiaF+NrTaoFx13MFCaiTlOnxV3kNtx7uf
         i19ISaHlnPIaczrol+YgAI0hsECuCQGR8RHBkyBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 5.8 093/232] watchdog: f71808e_wdt: remove use of wrong watchdog_info option
Date:   Thu, 20 Aug 2020 11:19:04 +0200
Message-Id: <20200820091617.340152564@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

commit 802141462d844f2e6a4d63a12260d79b7afc4c34 upstream.

The flags that should be or-ed into the watchdog_info.options by drivers
all start with WDIOF_, e.g. WDIOF_SETTIMEOUT, which indicates that the
driver's watchdog_ops has a usable set_timeout.

WDIOC_SETTIMEOUT was used instead, which expands to 0xc0045706, which
equals:

   WDIOF_FANFAULT | WDIOF_EXTERN1 | WDIOF_PRETIMEOUT | WDIOF_ALARMONLY |
   WDIOF_MAGICCLOSE | 0xc0045000

These were so far indicated to userspace on WDIOC_GETSUPPORT.
As the driver has not yet been migrated to the new watchdog kernel API,
the constant can just be dropped without substitute.

Fixes: 96cb4eb019ce ("watchdog: f71808e_wdt: new watchdog driver for Fintek F71808E and F71882FG")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20200611191750.28096-4-a.fatoum@pengutronix.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/f71808e_wdt.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -690,8 +690,7 @@ static int __init watchdog_init(int sioa
 	 * into the module have been registered yet.
 	 */
 	watchdog.sioaddr = sioaddr;
-	watchdog.ident.options = WDIOC_SETTIMEOUT
-				| WDIOF_MAGICCLOSE
+	watchdog.ident.options = WDIOF_MAGICCLOSE
 				| WDIOF_KEEPALIVEPING
 				| WDIOF_CARDRESET;
 


