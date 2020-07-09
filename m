Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC19C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1742076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGIIjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:39:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgGIIjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:39:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4F1131B;
        Thu,  9 Jul 2020 01:39:30 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1CE393F887;
        Thu,  9 Jul 2020 01:39:28 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:39:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dien Pham <dien.pham.ry@renesas.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Message-ID: <20200709083925.GC31544@bogus>
References: <20200709081705.46084-1-sudeep.holla@arm.com>
 <20200709081705.46084-2-sudeep.holla@arm.com>
 <OSBPR01MB40249DA5EFECDA8C5AC9C619D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB40249DA5EFECDA8C5AC9C619D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:26:54AM +0000, Dien Pham wrote:
> Hi Sudeep,
>
> Thanks for your patch.
>
> >-----Original Message-----
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >Sent: Thursday, July 9, 2020 3:17 PM
> >To: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; Stephen Boyd <sboyd@kernel.org>
> >Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-kernel@vger.kernel.org; Michael Turquette <mturquette@baylibre.com>; Dien Pham <dien.pham.ry@renesas.com>
> >Subject: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering clocks with discrete rates
> >
> >Currently we are not initializing the scmi clock with discrete rates correctly. We fetch the min_rate and max_rate value only for clocks with ranges and ignore the ones with discrete rates. This will lead to wrong initialization of rate range when clock supports discrete rate.
> >
> >Fix this by using the first and the last rate in the sorted list of the discrete clock rates while registering the clock.
> >
> >Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.com
> >Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> >Reported-by: Dien Pham <dien.pham.ry@renesas.com>
> >Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >---
> > drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
> > 1 file changed, 19 insertions(+), 3 deletions(-)
> >
> >Hi Stephen,
> >
> >If you are fine, I can take this via ARM SoC along with the change in firmware driver. However it is also fine if you want to merge this independently as there is no strict dependency. Let me know either way.
> >
> >v1[1]->v2:
> >	- Fixed the missing ; which was sent by mistake.
>
> I tested the patch,
> I is ok and can fix my issue.
>

Thanks for testing. Can I add ?

Tested-by: Dien Pham <dien.pham.ry@renesas.com>

--
Regards,
Sudeep
