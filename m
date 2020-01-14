Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF43CC33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D7D2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 08:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cYSAbBwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgANI3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 03:29:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38624 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:29:53 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00E8TfZC013873;
        Tue, 14 Jan 2020 02:29:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578990581;
        bh=EREYuC/AXrNZ/pdGBfsKD3rJsw744+e7sxVQeRfj0Ms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cYSAbBwXgYczJ1pzAgHb4s44xJhvBOfrWiaPtDtcOWA3pk4vWoH4RusCyBwGtRHWh
         h1cgcTwTWH/6ArvIdiID6Q8fjUqzqC3tz886wYHUXBRJYbzjeURiyZjgmQaZhViJVi
         2ud4Shu7La5vYldKuKPeggufGiEex5pc1opnFiek=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00E8TfjR103963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jan 2020 02:29:41 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 14
 Jan 2020 02:29:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 14 Jan 2020 02:29:41 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00E8TbcU059355;
        Tue, 14 Jan 2020 02:29:38 -0600
Subject: Re: [RESEND PATCH v5 01/11] dt-bindings: phy-mtk-tphy: add two
 optional properties for u2phy
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@a0393678ub>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <1578448326-27455-1-git-send-email-chunfeng.yun@mediatek.com>
 <20200110111006.GB2220@a0393678ub> <1578990166.21256.35.camel@mhfsdcap03>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <970b7cce-40ed-9ab7-5e04-9e3d609eadf7@ti.com>
Date:   Tue, 14 Jan 2020 14:01:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1578990166.21256.35.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On 14/01/20 1:52 PM, Chunfeng Yun wrote:
> Hi Kishon,
> 
> On Fri, 2020-01-10 at 16:40 +0530, Kishon Vijay Abraham I wrote:
>> Hi,
>>
>> On Wed, Jan 08, 2020 at 09:51:56AM +0800, Chunfeng Yun wrote:
>>> Add two optional properties, one for tuning J-K voltage by INTR,
>>> another for disconnect threshold, both of them are related with
>>> connect detection
>>>
>>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>>> Acked-by: Rob Herring <robh@kernel.org>
>>
>> Patch does not apply. I get the following errors
>> error: patch failed: Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt:52
>> error: Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt: patch does not apply
>> error: Did you hand edit your patch?
>>
>> Can you send them again in the right format?
> I download this patch from https://patchwork.kernel.org/patch/11322505/
> and fetch kernel5.5-rc5, then

Please try applying to
git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git next
> 
> git am --reject
> RESEND-v5-01-11-dt-bindings-phy-mtk-tphy-add-two-optional-properties-for-u2phy.patch
> Applying: dt-bindings: phy-mtk-tphy: add two optional properties for
> u2phy
> Checking patch Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt...
> Applied patch Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> cleanly.
> 
> don't reproduce the error you encountered, can you tell me the steps you
> apply the patch, thanks

git am chunfeng.yun.patch --reject
Applying: dt-bindings: phy-mtk-tphy: add two optional properties for u2phy
Checking patch Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt...
error: while searching for:
- mediatek,eye-vrt	: u32, the selection of VRT reference voltage?
- mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage?
- mediatek,bc12	: bool, enable BC12 of u2phy if support it?
?
Example:?
?

error: patch failed:
Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt:52
Applying patch Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
with 1 reject...
Rejected hunk #1.
Patch failed at 0001 dt-bindings: phy-mtk-tphy: add two optional
properties for u2phy
Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

Thanks
Kishon
