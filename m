Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA44EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD52A205CB
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFDI20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:28:26 -0400
Received: from foss.arm.com ([217.140.110.172]:41436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDI2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:28:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 581B331B;
        Thu,  4 Jun 2020 01:28:25 -0700 (PDT)
Received: from bogus (unknown [10.37.12.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2E43F305;
        Thu,  4 Jun 2020 01:28:22 -0700 (PDT)
Date:   Thu, 4 Jun 2020 09:28:14 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200604082814.GA8814@bogus>
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200528192005.GA494874@bogus>
 <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus>
 <20200603181743.GC23722@bogus>
 <20200604055903.ycvu6qfnlwgkh52a@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604055903.ycvu6qfnlwgkh52a@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:29:03AM +0530, Viresh Kumar wrote:
> On 03-06-20, 19:17, Sudeep Holla wrote:
> > I just realised that we have the timing info in the traces and you will
> > observe the sensor readings take something in order of 100us to 500-600us
> > or even more based on which sensor is being read. While we have 100us
> > timeout for cpufreq opp set.
>
> Which timeout from opp core are you talking about ?

The one we have in SCMI itself to meet the fast_switch requirement.

--
Regards,
Sudeep
