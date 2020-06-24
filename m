Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E016C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDA62078A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qdh87pWE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LK5fFfaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388763AbgFXEyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:54:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:57008 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbgFXEyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592974462; x=1624510462;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sm/MXadB9tk9yofZALuEQRO+oVYdRXFNKU11G44uVqE=;
  b=qdh87pWEnbtO3sPbgZGGi6rS37dOS+KU70Mx6DjsLpS3+ZZKUA55oqjj
   m46hiH56vsMBWG27w3Fwdsq1SgIvIWN7jpnCZV6vuOUH8TIYUKd2bn22r
   rLDe/QTTK02LoMvZYwyLgeaD7nu9vTZJiEyDiBz6dseBes5TSn98MF6Ya
   ttAq9tM5cVPmaiQXJIW9pV1Nwoh9KGxOx1IEAv+k2j7LNsUDr3TCAqOpb
   wAiW2j+5PzXtqXzygYzIJKTc3Vs5af5lykdje1frg2Xq9OHTT1eQtoE6M
   zgHrjFjKAycKmbumnrcoMPfJYwpQuNzhSAh0A4I0QnXtylU0QpjFBtNMt
   Q==;
IronPort-SDR: Cs3V/c83DcHf1Fn3pM/TZadWO7DCMjcCPwbmgj3DOExjrbXoCS0oFKi4N+jGEFVFRupyM10ZbI
 CG3jmyNw9eCBRPggNpjFeZL3ktSmfKUp6TA0bwZppyqqEp0ZUPd4qa0MFsA95MRBa0ep1S1WGf
 51fCzlqHYRMigISyZu4I0HdScS9Z+Sj8RYVibgYEzDf5VobEZuzC+KLnwi5nRSBWsJejNxyDev
 6mfjxGUq4JsAViKILBaghgaUEGOlmcycjYyGUMUiASrmIf9Dh9+9ycv4EHU/Kuy2jnRXwoEpek
 9OM=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="142139292"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 12:54:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6KhB1RUsSXQQpIWZvcYQyLjkoxhqGRYMDAEqmTxGTX+Ii2qJxf5pr6RroFsKPzam83AE32Mth1hdtb6bl4LELLkTnke9Y2IlQjdjXbGoUXDypAxcN4ba4H8Fwr+nZCTfrAXkrIbx+5D2oK+ws3vcDGCzkDs3X4j23hMZUBASQyUes3lfGm+21bAd094DVDQH2lokIo+g+qZWXVhQ9GatcAn740jdGfDuSZbOTv8dBLSufpPQPlJj1oGBOnETCJ4wL3MwutZc+BYDA3vQev0DucKQvoS5Z2uR2WJCe5TNnWsgXvsuEsahLEcFj+i0Cf27kEwV3whyDp4Ofn3hLn4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVifUK7pA3+DdJ2ejCs6Kwl2LjQ5xf0jpw0xCUdnE9Q=;
 b=kNEIxg5bmvNZQwQ/UvA1Rdr6mm8pX7MSR8+IMvVY/DOMKq/1lEP2amyZ163+mPtKLcWtHQFgn4ONqmzL4Mcu/wX5CBAhHK9ap7Kwfn85w2nbLqzbulJdxZAkCJPZFiF75B3JE3ckxSxKGtpC7q7+XFmBfTPxua8J+njCfJhwXgRLw/na92pUBwXjR/vT0yy4Jr7cCvzXjdTGyQJjsuUanrohmRuctq7VM3VAw/ic62w50KNO4omXBSMozyjMVayFjrS/c2K91gKdB9QkzgyhOiyEv+72Le4zM5wrFPAXQtTAYzJUXMan/KfQZ1XNTFJ4IMEYWqb9NuC0fb4UckD7pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVifUK7pA3+DdJ2ejCs6Kwl2LjQ5xf0jpw0xCUdnE9Q=;
 b=LK5fFfaZ8c7isFaTgDwYMyCNoRNVsKyBwGfm/YcQT1C51upa3HPiOhrEkD3TMybZcEEj2BbUDbZSxzjMRh9oeqUk3bnD7mmuT7JZGzCfqYXp0YxPA0Iv7IfT4QlM+UQ8BqCbpdw1oVCJYvmSaBFeLJh6mq9p34uSSbZnkAejpTU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0567.namprd04.prod.outlook.com (2603:10b6:903:b1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 04:54:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3109.023; Wed, 24 Jun 2020
 04:54:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Mike Snitzer <snitzer@redhat.com>,
        Ignat Korchagin <ignat@cloudflare.com>
CC:     "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>
Subject: Re: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Topic: [dm-devel] [RFC PATCH 0/1] dm-crypt excessive overhead
Thread-Index: AQHWSW85EuQz0D2EUU26/bqk/44H8Q==
Date:   Wed, 24 Jun 2020 04:54:18 +0000
Message-ID: <CY4PR04MB3751EB316BFD5600AFAA6796E7950@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <CY4PR04MB3751F148CCFAAC99A7F05CF7E7970@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200623150118.GA19657@redhat.com>
 <CALrw=nHNJTX3kzv2Q=dc6hYr=d8S2=gT0VHkWigS1pmwr9ps5Q@mail.gmail.com>
 <20200623152235.GB19657@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac1a6248-dfb1-49a3-4b6e-08d817faa6e2
x-ms-traffictypediagnostic: CY4PR04MB0567:
x-microsoft-antispam-prvs: <CY4PR04MB05679BD8ED988C7AA9C3F057E7950@CY4PR04MB0567.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: E//ejX1w/t9q0bzADKxW4N//OQ5wCWiNtyb3xStBtT7tdaW355T/QXI0WVULiioPCX5heLUJibz3jX6PlgB65iOjbieCVB06kLpWSVvP4JRXE2c7HoSnEiU+nk0aS86+zldpmw33X/cpJzl/CEgh+pIylrXmJ2HH/p85CpTyA/P11JQioF+n/OD0LZ/Fexg9Yd6keA2ldncv+I+EBM7gxuvmj7zaNq0+141awSWPcpQOpnjl7ijKVmbFz3492AQQ3SJGzx5kUxTcqW3N3bB0XMCzTQwcOPVP8r9NUXy2jTvstb2frUBbeDGdn4BEQ2S5Oml9IMexFcPq5cbs7nVEP6ESlSnIXSShjZe7SyNDRLR5MB8SxrYyiFmIJA81PIdJ+/P/FeA3pb2buzgOe3ch1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(186003)(966005)(478600001)(7696005)(6506007)(26005)(53546011)(8676002)(2906002)(316002)(55016002)(8936002)(52536014)(33656002)(9686003)(54906003)(110136005)(4326008)(64756008)(91956017)(66446008)(66556008)(66946007)(66476007)(76116006)(71200400001)(83380400001)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CDa01nptxlDgMy0AwLizDn87dpMlMIWUAmjM0vzkNJnAAmKKBsGkkNiTWXkNVYPo61wlQOj/VL8pXXtCv2ShREXJc9IeILAJf30mxZKbtwX4y/dxMyDiiX++ggng38jWqgus7/4VPJo7KZR3Gu2zOsYB4+/3nHZnYyuoQfAKSVFf43ziHW9eJMvYC+EB+SmqiDzeloQKnB+vV8PjKp+RzzfBvegiJn0HX67dYSBvxCvYa5seeOFmzBc1Q/r4Hp+GCD9FkJ1YB9mSgxBiQiIcwNmUlQqp2S/ggQBbeh5YWK5OGYymdL5TY4F7ZC2dKm97KzN2N6NmjvmrAbRcky+rUZclEVnNtKJoWD5hTPlVFaVRL+KxUNI0gyqcbqP7VLh0UJYLEucKAODwTQjgReOMlpn2RBR0qlb6OyKvzyiqJdDMdL79/zlLNV9pH69Mf6DUDFG1c5Md5Jd/KsYpV47p1gSJM/46CPeAlKunq13NnfDDwntqhwZKy5YArwpBDKSP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1a6248-dfb1-49a3-4b6e-08d817faa6e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 04:54:18.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xH3hC9IFXu4ej9Jg16EhTk81LceXwZ6zZ4HV8fhqDKWFmVxsxQpFNKNtiDlfVqkm/pcO+4YeYHzZUBN3UvHjUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0567
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/06/24 0:23, Mike Snitzer wrote:=0A=
> On Tue, Jun 23 2020 at 11:07am -0400,=0A=
> Ignat Korchagin <ignat@cloudflare.com> wrote:=0A=
> =0A=
>> Do you think it may be better to break it in two flags: one for read=0A=
>> path and one for write? So, depending on the needs and workflow these=0A=
>> could be enabled independently?=0A=
> =0A=
> If there is a need to split, then sure.  But I think Damien had a hard=0A=
> requirement that writes had to be inlined but that reads didn't _need_=0A=
> to be for his dm-zoned usecase.  Damien may not yet have assessed the=0A=
> performance implications, of not have reads inlined, as much as you=0A=
> have.=0A=
=0A=
We did do performance testing :)=0A=
The results are mixed and performance differences between inline vs workque=
ues=0A=
depend on the workload (IO size, IO queue depth and number of drives being =
used=0A=
mostly). In many cases, inlining everything does really improve performance=
 as=0A=
