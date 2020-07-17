Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1873C2BB1E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40F92074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q22LmMWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGQHWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:22:46 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55368 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgGQHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:22:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7MgEr010271;
        Fri, 17 Jul 2020 02:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594970562;
        bh=XNNcfenzn5BVU/fqCgZrkziwMHoFzsF1wvlu4KoZgxw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q22LmMWP7lD4vOudYIqSJvIRnD4REdx9eh3jmTX/0nev33P6RvryVQLbQQy1gIZe2
         3KPylsc9Tet61tnDx1wWQ8efyGmDvyn/7IXueu7ImNf5RAPa9W4Ow638vdpuuTsV1o
         O1/SPsBDrlyFbBdjP1VSFYyb7PAvxKjxXte7UveA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7Mg5F043448;
        Fri, 17 Jul 2020 02:22:42 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:22:42 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:22:42 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7McFK128800;
        Fri, 17 Jul 2020 02:22:39 -0500
Subject: Re: [PATCH 0/2] Add support for SD card on on AM65x-evm
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>
References: <20200710190215.30938-1-faiz_abbas@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <4873d494-d38e-acb1-242e-9fb2f6dbf999@ti.com>
Date:   Fri, 17 Jul 2020 10:22:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710190215.30938-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2020 22:02, Faiz Abbas wrote:
> The following patches add support for SD card node in am654x-evm
> 
> Because of fundamental interface issues (see patch 2 for details),
> SD card was never enabled for silicon revision 1.0
> 
> These issues have been fixed with SR2.0 but boards with SR1.0 are
> recommended to disable this node
> 
> These patches depend on kernel patches for supporting silicon revision
> 2.0 posted here:
> https://patchwork.kernel.org/project/linux-mmc/list/?series=305565
> 
> The dependencies have been picked up and are in linux-next

Queued up for 5.9, thanks.

-Tero

> 
> Faiz Abbas (2):
>    arm64: dts: ti: k3-am65-main: Add support for sdhci1
>    arm64: dts: ti: k3-am654-base-board: Add support for SD card
> 
>   arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 24 +++++++++++++++++++
>   .../arm64/boot/dts/ti/k3-am654-base-board.dts | 24 +++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
