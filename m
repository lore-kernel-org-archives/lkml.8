Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB8DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B2C6206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgGMNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:22:04 -0400
Received: from foss.arm.com ([217.140.110.172]:34254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729564AbgGMNWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:22:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0D2130E;
        Mon, 13 Jul 2020 06:22:02 -0700 (PDT)
Received: from bogus (unknown [10.37.8.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10A2F3F887;
        Mon, 13 Jul 2020 06:22:00 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:21:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering
 clocks with discrete rates
Message-ID: <20200713132153.GA30377@bogus>
References: <20200709081705.46084-1-sudeep.holla@arm.com>
 <20200709081705.46084-2-sudeep.holla@arm.com>
 <159442504011.1987609.3990897866011325023@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159442504011.1987609.3990897866011325023@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:50:40PM -0700, Stephen Boyd wrote:
> Quoting Sudeep Holla (2020-07-09 01:17:05)
> > Currently we are not initializing the scmi clock with discrete rates
> > correctly. We fetch the min_rate and max_rate value only for clocks with
> > ranges and ignore the ones with discrete rates. This will lead to wrong
> > initialization of rate range when clock supports discrete rate.
> > 
> > Fix this by using the first and the last rate in the sorted list of the
> > discrete clock rates while registering the clock.
> > 
> > Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.com
> > Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> > Reported-by: Dien Pham <dien.pham.ry@renesas.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
> >  1 file changed, 19 insertions(+), 3 deletions(-)
> > 
> > Hi Stephen,
> > 
> > If you are fine, I can take this via ARM SoC along with the change in
> > firmware driver. However it is also fine if you want to merge this
> > independently as there is no strict dependency. Let me know either way.
> 
> I don't mind either way. If you want to send it in along with the
> firmware change then that's fine.
>

OK I have now queued and will send it to arm-soc.

> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Thanks for the review.

-- 
Regards,
Sudeep
