Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64012070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fs+Md3hR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oXNKF+Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbgGFCZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:25:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22055 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbgGFCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594002309; x=1625538309;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
  b=Fs+Md3hRmHjqdbD5UMMkKzOIqQcbiC85gQjHCSM/rSUWPO6v3Em9yOel
   5Q0DRMXDQtYLZUHt9gYnRnW0f4lmN9vDfQL+YWtnWTSW8gaN3t9TKnDMb
   ErvsOs8u8c98PZyqy2GjzEO7E7JPQcSTWb3p6Oxxy9SHAOBoaN/VRoLfi
   K5JxNLXZoxYDtSbTekwlhpaef64rH8Rl0mq5FG+QTfCJB5/c+Tis9nAHy
   vKXAbLKnNnC81hd63U+ZjfLd73BPWZaaQkE3kDjGM1rztbG1LIm/gpX+R
   Bd25bLgG067pHK+NGr/IDRyK3mB/O3Dbioa0Wyr/h/ERnAx6LXFAznsO9
   A==;
IronPort-SDR: r2aBXyLxg94vbPZdMMCLO7+tolQ4F8HXhcXaiZJR5/w++Kmn11mdnsNZxCWVyS6283/W0c2IBH
 YeTw07oR1Mfg1F2oqqe2Rx/oKYxMdjh44hULEZEhbSmX2v1CHZwa+CcfPoQhszDe7KpLvL/3mL
 RRFPAZgQJCHssrK9zfPJer+Ew8isabfIS8Ui7KyxGTqumhyGKVH329vP1B0YDdC7SuTOjrqs6K
 gupnH+c2nb0UQ/5yE+jLaQc0KLxw/o5d/6I8wCaUmZaZqYhrK4zV1Oi5Z52d6FCf8ghPAOXcQK
 aQg=
X-IronPort-AV: E=Sophos;i="5.75,318,1589212800"; 
   d="scan'208";a="141699381"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2020 10:25:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QITeg0D8WQxtVQdwAkUl0rmP3awtV2XzSVuN4yH1XCK/SKh9Qvy0s0bP/6Mug6177s1T0mlU+bl2xH7oZj683qklNJu1T8aZkkenZ7mcvF9jioxmNH/LLVXDw9MZVkp7BUG2s7N8/A6/CJXObk2Yya36AAy2InJFEBUzDT31wTiuHnVli8ZHe8ympLbhG6TWLFneyP0zyukA6ro0NU/qLEHJ3V6Oz+IQz1qKH1Hb7Gg8MNS4Zet0n3U4aIOvRi5wq9K1iIOn3VSiAj8Ta8Q7LeDJxTXMSswUqe4nlYBnvAwH95pzHnB+oGqRpMNJxvUO7fu2my8lacuySawH7BiUvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
 b=jvBNcRTZ5v06BaIaB3SoVYKBRctQVC4h/KwZ+RMonbmTVIK9KMku7jY/7Rn1GKDK9VJDn+ttX2NJo/azDSHMTgaQOZ0SgJ790rOrrMg80iDq81Qik/pUXJh39ZbdaPuBZhp4CCnfPFJOhzb54hjSGzkrSOx4y0+wKUKubgSsBXHtWD/dQ1daEPLI4oRS3YGnpRifW9m/e5mHtX2PZIV4t2uKb5rmsLWeR2ICRzFUtIB0X1rjZ7m6LJzF3F7pxWSZ6FRIcmBWg6ICbl3b1+0hguIpx6g57RUzAjf2nvDkjojMR8qDMZiCTgiUHmMHkTOGp0LoEsJp5CyWQPZimt67Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2T259ic0yKu7rg6tYhMNSjKPQjSk30g0Su6IzM1ulM=;
 b=oXNKF+LpsnA3vPhq44+QGnnONUzyPK59VrzT7YU6lDjfuvBKAvHjlhJfnxH95mRDcGeBLjIROOqA/5DNy2+iBLZjhqpxwrxRMA5gIKvkLuSRHQrtz0PrDWZOrQrVrs5/aHRglO7O4HIZzQhvuo7xX9/mqfHo0c0WV4rz7BTl0GY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6102.namprd04.prod.outlook.com (2603:10b6:a03:e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Mon, 6 Jul
 2020 02:25:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 02:25:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] nvme-pci: Use standard block status macro
