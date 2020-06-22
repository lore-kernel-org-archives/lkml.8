Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B83DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5F82075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 21:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgFVVsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:48:08 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:42327 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730646AbgFVVsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:48:02 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1924B1C0002;
        Mon, 22 Jun 2020 21:47:59 +0000 (UTC)
Date:   Mon, 22 Jun 2020 23:47:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Karl =?iso-8859-1?Q?Rudb=E6k?= Olsen <karl@micro-technic.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] clk: at91: add sama5d3 pmc driver
Message-ID: <20200622214759.GK131826@piout.net>
References: <20200110223033.1261791-1-alexandre.belloni@bootlin.com>
 <37d11358-d3b5-10a1-72a3-93a03a6c1ea6@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37d11358-d3b5-10a1-72a3-93a03a6c1ea6@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/06/2020 23:24:45+0200, Ahmad Fatoum wrote:
> > +	regmap = syscon_node_to_regmap(np);
> 
> Shouldn't this be device_node_to_regmap for the same reasons outlined in your
> 6956eb33 ("clk: at91: fix possible deadlock") commit?
> 
> Same question for at91sam9g45.c, sam9x60.c and at91sam9n12.c.
> 

Agreed, I guess you can send a patch fixing all the instances.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
