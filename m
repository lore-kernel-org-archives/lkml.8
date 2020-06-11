Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF25C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C1E20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 10:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgFKKAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 06:00:34 -0400
Received: from foss.arm.com ([217.140.110.172]:49658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKKAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 06:00:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A6231B;
        Thu, 11 Jun 2020 03:00:31 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92CE23F73D;
        Thu, 11 Jun 2020 03:00:29 -0700 (PDT)
Date:   Thu, 11 Jun 2020 11:00:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200611100027.GB18781@bogus>
References: <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus>
 <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus>
 <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

Thanks for summarising the thoughts quite nicely.

On Wed, Jun 10, 2020 at 03:03:34PM +0530, Viresh Kumar wrote:
> On 05-06-20, 10:42, Jassi Brar wrote:
> > Since origin upto scmi_xfer, there can be many forms of sleep like
> > schedule/mutexlock etc.... think of some userspace triggering sensor
> > or dvfs operation. Linux does not provide real-time guarantees. Even
> > if remote (scmi) firmware guarantee RT response, it makes sense to
> > timeout a response only after the _request is on the bus_  and not
> > when you submit a request to the api (unless you serialise it).
> > IOW, start the timeout from  mbox_client.tx_prepare()  when the
> > message actually gets on the bus.
>
> There are multiple purposes of the timeout IMO:
>
> - Returning early if the other side is dead/hung, in such a case the
>   timeout can be put when the request is put on the bus as we don't
>   care of the time it takes to complete the request until the time the
>   request can be fulfilled. This can be a example of i2c/spi memory
>   read.
>
> - Ensuring maximum time in which the request needs to be serviced.
>   There may be hard requirements, like in case for DVFS from
>   scheduler's hot path (which is essential for better working of the
>   overall system). And for such a case the timeout is placed at the
>   right place IMO, i.e. right after a request is submitted to mailbox.
>

Agreed on both points.

> And some more points I wanted to share..
>
> - I am not sure I understood the *serializing* part you guys were
>   talking about. I believe mailbox framework is already serializing
>   the requests it is receiving on a single channel with a spin lock,
>   right ? Why does the client need to serialize them as well? Is that
>   for avoiding timeouts ?
>
> - For me, and Sudeep as well IIUC, the bigger problem isn't that
>   timeouts are happening and requests are failing (and so changing the
>   timeout to a bigger value isn't going to fix anything), but the
>   problem is that it is taking too long (because of the queue of
>   requests on a channel) for a request to finish after being
>   submitted. Scheduler doesn't care of the underneath logistics for
>   example, all it cares for is the time it takes to change the
>   frequency of a CPU. If you can do it fast enough in a guaranteed
>   manner, then you can use fast switching, otherwise not.
>
> - The hardware can very well support the case today where this can be
>   done in parallel and (almost) in a guaranteed time-frame. While the
>   software wants to add a limit to that and so wants to serialize
>   requests.
>

+1

> - As many people have already suggested it (like me, Sudeep, Rob,
>   maybe Bjorn as well), it seems silly to not allow driving the h/w in
>   the most efficient way possible (and allow fast cpu switching in
>   this case).
>
> > Interesting logs !  The time taken to complete _successful_ requests
> > are arguably better in bad_trace ... there are many <10usec responses
> > in bad_trace, while the fastest response in good_trace is  53usec.
>
> Indeed this is interesting. It may be worth looking (separately) into
> why don't we see those 3 us long requests anymore, or maybe they were
> just not there in the logs.
>

As I mentioned in another thread that non-dvfs requests may be prioritised
lower when there are parallel request to the remote. The so called bad
trace doesn't have such scenario with single channel and all requests
from OS being serialised. The good trace has 2 channels and requests to
remote happen in parallel and hence it is fair to see slightly higher
latencies for lower priority requests.

--
Regards,
Sudeep
