Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC683C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D2C21481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nlh3qko8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lzj1ztOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgIGM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 08:57:22 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42713 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbgIGMxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599483236; x=1631019236;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GVPGWupLZmUWah5/wB+wFCLyspFpZDSl3N+mmCxXvyo=;
  b=nlh3qko8gcKjftKHaDAYKl/d5PHETDd/zbhjLsfbrilKfSJD5JoUcZTq
   8SmPfzKMMPlpxzY6adkPmhHszow2excFdc7ksiDQG0zIe+T5mxWjTUMOY
   u/zTXelKtN9wvm1mDYebX786iTuheFEvNHhGTDXW7Fd1OH4bjDehqkezW
   UOSVzIWvFsghcZTVgZggxVwLZ4w1tyYBktNnai91fXRu3rAz0B3e1xj4j
   HNvaeKNVLMKsVBloiP8ExofkuNWTwfiI2nF0GRBPQiH2PYGZ7si9jnHmI
   EgcvXMVYAxfxrhsBbvz2mBBnEBCsI7HOTBoVSIQY+2puP3ctihoxoi9Q/
   Q==;
IronPort-SDR: 0PXqT+G6rHw3hAEexG2swKVXHmT5xxz3+4i+y/wTGoHqjOdEPEeURylKCoAyx/UA9uiUMshYe6
 J51mWLi7cPfrN09ObD1E4w9d6sJxOYYXSJZOMS5RreSQud+7xj8NL/3BmjuPLYNkFEIXWz90DM
 Va3RpMoPHYTZ0icDpGR4iHw9K29hMjKGW7Dznq7CPI8jjIEtaplkgDzjCvFxPXbuZ8NXhGXzb5
 jQWvHq9oIfrbQ/n0BHT303cXfH2toUUPz2G7w1zupDi3rTlOCMM2QcdqaSYGtmMsEW1sFcOvS8
 yEg=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="250033323"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 20:53:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEYbcEDnhsQTtHJCrW1fzBAIjwfkqDaGhJ1hEZbpMo/OmF3HwN58xWS1C11RlQ9aund8w9q+BLd0D8dWWlWvkzCcOogHOWGmTQJa2A6+syZaCds6PXghoYWyvXDaoPJaWohoRjRDY+ObguupCPslzWPq3Cdvcf/7jLd7xvp9VP5jO3vZ6oIbuqCfmi7L/zSyEXKsu+IVPQfnN5Shgu9jQxX/MyiMP17tKqAViJIjFHljOzLU/FnmhDrBtP+ZNjf3sRg9peLVrnO3WH8BgkHEwXEKY3DtVnUP7M0t7QZKTS49MVMu3zqXFOMqCShwTfsfdbXEKhACB32tWTZ3tj0NZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVPGWupLZmUWah5/wB+wFCLyspFpZDSl3N+mmCxXvyo=;
 b=UYCUE+py2TJAXzmrDCTvd8B5HNilfEQnXpZFTEjCz0wz1UNbbVfm8kAsf9gNsFt41fFpCtv4NpfcE7XblGgK9tevBV5fMAOOtF9HT9oOK7PvbyfEEjDYXYdUtm2wakOa4RF3+8EWfdiv5uGjABLtCQuD62vuQz4/ts4p28NkSVo0N381apqoFdTc0rM3u5Nma/R+zqeUdOgbJ4a+K9kjkbCsHe24esK7sdWCijXL287mEqnPYYEIchIVIa8Iz888WMjvYuquTDnsXxJ9KDQbHApBCIZpGw8MHhr4OobP1dZmLZM2VXx53WNM3vfy1luw2G7awOWc2bD8YDxkaSsUfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVPGWupLZmUWah5/wB+wFCLyspFpZDSl3N+mmCxXvyo=;
 b=lzj1ztOSUcJ+B3qcLnrVtJVPDKBCP9SN4n2UWJ0v/qJkHmYsvyytMRiU7tRmVyBlWMm/WRYOJQDJyRKEVW/brSuAeN3Cn9U0FuuYl6g+vWmlh4XKiS645+O9myD6xlhRBSDBaFTzgNFcSVlxp5QUb7ih/Sbk8EAv9FyPplACgIM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY1PR04MB2314.namprd04.prod.outlook.com (2a01:111:e400:c63a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Mon, 7 Sep
 2020 12:53:20 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 12:53:20 +0000
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
Date:   Mon, 7 Sep 2020 12:53:20 +0000
Message-ID: <CY4PR04MB375105E77F87B60E74E025BAE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
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
 <CY4PR04MB37516303D8C5FC32FB530FDBE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3rJtGTt6gss-5uAjzQ+BAXWTOTcjUzyFToz-QWbEfkLkaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd12864b-20b7-4dce-e164-08d8532cffbc
x-ms-traffictypediagnostic: CY1PR04MB2314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY1PR04MB23140B2D768192511F700BF5E7280@CY1PR04MB2314.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V7LH30Pb//T7e7Q7tPmFBoSyptlwKdPWrSjKtNzQnDal13pvvRErnu0grZY1+eTtSHpOtdoNZvuhIXqETL09jxK1RtNdVRH8JN84vgQfNnXLy+0n8jbI76PNhle4UevAV9nezKprekuVetznqF7/o9uH7NAHfW3Sfijg4p2UswBoeHu1T1QAVFkQE5bn3en9jTraiqjPPRzhYIw2q48865ByYG3e0PZ9fHXVloqowcBSu0X/2T9ggYHpbUInt9D1C25zLYUTb9VFON2A5OcUC9G5KjhzlSTAMZQU+Uwtv7AGDiGgK2pfIr3A6Maz1f6dSynUJG75inb7W6L8CReL1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(396003)(136003)(8936002)(478600001)(76116006)(91956017)(71200400001)(9686003)(6506007)(7696005)(66446008)(66946007)(66476007)(83380400001)(64756008)(53546011)(66556008)(5660300002)(6916009)(33656002)(2906002)(4326008)(316002)(8676002)(86362001)(186003)(55016002)(54906003)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: niFUg5HzJ4WJisE/fflQAvkr5M+p4a1LS2OzkvRNR8LF71/KNa4+L6uQ8dopxXywJr9uwC02ErUXcuICFbu7viOImx+Qd6upkE57gXAQmExo0DRT/d04Bj5kP2lueUYtfpuYatDTae+Bfh94yzZR8mvSvhe+NFwl+bhcUHaTUn9aAPBC5+IwDrQ8CU+MQ+16xOf90QaLmtH4Ww0H4rDQRH9N6mjKT+unfea20RhF3dA4GjJjQvD/CY1O7KDKXlaNSUJJUXoFS0Y4Ts8/cA63fkYU0nxF3JRnf0VHp0f+tPwe1Yi/NtfgYWCV5jTatwMb1/B1t37LrkLNi17/B0kob8pK8OaTsUnMhXwqMZMygRr6RPX+oJUCelEX5w7G2tVfCTJrD+nf5L7nNexTy6V5A46qdmR92xKVp5j1OkwzgUkN/XYrR4Gm5ldrOQy4Y1J/12A0SA4R8EaZd6LgbaEKbnq15IW4TBzR4K4NBxL1J2vzgqIIqYOJW1oj4FhC/O2DnZVGsmKj/LeTL4qE4PVaQxWxBHsDMprEeS/CpQHOx5UB/uoV2ADM8zfFkFO42Xu2ne01kn83/qby28420mvxgS/qDyYreSfCgdO8BvPNrmVKPmYSAeQyk+EdmjjbfkULfHQ5r3GJS2yi8DxwvIJax/hnpZksK05zA9+nny5DHsuGmD1HdzoRsZUNTQQthQspZ0yOazhv4B4cY5TMRcnn7Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd12864b-20b7-4dce-e164-08d8532cffbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 12:53:20.5930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gb7ROj4DaiNcPiH76zqubvTKA0CAcVrsvqjD7V6/YX3SqoYaoK5LS12k1Xkhyvyq1F4UPw+/pw70MVVhYtvfug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2314
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/07 20:54, Kanchan Joshi wrote:=0A=
> On Mon, Sep 7, 2020 at 5:07 PM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
>>=0A=
>> On 2020/09/07 20:24, Kanchan Joshi wrote:=0A=
>>> On Mon, Sep 7, 2020 at 1:52 PM Damien Le Moal <Damien.LeMoal@wdc.com> w=
rote:=0A=
>>>>=0A=
>>>> On 2020/09/07 16:01, Kanchan Joshi wrote:=0A=
>>>>>> Even for SMR, the user is free to set the elevator to none, which di=
sables zone=0A=
>>>>>> write locking. Issuing writes correctly then becomes the responsibil=
ity of the=0A=
>>>>>> application. This can be useful for settings that for instance use N=
CQ I/O=0A=
>>>>>> priorities, which give better results when "none" is used.=0A=
>>>>>=0A=
>>>>> Was it not a problem that even if the application is sending writes=
=0A=
>>>>> correctly, scheduler may not preserve the order.=0A=
>>>>> And even when none is being used, re-queue can happen which may lead=
=0A=
>>>>> to different ordering.=0A=
>>>>=0A=
>>>> "Issuing writes correctly" means doing small writes, one per zone at m=
ost. In=0A=
>>>> that case, it does not matter if the block layer reorders writes. Per =
zone, they=0A=
>>>> will still be sequential.=0A=
>>>>=0A=
>>>>>> As far as I know, zoned drives are always used in tightly controlled=
=0A=
>>>>>> environments. Problems like "does not know what other applications w=
ould be=0A=
>>>>>> doing" are non-existent. Setting up the drive correctly for the use =
case at hand=0A=
>>>>>> is a sysadmin/server setup problem, based on *the* application (sing=
ular)=0A=
>>>>>> requirements.=0A=
>>>>>=0A=
>>>>> Fine.=0A=
>>>>> But what about the null-block-zone which sets MQ-deadline but does no=
t=0A=
>>>>> actually use write-lock to avoid race among multiple appends on a=0A=
>>>>> zone.=0A=
>>>>> Does that deserve a fix?=0A=
>>>>=0A=
>>>> In nullblk, commands are executed under a spinlock. So there is no con=
currency=0A=
>>>> problem. The spinlock serializes the execution of all commands. null_b=
lk zone=0A=
>>>> append emulation thus does not need to take the scheduler level zone w=
rite lock=0A=
>>>> like scsi does.=0A=
>>>=0A=
>>> I do not see spinlock for that. There is one "nullb->lock", but its=0A=
>>> scope is limited to memory-backed handling.=0A=
>>> For concurrent zone-appends on a zone, multiple threads may set the=0A=
>>> "same" write-pointer into incoming request(s).=0A=
>>> Are you referring to any other spinlock that can avoid "same wp being=
=0A=
>>> returned to multiple threads".=0A=
>>=0A=
>> Checking again, it looks like you are correct. nullb->lock is indeed onl=
y used=0A=
>> for processing read/write with memory backing turned on.=0A=
>> We either need to extend that spinlock use, or add one to protect the zo=
ne array=0A=
>> when doing zoned commands and checks of read/write against a zone wp.=0A=
>> Care to send a patch ? I can send one too.=0A=
> =0A=
> Sure, I can send.=0A=
> Do you think it is not OK to use zone write-lock (same like SCSI=0A=
> emulation) instead of introducing a new spinlock?=0A=
=0A=
zone write lock will not protect against read or zone management commands=
=0A=
executed concurrently with writes. Only concurrent writes to the same zone =
will=0A=
be serialized with the scheduler zone write locking, which may not be used =
at=0A=
all also if the user set the scheduler to none. A lock for exclusive access=
 and=0A=
changes to the zone array is needed.=0A=
=0A=
=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
