Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 283D72070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgGQXA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:00:28 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:33499 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:00:28 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C0B93FF802;
        Fri, 17 Jul 2020 23:00:25 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     nicolas.ferre@microchip.com, linux-kernel@vger.kernel.org,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        ludovic.desroches@microchip.com,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] ARM: at91: Replace HTTP links with HTTPS ones
Date:   Sat, 18 Jul 2020 01:00:23 +0200
Message-Id: <159502678064.777887.13839495855154386922.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713065859.31770-1-grandmaster@al2klimov.de>
References: <20200713065859.31770-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 08:58:59 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.

Applied, thanks!

[1/1] ARM: at91: Replace HTTP links with HTTPS ones
      commit: f3a49f17845d81a032b83ef102fb24ffb2dfb3a0

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
