Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C75C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EFB2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OFpF9T6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgE2SXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:23:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51002 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2SXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:23:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04TIMrg8100299;
        Fri, 29 May 2020 13:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590776573;
        bh=sPL+7JF8rHgYei8jMdMnhOJQnH3qvwFo9YiQ/UVOtBk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OFpF9T6aPW1jiMAsw+jzoXiPteEzQWhRGAILRgyXSNnAa+jp7eel8S2M00s2gyOVq
         l/fvmMxrA3Zf7mTbwEAQKCGHMF/Q5ppbGpisOy5WVldIBX/mKLjFUN0/EWRvHlOMBE
         aAD63HCd+8PwKaqFxG7TORxY/H86X78JJdq5nc2M=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04TIMrTS013909
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 13:22:53 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 29
 May 2020 13:22:53 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 29 May 2020 13:22:53 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04TIMoKe058585;
        Fri, 29 May 2020 13:22:51 -0500
Subject: Re: [PATCH v4 0/2] soc: ti: add k3 platforms chipid module driver
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     Dave Gerlach <d-gerlach@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <20200512123449.16517-1-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <a132765e-f4e4-a1e8-fb43-239188fecf1b@ti.com>
Date:   Fri, 29 May 2020 21:22:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512123449.16517-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On 12/05/2020 15:34, Grygorii Strashko wrote:
> Hi All,
> 
> This series introduces TI K3 Multicore SoC platforms chipid module driver
> which provides identification support of the TI K3 SoCs (family, revision)
> and register this information with the SoC bus. It is available under
> /sys/devices/soc0/ for user space, and can be checked, where needed,
> in Kernel using soc_device_match().
> It is also required for introducing support for new revisions of
> K3 AM65x/J721E SoCs.
> 
> Example J721E:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments K3 J721E SoC
>    J721E
>    SR1.0
> 
> Example AM65x:
>    # cat /sys/devices/soc0/{machine,family,revision}
>    Texas Instruments AM654 Base Board
>    AM65X
>    SR1.0
> 
> Changes in v4:
>   - convert to platform_driver as suggested by Arnd Bergmann <arnd@arndb.de>
> 
> Changes in v3:
>   - add handling of kasprintf() fail
> 
> Changes in v2:
>   - pr_debug() replaced with pr_info() to show SoC info on init
>   - minor format change
>   - split series on driver and platform changes
>   - add Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
> 
> v3: https://lkml.org/lkml/2020/5/8/357
> v2: https://lkml.org/lkml/2020/5/5/1193
> v1: https://lwn.net/Articles/818577/
> 
> Grygorii Strashko (2):
>    dt-bindings: soc: ti: add binding for k3 platforms chipid module
>    soc: ti: add k3 platforms chipid module driver
> 
>   .../bindings/soc/ti/k3-socinfo.yaml           |  40 +++++
>   drivers/soc/ti/Kconfig                        |  10 ++
>   drivers/soc/ti/Makefile                       |   1 +
>   drivers/soc/ti/k3-socinfo.c                   | 152 ++++++++++++++++++
>   4 files changed, 203 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
>   create mode 100644 drivers/soc/ti/k3-socinfo.c
> 

Any chances you can pick this up?

-- 
Best regards,
grygorii
