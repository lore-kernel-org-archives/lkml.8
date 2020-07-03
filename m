Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5D9206A1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="LX8rAXw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGCJdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:33:11 -0400
Received: from mail-am6eur05on2086.outbound.protection.outlook.com ([40.107.22.86]:52608
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCJdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:33:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQB8lmj5TmOpxVPAcAE8EVLdEDuBqDG7uM5uolZIsCf+6fEhV0f3ZnWOGwlBc0JC7A8H1uq1ZBtM8hEhGlVzvxDHLRPybsl1WN+5KOyRE/Gj7oYuzIdgY3TXQAZvtMslajUB2EK5f40O/gCTmDPnXVddZwIdwi8IiFyGzhf2q+nDxO8bZzuxBwuJMmgp7E3bqTMuINYdEZ9e4CIrKpChudbolBP4Pslxoy0dVCFhg7s1//Lx+7P1ArrdNKXhke+Vslvtx+xZFqhlfsGc7pKKVbkbl4JmeIdQhtjo9E37sdHdRyJAjNsjbDeGoPpclEgt6HgfHOBW0Tp2qT7d7mRGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g2mmyzLQlUP83pMVvKeJyFpaXTOgi8ncEVyGIcGU7U=;
 b=PzEz8y+nLYiRUh0e4PR37QbJm/fBf25jLXzZARa/yZNeIcj4iyxf/GTjc9ZlB+wfPzjDJVnPMrWKP2LSx1yh9fflv5cVXyXYq6A0I1FIzJBO7xBCB2+nyyCNq/tUQj800uMu3Uy4Aq2AvASbhgf0ZD6N1VwXaDZA7pmxoG81PU5jy7xXHuT+co9Xgyre/eMpyzzqJEFa17G4rtv/FwVtjX9ty4bR9fb5hX1KfwM4wx2//IKfnjl+Tf6SeluWk0DjKP4k7iMFcGoPFZ7b8kfFcFB5KBcI9I1P5cmStylboOpySSvuxLSR6sf1RI/tMrJlZKl1A8h3z2BPQV3rH+cccQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g2mmyzLQlUP83pMVvKeJyFpaXTOgi8ncEVyGIcGU7U=;
 b=LX8rAXw9IGUqPghmIwhx5bq74Pey9+ed2vzfFSfkC2aEZfa67hd3THlu/38nlPrQLBTvu9LrIWmwhjUMsWF/dRB2ZPmYI+0JL2ay/TPzHbeYlgWQFpBTFyWbyhmjMs3ZfSXQKbWGlBng1JjCUUW2fGmM6bAR3WPhZn6tD07CK6M=
Received: from DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:65::9)
 by DB8PR10MB3768.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:148::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 09:33:07 +0000
Received: from DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::314b:f930:76b1:11c5]) by DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::314b:f930:76b1:11c5%10]) with mapi id 15.20.3131.029; Fri, 3 Jul 2020
 09:33:06 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "tiwai@suse.de" <tiwai@suse.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 04/11] ASoC: codecs: da7219: fix 'defined but not used'
 warning
Thread-Topic: [PATCH 04/11] ASoC: codecs: da7219: fix 'defined but not used'
 warning
Thread-Index: AQHWT9TglCRPh6aF50mArntijWazBaj1l1Kw
Date:   Fri, 3 Jul 2020 09:33:06 +0000
Message-ID: <DB6PR1001MB1096535996028B7DE0D136DC806A0@DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
 <20200701182422.81496-5-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200701182422.81496-5-pierre-louis.bossart@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 379ba017-6421-494b-ec74-08d81f341774
x-ms-traffictypediagnostic: DB8PR10MB3768:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR10MB3768C708CEF52F084651389FA76A0@DB8PR10MB3768.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wcyr+VA/mh7RjNH1rv+VoPU5FAOsLzV6gmXSZK5mW1DhByxvYAuruWbqvWALloIBWZdyI8LJLqmIC2vfl97L84yP8THDPjoSZaCas+EMaJF0k/I9Eg5wHS5a5eBx9MvYQ8xVYFS9vpu9aC2Hc6zzif8LXaFILSNfCgReIbimzcI5a8Y3QAondCg/F35ZBpFqHDwVleD+7riKrFnen7PFWwY8oZ7ZzApbd7e8zbxmubpPJEqT1AwKY8CF4B6flXe08noFjzDQVljdM8SRw9JRT+bc4ZTwRfkyhOwsmOmrMU51qohTuBA2sGlurCwZPM+c1PH24YdNI/OEnRIuVHPtOg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(86362001)(83380400001)(316002)(4326008)(55016002)(478600001)(9686003)(110136005)(33656002)(71200400001)(54906003)(26005)(8936002)(66476007)(7696005)(66946007)(66446008)(64756008)(66556008)(186003)(5660300002)(76116006)(2906002)(8676002)(52536014)(6506007)(53546011)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VMmVviWtJ3R6R4fKWadIRAv/6x+1GzyhD6+6MatwpLhGPut3XpvWr8se80dUfYJiyMxfYAOER9AvVKBDZPFXfXGQk/n9qPtwysXIsNJyjy28zF9CulIYbli5woaN02/X2aY2uWVmm91ejChxc8E6qlQwe4T1mN0UBRPoTzieLIgKNBxlkyGZtcW8tBlr38IbZrmHxFNXKEkiCpjSG3eU0USosbb/qHI4hib5s/ro8BNpLcskKcRxon+qMLMi5BW+4V8ypJhTuDpTvnLEquyESlZ1PvJbOlzT9PUXiufLUnzbw/TPMDn1ZBqPQo3RxmreOitpwv5YMxyWzi08gFzs8idrmvY1fBs1gOd+x4/yUUo1kTCn/I6n6RI6yPHEwbVyZLtphGhF+COlYTcQKPlmxeVKd5OTwXlGxPO5DnUHZOjJDwvHTQNvfmFUOolZTG+T4HjjLy1hA4EY1ZZ8snz79jh/wdHqzOxXLNcsS7kG61A=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR1001MB1096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 379ba017-6421-494b-ec74-08d81f341774
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 09:33:06.3385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qoYziLgV34Y2c7edlV0PbsveeSRUVB5bER2lMVYxyI0X1lunKX+MTnguBLfk05WP2W6f3qskd1xM1rNJSihWt6gHx4ujZlFoJIHbq+kWqv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3768
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01 July 2020 19:24, Pierre-Louis Bossart wrote:

> fix W=3D1 warning
>=20
> sound/soc/codecs/da7219.c:1711:36: warning: 'da7219_acpi_match'
> defined but not used [-Wunused-const-variable=3D]
>  1711 | static const struct acpi_device_id da7219_acpi_match[] =3D {
>       |                                    ^~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com=
>
> ---
>  sound/soc/codecs/da7219.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index f2520a6c7875..153ea30b5a8f 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1708,11 +1708,13 @@ static const struct of_device_id da7219_of_match[=
] =3D
> {
>  };
>  MODULE_DEVICE_TABLE(of, da7219_of_match);
>=20
> +#ifdef CONFIG_ACPI
>  static const struct acpi_device_id da7219_acpi_match[] =3D {
>  	{ .id =3D "DLGS7219", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);
> +#endif

I think this will break non-ACPI builds as this symbol is used in the
declaration of 'da7219_i2c_driver', without conditional compilation surroun=
ding
it. Unless of course I'm missing something. Could we instead use
'__maybe_unused' to avoid this warning?

>=20
>  static enum da7219_micbias_voltage
>  	da7219_fw_micbias_lvl(struct device *dev, u32 val)
> --
> 2.25.1

