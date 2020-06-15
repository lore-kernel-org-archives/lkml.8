Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4B9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F6D2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Tk6mZtCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgFOHrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:47:17 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48212 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgFOHrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:47:16 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05F7lBsP016324;
        Mon, 15 Jun 2020 02:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592207231;
        bh=Ef11p/NIErwu7Zja6hoZoc9WK3zg6NXxXuzepAV2x8A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Tk6mZtCdP83acUfOMQ/xepnJquIYfZv+DOtBInH3MkiGFLl+4J9WLm02ppSs76to8
         Oan6/9fALxXd9fblPXWVekNBsmFrEeZpQLzsxnS8GYQIVzGA2m1TF0b6TSKKWZpu9u
         MnQOpCRpMEm2kvIdwebuv7NJy2/A8Id8Zx/RIVhY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05F7lBa5107325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 Jun 2020 02:47:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 15
 Jun 2020 02:47:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 15 Jun 2020 02:47:10 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05F7l8eF119410;
        Mon, 15 Jun 2020 02:47:09 -0500
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3: add platforms chipid module nodes
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Dave Gerlach <d-gerlach@ti.com>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200613164346.28852-1-grygorii.strashko@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <8b8f7f92-571d-4a44-4858-7d79676a6375@ti.com>
Date:   Mon, 15 Jun 2020 10:47:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200613164346.28852-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 13/06/2020 19.43, Grygorii Strashko wrote:
> Hi Tero,
>=20
> Hence k3 platforms chipid module driver was merged, there is follow up =
series
> to add corresponding DT chipid nodes.=20
>=20
> [1] https://lkml.org/lkml/2020/5/29/979
>=20
> Grygorii Strashko (2):
>   arm64: dts: ti: k3-am65-wakeup: add k3 platforms chipid module node
>   arm64: dts: ti: k3-j721e-mcu-wakeup: add k3 platforms chipid module n=
ode

Can you also send a patch to enable the socinfo build?

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 8dd05b2a925c..1d3710e3626a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -98,6 +98,7 @@ config ARCH_K3
 	select TI_SCI_PROTOCOL
 	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
+	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
 	  architecture.

With this added:
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>=20
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      | 5 +++++
>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 5 +++++
>  2 files changed, 10 insertions(+)
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

