Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ECBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A121739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgCBKf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:35:29 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37671 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCBKf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:35:28 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1j8iQ3-0006CW-My; Mon, 02 Mar 2020 11:35:27 +0100
Subject: Re: [PATCH 2/3] ARM: dts: stm32: add STM32MP1-based Linux Automation
 MC-1 board
To:     Alexandre Torgue <alexandre.torgue@st.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20200226143826.1146-1-a.fatoum@pengutronix.de>
 <20200226143826.1146-2-a.fatoum@pengutronix.de>
 <244a4502-03e0-836c-2ce2-7fa6cef3c188@st.com>
 <fbba971d7501c774ce0081f22dcff4ef74002a4d.camel@pengutronix.de>
 <e227de9a-7440-7e1f-2928-5648cbbe44c1@st.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <a9a7c18b-c8a2-f566-b8a0-198551f60827@pengutronix.de>
Date:   Mon, 2 Mar 2020 11:35:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e227de9a-7440-7e1f-2928-5648cbbe44c1@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/2/20 11:29 AM, Alexandre Torgue wrote:
> On 3/2/20 11:18 AM, Lucas Stach wrote:
>> On Mo, 2020-03-02 at 11:06 +0100, Alexandre Torgue wrote:
>>>> +
>>>> +&gpu {
>>>> +    status = "okay";
>>>> +};
>>
>> This question is more to the ST guys than this specific DT: Why is the
>> GPU marked as disabled in the SoC dtsi file? This device is always
>> present on the SoC and AFAICS there are no board level dependencies, so
>> there is no reason to have it disabled by default, right? Removing the
>> status property from the dtsi would remove the need for this override
>> on the board DT.
> 
> You are right. With new stm32 device tree diversity, it makes no longer sens to disable GPU node in stm32mp157 dtsi file. Indeed, we use now dedicated files for each SoC (stm32mp151 / stm32mp153 /stm32mp157).
> 
> Ahmad, can you add this modification in your series please ?

Will preprend it to v2.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
