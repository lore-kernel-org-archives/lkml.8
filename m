Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDF6C2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C14206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbgC0QdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:33:03 -0400
Received: from foss.arm.com ([217.140.110.172]:48422 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgC0QdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:33:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7607D1FB;
        Fri, 27 Mar 2020 09:33:02 -0700 (PDT)
Received: from bogus (unknown [10.37.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65CD83F71F;
        Fri, 27 Mar 2020 09:33:00 -0700 (PDT)
Date:   Fri, 27 Mar 2020 16:32:53 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
Message-ID: <20200327163253.GA32313@bogus>
References: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 08:27:47AM +0000, Peng Fan wrote:
> Hi Sudeep,
>
> > Subject: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
>
> Are you fine with this patchset? Or You expect multi channel support?
>

I applied these patches[1]. I also looked at multi channel support and
I think it should be simple. I have made changes and will post soon.
I would like you to review and if possible test. I don't want to break
the existing single channel, so please do test in your setup for single
channel itself.

--
Regards,
Sudeep

[1] git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git for-next/scmi
