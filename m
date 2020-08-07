Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6598FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0D82086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHGVaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:30:14 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41991 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgHGVaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:30:10 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EEE70E0005;
        Fri,  7 Aug 2020 21:30:05 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: max77686: Fix wake-ups for max77620
Date:   Fri,  7 Aug 2020 23:30:05 +0200
Message-Id: <159683578749.18787.912305362655306164.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200806125431.699339-1-jonathanh@nvidia.com>
References: <20200806125431.699339-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 13:54:31 +0100, Jon Hunter wrote:
> Following commit d8f090dbeafd ("rtc: max77686: Do not allow interrupt to
> fire before system resume"), RTC wake-ups stopped working on Jetson TX2
> and Jetson Xavier platforms. The Jetson TX2 uses the max77620 PMIC and
> the Jetson Xavier uses max20024 PMIC. Both of these PMICs have the same
> max77620 RTC controller.
> 
> For the max77620 RTC, the variable 'rtc_irq_from_platform' is defined as
> true in the max77686 driver and because of this the IRQ passed to the
> max77686 driver for RTC is the PMIC IRQ and not the parent. Hence,
> following commit d8f090dbeafd ("rtc: max77686: Do not allow interrupt to
> fire before system resume"), for the max77620 the RTC IRQ within the
> PMIC is now getting disabled on entry to suspend and unable to wake the
> system up. Fix this by only disabling interrupts on entry to suspend
> in the max77686 RTC driver, if the interrupt is the parent interrupt.

Applied, thanks!

[1/1] rtc: max77686: Fix wake-ups for max77620
      commit: 16c24801122e2961c588562f04707b98f9c84bbb

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