Thread-Topic: [PATCH 5/5] nvme-pci: Use standard block status macro
Thread-Index: AQHWUOVmjr1DYiX5Qkm8oEEpRUYj2Q==
Date:   Mon, 6 Jul 2020 02:25:06 +0000
Message-ID: <BYAPR04MB49657FA8E31516885C73513986690@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
 <a14bca482584d912d72209c6edab6b77b1a924f2.1593743937.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 220d8d8e-ed2f-45e4-f082-08d82153cc92
x-ms-traffictypediagnostic: BYAPR04MB6102:
x-microsoft-antispam-prvs: <BYAPR04MB610265D113148BCDBD27C84B86690@BYAPR04MB6102.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:305;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hsXa5B8w1qV8wCs8VMnU8V1JNoGV7NRayoyLlR9p1/hDf6kBp/rrAyKNJLRPQeAX8wAvyD1+jvNkAZ8H9uRf0Xdf7CdchiNaGLvRF6hEhnlkSG+EoXLgimRicbAnzpHV4mkMc0hrfxjTpMhPcfVbtgP8xlLp+RpB1umqPIoiTbAphH2IjlbjF66Vd7bDPnVkcj4GCyCRaaPSCZ/E5pVQ9OSHIsisCI7LnByj2A0U2tXjwV//p5KmJ/bk/0vz4tgDCVQ4Rwtq5gU/yxedyFWyEsbpNwmd8TswtkRePEoYbGuEMqvayJA+ncjIdpHHhrPAkKTcbSSj3WOh48nThvy9ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(4326008)(2906002)(186003)(110136005)(7696005)(6506007)(53546011)(54906003)(71200400001)(478600001)(9686003)(316002)(26005)(76116006)(66446008)(66476007)(66946007)(66556008)(64756008)(558084003)(55016002)(33656002)(5660300002)(83380400001)(86362001)(8676002)(52536014)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K7ju2MJAylvCWM4vp2njuk1sz58eStQfEmdOulG/MDWqO7gBcG8cPE21I8a2sFOM8mI77xzVG5hzwZ8d1+88a9d7N8kirtpei01T7aDCqaEZBWq7yVQ5zOfY3B1z/6Klo1Cd8/BKQkxzWqj16U3t2G3ibhbHpvEwmqYvftcGt5HoZjQbpa4GYv1UDwy6QFJtj9PmQsKepWJXe9NJOUpezFmhjhacMgqXnt/U7KGhOVPupV3BC6DrnpQ5rK+tiMb70AmMF1aLhIcCf9TjSHyDnkVBiluWHxB8YU+3Fg5dFOLfbs+72nL9nI6CcvksaJ7lTSMk3tDUplf/rqWSyhc0HZMXBPFH+LXol3fNy6TI/MowWaXiLaV/VlO7/ZbIBm7lvvkNvTNYPzw8EMqFM0As0AQF8knW5OAWGAE1hQ+Yj2fn2ul81/8KDTpY1hn7RbfMPPgEKPQ386Zvx74dWgRZrMk7Ffl+wk980JubsBOLDCk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220d8d8e-ed2f-45e4-f082-08d82153cc92
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 02:25:06.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dM7R9JK4I779LPi0543JlPCzA2nNBJI/ezmiuUz93VAB4x70o7DU+k18386ZcCJjtr4/Rcr9vjCcqoS1EAloWYWSKItIykps013NN2eiP5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 7:55 PM, Baolin Wang wrote:=0A=
> Use standard block status macro.=0A=
> =0A=
> Signed-off-by: Baolin Wang<baolin.wang@linux.alibaba.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
