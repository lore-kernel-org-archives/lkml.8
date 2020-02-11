Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C749C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24129206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="AC5K6Ejs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbgBKPVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:21:48 -0500
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:21088
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728160AbgBKPVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:21:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKuU30cHVWFZOFpZ3YnIs9XcYZuegvyVrMN9Y47dThDeDSNZkvoYaW5JdJkRo/vVkvxQrq8DKrNClp9ghA1o++a6UYljazfAA7n8qzBWTdi5e8VOajONqspId3MS9nqxx5MmST0M72AdWHTiPodD6UoJtAToImcBngS2Xvyi+ehN+MTwIgeyR/QjKmtWAu7Wfl5f8U4+Hs4Mx/oI5RpsGU8cCNuXaXC8xFB8F9x88bA9E225peYSNycr6m5sDq+1giRCH+a5rf3IP6LLVGONfAS5T9fGYyYyzT9J0GHwrimNDeMYLuN2LBptLvojHbmYRvrrhS/NRH+2axAo2CsT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vl2wP++RxKB545R5NmJFzeU1/TFh4gXRZBAzZvew7E=;
 b=hIhRUHKGHKHOlNSnKLbbySF4zqTzPYj/UNs7LD8oDin5RG0zZl3apek3zHEkwD+apmGqXVXT+Gk4aXP9b1zVkbeh83a1OOJ6rKdrZBo3a3o0NO89H8CD1DRnI3aXiAfWV3aYCPrSmQVDFtICHJSVkaG9hklsi6cEUOTVotFL5bjOh1YaNHsGffOxfku6qn9b3zlXAUWPIDO9p9xuer7yF+MFVL1g+N7S2ZOFylUXVrMOqbeWi34TRWLE0KOjoB/dlSMRJm6QndIvMbBL6aHlfjQqY4h7nyGd4/oWjjAD+nlvidQZsq2R4C3GIPJrEcgVkv8lRsSlSxk6g/cm5hEqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Vl2wP++RxKB545R5NmJFzeU1/TFh4gXRZBAzZvew7E=;
 b=AC5K6EjspZ7+SqSiq0AihaNen16RU6qPQTzp3Z3m0DM8EBNc4QKeljgGhtLrzaQ5YxN8+XJwxj1k83uHqHCoSs5QxFaZg4MqjGNMmcfotsieFgmGicx0jNQS5EQl9ucf4qfypmjMMwF0miQCQVslZLUtaRMd/KsoTbnsbOtimkM=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB4479.namprd11.prod.outlook.com (52.135.36.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:21:41 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ade4:5702:1c8b:a2b3%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:21:41 +0000
From:   =?iso-8859-1?Q?J=E9r=F4me_Pouiller?= <Jerome.Pouiller@silabs.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] staging: wfx: remove set but not used variable
 'tx_priv'
Thread-Topic: [PATCH -next] staging: wfx: remove set but not used variable
 'tx_priv'
Thread-Index: AQHV4OR7Gte2wj4gBkWnG+bg+D3foqgWHCEA
Date:   Tue, 11 Feb 2020 15:21:41 +0000
Message-ID: <7641155.kNzuLtrjOU@pc-42>
References: <20200211140334.55248-1-yuehaibing@huawei.com>
In-Reply-To: <20200211140334.55248-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4e67687-94d9-4cf6-757d-08d7af0618f0
x-ms-traffictypediagnostic: MN2PR11MB4479:
x-microsoft-antispam-prvs: <MN2PR11MB4479C6F8843F0ABFD1DC1C6993180@MN2PR11MB4479.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:191;
x-forefront-prvs: 0310C78181
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(346002)(39850400004)(396003)(366004)(136003)(376002)(189003)(199004)(6916009)(6506007)(66574012)(33716001)(5660300002)(186003)(4326008)(26005)(478600001)(71200400001)(54906003)(316002)(9686003)(8936002)(86362001)(76116006)(81156014)(2906002)(8676002)(91956017)(81166006)(66476007)(66946007)(64756008)(66446008)(6486002)(66556008)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB4479;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FVwR8J54688jQw5yw9pM3bssUw+qCaJrj+pXFUG8hnKjD4IhyN5J0haOPefEJeQ/yLFc1Hcyx/i2Aw/4Y0VfnNusFtR5daWnPFcd/ezYhPDAqUWvW7Z/b2IRsW7VmzylY6Rd85RLJPCRiyNM4/ggGpE2pnCxGSff0zr/6L1yhJ9vwtXKl6tbQ7bXSyLECeeIgXeJ97EWy3dwAuVmelEPaI6oaCM/jGUQUDFRlYWUrvxKgimHADa8vedOOXy202clTkXnTnGf2nb5jrolbvUBvjQR1zrADCjM5WpUh+gdwYHDL3v1YURrg+XYIhWRWdRph37zHU5xqyXPv55YAH+w3NcY+gYNyCdgZvF7oE5mAbcgoQtLI3HXzek07yz9Ge1CKYsZghqg3PvWJO3uDZ0WQ/JaC8AJJfsKI0rn8FIMiXJ4Lj7SrzaCxhb5Idywd71O
x-ms-exchange-antispam-messagedata: mRA7To2fV/MOjNU0HXmgv9+3+EDXwD4HGOja0qaf7Jsa1pOGSrIMwaZaWb+EjJF9OTmRtSSBrRWMH6f/vqv5deXPtwVAlWPLUClKjL5qRg0P0HgxnM2gCUiCC0NTqbXGBn5JPsonUgWJ4uf6Y/m7YQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DE80FBCAE647C54DAE3DDFBD380973A0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e67687-94d9-4cf6-757d-08d7af0618f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2020 15:21:41.7631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GGiOwh/FkIUcwnR6+JZZHvYT3I1vMx1vlyO79wXbps0Sajt3zuohF2PPRSbqKD29bWWH01AbLMbsLIXpTzXvBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 11 February 2020 15:03:34 CET YueHaibing wrote:
> drivers/staging/wfx/queue.c: In function wfx_tx_queues_get:
> drivers/staging/wfx/queue.c:484:28: warning: variable tx_priv set but not=
 used [-Wunused-but-set-variable]
>=20
> commit 2e57865e79cf ("staging: wfx: pspoll_mask make no sense")
> left behind this unused variable.
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/staging/wfx/queue.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/staging/wfx/queue.c b/drivers/staging/wfx/queue.c
> index 0bcc61f..c73d158 100644
> --- a/drivers/staging/wfx/queue.c
> +++ b/drivers/staging/wfx/queue.c
> @@ -481,7 +481,6 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wde=
v)
>         struct wfx_queue *vif_queue =3D NULL;
>         u32 tx_allowed_mask =3D 0;
>         u32 vif_tx_allowed_mask =3D 0;
> -       const struct wfx_tx_priv *tx_priv =3D NULL;
>         struct wfx_vif *wvif;
>         int not_found;
>         int burst;
> @@ -541,7 +540,6 @@ struct hif_msg *wfx_tx_queues_get(struct wfx_dev *wde=
v)
>                 skb =3D wfx_tx_queue_get(wdev, queue, tx_allowed_mask);
>                 if (!skb)
>                         continue;
> -               tx_priv =3D wfx_skb_tx_priv(skb);
>                 hif =3D (struct hif_msg *) skb->data;
>                 wvif =3D wdev_to_wvif(wdev, hif->interface);
>                 WARN_ON(!wvif);
> --
> 2.7.4

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller

