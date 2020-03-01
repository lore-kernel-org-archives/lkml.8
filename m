Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43929C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDE2B24697
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 19:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mER34Irf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nK4Ixnj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgCATxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 14:53:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:61376 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCATxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 14:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1583092401; x=1614628401;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zmuRTfPquRE2poZCqDia56oJ2fBeS9Lmd+wec9IVBFs=;
  b=mER34IrfSTRZ3ktT70/PW3BYvAxdOyQbLw3qDm5hYzxZ1hDxfvD4FSNw
   lKFo9YDtsHnloq+nFHr+ZUbpHM2jKSj0vvo2Cfo2ZGARtCdn8eETkea7X
   frR/4Snrtk7DRSGEiOtJvw0xqKj+pI2p2hpx+CmEMwbrZShiYuSFs6g8+
   O11IbV9JES+bhXTnTA7lsIv2z2k8aOccTD4ySkfUSVhaSYUb0LIHKBu2y
   R1+Ai9ymR+4av27ih6u82ELaqVLmGE/ls4E0tu9NcPcvj+VRT/HoY1FDN
   Gm5D36GPtvQyyHBZMxAyYU0yHCT4G+1mQoCLAhWEbqp/6T4GeiWg8lDSa
   Q==;
IronPort-SDR: bzJkcmlmQuZGFy1hQo29g8QutI3q6EV2XdYrhtlQK7F8tMCa6ukF/gT2EhLjkGDUKbsejT2okA
 vc16zszoo8bAAfBMsCLxWnJec5AJqu4fMUdTbqYh3+/V+hUL6ZWPUbJISh4qz/TLK/7pwyRNoY
 91swkQuZ8dP7b7aLSFg9BVw0/Za1+tFzJuW8zSIVrPdP8YP4YZphNEdTpQC99e2nZshbFqKSv6
 gY6Yol3QeEW6wEDtYbxxWVzQDmEvFFMnneOtnEVxpduwcxHz2fywasaZa6Mx/DdFtZgSIsTqrU
 JHI=
