Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F955C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6896421582
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgGNHzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:55:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC32C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 00:55:29 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jvFmg-0007Gm-Ku; Tue, 14 Jul 2020 09:55:26 +0200
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
 <20200710132423.497230-3-philippe.schenker@toradex.com>
 <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
 <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7e6f8135-120f-0831-20ad-25648ea646b8@pengutronix.de>
Date:   Tue, 14 Jul 2020 09:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c76c0fd056512a3f8e24bf06e7bb7e1650090609.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philippe,

On 7/13/20 1:53 PM, Philippe Schenker wrote:
> On Mon, 2020-07-13 at 11:46 +0200, Ahmad Fatoum wrote:
>> Hello Philippe,
>>
>>> +	extcon_usbc_det: usbc_det {
>>> +		compatible = "linux,extcon-usb-gpio";
>>
>> According to 4602f3bff266 ("usb: common: add USB GPIO based connection
>> detection driver"):
>> "the old way using extcon to support USB Dual-Role switch is now
>> deprecated
>>  when use Type-B connector."
>>
>> Have you considered using a compatible = "gpio-usb-b-connector" child
>> node instead?
>>
>> Cheers,
>> Ahmad
> 
> Thanks for the Hint Ahmad,
> 
> I already tried and just now tried again but it doesn't work on our
> hardware. Are you sure this works with chipidea driver?

I haven't, just wanted to point its existence out in case you didn't know.
Seems we need to call of_platform_populate somewhere in the driver.
Unsure what other changes are necessary.

> Should this new usb-connector stuff work in general with every old
> driver?

If the driver support isn't there yet, I think use of extcon is fine as is.

Thanks
Ahmad

> 
> Philippe



-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
