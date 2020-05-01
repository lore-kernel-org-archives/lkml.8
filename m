Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E25C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CC5208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 20:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="a68RxpDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgEAUzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 16:55:22 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59292 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgEAUzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 16:55:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 041KtFB4009464;
        Fri, 1 May 2020 15:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588366515;
        bh=L1otyNvruxzYrays8d+Dfy2TZg5TRkz5w0VMaUbYdso=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=a68RxpDSolAOn89K69XTAVB5g9tknN9PPhB0ImXXY1eMcBgifQPh5p1UIAy9ZXmZb
         p9Nj/Lr0wFnZ9jSHO8wWZPxLDx7KDcjtIQKMk72SQf801FzXdQvRVlVVnYHdb7ej0f
         sBJuj7aGTar7izvHWDe2rGZtZOeqyNdSQf3w++h4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041KtFxE015659;
        Fri, 1 May 2020 15:55:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 1 May
 2020 15:55:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 1 May 2020 15:55:14 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 041KtB78036400;
        Fri, 1 May 2020 15:55:11 -0500
Subject: Re: [PATCH 0/5] soc: ti: add k3 platforms chipid module driver
To:     Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <23b3b069-426e-a113-a8bf-816b30f10490@ti.com>
Date:   Fri, 1 May 2020 23:55:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423180545.13707-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh, Tero

On 23/04/2020 21:05, Grygorii Strashko wrote:
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
> Grygorii Strashko (5):
>    dt-bindings: soc: ti: add binding for k3 platforms chipid module
>    soc: ti: add k3 platforms chipid module driver
>    arm64: arch_k3: enable chipid driver
>    arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
>    arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module
>      node
> 
>   .../bindings/soc/ti/k3-socinfo.yaml           |  40 ++++++
>   arch/arm64/Kconfig.platforms                  |   1 +
>   arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   5 +
>   .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |   5 +
>   drivers/soc/ti/Kconfig                        |  10 ++
>   drivers/soc/ti/Makefile                       |   1 +
>   drivers/soc/ti/k3-socinfo.c                   | 135 ++++++++++++++++++
>   7 files changed, 197 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-socinfo.yaml
>   create mode 100644 drivers/soc/ti/k3-socinfo.c
> 

Any more comments? I'm going resend it.

-- 
Best regards,
grygorii