Ignat reported.=0A=
=0A=
In our testing, we used hard drives and so focused mostly on throughput rat=
her=0A=
than command latency. The added workqueue context switch overhead and crypt=
o=0A=
work latency compared to typical HDD IO times is small, and significant onl=
y if=0A=
the backend storage as short IO times.=0A=
=0A=
In the case of HDDs, especially for large IO sizes, inlining crypto work do=
es=0A=
not shine as it prevents an efficient use of CPU resources. This is especia=
lly=0A=
true with reads on a large system with many drives connected to a single HB=
A:=0A=
the softirq context decryption work does not lend itself well to using othe=
r=0A=
CPUs that did not receive the HBA IRQ signaling command completions. The te=
st=0A=
results clearly show much higher throughputs using dm-crypt as is.=0A=
=0A=
On the other hand, inlining crypto work significantly improves workloads of=
=0A=
small random IOs, even for a large number of disks: removing the overhead o=
f=0A=
context switches allows faster completions, allowing sending more requests =
to=0A=
the drives more quickly, keeping them busy.=0A=
=0A=
For SMR, the inlining of write requests is *mandatory* to preserve the issu=
er=0A=
write sequence, but encryption work being done in the issuer context (write=
s to=0A=
SMR drives can only be O_DIRECT writes), efficient CPU resource usage can b=
e=0A=
achieved by simply using multiple writer thread/processes, working on diffe=
rent=0A=
zones of different disks. This is a very reasonable model for SMR as writes=
 into=0A=
