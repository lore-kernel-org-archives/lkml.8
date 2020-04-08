Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE079C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4420730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730417AbgDHQrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:47:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55206 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgDHQrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:47:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 535B328CC6F
Subject: Re: [PATCH] arm64: dts: mt8173: Add gce setting in mmsys and display
 node
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20191118104252.228406-1-hsinyi@chromium.org>
 <CAFqH_528vidMhTFxNZ=b7SFD2K12UwtdX3uTUzW4YUgeDWkg5A@mail.gmail.com>
 <CAAOTY_8RMboOuKVKPANZ1QN+mt0jvOr13o84VhWKGY1QZqbPDg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <e22e0400-56e0-2ff4-72d8-5231b7fa58fc@collabora.com>
Date:   Wed, 8 Apr 2020 18:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY_8RMboOuKVKPANZ1QN+mt0jvOr13o84VhWKGY1QZqbPDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang

Many thanks to let us know this, I completely missed.

On 8/4/20 18:09, Chun-Kuang Hu wrote:
> Hi, Hsin-Yi:
> 
> Enric Balletbo Serra <eballetbo@gmail.com> 於 2020年4月8日 週三 下午11:48寫道：
>>
>> Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 18 de nov.
>> 2019 a les 11:43:
>>>
>>> In order to use GCE function, we need add some informations
>>> into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-events).
>>>
>>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>>
>> With the fix provided by Hsin-Yi [1] and after the mmsys patches
>> landed I get GCE function working on mt8173, so
>>
>> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>
>> [1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromium.org/
>>
>> Thanks,
>>  Enric
>>
>>> ---
>>> - This is based on series "support gce on mt8183 platform"
>>>   https://patchwork.kernel.org/cover/11208309/
>>> - gce setting in 8183:
>>>   https://patchwork.kernel.org/patch/11127105/
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> index 15f1842f6df3..e84ec3f95d81 100644
>>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
>>> @@ -911,6 +911,11 @@ mmsys: clock-controller@14000000 {
>>>                         assigned-clocks = <&topckgen CLK_TOP_MM_SEL>;
>>>                         assigned-clock-rates = <400000000>;
>>>                         #clock-cells = <1>;
>>> +                       mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
>>> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> 
> Because of patch [1], atomic_exec parameter should be removed.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20200408&id=19d8e335d58a961a7ed377e5e2e63664b92c0b9c
> 

Many thanks to point this. Hsin-Yi, as the mt8173 device-tree will not land in
current merge window (Matthias correct me if I am  wrong) maybe you could send a
new version of the device-tree including these changes?


>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>>> +                       mediatek,gce-events = <CMDQ_EVENT_MUTEX0_STREAM_EOF>,
>>> +                                             <CMDQ_EVENT_MUTEX1_STREAM_EOF>;
> 
> Because of patch [2], these events should be moved to mutex node.
> 
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.6&id=60fa8c13ab1a33b8b958efb1510ec2fd8a064bcc
> 

Hsin-Yi, note this will also impact your fixes patch [1].

[1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromium.org/

Thanks,
 Enric

> Regards,
> Chun-Kuang.
> 
>>>                 };
>>>
>>>                 mdp_rdma0: rdma@14001000 {
>>> @@ -991,6 +996,7 @@ ovl0: ovl@1400c000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_OVL0>;
>>>                         iommus = <&iommu M4U_PORT_DISP_OVL0>;
>>>                         mediatek,larb = <&larb0>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xc000 0x1000>;
>>>                 };
>>>
>>>                 ovl1: ovl@1400d000 {
>>> @@ -1001,6 +1007,7 @@ ovl1: ovl@1400d000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_OVL1>;
>>>                         iommus = <&iommu M4U_PORT_DISP_OVL1>;
>>>                         mediatek,larb = <&larb4>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xd000 0x1000>;
>>>                 };
>>>
>>>                 rdma0: rdma@1400e000 {
>>> @@ -1011,6 +1018,7 @@ rdma0: rdma@1400e000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_RDMA0>;
>>>                         iommus = <&iommu M4U_PORT_DISP_RDMA0>;
>>>                         mediatek,larb = <&larb0>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xe000 0x1000>;
>>>                 };
>>>
>>>                 rdma1: rdma@1400f000 {
>>> @@ -1021,6 +1029,7 @@ rdma1: rdma@1400f000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_RDMA1>;
>>>                         iommus = <&iommu M4U_PORT_DISP_RDMA1>;
>>>                         mediatek,larb = <&larb4>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0xf000 0x1000>;
>>>                 };
>>>
>>>                 rdma2: rdma@14010000 {
>>> @@ -1031,6 +1040,7 @@ rdma2: rdma@14010000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_RDMA2>;
>>>                         iommus = <&iommu M4U_PORT_DISP_RDMA2>;
>>>                         mediatek,larb = <&larb4>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0 0x1000>;
>>>                 };
>>>
>>>                 wdma0: wdma@14011000 {
>>> @@ -1041,6 +1051,7 @@ wdma0: wdma@14011000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_WDMA0>;
>>>                         iommus = <&iommu M4U_PORT_DISP_WDMA0>;
>>>                         mediatek,larb = <&larb0>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x1000 0x1000>;
>>>                 };
>>>
>>>                 wdma1: wdma@14012000 {
>>> @@ -1051,6 +1062,7 @@ wdma1: wdma@14012000 {
>>>                         clocks = <&mmsys CLK_MM_DISP_WDMA1>;
>>>                         iommus = <&iommu M4U_PORT_DISP_WDMA1>;
>>>                         mediatek,larb = <&larb4>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x2000 0x1000>;
>>>                 };
>>>
>>>                 color0: color@14013000 {
>>> @@ -1059,6 +1071,7 @@ color0: color@14013000 {
>>>                         interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_LOW>;
>>>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>>>                         clocks = <&mmsys CLK_MM_DISP_COLOR0>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x3000 0x1000>;
>>>                 };
>>>
>>>                 color1: color@14014000 {
>>> @@ -1067,6 +1080,7 @@ color1: color@14014000 {
>>>                         interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_LOW>;
>>>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>>>                         clocks = <&mmsys CLK_MM_DISP_COLOR1>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x4000 0x1000>;
>>>                 };
>>>
>>>                 aal@14015000 {
>>> @@ -1075,6 +1089,7 @@ aal@14015000 {
>>>                         interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_LOW>;
>>>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>>>                         clocks = <&mmsys CLK_MM_DISP_AAL>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x5000 0x1000>;
>>>                 };
>>>
>>>                 gamma@14016000 {
>>> @@ -1083,6 +1098,7 @@ gamma@14016000 {
>>>                         interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_LOW>;
>>>                         power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>>>                         clocks = <&mmsys CLK_MM_DISP_GAMMA>;
>>> +                       mediatek,gce-client-reg = <&gce SUBSYS_1401XXXX 0x6000 0x1000>;
>>>                 };
>>>
>>>                 merge@14017000 {
>>> --
>>> 2.24.0.432.g9d3f5f5b63-goog
>>>
>>>
>>> _______________________________________________
>>> Linux-mediatek mailing list
>>> Linux-mediatek@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
