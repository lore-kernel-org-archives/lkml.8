Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1680DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB5CD206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DhrsVQLt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vnpUlvO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHSLRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:17:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgHSLRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597835856; x=1629371856;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hMq1oiVQRLzX4TC47DOEFHh+3BdCoKTIm0tRO0xUSTA=;
  b=DhrsVQLtO+0AKgE54zASUCUqWUONxBLQWjCvbOf9IoUaYrZgc2ZguzJI
   XsOaS0vQHMSmWiAC45Kmzt270XU8NpmuBOHwqoCoV6luNpGtDJR9sbYgT
   KX+/dXKqCUwMVPXlMnGvpUY8Iqtl0C25loJ6AFF5D3HdqThsm1z5IH1gL
   jYS0xGwE1I6jZyehJeWEbTD5tUnCVCihjoX9T2s1nnIqNmr4bqcuVB/4b
   Mc/dTW3cyuxhbM1nl0ekywRRU/nWW6Ia/nAkRqf1P3+XMHdm5qPb6VE+D
   Iu/JXnf9KSmFr5EPOdPSX93cRNrgdYQoeovCbq7Hp2yWglQGeSi+wA/IG
   Q==;
IronPort-SDR: P4IOIpyGx9el8iX1nFq7xBrJXrtIJSJsnyXfPJNG+Dhtva4PpEIxTH59c9FhxQ5ZtWjuxI3gqf
 A6YsArfYYeR3dm0bqUtjzxxN9vJr908COeKY2Fg8o7/rgevZl0K7cTkfKpDN3HXgELHw595JDd
 x4GqBB9le2YuuyD8mlgGa9UfroeAm7C/SIMZtcheQqvoin95KnDuLRFGwgRwvSpGMpYIcVtclu
 NjV1yD60ivweXFpFOC4LpRk4/sY1us/z8Yy00To3j5TGcBBfIVBSQ3zoXt7wjtoAKN1TtTVXMB
 LmQ=
