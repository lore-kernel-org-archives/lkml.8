Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDC8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414FC24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgANLDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:03:42 -0500
Received: from foss.arm.com ([217.140.110.172]:50740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgANLDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:03:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F62A142F;
        Tue, 14 Jan 2020 03:03:41 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566B33F6C4;
        Tue, 14 Jan 2020 03:03:40 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:03:34 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200114110223.GA47447@bogus>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7>
 <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:56:15PM +0530, Viresh Kumar wrote:

[...]

> The scmi protocol requires a block of shared memory which is
> represented by struct scmi_shared_mem, and payload is this memory
> block itself. This block of memory is accessed throughout driver.c
> file using ioread/write commands. If payload is transport specific, so
> will be those accesses, isn't it ? Are you suggesting to move all this
> to mailbox.c (the transport specific file) instead ? I am sorry, but I
> am not able to understand how exactly you want me to reorder code here
> :(
>

I don't have complete understanding of the requirements yet, but we may
have to make scmi_shared_mem transport specific vaguely based on virtio
requirements. I must have more info once I have discussion with them
soon. I will reply to this thread after that. More likely by end of this
week. Thanks for your patience, we are still trying to make sure we
have gathered all the requirements.

> @Sudeep: I had a question for you though. Looks like we are doing
> ioremap() of this payload for every channel's tx/rx, why ? Why is the
> same memory area mapped that way ? Can we just map the area once for
> scmi block ?
>

Though it may be part of same block of memory on most of the platforms,
it is not mandatory. It can be scattered. VirtIO based transport might
have something like that.

--
Regards,
Sudeep
