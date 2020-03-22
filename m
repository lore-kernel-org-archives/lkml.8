Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD22C54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D264206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 21:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCVVMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 17:12:40 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:51607 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgCVVMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 17:12:39 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 623B0C000B;
        Sun, 22 Mar 2020 21:12:38 +0000 (UTC)
Date:   Sun, 22 Mar 2020 22:12:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        ran.wang_1@nxp.com, biwen.li@nxp.com
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: enable acpi support
Message-ID: <20200322211237.GD221863@piout.net>
References: <20200318025354.6447-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318025354.6447-1-peng.ma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/03/2020 10:53:54+0800, Peng Ma wrote:
> This patch enables ACPI support in Rtc Flex timer driver.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  drivers/rtc/rtc-fsl-ftm-alarm.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
