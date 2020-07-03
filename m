Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B917420890
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgGCHes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCHer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:34:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2144C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 00:34:47 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jrGDc-0003cT-Da; Fri, 03 Jul 2020 09:34:44 +0200
Subject: Re: [PATCH v2] clk: at91: add sama5d3 pmc driver
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Karl_Rudb=c3=a6k_Olsen?= <karl@micro-technic.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200110223033.1261791-1-alexandre.belloni@bootlin.com>
 <37d11358-d3b5-10a1-72a3-93a03a6c1ea6@pengutronix.de>
 <20200622214759.GK131826@piout.net>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <043970b9-6cc6-e5c6-b5b1-e0f1a9799ae1@pengutronix.de>
Date:   Fri, 3 Jul 2020 09:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622214759.GK131826@piout.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On 6/22/20 11:47 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 22/06/2020 23:24:45+0200, Ahmad Fatoum wrote:
>>> +	regmap = syscon_node_to_regmap(np);
>>
>> Shouldn't this be device_node_to_regmap for the same reasons outlined in your
>> 6956eb33 ("clk: at91: fix possible deadlock") commit?
>>
>> Same question for at91sam9g45.c, sam9x60.c and at91sam9n12.c.
>>
> 
> Agreed, I guess you can send a patch fixing all the instances.

I just sent out a patch for those 4 files. I don't know if this issue is equally
applicable to the dt-compat.c code, so I left that one as is.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
