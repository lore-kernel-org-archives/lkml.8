Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9A2C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB3E207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgHTWTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:19:22 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:34259 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:19:21 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D7E7060003;
        Thu, 20 Aug 2020 22:19:17 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: Ensure oscillator is enabled for DS1388
Date:   Fri, 21 Aug 2020 00:19:17 +0200
Message-Id: <159796194488.2240479.15277965351835243042.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200816235731.21071-1-chris.packham@alliedtelesis.co.nz>
References: <20200816235731.21071-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 11:57:31 +1200, Chris Packham wrote:
> Similar to the other variants the DS1388 has a bit to stop the
> oscillator to reduce the power consumption from VBAT. Ensure that the
> oscillator is enabled when the system is up.

Applied, thanks!

[1/1] rtc: ds1307: Ensure oscillator is enabled for DS1388
      commit: 59ed0127155201863db49f3dc5fb41316433340a

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