X-IronPort-AV: E=Sophos;i="5.70,505,1574092800"; 
   d="scan'208";a="131620631"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2020 03:53:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CwD6nD6paxvQ5Mmfxyy7+G3KW9iH/g5j7kAgvMY+5Tal9zOm+J/eCmwrvF9f/FtrPn99JCBxoMe77FcJV1WjI/BxfXd+ir6z7AMy1SVFf2EeCnekchHYCigiLYGbsvDnwFchYnsbUQ2OpfUOudR/QNuTck/3oQKeMEuS2c+/zfaKqn6DRaGaEpyqw28Lx8iY3bseRkIunvS6i6IfWBt8f0kpuxtgPGMModqK57DFs8DLBNZ5D2tTAmqvn0yLaxmmQs3xTcXIVVvtVa0WUobTzzJK7b9XwMMgaCPLlVy6ANjU0dMwb/Zt9CqNVWXxw0vXSQqAyaVfAwT+hqIuM9ZrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmuRTfPquRE2poZCqDia56oJ2fBeS9Lmd+wec9IVBFs=;
 b=mIQVFN6hfZ8v3SFwTc8xFz5haSpFuJgaXzkiBmdcT3zpEIoiDXrVJO/zDghnKoNIYFMJ4mQE5tmFmoK17tbJ3bNprXmCiOj9h2GbL5eEiNi+VVjiWIp5L28QF4ZKCCP2yoCoGYroxLO/s15ut181/vY78mqu58jxKhtvKGCght8FRF61WM0XdD8Lu6XeZpemsuWnm+qsxxaTOWNkTuWns/qZNqf6+99OSwSMo6cOhv7iF5qfGMDpQOyRNm90pOTD9QIIuPh9hX1GEaXl2slKNT16QwQTvajrTpT6nEXGE4Pae/p7kqkBfdxSWnkaBx/szcoYAV5VWby1MOHo0Sgbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmuRTfPquRE2poZCqDia56oJ2fBeS9Lmd+wec9IVBFs=;
 b=nK4Ixnj+KhCS55nbkTmqhBsGMCAJd462x+OYRWM39UZ0HksXtj/igZ4GqR3L6F09MndTIluNVzjQyxXURxJ9ZsUB+0Lp55UQZkUPFwBRwERcoqKkuHv/Bl0SNngfd9YcPz1wbSELoqN91Mqpa1syxaBxvr/6CRJyiTSoHDYPIjU=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5127.namprd04.prod.outlook.com (2603:10b6:a03:4c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Sun, 1 Mar
 2020 19:53:18 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2772.019; Sun, 1 Mar 2020
 19:53:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC:     Jens Axboe <axboe@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Topic: [PATCH] nvme: Check for readiness more quickly, to speed up boot
 time
Thread-Index: AQHV7qtY5m6g7a4cOEmKX4VCzFI0fA==
Date:   Sun, 1 Mar 2020 19:53:17 +0000
Message-ID: <BYAPR04MB574947C1DF24C4DDC04D230786E60@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200229025228.GA203607@localhost>
 <20200301183231.GA544682@dhcp-10-100-145-180.wdl.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f4820f3-b99c-4bdd-e1da-08d7be1a2fcd
x-ms-traffictypediagnostic: BYAPR04MB5127:
x-microsoft-antispam-prvs: <BYAPR04MB5127B7EAE5F9D711D9E03FE186E60@BYAPR04MB5127.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 0329B15C8A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(189003)(199004)(8936002)(110136005)(54906003)(316002)(33656002)(71200400001)(81166006)(81156014)(64756008)(55016002)(76116006)(9686003)(66476007)(52536014)(8676002)(4326008)(66446008)(7696005)(66556008)(66946007)(2906002)(4744005)(5660300002)(186003)(86362001)(53546011)(26005)(478600001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5127;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zvVoQDOcCjYv/mF2hQEX6wPzZoTxE4dqAPGtGwROo6xDMQhw1oFpSpuveI4pY4RlmiB6iRpAVYOC6VVYKvMHRLfkaSJXBK1JvBT5P9clVVOeSAzuVA7R+AnwUTmPkVWbNDAC7jW4BBUGJ1kI6USFSjHm+DYU7w1BPZgnAJ8OzO9/opIRogwElntK/OG2iIK4NwMfaxvAuZ/JwfM15O1f33IQ9NG4uUGFqfPkQ2ax38+mgthPWDvYuQC/uw0K0WD3bINKGpj9w74kKsBkk0x5nHu/VqkGTPGnmKwki/azsvViCrH3STlAeUPX0bbsu2uhlu8fnb72+eMtoIVmdh2bVcNAZpDtRY3m/Tq84CqxTF+FTp6FcwSxmecjCmP3sbDmIuV8uUEVCzqEmKm3lxlXvm/bZN1JOiVXCjDAauP0pUrSkuvuhBnyENvycsnwZmyl
x-ms-exchange-antispam-messagedata: TkqsMfnU91qKCnfSzHrj2CoSibvCR0+MSnfW5q1Z1ERwt2BGVHk3Rt/QIOVU0uz09+da2XaPdSGFyyktNfXQ3MnyUaaFWivv8CXcHHc9Jcko5v7r6CKr502qa1uidv+yBm+KGvJt09r2ChDHi4yKwA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4820f3-b99c-4bdd-e1da-08d7be1a2fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2020 19:53:17.2785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuKx/9MGexkHlvK/ZqyJTw0gr4hOxpPOYNJ29AytJNyyhh6KBPKoXeo5RpRh58DYfUq4B9xR+jTZGb3eV4DjcCGRr8r94l13YU5qeXdf3IQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keith,=0A=
=0A=
On 03/01/2020 10:32 AM, Keith Busch wrote:=0A=
> The key being this sleep schedules the task unlike udelay. It's neat=0A=
> you can boot where 100ms is considered a long time.=0A=
>=0A=
> This clearly helps when you've one nvme that becomes ready quickly, but=
=0A=
> what happens with many nvme's that are slow to ready? This change will=0A=
> end up polling the status of those 1000's of times, I wonder if there's=
=0A=
> a point where this frequent sleep/wake cycle initializing a whole lot=0A=
> of nvme devices in parallel may interfere with other init tasks.=0A=
=0A=
This is what I didn't understand, although patch does improves=0A=
performance for one controller under one situation, (also after=0A=
testing I didn't see big issues with the controllers that I've,=0A=
I didn't understand how it will behave with the situation you have=0A=
mentioned. But anyways, looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
