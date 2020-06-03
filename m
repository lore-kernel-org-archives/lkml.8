Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8576AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D05420734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgFCS2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:28:12 -0400
Received: from foss.arm.com ([217.140.110.172]:36694 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCS2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:28:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9DF931B;
        Wed,  3 Jun 2020 11:28:10 -0700 (PDT)
Received: from bogus (unknown [10.37.8.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9073D3F305;
        Wed,  3 Jun 2020 11:28:08 -0700 (PDT)
Date:   Wed, 3 Jun 2020 19:28:05 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200603182805.GD23722@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200519012927.GT2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519012927.GT2165@builder.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the details response.

On Mon, May 18, 2020 at 06:29:27PM -0700, Bjorn Andersson wrote:
> On Thu 14 May 22:17 PDT 2020, Viresh Kumar wrote:
>

[...]

I find this part nicely summarise your response.

> > - With serialization, if we use only one channel as today at every
> >   priority, if there are 5 requests to send signal to the receiver and
> >   the dvfs request is the last one in queue (which may be called from
> >   scheduler's hot path with fast switching), it unnecessarily needs to
> >   wait for the first four transfers to finish due to the software
> >   locking imposed by the mailbox framework. This adds additional delay,
> >   maybe of few ms only, which isn't required by the hardware but just by
> >   the software and few ms can be important in scheduler's hotpath.
> >
>
> So these 5 requests, are they conveyed by the signals [1,2,3,4,5] or
> [BIT(0), BIT(1), BIT(2), BIT(3), BIT(4)]?
>

Latter in this case. IMO it is platform choice on how to use it. It is
equally possible to send 2^31 different signals. But the receiver must
also interpret it in the *exact* same way. In this case, the receiver
which is platform firmware interprets as individual bit signals.

> In the first case you have to serialize things given that e.g. signal 1
> immediately followed by 2 is indistinguishable from 3.
>

Agree and we are not proposing to break that use case. It exists in the
driver/binding today and will continue as is.

> If you signals are single-bit notifications then you don't need any
> serialization.
>

Indeed, we are making use of that.

--
Regards,
Sudeep
