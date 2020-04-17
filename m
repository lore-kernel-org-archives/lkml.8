Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7AEC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547D42223C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgDQPlp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729110AbgDQPlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:41:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B52C061A0C;
        Fri, 17 Apr 2020 08:41:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0920E2A0613;
        Fri, 17 Apr 2020 16:41:43 +0100 (BST)
Date:   Fri, 17 Apr 2020 17:41:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Marek Vasut <marex@denx.de>
Cc:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 03/12] bus: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
Message-ID: <20200417174140.00456f36@collabora.com>
In-Reply-To: <c69f86f4-5904-3f35-dac1-87080402a096@denx.de>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
        <1586966256-29548-4-git-send-email-christophe.kerello@st.com>
        <20200416215328.53982fef@collabora.com>
        <e4a21df4-b01b-1215-7a3b-fea94f099b8f@st.com>
        <c69f86f4-5904-3f35-dac1-87080402a096@denx.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 17:31:49 +0200
Marek Vasut <marex@denx.de> wrote:

> On 4/17/20 5:29 PM, Christophe Kerello wrote:
> > 
> > 
> > On 4/16/20 9:53 PM, Boris Brezillon wrote:  
> >> On Wed, 15 Apr 2020 17:57:27 +0200
> >> Christophe Kerello <christophe.kerello@st.com> wrote:
> >>  
> >>> The driver adds the support for the STMicroelectronics FMC2 EBI
> >>> controller
> >>> found on STM32MP SOCs.
> >>>
> >>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >>> Tested-by: Marek Vasut <marex@denx.de>
> >>> ---
> >>> Changes in v2:
> >>>   - call 2 APIs to manage FMC2 enable/disable instead of ops
> >>>   - call 2 APIs to manage FMC2 NWAIT shared signal instead of ops
> >>>
> >>>   drivers/bus/Kconfig          |   11 +
> >>>   drivers/bus/Makefile         |    1 +
> >>>   drivers/bus/stm32-fmc2-ebi.c | 1091
> >>> ++++++++++++++++++++++++++++++++++++++++++  
> >>
> >> Hm, I see that other memory bus controller drivers are placed under
> >> drivers/memory/, any reason for choosing drivers/bus/? If that's where
> >> we want to have all generic memory bus controllers to live it might be
> >> worth moving existing drivers to the drivers/bus/ directory at some
> >> point.
> >>  
> > 
> > Hi Boris,
> > 
> > I see this controller as an external bus interface as we are able to
> > attach different devices on it, like a PSRAM, an ethernet controller, a
> > FPGA, a LCD display, ...
> > 
> > When I had a look at bus/Kconfig file, I have found similar drivers
> > (like IMX_WEIM or QCOM_EBI2 drivers). These drivers are able to connect
> > devices like NAND Flash, SRAM, ethernet adapters, FPGAs and LCD displays
> > as it is written in the Kconfig file.
> > 
> > But, after checking memory/Kconfig file, it is also possible to find
> > similar drivers (like ATMEL_EBI driver that is inspired by the WEIM bus
> > driver).
> > 
> > So, I will follow the recommendation and I will move it to
> > drivers/memory folder if it is the place where this driver should be.  
> 
> The EBI isn't a memory bus, you can very well have a non-memory device,
> like an external parallel bus memory controller on it. So why should it
> be in drivers/memory ?

Just like most of those so-called memory bus controllers we have under
drivers/memory/ => they are most of the time used to interact with
memories but can also be used for other things (Christophe listed a few
uses cases). And I'm not pushing one way or the other, all I said was
that we should makes things consistent instead of having half of
those controller drivers in drivers/memory/ and the other half in
drivers/bus/.

