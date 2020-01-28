Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0778FC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A7C24687
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1RRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:17:45 -0500
Received: from foss.arm.com ([217.140.110.172]:60876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgA1RRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:17:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E803328;
        Tue, 28 Jan 2020 09:17:44 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E6273F52E;
        Tue, 28 Jan 2020 09:17:42 -0800 (PST)
Date:   Tue, 28 Jan 2020 17:17:36 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "lkml@metux.net" <lkml@metux.net>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Message-ID: <20200128171639.GA36496@bogus>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128163628.GB30489@bogus>
 <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f54ec36-8022-a57a-c634-45257f4c6984@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:46:41PM +0000, Benjamin GAIGNARD wrote:
>
> On 1/28/20 5:36 PM, Sudeep Holla wrote:
> > On Tue, Jan 28, 2020 at 04:37:59PM +0100, Benjamin Gaignard wrote:
> >> Bus firewall framework aims to provide a kernel API to set the configuration
> >> of the harware blocks in charge of busses access control.
> >>
> >> Framework architecture is inspirated by pinctrl framework:
> >> - a default configuration could be applied before bind the driver.
> >>    If a configuration could not be applied the driver is not bind
> >>    to avoid doing accesses on prohibited regions.
> >> - configurations could be apllied dynamically by drivers.
> >> - device node provides the bus firewall configurations.
> >>
> >> An example of bus firewall controller is STM32 ETZPC hardware block
> >> which got 3 possible configurations:
> >> - trust: hardware blocks are only accessible by software running on trust
> >>    zone (i.e op-tee firmware).
> >> - non-secure: hardware blocks are accessible by non-secure software (i.e.
> >>    linux kernel).
> >> - coprocessor: hardware blocks are only accessible by the coprocessor.
> >> Up to 94 hardware blocks of the soc could be managed by ETZPC.
> >>
> > /me confused. Is ETZPC accessible from the non-secure kernel space to
> > begin with ? If so, is it allowed to configure hardware blocks as secure
> > or trusted ? I am failing to understand the overall design of a system
> > with ETZPC controller.
>
> Non-secure kernel could read the values set in ETZPC, if it doesn't match
> with what is required by the device node the driver won't be probed.
>

OK, but I was under the impression that it was made clear that Linux is
not firmware validation suite. The firmware need to ensure all the devices
that are not accessible in the Linux kernel are marked as disabled and
this needs to happen before entering the kernel. So if this is what this
patch series achieves, then there is no need for it. Please stop pursuing
this any further or provide any other reasons(if any) to have it. Until
you have other reasons, NACK for this series.

Note you haven't cc-ed 2 people who has comments earlier[1][2]
--
Regards,
Sudeep

[1] https://lkml.org/lkml/2018/2/27/512
[2] https://lkml.org/lkml/2018/2/27/598
