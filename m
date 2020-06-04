Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73373C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490552074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EqDPfrL2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k9srORDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFDHRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:17:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:53995 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgFDHRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591255041; x=1622791041;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/8orTHFTtk6h29jFhZ9RZljaGhuUd+D2/a42ORNh9Wo=;
  b=EqDPfrL2IuPEIeBAFpsba/zu86lk6TMTDldCsNl5HqJ/mW8zNzre+A9m
   LAzq+ShLvD/EpytSFYdoqYn8vX4Hu1/Pm1HI+0aTexJCg/WtW4xH/V6a6
   7rfjmcmttXpB5PguQ11I7SUjcSKnzPd1E4/a3PeXVjBauibtz1WjHuMHC
   +47sR1n0Gg0odsKKMShGthQDOQsoPuCGikFPIEVrQu/GNq1ALtWh9ON9i
   GIDa+qaWzttGBvk+G3T2tvAk8BKVuclIdDukfceHuOZy48+yTeHxEVOGg
   LSIUHYPhWPM43BTVzESJMeuxRVsVLhztqNouBKWtUrJO33aRNhFstmdcO
   A==;
IronPort-SDR: oHR+ouPDFIGlGu7WiUqtsa1PY/HZCeMxz6JMtlVhYUoC3yEZWRzYsnJBzTmYmkbZ52haqdqbmU
 Z9A74cPCzRJjtSLB5O5hAM+C5aKBf+KRaxiT69FdDd2QlvszKfWC7w5kuiCuTf5XexWZH+z0nE
 nBWNW4aAZnSoUO4l+VKulRLjZhhsaqfiI5T2gPKFc1FcWm6v9GyclHNBqshee0DGnQFmreapiT
 gK0pWNDP2Wj66vTTL9cQHIBzZkYidNa1RBNNbUmcXe+QhmVPOQ85DaECh9uSM0FVLfs/3CNBcu
 lRM=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="140603248"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:17:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTlJRUp2VmOzjZnRXLtKHo4PUM5+rt40hFnQzZ5CDGiMV+B5lhl9y6+/7ZZRVnlg+KcmdIt3dU6uxoTpzHoyAjb3o/mYdihoUk/ui2ghcNldjpcefBPf9hMylyn3KdU4a/XLOh5LwcZ39vkrEJOof4wyCbuhPddVoiopcQcC0Kc+YgCEoLq4FH/ZesIaC9Zos0PzVpFnaOeMSj4rgL2ZYmNk9dTSqqdyo/DmuC0P/5yq9sr0A0oZ51LoTWZZasBq6dRk39bieFPj5P3cG/kdXKImniOUw/qJfflVzyn+th5dKmVru2jcNhVQXKY28AoZ7bAToHQQxAlmEKOI1TKitQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8orTHFTtk6h29jFhZ9RZljaGhuUd+D2/a42ORNh9Wo=;
 b=UIJb+sWMCJMPpo335sQ4FfLD2IUHEpVIchOshWohZ5HmB1x4OPcCkMGSpof6XeuGODrA18NQ7vjDNm2TwMGhyKWCMehBs3wMHQtlxzdkr0dg/QVqFxhWafn/WMntf6DdYy5DRk18LAT1MNmFtHigZzwg5SU4gLEeK3ftky9QuS0IaUvHWsl+suvaw0ZFJHzyWkEMZtninbF1lUlAVaap+Ae6XzerwD08u34Sb/VVdHPAG+DtilLLkYxVddS45JtBx/z16T8ZJem7ffNMx/9VmAMwJU5Ei5o8PX4J/GsJHe4Ua8k98K649ZB4GteQS601hNM1YvjaA+Si0uOEbJz9Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8orTHFTtk6h29jFhZ9RZljaGhuUd+D2/a42ORNh9Wo=;
 b=k9srORDTeIY/4jjikF7iDgfu0EgIpfFYjLEIvIJTP+zaikpqNOrvd6G5tOR7bFBugWPK9TaICdxJNKjvrmt9cjgcuZVb7bQH6u/caeoYTCBGaVvb2iEYE+qmxonT6f71KIIf1fkXCZN0lDmQL30/x2nCQ5cpciN1PttLvVHppmM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4661.namprd04.prod.outlook.com (2603:10b6:a03:12::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 07:17:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:17:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     kernel test robot <lkp@intel.com>, "Jan, Kara," <jack@suse.cz>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type in
 assignment (different address spaces)
Thread-Topic: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type
 in assignment (different address spaces)
Thread-Index: AQHWOZq0JeGPDjwwNk2lvn18OjkZKw==
Date:   Thu, 4 Jun 2020 07:17:18 +0000
Message-ID: <BYAPR04MB496553E6787BD7E13E96302786890@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <202006031903.CiDVFCgm%lkp@intel.com>
 <BYAPR04MB496578B5C8F42E1639F56D8A86880@BYAPR04MB4965.namprd04.prod.outlook.com>
 <1327a77d-3c9e-31d3-0b14-454803068402@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d6947d0d-d560-449e-1941-08d8085750ea
x-ms-traffictypediagnostic: BYAPR04MB4661:
x-microsoft-antispam-prvs: <BYAPR04MB4661889C5E0D25896F03012A86890@BYAPR04MB4661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UGZqQBvVbLca6mohZOpcO2cc/3jlTJ+cYNklZ6aeWNwJqVVU5GiOfLt2uAgnysqTH8xWpv9YFBTgZCi785cW585WuNkDYZpn09pcpHaaPzK9P3azbsaa7Jba5Cv7o5Xl2uUTgagl3Kkl6OD+9wwEGyz9xEd5lfyHMbi47NkDvH107N7Njsy0h4SujKv/7toViXKvVrhDs2d0iog+QAHVzHNjuI+K/ZjYitVybZ/gl6whA2WYabmOqeHrbXcBBmfPTj2ZYSaGVpfqhS+1tQgsrXEc4DETZy5l2GvtgZhZDWwK5JKrT3h6tpeuQpZlD/4qC08Xih8tYf4i2CawVO/aGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(4326008)(316002)(53546011)(71200400001)(33656002)(66556008)(66446008)(478600001)(8936002)(2906002)(76116006)(66476007)(64756008)(8676002)(66946007)(83380400001)(186003)(55016002)(86362001)(6506007)(26005)(7696005)(9686003)(52536014)(54906003)(5660300002)(6916009)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qU73Mni7d2z509YrPPsMNwn8DoRzsTRLImjGgTvolXjoW28w1YHJVQ+19d3elpJd2c3MAjXGmsdCv8W2azFgpsJg0Z3ekUHib7Zyw3R6Qy0zi8ximRqLZzZAeJG3zq+EcprJLqEB2kENcSGCS93ojzTUIlYUrSFRO9pPDTtmEy4f2Q8HQMj0+0uzawokHsh0NENl4DJOl/I3D2nI5q9sNGak/2wDqf+K+uWjJeFcAXeXWpPJtoY425eX+votooAuUx1CjrAzEEEuZjKVNY5AaN8pfZlp75aqbSHXEI9YeSP7Qr6w9UgnqY1LtPk0EhoWVenN7Rd4DLia7lAJBbf9HmAmWYyGAQYO8Kp8xhfM17/+qVS1NMtQgS5v+S1lFfVEPTHEG2+rJBqLwQRoe+8BkWzr1nH3PHaB5ZKBZgCB+xDBF679qO4oxPDIrsg47FTqLq3IytdqsM3u/ngsnqPsdYxYr2a0H89fA/ZpRo2z93c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6947d0d-d560-449e-1941-08d8085750ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 07:17:18.3882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z6TAMd1XCNLDGSnwStwFmsFuOhC5U6RrkvFgPvlPWB650cW6FcD/2lZuDTqJ628WHnKBitVAZdW6gTGPMIqM8bXf4yEQRzSebTDnqAe/Ugs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/20 7:30 PM, Jens Axboe wrote:=0A=
>> Can you please let me know how can we proceed with the series so that=0A=
>> we can stop these emails ?=0A=
> Which patch from Jan? I saw one, and it had issues. Then there's a second=
=0A=
> one, which is ordered behind a series that's not in my tree and wasn't=0A=
> queued for 5.8. And finally, there's your series, which seemed to be a=0A=
> subset of Jan's patch for patch 1.=0A=
> =0A=
> So it's really not very clear. Maybe if folks got together and actually=
=0A=
> put together a series to fix this it would be easier to get this done.=0A=
> =0A=
> -- Jens Axboe=0A=
=0A=
I sent an updated series on the linux-block/for-next which removes the=0A=
duplicate patch (Jan's rcu warning fix). In case you happened to apply=0A=
other series before mine (with V2) which has Jan's patch I'll resend=0A=
this one with V3.=0A=
=0A=
