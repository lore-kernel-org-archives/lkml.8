Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41227C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB3D20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgFZUoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:44:08 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:52375 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:44:08 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id F23A3E0005;
        Fri, 26 Jun 2020 20:44:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, ludovic.desroches@microchip.com,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        nicolas.ferre@microchip.com, robh+dt@kernel.org,
        jason@lakedaemon.net, maz@kernel.org, tglx@linutronix.de
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] add RTT support for SAM9X60
Date:   Fri, 26 Jun 2020 22:44:01 +0200
Message-Id: <159320404890.1517140.1473221944024605941.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1591779936-18577-1-git-send-email-claudiu.beznea@microchip.com>
References: <1591779936-18577-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 12:05:33 +0300, Claudiu Beznea wrote:
> This series adds RTT support for SAM9X60.
> 
> Changes in v2:
> - use "atmel,at91sam9260-rtt" as fallback for compatible
> - in patch 1 keep only the addition of sam9x60_aic_irq_fixup
> - get rid of patches 2/5 from v1
> - squash patches 4/5, 5/5 from v1
> - change commit title for patch "rtc: at91sam9: add microchip,sam9x60-rtt"
>   from v1 into "dt-bindings: rtc: add microchip,sam9x60-rtt" and
>   place it before device tree patch
> 
> [...]

Applied 2 and 3, thanks!

[2/3] dt-bindings: rtc: add microchip,sam9x60-rtt
      commit: 73554069ded8fc6fa747423522c4295d5bbf6f52
[3/3] ARM: dts: sam9x60: add rtt
      commit: 5f6b33f463468b9595eebfed142756ba13ea2b60

Best regards,

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
