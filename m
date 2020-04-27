Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7FEC55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 656A720575
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BXLQ8oWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgD0LPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:15:32 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38002 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0LPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:15:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RBFSN3063594;
        Mon, 27 Apr 2020 06:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587986128;
        bh=gWEr5tUocVL65YN3YdxkcoYlxJ4xnh76tpLqZoEi+T4=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=BXLQ8oWgszzhS0GV9UfDuuVUIYnrSddUEq0vE+9Rs9AACJ3poew6mm6tlOp/V0bfI
         4/WQE22r6YIZwkiu1I0urYnMsabV716UlqXvWUcP/5/UvvyjtcNvFwMdcc84Tciw+b
         yCHmotWXuGxhCX8NBjOsiZ1UVnUes0ZtGV3qKBQg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RBFS42121540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 06:15:28 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 06:15:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 06:15:27 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RBFPaI063776;
        Mon, 27 Apr 2020 06:15:26 -0500
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j721e-main.dtsi: Add DSS node
To:     Jyri Sarha <jsarha@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
 <20200422091512.950-2-tomi.valkeinen@ti.com>
 <ade3a177-f060-bc40-bcc1-494093e3071d@ti.com>
 <47b7f858-a8d9-1c3b-4dca-2cc493f6730f@ti.com>
 <fa497e8d-7911-5f3d-cf91-347370f8edaa@ti.com>
 <217c0c14-f4fb-7321-9f57-205df0cd01fe@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <9a4b1d0a-c871-2280-8d22-196730e9385b@ti.com>
Date:   Mon, 27 Apr 2020 14:15:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <217c0c14-f4fb-7321-9f57-205df0cd01fe@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2020 14:10, Jyri Sarha wrote:
> On 27/04/2020 13:51, Tomi Valkeinen wrote:
>> On 27/04/2020 13:37, Jyri Sarha wrote:
>>> On 27/04/2020 13:09, Tero Kristo wrote:
>>>>> +        status = "disabled";
>>>>
>>>> Again, why disabled by default?
>>>>
>>>
>>> tidss device is not functional without a defined video-port. The driver
>>> is not implemented in a way that it would handle a broken configuration
>>> gracefully.
>>
>> Then we need to fix it. The driver should handle the case where there
>> are no ports defined just fine.
>>
> 
> Just by reading the code, I would say that currently the probe would
> fail with returned -ENOMEM after calling drm_vblank_init() with zero CRTCs.
> 
> So should the probe fail gracefully and silently, or should we try to
> register a DRM device with no CRTCs? Is that even possible?

My first thought is that the driver should exit probe silently with ENODEV if there are no outputs 
defined (but, of course, with EPROBE_DEFER if there are outputs which haven't been probed yet).

It gets a bit more complex if we ever support writeback, as that can be used as mem-to-mem without 
any displays, but I think we can ignore that for now.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
