Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E7FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD202075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 22:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgHTWUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 18:20:05 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40959 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHTWUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 18:20:04 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id AB70520008;
        Thu, 20 Aug 2020 22:20:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        a.zummo@towertech.it
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: ds1307: Clear OSF flag on DS1388 when setting time
Date:   Fri, 21 Aug 2020 00:20:01 +0200
Message-Id: <159796199533.2240745.18390215735431825609.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818013543.4283-1-chris.packham@alliedtelesis.co.nz>
References: <20200818013543.4283-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 13:35:43 +1200, Chris Packham wrote:
> Ensure the OSF flag is cleared on the DS1388 when the clock is set.

Applied, thanks!

[1/1] rtc: ds1307: Clear OSF flag on DS1388 when setting time
      commit: f471b05f76e4b1b6ba07ebc7681920a5c5b97c5d

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
