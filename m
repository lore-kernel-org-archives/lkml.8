Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC3AAC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FAE7206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rc+0rrd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCMEoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:44:00 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59434 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCMEoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:44:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D4hmM2019617;
        Thu, 12 Mar 2020 23:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584074628;
        bh=XpUwsYDH/tbEiw9bK9EeXQskLAoqJ6LteWN9NgyZdl4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rc+0rrd5mK+hpp1qXDueWMnJ+xVaNuRe4JNuHPRBgh+l2k9lxqWLzA+M4TzdAqh1l
         4gcaA3aKJdqF5/bDmdHL/dt0N5s59RD+uSAHCOmll67WkRC0y22b+tb1M77vB0ovrP
         crI699YeDGzoMFwL6tL9zop3mm8/WGFSMAd7UIM8=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D4hluL001597
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 23:43:47 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 23:43:47 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 23:43:47 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D4hhuU126810;
        Thu, 12 Mar 2020 23:43:44 -0500
Subject: Re: [Patch V5 00/21] Tegra XUSB OTG support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Felipe Balbi <balbi@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1581322307-11140-1-git-send-email-nkristam@nvidia.com>
 <20200217085130.GJ1339021@ulmo> <20200227173226.GA1114616@ulmo>
 <20200304070100.GA1271591@kroah.com> <20200312092232.GA1199023@ulmo>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <3e76c44e-f2b0-3c8a-c7b3-0461ff1176d3@ti.com>
Date:   Fri, 13 Mar 2020 10:18:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312092232.GA1199023@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/03/20 2:52 pm, Thierry Reding wrote:
> On Wed, Mar 04, 2020 at 08:01:00AM +0100, Greg Kroah-Hartman wrote:
>> On Thu, Feb 27, 2020 at 06:32:26PM +0100, Thierry Reding wrote:
>>> On Mon, Feb 17, 2020 at 09:51:30AM +0100, Thierry Reding wrote:
>>>> On Mon, Feb 10, 2020 at 01:41:26PM +0530, Nagarjuna Kristam wrote:
>>>>> This patch series adds OTG support on XUSB hardware used in Tegra210 and
>>>>> Tegra186 SoCs.
>>>>>
>>>>> This patchset is composed with :
>>>>>  - dt bindings of XUSB Pad Controller
>>>>>  - dt bindings for XUSB device Driver
>>>>>  - Tegra PHY driver for usb-role-switch and usb-phy
>>>>>  - Tegra XUSB host mode driver to support OTG mode
>>>>>  - Tegra XUSB device mode driver to use usb-phy and multi device mode
>>>>>  - dts for XUSB pad controller
>>>>>  - dts for xudc for Jetson TX1 and TX2
>>>>>  - dts for Jetson-TK1
>>>>>  - dts for Jetson-Nano
>>>>>
>>>>> Tegra Pad controller driver register for role switch updates for
>>>>> OTG/peripheral capable USB ports and adds usb-phy for that corresponding
>>>>> USB ports.
>>>>>
>>>>> Host and Device mode drivers gets usb-phy from USB2's phy and registers
>>>>> notifier for role changes to perform corresponding role tasks.
>>>>>
>>>>> Order of merging Patches:
>>>>> Please merge DT changes first followed Tegra PHY driver changes and then
>>>>> USB driver changes.
>>>>
>>>> Felipe, Greg, Kishon,
>>>>
>>>> Given the runtime dependencies between these various parts, I could pick
>>>> these up into the Tegra tree if you provide an Acked-by.
>>>
>>> Ping. Are you guys okay if I pick these up into the Tegra tree?
>>
>> That's up to Felipe, I have no opinion :)
> 
> Felipe, Kishon,
> 
> I've picked up the device tree changes into the Tegra tree. Let me know
> if you also want me to pick up the USB and PHY driver changes.

The PHY and USB changes can only go together since xhci-tegra.c seems to
use an export symbol of xusb PHY. So I'm fine if someone takes the PHY
changes along with USB changes.

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

Thanks
Kishon
