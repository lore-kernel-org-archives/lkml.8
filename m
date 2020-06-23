Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839DCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B35A20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qmzQkGlc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgFWJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:28:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38074 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbgFWJ2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:28:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05N9S5Ze125926;
        Tue, 23 Jun 2020 04:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592904485;
        bh=fEs47RkZAn3o/i2PzvLLvWnHhB3TwHTtIfZTfW8Ym2A=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qmzQkGlcIGW8tTCERgHaPdshR+P5MVgidMjFj7XXg5ukVfic43hZAj79vpZQQ5uJC
         G74mzz4I2s31oVrEhjCDYtFK8SMiT/7xo3uTWwHHzRfsSpOKYQJpAwqPBpsCo27XCH
         NVhPriYQt4yHQFoVEJg/9Xqu3AuXA9q6rmCspZR4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05N9S5c1034921;
        Tue, 23 Jun 2020 04:28:05 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 04:28:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 04:28:05 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05N9S3LY025765;
        Tue, 23 Jun 2020 04:28:03 -0500
Subject: Re: [PATCH v3 3/3] ASoC: ti: Add custom machine driver for j721e EVM
 (CPB and IVI)
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200612085909.15018-1-peter.ujfalusi@ti.com>
 <20200612085909.15018-4-peter.ujfalusi@ti.com>
 <7f2c4297-3ad9-5b8f-c9a5-5120078120c6@ti.com>
 <20200612122757.GF5396@sirena.org.uk>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <8c255c3c-8c9c-9200-962f-69de9a1f861c@ti.com>
Date:   Tue, 23 Jun 2020 12:28:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200612122757.GF5396@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/06/2020 15.27, Mark Brown wrote:
> On Fri, Jun 12, 2020 at 12:27:17PM +0300, Peter Ujfalusi wrote:
>=20
>>> +	if (IS_ERR(clocks->target)) {
>>> +		ret =3D PTR_ERR(clocks->target);
>>> +		if (ret !=3D -EPROBE_DEFER)
>>> +			dev_err(dev, "failed to acquire %s': %d\n",
>=20
>> Looks like I have extra "'" in the prints...
>=20
> Apart from the issues you pointed out yourself this all looks reasonabl=
e
> to me.

Thanks Mark,
I'll wait for Rob on the binding doc side before I send the updated v4.

- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

