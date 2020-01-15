Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27BDC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B10C2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAOOdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:33:43 -0500
Received: from foss.arm.com ([217.140.110.172]:38204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgAOOdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:33:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF44A31B;
        Wed, 15 Jan 2020 06:33:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A16FB3F68E;
        Wed, 15 Jan 2020 06:33:41 -0800 (PST)
Date:   Wed, 15 Jan 2020 14:33:25 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200115143325.GA12340@bogus>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <AM0PR04MB4481AA813CB53AC0D2C238C788370@AM0PR04MB4481.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4481AA813CB53AC0D2C238C788370@AM0PR04MB4481.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 08:53:51AM +0000, Peng Fan wrote:
>
> > Subject: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
> > transport type
> >
> > The SCMI specification is fairly independent of the transport protocol, which
> > can be a simple mailbox (already implemented) or anything else.
> > The current Linux implementation however is very much dependent of the
> > mailbox transport layer.
> >
> > This patch makes the SCMI core code (driver.c) independent of the mailbox
> > transport layer and moves all mailbox related code to a new
> > file: mailbox.c.
> >
> > We can now implement more transport protocols to transport SCMI messages,
> > some of the transport protocols getting discussed currently are SMC/HVC,
> > SPCI (built on top of SMC/HVC), OPTEE based mailbox (similar to SPCI), and
> > vitio based transport as alternative to mailbox.
> >
> > The transport protocols just need to provide struct scmi_desc, which also
> > implements the struct scmi_transport_ops.
>
> I need put shmem for each protocol, is this expected?

No, it's optional. If some/all protocols need dedicated channel for whatever
reasons(like DVFS/Perf for polling based transfers), they can specify.
Absence of dedicated channel infers all protocols share the channel(s).

> Sudeep,
> I am able to use smc to directly transport data,
> with adding a new file, just named smc.c including a scmi_smc_desc,

Good.

> But I not find a good way to pass smc id to smc transport file.
>

IMO, we have to deal this in transport specific init. I am thinking of
chan_setup in context of this patch. Does that make sense ?

[...]

> +
> +    scmi_clk: protocol@14 {
> +            reg = <0x14>;
> +            shmem = <&cpu_scp_lpri>;
> +            #clock-cells = <1>;
> +            clocks = <&osc_32k>, <&osc_24m>, <&clk_ext1>, <&clk_ext2>,
> +                     <&clk_ext3>, <&clk_ext4>;
> +            clock-names = "osc_32k", "osc_24m", "clk_ext1", "clk_ext2",
> +                          "clk_ext3", "clk_ext4";

This caught my attention, why do we need these clocks phandle list and
clock names above ? Ideally just need scmi_clk phandle and the index to
refer and names need to be provided by the firmware.

--
Regards,
Sudeep
