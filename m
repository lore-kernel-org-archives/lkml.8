Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0DAC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8824F20809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GEtTL4vJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgG0WjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:39:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50770 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgG0WjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:39:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RMdCSp117118;
        Mon, 27 Jul 2020 17:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595889552;
        bh=BvCgv2VkYscYUBrio/xCc/7/XZeeMfxy0YDyyGSGIo4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GEtTL4vJBR/HVnlMugvN7TlachHm/SgGkIZsvgQMGAQpS/BWl92b6CwoqdWh/p3eR
         chjJNq4GlO0NOGmU50bfAXRJl5NXTk0r/5ZgLq3L/tMofRIRzodRA4ZGj0V3k/lAgs
         g+SedXDNUP9HDI3TzHvv760aZhbCpmqDA3l65r/o=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RMdCbb001847
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 17:39:12 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 17:39:12 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 17:39:12 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RMdBwJ092701;
        Mon, 27 Jul 2020 17:39:11 -0500
Subject: Re: [PATCH v2 1/4] dt-bindings: remoteproc: Add bindings for R5F
 subsystem on TI K3 SoCs
To:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stefanos@xilinx.com>,
        <BLEVINSK@xilinx.com>, <tomase@xilinx.com>
References: <20200630024922.32491-1-s-anna@ti.com>
 <20200630024922.32491-2-s-anna@ti.com> <20200714171553.GA2522956@bogus>
 <20200716171903.GA3286345@xps15>
 <alpine.DEB.2.21.2007161232400.3886@sstabellini-ThinkPad-T480s>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b7415d48-a354-5610-a657-08cdefc482a6@ti.com>
Date:   Mon, 27 Jul 2020 17:39:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2007161232400.3886@sstabellini-ThinkPad-T480s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 7/16/20 2:43 PM, Stefano Stabellini wrote:
> On Thu, 16 Jul 2020, Mathieu Poirier wrote:
>> Hi Rob,
>>
>> On Tue, Jul 14, 2020 at 11:15:53AM -0600, Rob Herring wrote:
>>> On Mon, Jun 29, 2020 at 09:49:19PM -0500, Suman Anna wrote:
>>>> The Texas Instruments K3 family of SoCs have one or more dual-core
>>>> Arm Cortex R5F processor subsystems/clusters (R5FSS). The clusters
>>>> can be split between multiple voltage domains as well. Add the device
>>>> tree bindings document for these R5F subsystem devices. These R5F
>>>> processors do not have an MMU, and so require fixed memory carveout
>>>> regions matching the firmware image addresses. The nodes require more
>>>> than one memory region, with the first memory region used for DMA
>>>> allocations at runtime. The remaining memory regions are reserved
>>>> and are used for the loading and running of the R5F remote processors.
>>>> The R5F processors can also optionally use any internal on-chip SRAM
>>>> memories either for executing code or using it as fast-access data.
>>>>
>>>> The added example illustrates the DT nodes for the single R5FSS device
>>>> present on K3 AM65x family of SoCs.
>>>>
>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>> ---
>>>> v2:
>>>>   - Renamed "lockstep-mode" property to "ti,cluster-mode"
>>>
>>> I don't think that's a move in the right direction given this is at
>>> least partially a standard feature.
>>>
>>> As I said before, I'm very hesistant to accept anything here given I
>>> know the desires and activity to define 'system Devicetrees' of which
>>> TI is participating. While maybe an rproc node is sufficient for a
>>> DSP, it seems multiple vendors have R cores and want to define them in
>>> system DT.

Ping on this discussion. TI is participating on the System DT evolution 
in general, but we don't have any plans to use DTS on our remote cores. 
We have our own auto-generated Chip-Support-Library (CSL) code that gets 
used on our firmwares.

Also, most of the properties I defined are rather standard properties. I 
have posted a revised v3 [1] after the common ti,sci properties 
refactoring. This series is only waiting on the bindings. I am happy to 
change any ti, prefixed properties. I had one open question [2] that I 
am waiting for a response from you for identifying the R5F Core.

regards
Suman

[1] https://patchwork.kernel.org/patch/11679331/
[2] https://patchwork.kernel.org/comment/23273441/

>>>
>>> Though the system DT effort has not yet given any thought to what is the
>>> view of one processor or instance to another instance (which is what
>>> this binding is). We'll still need something defined for that, but I'd
>>> expect that to be dependent on what is defined for system DT.
>>
>> Efforts related to the definition of the system DT are under way, something I
>> expect to keep going on for some time to come.  I agree with the need to use the
>> system DT to define remote processors and I look forward to the time we can do
>> so.
> 
> I'll take this opportunity to add that I should be able to publicly
> present a System Device Tree proposal for this during the next call (the
> next one after the call early next week that has already a full agenda.)
> 
> 
>> That being said we need to find a concensus on how to move forward with patches
>> that are ready to be merged.  What is your opinion on that?
> 
> In my opinion we don't have to necessarily wait for System Device Tree
> to make progress with those if they look OK.
> 

