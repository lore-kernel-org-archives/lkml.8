Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A71C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F882072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHQJVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:21:19 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:39241 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgHQJVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:21:18 -0400
X-Originating-IP: 176.184.36.142
Received: from localhost (sto93-h02-176-184-36-142.dsl.sta.abo.bbox.fr [176.184.36.142])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5ADC3E0006;
        Mon, 17 Aug 2020 09:21:03 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        ludovic.desroches@microchip.com, nicolas.ferre@microchip.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] AT91 PM improvements
Date:   Mon, 17 Aug 2020 11:20:45 +0200
Message-Id: <159765603097.1268970.6113229947662328094.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
References: <1596616610-15460-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 11:36:47 +0300, Claudiu Beznea wrote:
> This series adds ULP0 fast mode intended to reduce the suspend/resume
> time in the detriment of power consumption (patch 1/3).
> Along with this patch 2/3 adds code to avoid requesting a PM mode
> not available on platforms not supporting it.
> Patch 3/3 decrements a device_node refcount after its usage.
> 
> Thank you,
> Claudiu Beznea
> 
> [...]

Applied, thanks!

[1/3] ARM: at91: pm: add support for ULP0 fast wakeup
      commit: e70bfc2fa8fe1a95a522f9d1ccf24d3d9b81366a
[2/3] ARM: at91: pm: add per soc validation of pm modes
      commit: 39add36049c347dffcb2be872dd442c137625f17
[3/3] ARM: at91: pm: of_node_put() after its usage
      commit: e222f943519564978e082c152b4140a47e93392c

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
