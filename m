Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B845AC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E41620787
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 10:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJKSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 06:18:37 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38332 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDJKSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:18:36 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id D106720029;
        Fri, 10 Apr 2020 12:18:32 +0200 (CEST)
Date:   Fri, 10 Apr 2020 12:18:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: drm/tve200: Checking for a failed platform_get_irq() call in
 tve200_probe()
Message-ID: <20200410101831.GA27723@ravnborg.org>
References: <0263f4fb-c349-7651-b590-8722cdd30c85@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0263f4fb-c349-7651-b590-8722cdd30c85@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=eMA9ckh1 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=IkcTkHD0fZMA:10 a=P-IC7800AAAA:8
        a=VwQbUJbxAAAA:8 a=JCZqW-9RZpn1hzHRehAA:9 a=MPcP9uqrSlW2Lgt8:21
        a=4ciHVacbEfDAk_G1:21 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus.

On Thu, Apr 09, 2020 at 03:05:17PM +0200, Markus Elfring wrote:
> Hello,
> 
> I have taken another look at the implementation of the function “tve200_probe”.
> A software analysis approach points the following source code out for
> further development considerations.
> https://elixir.bootlin.com/linux/v5.6.3/source/drivers/gpu/drm/tve200/tve200_drv.c#L212
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/tve200/tve200_drv.c?id=5d30bcacd91af6874481129797af364a53cd9b46#n212
> 
> 	irq = platform_get_irq(pdev, 0);
> 	if (!irq) {
> 		ret = -EINVAL;
> 		goto clk_disable;
> 	}
> 
> 
> The software documentation is providing the following information
> for the used programming interface.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c?id=5d30bcacd91af6874481129797af364a53cd9b46#n221
> https://elixir.bootlin.com/linux/v5.6.3/source/drivers/base/platform.c#L202
> 
> “…
>  * Return: IRQ number on success, negative error number on failure.
> …”
> 
> Would you like to reconsider the shown condition check?
Thansk for spotting this.

The right way to check for errors is to check if the return value is
less than 0.
Could you please audit all uses of platform_get_irq() in drivers/gpu/
and send a series of patches, one for each driver.

A quick "git grep -C 5 platform_get_irq" identified a few extra drivers
that does not implement the recommend way to check for errors.

Try to be a bit more terse in the changelog - but refer to
the documentation of platform_get_irq():

 * Example:
 *		int irq = platform_get_irq(pdev, 0);
 *		if (irq < 0)
 *			return irq;

Easier to embed it - rather than to link it.
Fine with links in the intro mail.

 	Sam
