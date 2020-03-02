Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF33C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CFF208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCBKS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:18:58 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44049 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCBKS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:18:57 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1j8i9o-000400-Pk; Mon, 02 Mar 2020 11:18:40 +0100
Message-ID: <fbba971d7501c774ce0081f22dcff4ef74002a4d.camel@pengutronix.de>
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add STM32MP1-based Linux
 Automation MC-1 board
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Date:   Mon, 02 Mar 2020 11:18:39 +0100
In-Reply-To: <244a4502-03e0-836c-2ce2-7fa6cef3c188@st.com>
References: <20200226143826.1146-1-a.fatoum@pengutronix.de>
         <20200226143826.1146-2-a.fatoum@pengutronix.de>
         <244a4502-03e0-836c-2ce2-7fa6cef3c188@st.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2020-03-02 at 11:06 +0100, Alexandre Torgue wrote:
> Hi Ahmad
> 
> Thanks for adding a new STM32 board. Some minor comments.
> 
> On 2/26/20 3:38 PM, Ahmad Fatoum wrote:
> > The Linux Automation MC-1 is a SBC built around the Octavo Systems
> > OSD32MP15x SiP. The SiP features up to 1 GB DDR3 RAM, EEPROM and
> > a PMIC. The board has eMMC and a SD slot for storage and GbE
> > for both connectivity and power.
> > 
> > Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de
> > ---
[...]
> > +
> > +&gpu {
> > +	status = "okay";
> > +};

This question is more to the ST guys than this specific DT: Why is the
GPU marked as disabled in the SoC dtsi file? This device is always
present on the SoC and AFAICS there are no board level dependencies, so
there is no reason to have it disabled by default, right? Removing the
status property from the dtsi would remove the need for this override
on the board DT.

Regards,
Lucas

