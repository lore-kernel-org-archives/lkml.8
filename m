Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E85C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B281620707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHZHqj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHZHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:46:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A124C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 00:46:38 -0700 (PDT)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAq8T-00014I-FH; Wed, 26 Aug 2020 09:46:21 +0200
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kAq8S-0003zE-FX; Wed, 26 Aug 2020 09:46:20 +0200
Message-ID: <6a4757e808c2201dc212d1ccf63310b3fd5b2268.camel@pengutronix.de>
Subject: Re: [PATCH v2 11/17] clk: imx: Add blk_ctrl combo driver
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, Rob Herring <robh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 26 Aug 2020 09:46:20 +0200
In-Reply-To: <20200825183009.olarh5ewkljeh35d@fsr-ub1664-175>
References: <1597406966-13740-1-git-send-email-abel.vesa@nxp.com>
         <1597406966-13740-12-git-send-email-abel.vesa@nxp.com>
         <ea2563fcb456830b37b0031455e5054d6b81c680.camel@pengutronix.de>
         <20200825112421.eut7gx3i4eirhnfw@fsr-ub1664-175>
         <8e8e33386eea12036bb17529b4d578704bf735d1.camel@pengutronix.de>
         <20200825183009.olarh5ewkljeh35d@fsr-ub1664-175>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-25 at 21:30 +0300, Abel Vesa wrote:
[...]
> > 	if (assert)
> > 		pm_runtime_get_sync();
> > 	spin_lock_irqsave();
> > 	/* ... */
> > 	spin_unlock_irqrestore();
> > 	if (assert && asserted_before)
> > 		pm_runtime_put();
> > 
> 
> On a second thought this doesn't work because, for the first assertion,
> the runtime put will never be called, if the asserted_before does not count
> the current assertion.

I'm not sure I follow. The first assert will increment device usage
0 -> 1, all others asserts will just temporarily increment and decrement
1 -> 2 -> 1. Isn't this just missing one
	if (!assert && !asserted_after)
		pm_runtime_put()
to do the last deassert 1 -> 0 transition?

> If it counts the current assertion, then every assertion
> will end with runtime put. None of these options work here.
>
> How about the following:
>
> 	if (assert && !test_and_set_bit(1, &drvdata->rst_hws[id].asserted))     
> 		pm_runtime_get_sync(rcdev->dev);                                
>                                                                         
> 	spin_lock_irqsave(&drvdata->lock, flags);                               
>                                                                         
> 	reg = readl(reg_addr);                                                  
> 	if (assert)                                                             
> 		writel(reg & ~(mask << shift), reg_addr);                       
> 	else                                                                    
> 		writel(reg | (mask << shift), reg_addr);                        
>                                                                         
> 	spin_unlock_irqrestore(&drvdata->lock, flags);                          
>                                                                         
> 	if (!assert && test_and_clear_bit(1, &drvdata->rst_hws[id].asserted))   
> 		pm_runtime_put(rcdev->dev);                                     
>                                                                         
> This would only call the get_sync/put once for each reset bit.

Yes, that should work. I think it is a much better idea, no more looping
through the entire reset control array.

regards
Philipp
