Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64722063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGPJP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:15:28 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:9461 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPJP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:15:27 -0400
X-Originating-IP: 90.65.108.121
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 57FAA240004;
        Thu, 16 Jul 2020 09:15:24 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] rtc: max77686: Do not allow interrupt to fire before system resume
Date:   Thu, 16 Jul 2020 11:15:24 +0200
Message-Id: <159489082551.8339.14774575575042463785.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615161455.4420-1-krzk@kernel.org>
References: <20200615161455.4420-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 18:14:55 +0200, Krzysztof Kozlowski wrote:
> The rtc-max77686 device shares the main interrupt line with parent MFD
> device (max77686 driver).  During the system suspend, the parent MFD
> device disables this IRQ to prevent an early event happening before
> resuming I2C bus controller.
> 
> The same should be done by rtc-max77686 driver because otherwise the
> interrupt handler max77686_rtc_alarm_irq() will be called before its
> resume function (max77686_rtc_resume()).  Such issue is not fatal but
> disabling shared IRQ by all users ensures correct behavior.

Applied, thanks!

[1/1] rtc: max77686: Do not allow interrupt to fire before system resume
      commit: d8f090dbeafdcc3d30761aa0062f19d1adf9ef08

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
