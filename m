Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E0EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ACC0215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FVtNNFAG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aA7rBtFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIGLjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:39:47 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:34189 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbgIGLhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599478635; x=1631014635;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
  b=FVtNNFAG7bHp5iKR4Q3KJgCrbe/6TNQY3olUex7Iq1mpuf5sB73rsvaY
   wMdp6ygWMZPsXJQri8NxWPayjOgnZl4CggLoUMvnY3zKHXmg0bA0la6Jf
   I6De6oRsVfNweSpVVJIMjZA6UdxA/ZQaqQY1E/t7Z4fxbKT/1erKEBmHS
   3dBSADrhKpE9O21DHDjGRUuW0ydzruePqFE2AP7r6Z0Nr8998K28KwdHT
   AP+qPa+Us6DnybhtzIhg8zyotU43LxVGqVzhAat4aqvPXkxYefXY1XcpS
   iFWOVSK0dTGUV6Wl6BHlKLi8PvBzG1Oc9Ec+ocGVLZ0JuEdZfycwSOYP6
   w==;
IronPort-SDR: 7dI0m6ZWB5H2HJG4yiLPf4reGPvPtpb+qL/RvJXVX8YAQwfuLW9X4rKTTv/w1XU8Nqs/P3Pg1y
 DjqcPUEibuDXCbgiqFzibJ33ALVTJgDJanq5gcpbpHpYCN3+hvB6USuhULkVsi4u8rcPM0N7+N
 9gxASpAJ2YCilCpAyhaM5e94zvjcRGCu8JJiGQvyf++BPJceU9Te3J4z6ctdNtQ6ADwSgmiQAJ
 11puNbM4hPee9sYOtWMS97DvrHDY9XxcdTiIg2NhJvRDed2+BPCKz6bnDMwjZ8zqvHJNb0H3LS
 FTc=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="146733323"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 19:37:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqFK1229j+V08YnUkzKb9tKoAlxiMDSG1S6Y0qydYGIvA0C8CXNQxyp2ayuUUZG3ti77oO1uOX6EJF7svKJNTwDlxoHrWTUG+Zl+l6hp7kDmn55ijGLV0J+pLAgjEr91RRkw/HY/t2cm7HZp4Nzo3ViTvA25rZ0YhEDnC027y5mB05o7N9+EF512qXZxb4OBk6Pk5bplb/7aZwTyMSoBdguJjmpLF6v4z4/Zhq/si9ULtm18p2dqZ8yCaTpYigFoVkoqvEEhscDLjNfPHzO4T0bbGVMCMxjQneQGcGN79NtJftegf0e+quwFTkMBsUzbVZNfiTS8p06y8AXgUx4/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
 b=fNlwdruCrBuRkio0gCaMOgnlVfQBr11vL9m8kWJvgPW9F8H3lLjS2wa9okuggaKSPcsg0WyH3lUFRcRikoX86nc0Ip8oYh9VJhiG3jaKtWI1lxd9fvnC3FubiPtckbcKdM1KgF0GnU4rUfifbTG84F+VaNXxxGZYoZnU6vWSa8Vn70teX5jqThtKpKB5eIazTpW0dy5DJjEXg01Z6S/TqtejrkV+A+lBNfN8UjZ1tnYZ9nSxNzDijN66NYBVnp9Yw7Y3cH11P1pIs9ZVYDuJCo/Mkm0QBZGsjfpko/FzpTcBpoEDN14ZWI8zBJ37MAl7xa/UQZCY4iIcKWUibPCQUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AerEyFqp12J8GLMrWSCgphv6T2pK6qtYls/zxdPokI=;
 b=aA7rBtFXduEfeWw+Ca9WSPT9kLVaL4IVvTn8uJ/KV0kskhU+vYBTADu6OEdERrvctTbDce41z0495X3/EQTvIg54bEJ7UEASza0eIn3mHXub0hQs4xLcK6vTkqJGT6lI5xwxBwHR4+BHeyfHo0frZnObfNQ6+VjxJQ6b4vuj2ww=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 11:37:01 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 11:37:01 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>
