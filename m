Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FF6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FED2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wGVX7Onw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGQHgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:36:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43212 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgGQHgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:36:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7aKLt017921;
        Fri, 17 Jul 2020 02:36:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594971380;
        bh=XNxA2YHCiMidNevYGW4DHNRVyITdLftF9encdz2b30w=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wGVX7OnwtYJiSo+PCFXoFa5Cip0Bcu47wR1eox45tAY5NUfIzyUxUQtaNojCk/tnH
         xO+k+1/YmyrvIlHsAgwTUFYhcF2S1eb4kfTBVDpj8vYUxS+r6fiYd4q168GuWTiBjQ
         /QcPiYTZmkDkQqUAgUuSol6vlQ0upJsp7wf43A5A=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06H7aKqS043241
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 02:36:20 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:36:19 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:36:19 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7aDk7044590;
        Fri, 17 Jul 2020 02:36:16 -0500
Subject: Re: [PATCH v4 0/6] arm64: ti: k3-j721e: Add SERDES PHY and USB3.0
 support
To:     Roger Quadros <rogerq@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200629125254.28754-1-rogerq@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <819b80c3-b029-3bb6-4c17-4f694f93b905@ti.com>
Date:   Fri, 17 Jul 2020 10:36:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200629125254.28754-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2020 15:52, Roger Quadros wrote:
> Hi Tero,
> 
> This series adds SERDES PHY support and Type-C USB Super-Speed support
> to the J721E EVM.
> 
> Please queue this for -next. Thanks.

Queued up for 5.9, thanks.

-Tero

> 
> cheers,
> -roger
> 
> Changelog:
> v4:
> - Removed redundant patch
> - used compaible string for yaml filename
> - typo fix s/mdf/mfd in patch subject
> - added simple-mfd, address-cells, size-cells and ranges
> 
> v3:
> - Add new DT schema for J721E System controller.
> - Re-order system controller's compatible string i.e. most compatible to least.
> 
> v2:
> - Addressed Rob's comments.
> - Changed type-C debounce delay from 300ms to 700ms as 300ms is not
> sufficient on EVM.
> 
> 
> Kishon Vijay Abraham I (2):
>    arm64: dts: ti: k3-j721e-main: Add WIZ and SERDES PHY nodes
>    arm64: dts: ti: k3-j721e-main: Add system controller node and SERDES
>      lane mux
> 
> Roger Quadros (4):
>    dt-bindings: mfd: ti,j721e-system-controller.yaml: Add J721e system
>      controller
>    arm64: dts: ti: k3-j721e-main.dtsi: Add USB to SERDES MUX
>    arm64: dts: ti: k3-j721e: Enable Super-Speed support for USB0
>    arm64: dts: k3-j721e-proc-board: Add wait time for sampling Type-C DIR
>      line
> 
>   .../mfd/ti,j721e-system-controller.yaml       |  74 +++++
>   .../dts/ti/k3-j721e-common-proc-board.dts     |  33 ++-
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 275 ++++++++++++++++++
>   include/dt-bindings/mux/mux-j721e-wiz.h       |  53 ++++
>   4 files changed, 433 insertions(+), 2 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
>   create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
