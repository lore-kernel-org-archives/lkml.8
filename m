Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9563C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E0920760
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGCRI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:08:57 -0400
Received: from foss.arm.com ([217.140.110.172]:53300 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgGCRI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:08:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0883431B;
        Fri,  3 Jul 2020 10:08:56 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8FBA3F73C;
        Fri,  3 Jul 2020 10:08:53 -0700 (PDT)
Subject: Re: [PATCH] usb: host: ohci-platform: Disable ohci for rk3288
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@collabora.com>,
        linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        William Wu <william.wu@rock-chips.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        Kever Yang <kever.yang@rock-chips.com>
References: <20200702090504.36670-1-jagan@amarulasolutions.com>
 <f0ae5915-9cb8-9550-f05c-6cebad191a14@arm.com>
 <CAMty3ZBBdYdNOf-nQTdKZfi-VagaML6k+4PkAh6Uz936h9auow@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a3d2bc2a-9c19-25fa-f2d7-1a26fcc0c047@arm.com>
Date:   Fri, 3 Jul 2020 18:08:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMty3ZBBdYdNOf-nQTdKZfi-VagaML6k+4PkAh6Uz936h9auow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-03 12:39, Jagan Teki wrote:
> On Thu, Jul 2, 2020 at 8:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 2020-07-02 10:05, Jagan Teki wrote:
>>> rk3288 has usb host0 ohci controller but doesn't actually work
>>> on real hardware but it works with new revision chip rk3288w.
>>>
>>> So, disable ohci for rk3288.
>>>
>>> For rk3288w chips the compatible update code is handled by bootloader.
>>>
>>> Cc: William Wu <william.wu@rock-chips.com>
>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>> ---
>>> Note:
>>> - U-Boot patch for compatible update
>>> https://patchwork.ozlabs.org/project/uboot/patch/20200702084820.35942-1-jagan@amarulasolutions.com/
>>>
>>>    drivers/usb/host/ohci-platform.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
>>> index 7addfc2cbadc..24655ed6a7e0 100644
>>> --- a/drivers/usb/host/ohci-platform.c
>>> +++ b/drivers/usb/host/ohci-platform.c
>>> @@ -96,7 +96,7 @@ static int ohci_platform_probe(struct platform_device *dev)
>>>        struct ohci_hcd *ohci;
>>>        int err, irq, clk = 0;
>>>
>>> -     if (usb_disabled())
>>> +     if (usb_disabled() || of_machine_is_compatible("rockchip,rk3288"))
>>
>> This seems unnecessary to me - if we've even started probing a driver
>> for a broken piece of hardware to the point that we need magic checks to
>> bail out again, then something is already fundamentally wrong.
>>
>> Old boards only sold with the original SoC variant have no reason to
>> enable the OHCI (since it never worked originally), thus will never
>> execute this check.
>>
>> New boards designed around the W variant to make use of the OHCI can
>> freely enable it either way.
>>
>> The only relative-edge-case where it might matter is older board designs
>> still in production which have shipped with both SoC variants. Enabling
>> OHCI can't be *necessary* given that it's still broken on a lot of
>> deployed boards, so at best it must be an opportunistic nice-to-have.
>> Since we're already having to rely on the bootloader to patch up the
>> devicetree for other low-level differences in this case, it should be
>> part of that responsibility for it to only enable the OHCI on the
>> appropriate SoC variant too. Statically enabling it in the DTS for a
>> board where it may well not work is just bad.
> 
> You mean enable OHCI by identifying revision W with dts status "okay"?
> doesn't it complex for the bootloader to update all effecting changes?

Well, on boards which may have either SoC it's already got to detect the 
difference and make at least a couple of other DT adjustments; a handful 
more lines to check for a specific node and flip its status wouldn't be 
too horrendous (although I suppose you'd also want to check whether the 
EHCI is enabled first, to guess at whether the port's even wired up at all).

Or alternatively, as I said, simply don't bother doing anything - boards 
that only use RK3288W can enable OHCI in their DTS, and other boards 
that have been not using it for however many years can continue not 
using it even if it might technically be available on newer production runs.

Robin.
