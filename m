Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC52C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706012074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 02:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgE3CDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 22:03:17 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:58849 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbgE3CDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 22:03:16 -0400
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 996AD200004;
        Sat, 30 May 2020 02:03:14 +0000 (UTC)
Date:   Sat, 30 May 2020 04:03:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: rv3028: Add missed check for
 devm_regmap_init_i2c()
Message-ID: <20200530020314.GJ3972@piout.net>
References: <20200528103950.912353-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528103950.912353-1-hslester96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2020 18:39:50+0800, Chuhong Yuan wrote:
> rv3028_probe() misses a check for devm_regmap_init_i2c().
> Add the missed check to fix it.
> 
> Fixes: e6e7376cfd7b ("rtc: rv3028: add new driver")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Add fixes tag.
> 
>  drivers/rtc/rtc-rv3028.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Actually, this is the one I applied.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
