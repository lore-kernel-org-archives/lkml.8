Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896A5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F02E20707
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 01:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgE3Bct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 21:32:49 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:37139 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgE3Bct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 21:32:49 -0400
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id A82C2200004;
        Sat, 30 May 2020 01:32:44 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: goldfish: Use correct return value for goldfish_rtc_probe()
Date:   Sat, 30 May 2020 03:32:44 +0200
Message-Id: <159080235791.311419.12086929009515039595.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1590370788-15136-1-git-send-email-yangtiezhu@loongson.cn>
References: <1590370788-15136-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 09:39:47 +0800, Tiezhu Yang wrote:
> When call function devm_platform_ioremap_resource(), we should use IS_ERR()
> to check the return value and return PTR_ERR() if failed.

Applied, thanks!

[1/2] rtc: goldfish: Use correct return value for goldfish_rtc_probe()
      commit: e712bb5c45313b3ab35ece2fb0a44cdc49548bd9
[2/2] rtc: mpc5121: Use correct return value for mpc5121_rtc_probe()
      commit: 4c2a13a2d686a7412d862802156eebd0e15df7ad

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
