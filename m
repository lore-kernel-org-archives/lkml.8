Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32202C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0844121835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 05:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NCRNfyWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgAVFCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 00:02:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41994 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgAVFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 00:02:21 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00M52EbK034781;
        Tue, 21 Jan 2020 23:02:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579669334;
        bh=19Euv4bypX6Nyf5cnWQL/mS9NVJvz1Qup12v8d47CGY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NCRNfyWuc/18KD4nNqw6EIUZdIKLO4uIUnoiv4ipzx/IwraS4DtamhJa0iNEi0l/4
         5YvNzKFkUQbtC2J+KC9Tl+Z6xftNufhBsN2IDu4/IUQsMm6DXa+ACLOlnpxVjAv49j
         gdpa8v9LKz895pnMTvNjAEc1Nwyz3NI63ucoitI0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00M52E70073297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jan 2020 23:02:14 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Jan 2020 23:02:14 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Jan 2020 23:02:14 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00M528Us130655;
        Tue, 21 Jan 2020 23:02:09 -0600
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Rob Herring <robh@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh R <vigneshr@ti.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200108111830.8482-1-rogerq@ti.com>
 <20200108111830.8482-3-rogerq@ti.com> <20200115014724.GA20772@bogus>
 <1c55f0a8-99e3-934f-e8b8-d090df06a12e@ti.com>
 <CAL_JsqLfJDN2LnqWHehFiM-SQyeqQAk2wjoKRbBiPy4tc5OkMQ@mail.gmail.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d1b9fb54-9f6b-ef23-1c6f-d4c341a22785@ti.com>
Date:   Wed, 22 Jan 2020 10:35:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLfJDN2LnqWHehFiM-SQyeqQAk2wjoKRbBiPy4tc5OkMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On 21/01/20 11:27 PM, Rob Herring wrote:
> On Mon, Jan 20, 2020 at 11:10 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 15/01/20 7:17 AM, Rob Herring wrote:
>>> On Wed, Jan 08, 2020 at 01:18:27PM +0200, Roger Quadros wrote:
>>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>>
>>>> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>> ---
>>>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 26 +++++++++++
>>>>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>>>>  2 files changed, 79 insertions(+)
>>>>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
>>>>
>>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>> index 24cb78db28e4..6741c1e67f50 100644
>>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>>> @@ -5,6 +5,8 @@
>>>>   * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
>>>>   */
>>>>  #include <dt-bindings/phy/phy.h>
>>>> +#include <dt-bindings/mux/mux.h>
>>>> +#include <dt-bindings/mux/mux-j721e-wiz.h>
>>>>
>>>>  &cbass_main {
>>>>      msmc_ram: sram@70000000 {
>>>> @@ -19,6 +21,30 @@
>>>>              };
>>>>      };
>>>>
>>>> +    scm_conf: scm_conf@100000 {
>>>
>>> Don't use '_' in node names.
>>
>> Okay.
>>>
>>>> +            compatible = "syscon", "simple-mfd";
>>>
>>> Needs a specific compatible especially since the child node doesn't have
>>> one.
>>
>> Child node has "mmio-mux" as compatible no? Are you referring to
>> something else here?
> 
> I'm referring to exactly what I quoted, but that's also a generic
> compatible, so you'd never be able to match any of this block to a
> specific driver or handle any quirks.

Okay, right now we didn't see the need for a specific compatible but I
guess that is necessary to make it more future proof. Will add a
specific compatible.

Thanks
Kishon
