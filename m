Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D71DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D46208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AVDiEzWU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CSMiCPpp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgIGIWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:22:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48235 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgIGIWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:22:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599466936; x=1631002936;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
  b=AVDiEzWUIPEx6okE2ZcJ9H0xqcSQOuJFFryqOb3GS/bwOf3nBvOtlBMw
   ZormHqhmdnex4rhG8g/KVbXu7tnl7gK0rIwW9cAn1//qydk5h5LutdXVY
   7IxdNM3g4zYlbEddkfQ73sO0/CR5FGWocIbjiRDvFLvlJdpR3m4rm8Yzl
   IVTLqazGZ6OI8BvAFehCMR7o392Hnae70meiQKt2U8fgX9aonyJfz//HJ
   cnT7wlAEQiYGlbb/PVn+sJDfn2qWDpQk02/y061GJ4A4iQ/Wu5l6KuABH
   6L1EKqbyKBkSR+Wwiz+G6BeUE7+eYY6lfqmwJ0aS2E1wTFu6sS3NVPZWP
   w==;
IronPort-SDR: zEPeSi3ORBoaH8TP8eDeWs1O0z/CkADapZSKD368kvjKjD199l3R/w0Sdnin62x9p2LTd4utJe
 PJ6lCOuMlTuifW7GEaNdER2MDBOab6VCL/pqzOKSQgO44NU30/OIah6xY0DZ+b8+Cu7lUk+EIa
 PkhJLGj9r1b3T4KYCStwMO4PJVrtmrwmEk8B7QFNydhD7/c+wZ4TWajQSB+7B6Mfc9faPBjga8
 PUu3Y/AQTC9/Rpggbi5CIV7WoM97lfRGeFJnfNlOTo2jrvtTm0HV3/QKREm50TwmW1H2XH/oCk
 qCw=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="147948021"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 16:22:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj1PZD2LBp/M7Jhb798pKNFR0t2H2Olsg544sN4qDSIadOh3K6MvXzEVOcfzQpzBf8ESMsjEpp7fyE2D+4TvSceufgXB9ACEAREww7wLINTsoiKuva5BPUh320wNfNUiaz60pNjD48gU3Qv6V+pqEoL84+hvu3prKim/cu7h5AhoRdxTNHERdxBViFjP1nhBxV0i5K+wmzVVYrIN/OGnIUNsDDxQap/8ovB8+lBJS20FFkD3ye0Fc1WqRgOyY75+XY7oSGjRl1GzglOCJNWRZSUee00CS0a09xJ9jGXKQs3vJ04LpCOm3SN5bU2d86t+C3bYlFfJKxqsdJyy4A41xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
 b=dozkJG0rZC2hcyNiRL+bVGfofk7JOsOmDKRoNVGKqKv+9+gySBm3TdqISGMDqXwSFR8CFnCAparO3pZmzBJrHOEO8iAaxRdH0FYFI2/oOA1N18qQ7gkqRoxhJa5WmHrjmam/Rz3POwT5nRV+OtrRkfsFLPMCZjWulaBNsPo2814J+lgdUohN/o6rrFdX8I7dJjCqhoxETBWU7NDK/Q2d4XqBrU8vVLh34uZFO/64cQSWAJ++hfrru+uIA7vECio0cylsMy+QzQiocJSvoftCR8WJhwhhL2HNfRIMGysM3nHMHhlsvM9G6jAfSwtcxRjfJkq4yp1kJ2UpvDEfdi1LjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF+76oE0BXMlvu+NlKuicfRFSQRPlUn13isTCPzIJuY=;
 b=CSMiCPpp70cljJmcGTIVXEukCNXsLH6dsGbOsW6yYlVN7D0EQTjHDHO4dhnjhoTynpHgblLa5Pgv5Kz/MXh9dO5CtYtD09HfqxtrjI5+IIlyUWp4MgoPMN0fSt++0DyaJ0GksRJRTsy1PMTeQMB4N7RTdBtcgmDQWiF6NsgdMg4=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB3752.namprd04.prod.outlook.com (2603:10b6:903:e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Mon, 7 Sep
 2020 08:22:13 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::9124:2453:fe9c:9a7%12]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:22:13 +0000
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
Date:   Mon, 7 Sep 2020 08:22:13 +0000
Message-ID: <CY4PR04MB375151ABDF83FE0A9804C3EDE7280@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
 <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+0+jThD2KEu-d4rB=C4xL3Bb+cD=jUDbsGGBKR_GMpfQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:2cd0:86fe:82f2:c566]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe9018ae-b6c1-4035-5d80-08d853071fe5
