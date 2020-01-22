Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAA1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1870E2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgAVMPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:15:47 -0500
Received: from foss.arm.com ([217.140.110.172]:55698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgAVMPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:15:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B90328;
        Wed, 22 Jan 2020 04:15:46 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 324543F52E;
        Wed, 22 Jan 2020 04:15:45 -0800 (PST)
Date:   Wed, 22 Jan 2020 12:15:38 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200122121538.GA31240@bogus>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 08:06:23AM +0530, Viresh Kumar wrote:
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent on the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Sudeep: It was my mistake that I didn't check if there is something
> already queued for next release and you never told me as well earlier :)
>

No I didn't want to distract the discussion with that silly thing.

> Can you please help me getting this tested, now that I have rebased it
> as well :) ?
>

Sure, I will give it a go on my Juno. Thanks for the rebase, makes it
simpler.

--
Regards,
Sudeep
