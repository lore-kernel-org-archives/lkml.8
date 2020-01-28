Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9108C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C7624681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgA1Qge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:36:34 -0500
Received: from foss.arm.com ([217.140.110.172]:60324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgA1Qgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:36:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D4D71FB;
        Tue, 28 Jan 2020 08:36:33 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E072A3F68E;
        Tue, 28 Jan 2020 08:36:30 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:36:28 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     broonie@kernel.org, robh@kernel.org, arnd@arndb.de,
        shawnguo@kernel.org, s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        lkml@metux.net, loic.pallardy@st.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, system-dt@lists.openampproject.org,
        stefano.stabellini@xilinx.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 0/7] Introduce bus firewall controller framework
Message-ID: <20200128163628.GB30489@bogus>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128153806.7780-1-benjamin.gaignard@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 04:37:59PM +0100, Benjamin Gaignard wrote:
> Bus firewall framework aims to provide a kernel API to set the configuration
> of the harware blocks in charge of busses access control.
>
> Framework architecture is inspirated by pinctrl framework:
> - a default configuration could be applied before bind the driver.
>   If a configuration could not be applied the driver is not bind
>   to avoid doing accesses on prohibited regions.
> - configurations could be apllied dynamically by drivers.
> - device node provides the bus firewall configurations.
>
> An example of bus firewall controller is STM32 ETZPC hardware block
> which got 3 possible configurations:
> - trust: hardware blocks are only accessible by software running on trust
>   zone (i.e op-tee firmware).
> - non-secure: hardware blocks are accessible by non-secure software (i.e.
>   linux kernel).
> - coprocessor: hardware blocks are only accessible by the coprocessor.
> Up to 94 hardware blocks of the soc could be managed by ETZPC.
>

/me confused. Is ETZPC accessible from the non-secure kernel space to
begin with ? If so, is it allowed to configure hardware blocks as secure
or trusted ? I am failing to understand the overall design of a system
with ETZPC controller.

> At least two other hardware blocks can take benefits of this:
> - ARM TZC-400: http://infocenter.arm.com/help/topic/com.arm.doc.100325_0001_02_en/arm_corelink_tzc400_trustzone_address_space_controller_trm_100325_0001_02_en.pdf
>   which is able to manage up to 8 regions in address space.

I strongly have to disagree with the above and NACK any patch trying
to do so. AFAIK, no system designed has TZC with non-secure access.
So we simply can't access this in the kernel and hence need no driver
for the same. Please avoid adding above misleading information in future.

--
Regards,
Sudeep

