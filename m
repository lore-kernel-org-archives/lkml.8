Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B022054F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923707;
	bh=UUrS1yBUSa9rxTrMyNiRGKbwDpz6ndKaUEJYbS4t3sA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n+qYavG5MdFQigK/vFC1LS2v5RnGMT3+LLwXhZQW5cFnSKVoxQVPpkGDtxZOeQtxJ
	 Dot68vfUHhYWDKFIRe2u7imyWCQsehJI0z/9I6BnPsH98Z+OMJgxeOZCPy4k0HmoHe
	 kaK7OeKnSedAFbTiaYhjCKnShOpK1OCZN89AESUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbgHTLlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbgHTKEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:04:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1AF422CA0;
        Thu, 20 Aug 2020 10:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917878;
        bh=UUrS1yBUSa9rxTrMyNiRGKbwDpz6ndKaUEJYbS4t3sA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTOgGri1EyaAITT5QCybCi9feux1brjzd+tHKT7Memu66aqSSdJr5G6Dt+hTQhSX2
         eZLZcl3O6tUlgafChv0qi1agRHZmYUJ06vIkf4MP60yqw0+Tg6HdmgLTNaDrMJmnZ+
         uqhzwPCSSh8adcPqZMMiFYCkeCEDnJKRJW/uzsMk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Subject: [PATCH 4.9 189/212] watchdog: f71808e_wdt: remove use of wrong watchdog_info option
Date:   Thu, 20 Aug 2020 11:22:42 +0200
Message-Id: <20200820091611.927461222@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091602.251285210@linuxfoundation.org>
References: <20200820091602.251285210@linuxfoundation.org>
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
@@ -688,8 +688,7 @@ static int __init watchdog_init(int sioa
 	 * into the module have been registered yet.
 	 */
 	watchdog.sioaddr = sioaddr;
-	watchdog.ident.options = WDIOC_SETTIMEOUT
-				| WDIOF_MAGICCLOSE
+	watchdog.ident.options = WDIOF_MAGICCLOSE
 				| WDIOF_KEEPALIVEPING
 				| WDIOF_CARDRESET;
 