a single zone have to be done under mutual exclusion to ensure sequentialit=
y.=0A=
=0A=
For reads, SMR drives are essentially exactly the same as regular disks, so=
=0A=
as-is or inline are both OK. Based on our performance results, allowing the=
 user=0A=
to have the choice of inlining or not reads based on the target workload wo=
uld=0A=
be great.=0A=
=0A=
Of note is that zone append writes (emulated in SCSI, native with NVMe) are=
 not=0A=
subject to the sequential write constraint, so they can also be executed ei=
ther=0A=
inline or asynchronously.=0A=
=0A=
> So let's see how Damien's work goes and if he trully doesn't need/want=0A=
> reads to be inlined then 2 flags can be created.=0A=
=0A=
For SMR, I do not need inline reads, but I do want the user to have the=0A=
possibility of using this setup as that can provide better performance for =
some=0A=
workloads. I think that splitting the inline flag in 2 is exactly what we w=
ant:=0A=
=0A=
1) For SMR, the write-inline flag can be automatically turned on when the t=
arget=0A=
device is created if the backend device used is a host-managed zoned drive =
(scsi=0A=
or NVMe ZNS). For reads, it would be the user choice, based on the target w=
orkload.=0A=
2) For regular block devices, write-inline only, read-inline only or both w=
ould=0A=
be the user choice, to optimize for their target workload.=0A=
=0A=
With the split into 2 flags, my SMR support patch becomes very simple.=0A=
=0A=
> =0A=
> Mike=0A=
> =0A=
> --=0A=
> dm-devel mailing list=0A=
> dm-devel@redhat.com=0A=
> https://www.redhat.com/mailman/listinfo/dm-devel=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
