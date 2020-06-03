Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872F2068D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgFCSEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:04:44 -0400
Received: from foss.arm.com ([217.140.110.172]:36456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgFCSEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:04:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F7AE31B;
        Wed,  3 Jun 2020 11:04:42 -0700 (PDT)
Received: from bogus (unknown [10.37.8.135])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECD343F305;
        Wed,  3 Jun 2020 11:04:38 -0700 (PDT)
Date:   Wed, 3 Jun 2020 19:04:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200603180435.GB23722@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
 <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:37:58AM +0530, Viresh Kumar wrote:
> On 28-05-20, 13:20, Rob Herring wrote:
> > Whether Linux
> > requires serializing mailbox accesses is a separate issue. On that side,
> > it seems silly to not allow driving the h/w in the most efficient way
> > possible.
>
> That's exactly what we are trying to say. The hardware allows us to
> write all 32 bits in parallel, without any hardware issues, why
> shouldn't we do that ? The delay (which Sudeep will find out, he is
> facing issues with hardware access because of lockdown right now)

OK, I was able to access the setup today. I couldn't reach a point
where I can do measurements as the system just became unusable with
one physical channel instead of 2 virtual channels as in my patches.

My test was simple. Switch to schedutil and read sensors periodically
via sysfs.

 arm-scmi firmware:scmi: message for 1 is not expected!
 arm-scmi firmware:scmi: timed out in resp(caller: scmi_sensor_reading_get+0xf4/0x120)
 arm-scmi firmware:scmi: timed out in resp(caller: scmi_sensor_reading_get+0xf4/0x120)
 arm-scmi firmware:scmi: message for 1 is not expected!
 arm-scmi firmware:scmi: timed out in resp(caller: scmi_sensor_reading_get+0xf4/0x120)
 arm-scmi firmware:scmi: message for 1 is not expected!

With trace enabled I can see even cpufreq_set timing out. Sample trace
output:

       bash-1019  [005]  1149.452340: scmi_xfer_begin:      transfer_id=1537 msg_id=7 protocol_id=19 seq=0 poll=1
       bash-1019  [005]  1149.452407: scmi_xfer_end:        transfer_id=1537 msg_id=7 protocol_id=19 seq=0 status=0
       bash-1526  [000]  1149.472553: scmi_xfer_begin:      transfer_id=1538 msg_id=6 protocol_id=21 seq=0 poll=0
     <idle>-0     [001]  1149.472733: scmi_xfer_begin:      transfer_id=1539 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [001]  1149.472842: scmi_xfer_end:        transfer_id=1539 msg_id=7 protocol_id=19 seq=1 status=-110
     <idle>-0     [001]  1149.483040: scmi_xfer_begin:      transfer_id=1540 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [001]  1149.483043: scmi_xfer_end:        transfer_id=1540 msg_id=7 protocol_id=19 seq=1 status=0
    rs:main-543   [003]  1149.493031: scmi_xfer_begin:      transfer_id=1541 msg_id=7 protocol_id=19 seq=1 poll=1
    rs:main-543   [003]  1149.493047: scmi_xfer_end:        transfer_id=1541 msg_id=7 protocol_id=19 seq=1 status=0
     <idle>-0     [000]  1149.507033: scmi_xfer_begin:      transfer_id=1542 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [000]  1149.507044: scmi_xfer_end:        transfer_id=1542 msg_id=7 protocol_id=19 seq=1 status=0
       bash-1526  [000]  1149.516068: scmi_xfer_end:        transfer_id=1538 msg_id=6 protocol_id=21 seq=0 status=-110
       bash-1526  [000]  1149.516559: scmi_xfer_begin:      transfer_id=1543 msg_id=6 protocol_id=21 seq=0 poll=0
     <idle>-0     [001]  1149.516729: scmi_xfer_begin:      transfer_id=1544 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [001]  1149.516837: scmi_xfer_end:        transfer_id=1544 msg_id=7 protocol_id=19 seq=1 status=-110
ksoftirqd/0-9     [000]  1149.519065: scmi_xfer_begin:      transfer_id=1545 msg_id=7 protocol_id=19 seq=1 poll=1
ksoftirqd/0-9     [000]  1149.519072: scmi_xfer_end:        transfer_id=1545 msg_id=7 protocol_id=19 seq=1 status=0
     <idle>-0     [001]  1149.526878: scmi_xfer_begin:      transfer_id=1546 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [001]  1149.526882: scmi_xfer_end:        transfer_id=1546 msg_id=7 protocol_id=19 seq=1 status=0
     <idle>-0     [000]  1149.551119: scmi_xfer_begin:      transfer_id=1547 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [000]  1149.551138: scmi_xfer_end:        transfer_id=1547 msg_id=7 protocol_id=19 seq=1 status=0
       bash-1526  [000]  1149.560191: scmi_xfer_end:        transfer_id=1543 msg_id=6 protocol_id=21 seq=0 status=-110
       bash-1526  [000]  1149.560690: scmi_xfer_begin:      transfer_id=1548 msg_id=6 protocol_id=21 seq=0 poll=0
     <idle>-0     [001]  1149.560859: scmi_xfer_begin:      transfer_id=1549 msg_id=7 protocol_id=19 seq=1 poll=1
     <idle>-0     [001]  1149.560968: scmi_xfer_end:        transfer_id=1549 msg_id=7 protocol_id=19 seq=1 status=-110

protocol_id=19 is cpufreq and 21 is sensor. This is simplest test and
I can easily generate more timeouts starting some stress test with DVFS.

--
Regards,
Sudeep
