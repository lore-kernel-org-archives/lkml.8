Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81866C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BED320708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGIIiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:38:14 -0400
Received: from foss.arm.com ([217.140.110.172]:43062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgGIIiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:38:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96DF131B;
        Thu,  9 Jul 2020 01:38:13 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D15183F887;
        Thu,  9 Jul 2020 01:38:11 -0700 (PDT)
Date:   Thu, 9 Jul 2020 09:38:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dien Pham <dien.pham.ry@renesas.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Message-ID: <20200709083808.GB31544@bogus>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
 <OSBPR01MB4024648DB0F2C680892B442FD1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB4024648DB0F2C680892B442FD1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dien-san,

On Thu, Jul 09, 2020 at 08:20:51AM +0000, Dien Pham wrote:
> Hi Sudeep,
>
> I share my build warning and some in-line comment below:
>
>   CC      drivers/firmware/arm_scmi/clock.o
> drivers/firmware/arm_scmi/clock.c: In function 'rate_cmp_func':
> drivers/firmware/arm_scmi/clock.c:127:12: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   u64 *r1 = _r1, *r2 = _r2;
>             ^~~
> drivers/firmware/arm_scmi/clock.c:127:23: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
>   u64 *r1 = _r1, *r2 = _r2;
>                        ^~~
>   CC      arch/arm64/kernel/vdso.o
> drivers/firmware/arm_scmi/clock.c: In function 'scmi_clock_protocol_init':
> drivers/firmware/arm_scmi/clock.c:197:3: warning: 'rate' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>

Sorry for this. I noticed yesterday when I built but strangely I had
created patches before I fixed these and sent them instead of fixed version.
My mistake.

> >-----Original Message-----
> >From: Sudeep Holla <sudeep.holla@arm.com>
> >Sent: Wednesday, July 8, 2020 6:07 PM
> >To: linux-arm-kernel@lists.infradead.org; linux-clk@vger.kernel.org; Stephen Boyd <sboyd@kernel.org>
> >Cc: Sudeep Holla <sudeep.holla@arm.com>; linux-kernel@vger.kernel.org; Michael Turquette <mturquette@baylibre.com>; Dien Pham <dien.pham.ry@renesas.com>
> >Subject: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates sorted
> >
> >Instead of relying on the firmware to keep the clock rates sorted, let us sort the list. This is not essential for clock layer but it helps to find the min and max rates easily from the list.
> >
> >Fixes: 5f6c6430e904 ("firmware: arm_scmi: add initial support for clock protocol")
> >Reported-by: Dien Pham <dien.pham.ry@renesas.com>
> >Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >---
> > drivers/firmware/arm_scmi/clock.c | 13 ++++++++++++-
> > 1 file changed, 12 insertions(+), 1 deletion(-)
> >
> >Hi Dien-san,
> >
> >If you could review/test these patches, I can queue them ASAP.
> >I am planning to send the PR for ARM SoC later this week, so I need your tested-by.
>
> I applied the patch,
> Although there are some build warnings, but the patch effect is ok.
>

Thanks for testing.

> >
> >Regards,
> >Sudeep
> >
> >diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
> >index 4c2227662b26..2dd119cdebf6 100644
> >--- a/drivers/firmware/arm_scmi/clock.c
> >+++ b/drivers/firmware/arm_scmi/clock.c
> >@@ -5,6 +5,8 @@
> >  * Copyright (C) 2018 ARM Ltd.
> >  */
> >
> >+#include <linux/sort.h>
> >+
> > #include "common.h"
> >
> > enum scmi_clock_protocol_cmd {
> >@@ -121,6 +123,13 @@ static int scmi_clock_attributes_get(const struct scmi_handle *handle,
> > 	return ret;
> > }
> >
> >+static int rate_cmp_func(const void *_r1, const void *_r2) {
> >+	u64 *r1 = _r1, *r2 = _r2;
>
> It is better to add 'const' as below to avoid warning.
> const u64 *r1 = _r1, *r2 = _r2;
>

Yes, I have this in the correct version which I sent as v2 this morning.

> >+
> >+	return r1 - r2;
>
> r1 and r2 are u64, but returned value is 'int' type.
> Do you think we should improve this ? e.g. return (int)r1 - r2;
>

Not changing to const above must suffice.

> >+}
> >+
> > static int
> > scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> > 			      struct scmi_clock_info *clk)
> >@@ -184,8 +193,10 @@ scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> > 		 */
> > 	} while (num_returned && num_remaining);
> >
> >-	if (rate_discrete)
> >+	if (rate_discrete) {
> > 		clk->list.num_rates = tot_rate_cnt;
> >+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
>
> About warning of above line, I think it relates to below snip of code:
>                 if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
>                         dev_err(handle->dev, "No. of rates > MAX_NUM_RATES");
>                         break;
>                 }
>

I don't understand your comment and relation to above warning.

> I see that in this case is true, it is not proceeded as error case,
> If so I think you can update 'rate' for value from 'tot_rate_cnt' to SCMI_MAX_NUM_RATES at here.
> How do you think ?
>

--
Regards,
Sudeep