CC:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date:   Mon, 7 Sep 2020 11:37:01 +0000
Message-ID: <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
 <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+sN8n6-ibJ1v_S5HEdfhbJ8yAYTm5ja=0M8ng2ujLZ4g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9150e58f-c4e8-4187-6ef6-08d85322568c
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB36333B4099992AC8CC8390A5E7280@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxWSETqZXFPg6jYXinbGxdkHFklA+MlVx+M02LUyRcLlfE9o68reeNU4zzz1lxRlHTsLfJAg4DwbOZCeMgL0uUMwLJeaBomPcTgZZBgoDliHrta1naUOKXzWI5p5x3bswxc3ZhNiJxLr24v9VbK2rbZb7/FqpOTIg8pWQhTTOlcZQPBmrtC/z8R/sOdURvvW6R5j7UVi1zMeco6CgfgDOUUo1YzbOlsWW3LGOHRpcX7EIvhOd0H5MjYPWvZ4hUcvsIEKg2dlT+7k6syjRAkb6N8A/xweJYElgi7Tnr3XlHDN5xY6+lYihaHmqSSPWy2y2Fnai8arYk7CKfZNn51a8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(71200400001)(5660300002)(52536014)(54906003)(4326008)(33656002)(316002)(478600001)(86362001)(8936002)(55016002)(83380400001)(7696005)(186003)(2906002)(9686003)(76116006)(6506007)(91956017)(53546011)(66946007)(7416002)(66556008)(64756008)(66446008)(66476007)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kr8ddXBWXZXauzUxhUkLh02rqqOIEpX5iMkGl8QRe4LykP/z13CFNWyTU/9+JMSOJCFiVTTquZZHDu0jJQf61Ik4J1/L9DprMosiYlEyxj3k/9SfROebUJ1BDiRIZ2sSjwEQm+WgwyHRS8SJgHrAv9+zQhcoY7FkR1zGT+6bqplH2aW57pAAk0CAbevh63/Bn1CEkD0b6PRaC/lOVcDJ0SAM5IW220OGTKh+vNNhfIEnbptIflLwPrXZbw+fNd9Imbj4z/E0qsXyJYOHXIzIMfgs3EZo2kd96OmKhR4Lco5OwCmvhjQwmS5rmNaeMgA3MqzMKM0u1Z70AEQJ+gZsvWBYPIQbqpiltBaAZfHiJrLNJNi8DGBdAUyYZzEpEXTW8FWbdgLzlC0G+vVJLRxQp3X6JAL1ScBfIUX5A5i2vyAv60UEm0YKGEb9Q6IxL1kvzN+3MH81dCSONU316SiaCiPdeXgnzKAeyG491IO9taBm81CkFGQryD5tpcLjMKFHiazA7cob3A+vMb2KjfQunM0RbWa5u2vqdfvjbZY8SX/B/Yn32kOiwqKCcZ8v+YUbzyQqsY9qun4rSeWJfsHQaE8NndVGaymNvHbwPByuMjc839TCz9sfg20R/nryQnYrDUGeWafhQ1V/2aY9VM+MOYXsO/8+nKZbLiBb03hj8tApMo6kugdvgiz/a9C3N636RCq2kR3ylw2fpKmGZBb2dg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9150e58f-c4e8-4187-6ef6-08d85322568c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 11:37:01.7293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDjYt82nWwD8iDiRWYHysHMd00OYrfDbBZnV27LEQHcxK4mMrRgQDETDGE9nR2HPjiQeH+VDTPochfy5XXXy0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/07 20:24, Kanchan Joshi wrote:=0A=
> On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
>>=0A=
>> On 2020/09/07 16:01, Kanchan Joshi wrote:=0A=
>>>> Even for SMR, the user is free to set the elevator to none, which disa=
bles zone=0A=
>>>> write locking. Issuing writes correctly then becomes the responsibilit=
y of the=0A=
>>>> application. This can be useful for settings that for instance use NCQ=
 I/O=0A=
>>>> priorities, which give better results when "none" is used.=0A=
>>>=0A=
>>> Was it not a problem that even if the application is sending writes=0A=
>>> correctly, scheduler may not preserve the order.=0A=
>>> And even when none is being used, re-queue can happen which may lead=0A=
>>> to different ordering.=0A=
>>=0A=
>> "Issuing writes correctly" means doing small writes, one per zone at mos=
t. In=0A=
>> that case, it does not matter if the block layer reorders writes. Per zo=
ne, they=0A=
>> will still be sequential.=0A=
>>=0A=
>>>> As far as I know, zoned drives are always used in tightly controlled=
=0A=
>>>> environments. Problems like "does not know what other applications wou=
ld be=0A=
>>>> doing" are non-existent. Setting up the drive correctly for the use ca=
se at hand=0A=
>>>> is a sysadmin/server setup problem, based on *the* application (singul=
ar)=0A=
>>>> requirements.=0A=
>>>=0A=
>>> Fine.=0A=
>>> But what about the null-block-zone which sets MQ-deadline but does not=
=0A=
>>> actually use write-lock to avoid race among multiple appends on a=0A=
>>> zone.=0A=
>>> Does that deserve a fix?=0A=
>>=0A=
>> In nullblk, commands are executed under a spinlock. So there is no concu=
rrency=0A=
>> problem. The spinlock serializes the execution of all commands. null_blk=
 zone=0A=
>> append emulation thus does not need to take the scheduler level zone wri=
te lock=0A=
>> like scsi does.=0A=
> =0A=
> I do not see spinlock for that. There is one "nullb->lock", but its=0A=
> scope is limited to memory-backed handling.=0A=
> For concurrent zone-appends on a zone, multiple threads may set the=0A=
> "same" write-pointer into incoming request(s).=0A=
> Are you referring to any other spinlock that can avoid "same wp being=0A=
> returned to multiple threads".=0A=
=0A=
Checking again, it looks like you are correct. nullb->lock is indeed only u=
sed=0A=
for processing read/write with memory backing turned on.=0A=
We either need to extend that spinlock use, or add one to protect the zone =
array=0A=
when doing zoned commands and checks of read/write against a zone wp.=0A=
Care to send a patch ? I can send one too.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
