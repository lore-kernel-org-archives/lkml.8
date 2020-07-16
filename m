Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE942074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgGPJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:29:54 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:56719 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgGPJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:29:53 -0400
Received: from localhost (lfbn-lyo-1-1676-121.w90-65.abo.wanadoo.fr [90.65.108.121])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 572EA100036;
        Thu, 16 Jul 2020 09:28:50 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] rtc: pl031: fix set_alarm by adding back call to alarm_irq_enable
Date:   Thu, 16 Jul 2020 11:28:48 +0200
Message-Id: <159489162374.11068.17476364476005647206.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714124556.20294-1-sudeep.holla@arm.com>
References: <20200714124556.20294-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 13:45:56 +0100, Sudeep Holla wrote:
> Commit c8ff5841a90b ("rtc: pl031: switch to rtc_time64_to_tm/rtc_tm_to_time64")
> seemed to have accidentally removed the call to pl031_alarm_irq_enable
> from pl031_set_alarm while switching to 64-bit apis.
> 
> Let us add back the same to get the set alarm functionality back.

Applied, thanks!

[1/1] rtc: pl031: fix set_alarm by adding back call to alarm_irq_enable
      commit: 4df2ef85f0efe44505f511ca5e4455585f53a2da

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
