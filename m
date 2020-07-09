Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5F6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3520F206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 09:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgGIJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:47:20 -0400
Received: from foss.arm.com ([217.140.110.172]:46918 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgGIJrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 05:47:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CD3231B;
        Thu,  9 Jul 2020 02:47:18 -0700 (PDT)
Received: from bogus (unknown [10.37.8.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8885D3F887;
        Thu,  9 Jul 2020 02:47:16 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:47:13 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Dien Pham <dien.pham.ry@renesas.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 1/2] firmware: arm_scmi: Keep the discrete clock rates
 sorted
Message-ID: <20200709094713.GD31544@bogus>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
 <OSBPR01MB4024648DB0F2C680892B442FD1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
 <20200709083808.GB31544@bogus>
 <OSBPR01MB402413D62446CFC9FE2B18E9D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB402413D62446CFC9FE2B18E9D1640@OSBPR01MB4024.jpnprd01.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 08:53:44AM +0000, Dien Pham wrote:
> Dear Sudeep-san,
> 
> > > >+}
> > > >+
> > > > static int
> > > > scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> > > > 			      struct scmi_clock_info *clk) @@ -184,8 +193,10 @@ 
> > > >scmi_clock_describe_rates_get(const struct scmi_handle *handle, u32 clk_id,
> > > > 		 */
> > > > 	} while (num_returned && num_remaining);
> > > >
> > > >-	if (rate_discrete)
> > > >+	if (rate_discrete) {
> > > > 		clk->list.num_rates = tot_rate_cnt;
> > > >+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
> > >
> > > About warning of above line, I think it relates to below snip of code:
> > >                 if (tot_rate_cnt + num_returned > SCMI_MAX_NUM_RATES) {
> > >                         dev_err(handle->dev, "No. of rates > MAX_NUM_RATES");
> > >                         break;
> > >                 }
> > >
> > 
> > I don't understand your comment and relation to above warning.
> 
> I'd like to mention about below warning.
> 
> >drivers/firmware/arm_scmi/clock.c: In function 'scmi_clock_protocol_init':
> >drivers/firmware/arm_scmi/clock.c:197:3: warning: 'rate' may be used uninitialized in this function [-Wmaybe-uninitialized]

Ah ok, sorry I didn't see this one. I am unable to observe this in the
default build, I will check with W=1. Thanks for that.

> >  sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
> 
> The warning for line
> > > >+		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
> 
> But, I think that it is affected by 'break' of below line. And for fixing
> this warning, I think we should fix inside this 'if' block.

OK will take a look.

-- 
Regards,
Sudeep
