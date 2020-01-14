Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E0CC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E694424658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgANRmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:42:08 -0500
Received: from foss.arm.com ([217.140.110.172]:55708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:42:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 337A31396;
        Tue, 14 Jan 2020 09:42:07 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7063F68E;
        Tue, 14 Jan 2020 09:42:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 17:41:57 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Message-ID: <20200114174157.GA23201@bogus>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
 <20200113064156.lt3xxpzygattz3he@vireshk-i7>
 <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
 <20200114092615.nvj6mkwkplub5ul7@vireshk-i7>
 <CAK8P3a0jXyJArzQFd+u68iRvXNnXb_oHbWF9-abvvFuqhpi-NA@mail.gmail.com>
 <20200114111110.jhkj2y47ncp5233r@vireshk-i7>
 <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1cByQrhKV=8gRASNy74p8=WKfi1ZU13S2OpFQRjohUsg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 12:17:28PM +0100, Arnd Bergmann wrote:
> On Tue, Jan 14, 2020 at 12:11 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >

> >
> > Okay, I think I understand that a bit now. So here are the things
> > which I may need to do now:
> >
> > - Maybe move payload to struct scmi_mailbox structure, as that is the
> >   transport dependent structure..
> >
> > - Do ioremap, etc in mailbox.c only instead of driver.c
> >
> > - Provide more ops in struct scmi_transport_ops to provide read/write
> >   helpers to the payload and implement the ones based on
> >   ioread/iowrite in mailbox.c ..
> >
> > Am I thinking in the right direction now ?
>
> That sounds about right. What I'm still not sure about is whether the
> current kernel code is actually correct and should use iomeap()
> in the first place. Can you confirm that all current hardware
> implementations actually use MMIO type registers here rather than
> just rely on a buffer in RAM?
>

I remember we had this discussion in the past and was trying to dig up
the archive. I found it [1]. At that time and even today, I don't have
knowledge of any upstream platform using memory other than SRAM and
hence I found it safe to retain ioremap as is.

But I agree in general, this abstraction will allow us to add shmem of
other memory types like RAM. However, it's difficult to have understanding
and representation of the memory type used by the platform firmware say
in DT or even ACPI.

--
Regards,
Sudeep

[1] https://www.spinics.net/lists/arm-kernel/msg647292.html
