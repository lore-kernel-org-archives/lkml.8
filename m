Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ED9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2183D206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbgAXLkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:40:18 -0500
Received: from foss.arm.com ([217.140.110.172]:49838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391228AbgAXLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:22:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57B94328;
        Fri, 24 Jan 2020 03:22:41 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22EC03F68E;
        Fri, 24 Jan 2020 03:22:40 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:22:35 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200124112235.GA40307@bogus>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus>
 <20200123103033.GA7511@bogus>
 <20200124030212.qjlzz75dgt5kla7t@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124030212.qjlzz75dgt5kla7t@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 08:32:12AM +0530, Viresh Kumar wrote:

[...]

>
> I think this defines the problem somewhat, though I wasn't able to
> reproduce the problem on my platform :)

No worries, I found the issue. It's devm_kzalloc in mailbox_chan_setup.
You need to pin the allocation with dev the main scmi platform device and
not individual protocol specific scmi_device. Basically, change cdev to
dev in there. It fixed the issue. You have it correct later for payload
devm_ioremap. I couldn't review the change in detail yet, allow me today.
You can post next version next week, anyways too late for v5.6 ;).

Peng, Peter,

Any comments on this ? I hope you are happy with this for SMC and virtio
based transport.

--
Regards,
Sudeep