X-IronPort-AV: E=Sophos;i="5.76,331,1592841600"; 
   d="scan'208";a="149636131"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2020 19:17:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PigMxY2/oQz1q4OqSoqNdFkGm5Fj5F7xaBOFIhQOOGQUrDtRZgQWbIhEHZwlCduJ5rJbp/5HiOB5q6bex/hvoZKhXmKRW85Us3Qm9CwdYIiF5eZRF+kZ0TPP2tbs2QSgIXjv02HC2PzpMl5GOqgqwdvm4iIbf0CadMY29ZneD3FgNCNbMwFay27xda2Mi5uEFfReaff1RHDhh9iFRPUAGhQRQqc/YpqxcktRXEPOhJZzxiZxSVxiW5+M5leYRbONyUlKjrFn+M4ETS3Sams2dgLCT3e1ChnoFYr1e9LEHJNV80otAbHP25Z1oWJUJKE3VlSHKCF7GvzQQ+J3mD3GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbF80ekpXZTXVthrpQxMqWZlcOOKaCnyZOvc/iPj5uE=;
 b=LD5mtAx0bahm/3vm441kRJ1oOAKNQk+OcRZeNRyiYg88NvBESN6moxf+iuEE7djZwDCVxg5QRiqPx8pKuRU/Ix7OKgCg6/uIRu6FJJrw0ikaigwAiaTFQMVY2jl/k6rX2QsSB2assfqgugbYinktR4a7GJXM7N1z0teFAImdBSxyMvbQHBMn3cPF96HkrRyt1HQa9xmX+Qfyc1cZxPpahvLCwcxeWzpR0/o+gJ+qq1AwVNRj+yuAR0l8Mt+Ow5y7TsbNbcn8gAy4xqXuyANFe26I2hEGx9CA0G/ILZkPjWzyl48/jScrn70LoJMz7ZUNmRAu/61PoclRyAWn3e0SEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbF80ekpXZTXVthrpQxMqWZlcOOKaCnyZOvc/iPj5uE=;
 b=vnpUlvO2924LXqUgJgBY4N3WSxnztfPV59Eow0psXotD79O+Jj5uwijVRyWpEir04z8Rqylolm9bHPu/0Q/YlcThLxkpksDPLj1vkvOT3fkNMaA5tqgEQkeilP67A17Y/X16UhhuUEO9dCYXVNUQXU/TFDrZ6XN9ouoKG21hs6w=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB1175.namprd04.prod.outlook.com (2603:10b6:903:bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 11:17:30 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.028; Wed, 19 Aug
 2020 11:17:30 +0000
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
Date:   Wed, 19 Aug 2020 11:17:29 +0000
Message-ID: <CY4PR04MB3751B077D152A80B19236C20E75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
 <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CA+1E3r+C2KQENu=fO_+FZoUEvqZrAQcxziwSGt=FVidv85KQxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 105a9491-3659-4dac-9636-08d844317647
x-ms-traffictypediagnostic: CY4PR04MB1175:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB1175D09396A2BD8FE9B84838E75D0@CY4PR04MB1175.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtfN/YdFtJ9xqXtYL/V9umhdluOkYYv581DTB9HSKIpJ02ucGaocX2j6RPKaSlvVhJoPiCdwUViM551aszPWmUm/cTM+7Hks6YbLW4KXNzcP474yqK7KoI+bbV17WMJ2POcifXzGjzht9mhhFxZyWhnW49QIZXXJeMqqV8j11ilWxyNBR5lgb+FNA5Lrn2ao8PYJ51/hRiYIHSFse+HgKcUcdiLpejlTEvktv4amg4rmK3Rt7UlNc3j1NE7smgaBh5ylfgYrM7Iyz6XrgmFjc1ZIlLkGa8XfZ8egX0J3p+WUQCh1xKzFZm3whnVcLehgunIpQKTH9PkY5eUHB5lIEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(186003)(54906003)(71200400001)(26005)(6506007)(53546011)(83380400001)(316002)(7696005)(55016002)(6916009)(9686003)(76116006)(4326008)(33656002)(2906002)(5660300002)(52536014)(66446008)(66556008)(66946007)(64756008)(66476007)(7416002)(91956017)(478600001)(86362001)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZUGclRIfuxoo2HHMX7t7PBJuNs5DveWG6FPm3Wzcw3t/DionWo1vYdwSEVP3KDASPm1lLRNs4GIMc0Zvr/ZQb1XSyOv4TRDr/H/2Ing+VM2lz96dOS6FvHP221a3zd4axdHKLCTjZLXMvR1TKjDRvxm/gktYQv9DNk7NBGUjKapXApHu/PtZDrLr1+wiV8SqBrTZy46kXzHhTBxeXl9o+B55PZ7JPfLuXHy6PvZeEr3LfnhyRVp+3JG0TSFVRCIIWTR50oIMk/xUrJQlAV0PUIHIGlHOCMHjrh0nKVdqMSMCeHtknooDYYJTWJ1aKoGpI1T2R7e1TgUtR7wvpnj189XnH5oo/uWmp0qOEhHxV4va7vohQIk8rZpsAWe2gBhWGqkZObJeIySdr8wBavUaKFlb90bVor+xNsNScxEerTgOGXBKjZPB8fIs+MqDw+6iR5XRb6UDRvdWC3WmldKHtCT2ObfkJFquHkyKRM3Px6bvV5bOwWokT3eNyXFflJwEBuuVCow0oA4SkGfb4C1KI7/61Z6nWNSs3iItEcP5krBefIhPSYj5wsmzYhcPbknkQmgHjZqnGY0VFJhS6Kx3Q91bix7DfXyvbiKyLWeuvnBFDk7QN2QBkidn7aOoDVo4ycK3bCaLlgk2x2EpE33a7g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105a9491-3659-4dac-9636-08d844317647
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 11:17:30.0115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05sTsFfxoea8zZQ3g7SkRGx7BdHr5lCVm4iF5ZazoswAnp6zyevD31kzvNFGOe8+MpqQyz8IEFWps4M8EY2qpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB1175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/19 19:32, Kanchan Joshi wrote:=0A=
> On Wed, Aug 19, 2020 at 3:08 PM Damien Le Moal <Damien.LeMoal@wdc.com> wr=
ote:=0A=
>>=0A=
>> On 2020/08/19 18:27, Kanchan Joshi wrote:=0A=
>>> On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:=
=0A=
>>>>=0A=
>>>> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:=0A=
>>>>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.=0A=
>>>>=0A=
>>>> No, it is not.=0A=
>>>=0A=
>>> Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS=
?=0A=
>>> I see that null-block zoned and SCSI-ZBC both set this requirement. I=
=0A=
>>> wonder how it became different for NVMe.=0A=
>>=0A=
>> It is not required for an NVMe ZNS drive that has zone append native sup=
port.=0A=
>> zonefs and upcoming btrfs do not use regular writes, removing the requir=
ement=0A=
>> for zone write locking.=0A=
> =0A=
> I understand that if a particular user (zonefs, btrfs etc) is not=0A=
> sending regular-write and sending append instead, write-lock is not=0A=
> required.=0A=
> But if that particular user or some other user (say F2FS) sends=0A=
> regular write(s), write-lock is needed.=0A=
=0A=
And that can be trivially enabled by setting the drive elevator to mq-deadl=
ine.=0A=
=0A=
> Above block-layer, both the opcodes REQ_OP_WRITE and=0A=
> REQ_OP_ZONE_APPEND are available to be used by users. And I thought=0A=
> write-lock is taken or not is a per-opcode thing and not per-user (FS,=0A=
> MD/DM, user-space etc.), is not that correct? And MQ-deadline can=0A=
> cater to both the opcodes, while other schedulers cannot serve=0A=
> REQ_OP_WRITE well for zoned-device.=0A=
=0A=
mq-deadline ignores zone append commands. No zone lock is taken for these. =
In=0A=
scsi, the emulation takes the zone lock before transforming the zone append=
 into=0A=
a regular write. That locking is consistent with the mq-scheduler level loc=
king=0A=
since the same lock bitmap is used. So if the user only issues zone append=
=0A=
writes, mq-deadline is not needed and there is no reasons to force its use =
by=0A=
setting ELEVATOR_F_ZBD_SEQ_WRITE. E.g. the user may want to use kyber...=0A=
=0A=
>> In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be =
set only=0A=
>> and only if the drive does not have native zone append support.=0A=
> =0A=
> Sure I can keep it that way, once I get it right. If it is really not=0A=
> required for native-append drive, it should not be here at the place=0A=
> where I added.=0A=
> =0A=
>> And even in that=0A=
>> case, since for an emulated zone append the zone write lock is taken and=
=0A=
>> released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is req=
uired=0A=
>> only if the user will also be issuing regular writes at high QD. And tha=
t is=0A=
>> trivially controllable by the user by simply setting the drive elevator =
to=0A=
>> mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.=
=0A=
> =0A=
> Are we saying applications should switch schedulers based on the write=0A=
> QD  (use any-scheduler for QD1 and mq-deadline for QD-N).=0A=
> Even if it does that, it does not know what other applications would=0A=
> be doing. That seems hard-to-get-right and possible only in a=0A=
> tightly-controlled environment.=0A=
=0A=
Even for SMR, the user is free to set the elevator to none, which disables =
zone=0A=
write locking. Issuing writes correctly then becomes the responsibility of =
the=0A=
application. This can be useful for settings that for instance use NCQ I/O=
=0A=
priorities, which give better results when "none" is used.=0A=
=0A=
As far as I know, zoned drives are always used in tightly controlled=0A=
environments. Problems like "does not know what other applications would be=
=0A=
doing" are non-existent. Setting up the drive correctly for the use case at=
 hand=0A=
is a sysadmin/server setup problem, based on *the* application (singular)=
=0A=
requirements.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
