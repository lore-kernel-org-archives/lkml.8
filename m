Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94EFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E177206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgGLXTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:19:30 -0400
Received: from foss.arm.com ([217.140.110.172]:59674 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgGLXT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:19:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1465130E;
        Sun, 12 Jul 2020 16:19:29 -0700 (PDT)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA443F7C3;
        Sun, 12 Jul 2020 16:19:27 -0700 (PDT)
Subject: Re: [PATCH v5 10/10] arm64: dts: actions: Add uSD support for
 Cubieboard7
To:     Amit Tomer <amittomer25@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, cristian.ciocaltea@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org, devicetree@vger.kernel.org
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-11-git-send-email-amittomer25@gmail.com>
 <20200712173044.GL6110@Mani-XPS-13-9360>
 <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <5e2eb92e-eada-9b14-3f15-38717284bc92@arm.com>
Date:   Mon, 13 Jul 2020 00:17:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CABHD4K8+cZMwA=pQx4Gvv5Z4xLof8Ln6fUNrB0=-SS2M_0_3aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2020 19:45, Amit Tomer wrote:

Hi,

> On Sun, Jul 12, 2020 at 11:00 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
>>
>> On Thu, Jul 02, 2020 at 08:22:56PM +0530, Amit Singh Tomar wrote:
>>> This commit adds uSD support for Cubieboard7 board based on Actions Semi
>>> S700 SoC. SD0 is connected to uSD slot. Since there is no PMIC support
>>> added yet, fixed regulator has been used as a regulator node.
>>>
>>> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>
>>> ---
>>> Changes since v4:
>>>       * No change.
>>> Changes since v3:
>>>         * No change.
>>> Changes since v2:
>>>         * No change.
>>> Changes since v1:
>>>         * No change.
>>> Changes since RFC:
>>>         * No change.
>>> ---
>>>  arch/arm64/boot/dts/actions/s700-cubieboard7.dts | 41 ++++++++++++++++++++++++
>>>  arch/arm64/boot/dts/actions/s700.dtsi            |  1 +
>>>  2 files changed, 42 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>>> index 63e375cd9eb4..ec117eb12f3a 100644
>>> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>>> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>>> @@ -13,6 +13,7 @@
>>>
>>>       aliases {
>>>               serial3 = &uart3;
>>> +             mmc0 = &mmc0;
>>>       };
>>>
>>>       chosen {
>>> @@ -28,6 +29,23 @@
>>>               device_type = "memory";
>>>               reg = <0x1 0xe0000000 0x0 0x0>;
>>>       };
>>> +
>>> +     /* Fixed regulator used in the absence of PMIC */
>>> +     vcc_3v1: vcc-3v1 {
>>> +             compatible = "regulator-fixed";
>>> +             regulator-name = "fixed-3.1V";
>>> +             regulator-min-microvolt = <3100000>;
>>> +             regulator-max-microvolt = <3100000>;
>>> +     };
>>
>> Is this regulator used somewhere?
> 
> This is something I copied from bubblegum dts as I wasn't sure what is right way
> to include these regulators.

But this regulator is only used for the eMMC there, which we apparently
don't have on the Cubieboard 7?

> Also, another day tested it without having these regulators in , and
> still it seems to
> work.  So should these be removed ?

If there are not even referenced in the .dts, then fixed regulators are
rather pointless. So yes, please remove this vcc-3v1 one.

What is the story with the other regulator? Is there a PMIC or a power
switch for the SD card? Or is the power supply actually hardwired?

Cheers,
Andre