x-ms-traffictypediagnostic: CY4PR04MB3752:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB37521AF21D333EF769F12901E7280@CY4PR04MB3752.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8Ophps+gFwyiGj/E//u/Qk+6vYT3SfN7Z52+OaFKuJf0fNza80fwMiaqaPOKnshTJoNTfHtBh/fO69UeLPdaeSQV/94MvwXYs/04WONLn7rCkYPmOoQvOvyLzYlnZc/sIikWuAeBUwwwZNJZdQaViXhQ+aoJSWVTtBrIJFe6KDycemhyDv0DOyEbFIoMVQRSpZaQZnNQTr3fq2MoNilvvPpQJRJCOJM8/sqe0gCygN2abB+c48lZ4cZPUBUAJmP2Rr232ue6ssUvWQtwnnul45H9aCmPPAwgwqVBAvpFa7o/tVFn2w68uWmgIH9YO8aPKGuYaGPQawDIeJoUMsP1aQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(478600001)(8676002)(66476007)(66556008)(76116006)(66946007)(2906002)(64756008)(186003)(66446008)(55016002)(52536014)(316002)(71200400001)(54906003)(4326008)(7416002)(8936002)(9686003)(7696005)(33656002)(53546011)(91956017)(83380400001)(6506007)(5660300002)(86362001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NhLtQNRuxJD21pZm2c50704z5LVBxiKj2/3vvc3w2aX1/pKWoR7K0udB/sk/MFIz6qhc6FK/VxgT6n0hhPJdBomG1pH9aauSxYIubIdjiKZaXXSLqfd6BvNa5ZrHh+T7J959e4DmSKkgDRLWLMNz9vVK4rTU97lsI1AYuX4f9qLUZ5tlBToYBFt+S5L0AkA6wDRrrQ40Rx31uRYKxe/vVgIknTiMZ3J0A6rup8LDq88m7ItNKsLkLUmIZ6GJzFTMJSOLp1cKObOxpTVuy+M+aLp4r/PmvZxXR3XcnaiVUSadjeZObkH7fw5omtN4pi+yY/j2fAS7D4SSAgHINWCSpE6z7jjvaLMPSVllRjL4+rdAEUAfW7ENXQDvspI6lBxeT2u88ER0GGQhnTOz6b47XQY6E+X1PTHhE+XchcpvGPLB/2u8bVE4KiSoBU/Bb+NpB+aVvNKJg2lIN/ZqrU5lxD6qfluEtBNdYE3hMbfIRB0KTNqOvkIvQuIW17EY5cTDLH3rdGfc9mzxhe3ROF7aRCv52UNyg7vJYG3hGut8AxtDv7JvbZUu83BY6yP4iVaavxUAQ2dZ9FZM/8qXXkdMbNMKIleIw6Sxq7hEGwFVmGBMvL1tRpxb/agmjPL9NnFdKLBMAThhqtm6RSO6ObX8X92/xau9TaGgY0o1XZ86mIe2eKLbe5RyZAvr99jdp8bdvYDZZMqbmNje/2luacn0kA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe9018ae-b6c1-4035-5d80-08d853071fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 08:22:13.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9XckTy+wrPV+C/3LY47OwWjWNI/t6qiSsUTZyYLxI22PI3WLxk0s8AhpLxTjtq66decI5gax600z4k6lVALfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB3752
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/07 16:01, Kanchan Joshi wrote:=0A=
>> Even for SMR, the user is free to set the elevator to none, which disabl=
es zone=0A=
>> write locking. Issuing writes correctly then becomes the responsibility =
of the=0A=
>> application. This can be useful for settings that for instance use NCQ I=
/O=0A=
>> priorities, which give better results when "none" is used.=0A=
> =0A=
> Was it not a problem that even if the application is sending writes=0A=
> correctly, scheduler may not preserve the order.=0A=
> And even when none is being used, re-queue can happen which may lead=0A=
> to different ordering.=0A=
=0A=
"Issuing writes correctly" means doing small writes, one per zone at most. =
In=0A=
that case, it does not matter if the block layer reorders writes. Per zone,=
 they=0A=
will still be sequential.=0A=
=0A=
>> As far as I know, zoned drives are always used in tightly controlled=0A=
>> environments. Problems like "does not know what other applications would=
 be=0A=
>> doing" are non-existent. Setting up the drive correctly for the use case=
 at hand=0A=
>> is a sysadmin/server setup problem, based on *the* application (singular=
)=0A=
>> requirements.=0A=
> =0A=
> Fine.=0A=
> But what about the null-block-zone which sets MQ-deadline but does not=0A=
> actually use write-lock to avoid race among multiple appends on a=0A=
> zone.=0A=
> Does that deserve a fix?=0A=
=0A=
In nullblk, commands are executed under a spinlock. So there is no concurre=
ncy=0A=
problem. The spinlock serializes the execution of all commands. null_blk zo=
ne=0A=
append emulation thus does not need to take the scheduler level zone write =
lock=0A=
like scsi does.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
