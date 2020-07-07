Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B50C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD041206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O9vEWm+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGGHBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:01:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57752 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgGGHBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:01:53 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06771cVw059056;
        Tue, 7 Jul 2020 02:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594105299;
        bh=KVGw85WEdh6sD68oVUbd+Hkf19Ffz1FJ5ZxJS8+3gNA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=O9vEWm+62XVfTOSNnhB5N4/19dgbHA9ihclyVYQOAbqyVJMiRYFhQjY35Xmh+CD7N
         4JziLs2eIG1vbVrNABiErIXBp1DOKeXQz+ko6H52AacZ7jw+CZh9bh1Qhdtk4q7bpB
         4hzYq6x/ls+0+1p+hNyG3+50byNWuzhndiwC0bV8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06771ctv007282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jul 2020 02:01:38 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 7 Jul
 2020 02:01:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 7 Jul 2020 02:01:38 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06771Z5J075642;
        Tue, 7 Jul 2020 02:01:36 -0500
Subject: Re: [PATCH] arm64: arch_k3: enable chipid driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
References: <20200619162527.1226-1-grygorii.strashko@ti.com>
 <4bbdfff6-8fba-0568-b243-5da9ee6e29b6@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <5529a5b2-f929-76fe-d27f-43d3e0432b43@ti.com>
Date:   Tue, 7 Jul 2020 10:02:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4bbdfff6-8fba-0568-b243-5da9ee6e29b6@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/07/2020 13.18, Grygorii Strashko wrote:
> hi All,
>=20
> On 19/06/2020 19:25, Grygorii Strashko wrote:
>> Select TI chip id driver for TI's SoCs based on K3 architecture to
>> provide
>> this information to user space and Kernel as it is required by other
>> drivers to determine SoC revision to function properly.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>> =C2=A0 arch/arm64/Kconfig.platforms | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platfor=
ms
>> index 8dd05b2a925c..1d3710e3626a 100644
>> --- a/arch/arm64/Kconfig.platforms
>> +++ b/arch/arm64/Kconfig.platforms
>> @@ -98,6 +98,7 @@ config ARCH_K3
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TI_SCI_PROTOCOL
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TI_SCI_INTR_IRQCHIP
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 select TI_SCI_INTA_IRQCHIP
>> +=C2=A0=C2=A0=C2=A0 select TI_K3_SOCINFO
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This enables support for Te=
xas Instruments' K3 multicore SoC
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 architecture.
>>
>=20
> Are there any comments?

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> The driver and dt changes were merged [1][2] and for adding new am654x =
SoC
> revision SR2.0 we need this driver to be enabled always as other driver=
s
> are
> going to use SOC Bus API intensively.
>=20
> No dependencies.
>=20
> [1]
> https://lore.kernel.org/lkml/20200512123449.16517-1-grygorii.strashko@t=
i.com/
>=20
> [2]
> https://lore.kernel.org/lkml/20200613164346.28852-1-grygorii.strashko@t=
i.com/
>=20
>=20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

