Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E282BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D6B206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgC3KA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:00:58 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36775 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728553AbgC3KA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:00:56 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 48rSdf3FPJz1rtyc;
        Mon, 30 Mar 2020 12:00:53 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 48rSdd50gxz1r0c4;
        Mon, 30 Mar 2020 12:00:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Umm6pyC2bxUh; Mon, 30 Mar 2020 12:00:52 +0200 (CEST)
X-Auth-Info: hHMGdqnHqAE6fvhPm1qMt5QwR23l1fijZnvach0Idkg=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 30 Mar 2020 12:00:52 +0200 (CEST)
Subject: Re: [03/12] bus: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
To:     Christophe Kerello <christophe.kerello@st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        tony@atomide.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <1584975532-8038-1-git-send-email-christophe.kerello@st.com>
 <1584975532-8038-4-git-send-email-christophe.kerello@st.com>
 <f6a2c766-8ae5-fab7-e2f6-db23f39b5d91@denx.de>
 <93fce520-9269-123c-9523-173e75cdce2e@st.com>
From:   Marek Vasut <marex@denx.de>
Message-ID: <94845952-ae8d-dab1-7bbe-21830d05480b@denx.de>
Date:   Mon, 30 Mar 2020 11:30:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <93fce520-9269-123c-9523-173e75cdce2e@st.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 11:19 AM, Christophe Kerello wrote:
> 
> 
> On 3/30/20 3:24 AM, Marek Vasut wrote:
>> On 3/23/20 3:58 PM, Christophe Kerello wrote:
>>> The driver adds the support for the STMicroelectronics FMC2 EBI
>>> controller
>>> found on STM32MP SOCs.
>>>
>>
>> On DH STM32MP1 SoM in PDK2 carrier board,
>> Tested-by: Marek Vasut <marex@denx.de>
>>
>> btw. it seems this sets BTRx DATLAT and CLKDIV to 0xf , it's "Don't
>> care" in the datasheet for Muxed mode, but then it should probably be
>> set to 0.
> 
> Hi Marek,

Hi,

> Thanks for testing.

Sure

> These 2 bit fields (BTRx DATLAT and CLKDIV) are only needed for
> synchronous transactions. Based on your bindings, the transaction type
> is asynchronous.
> CLKDIV bit fields should not be set to 0x0, as this value is reserved
> for this bit field. The driver keeps the reset value when it is not
> needed to update a bit field.

Then I guess that's fine either way.
