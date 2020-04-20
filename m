Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA4DC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3B3A205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fwVzMkpM";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="bistvLFL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDTKxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:53:35 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:40838 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgDTKxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1587380014; x=1618916014;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rltmw3+1OH6GRfubO53Hpvcyhk+7Fil2++3xACGVHq8=;
  b=fwVzMkpMJaiTwvlBuAo5WE2qUnqBCTRdqPU59s7CHKUyE6jdyh+HZmf3
   4XayuIFTG4zadN3HwRkAbni/JNAkxBwQ8pOytzgcf3dZFyWxSTjXWaetg
   KXdDpvpVART9BPQIarR27bTZYeRul88aoiPc8n0305sm7EP8U13kE1IQ7
   wQADsRnxxkRAXlIAfTAalA4Hw50kiF6s37afNkXod5pBP7xu5iW+onSHd
   vpB92c9gd4JwVTroIAf/7tVch18/hVNXnySLR52FACvL8czZO3lH9QYsi
   b+aaZBtadBGdIXg2TmB3k5fWSvg+0SVIidRnm64k2Bw3LmVstBm/k8hbc
   g==;
IronPort-SDR: frPSv4+v/PoYgzp1x4/giUdp2Qa2NwHKLQ9PvQ7NiUpBO2X/aeu4oYvvfSCtFw1GNjyN9r/Oq0
 PhA7MeF+P3+CkSPMtajX3v+jxuGXRVBOuM4KNpQZmHihfr4gxabBpXqbjCkBbBS4lnkM+kG1Nh
 anvM2xv5PRQdgL6bXwcxSjIuvvfFH04lwygGY1Rnux4aP8Xy1gAyC1ekqb8WCBMBIaSHnkzoI1
 xy5eCtII5nqBigIvOYRAMgC2uCmn/2wEJ+eWSveQhpH4Qh7WYlnR66YYqrT3SApFwWVFkhBOeM
 q+8=
X-IronPort-AV: E=Sophos;i="5.72,406,1580799600"; 
   d="scan'208";a="73112990"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Apr 2020 03:53:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 03:53:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 20 Apr 2020 03:53:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwMyefCP8OLj/lnzHiKFenID32R2vmPt4DwcVWyGiXrgjoMJf906ATANiDRgDNFCD+xGoT/Ajwo2M7ZoBQS0uRUbweQ5MsvvGJ1dOtc2QGq6nTlv/SGwAKc1jIr+Zffca9IRP//h6Y8+dwH7A00JTInkoe1shZW3K3376HHNn3goKkLM/xs5UheZm1+dthyHyUt3yyZBu/rVg/K+EROTPEgPg2oZQJPYU4m9ngk5qMbzEYqvwtQZscoFnEGm963o/wQomFCWNWhEE1wL1ejlHBfVlPu1C8UHbLjtptCh5fz2pU5cpV2fa6ZWisLvD4c8gfMDviNPf/i9d7SD7fF8NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rltmw3+1OH6GRfubO53Hpvcyhk+7Fil2++3xACGVHq8=;
 b=Jy4g3eq7H3M484xaEdU6gyGl0y5Vv4qNzQieY7TnwCq0hLfOPHM0RBjW19MW4XRDlgkmi6F6Ow+BAAGOl7SNrOHy+XEhLt8Ew0GOj6V77rnGHYvrY0+1jZzFMtGQGBAIr5JJUbv6w0DzfJFFOuxfilRu0G32RKQAtj99VK9Z9FQ6yq0pJZvLetdCUt7E1iqStkG2Q1563dOSeNT4HeR5sX53ukjxnHxkad1yLr3xF7cuttXKTmjhqDMgBoJzqsMeLyuo0t9BziIEcxokR5XpEafs7KFYG50PISrTbHEgV3eU7/yt64Scv05uG4EC6mcizLF+NOVnQbK7a6niE2HlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rltmw3+1OH6GRfubO53Hpvcyhk+7Fil2++3xACGVHq8=;
 b=bistvLFL4YYW8NtxhR0CuWzZmlTEKvT1LICgKo9ZNK/rTcKpBE87ppPnerXaeK68cDsHs5dn+mTI7Jb5PhReC5hg5AvUAAWZHSziYTS5OP9y4g9ELI+s3PiF3Z7Z+s90sN8ANrAsUrMRJxUZg/0M5D/CHrXRM74q8LCVBzKn3Cs=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4323.namprd11.prod.outlook.com (2603:10b6:a03:1c2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 10:53:31 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:53:31 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <robimarko@gmail.com>, <gch981213@gmail.com>, <mantas@8devices.com>
CC:     <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
Thread-Topic: [PATCH] Revert "mtd: spi-nor: Add 4B_OPCODES flag to w25q256"
Thread-Index: AQHWFwHuwNKAdLZYj0KePk/huKX8Yw==
Date:   Mon, 20 Apr 2020 10:53:31 +0000
Message-ID: <8596200.jqiEVcpjua@192.168.0.120>
References: <20200404125845.1381080-1-gch981213@gmail.com>
 <CAJsYDVLA3fgjBGdStkiZeqEv8q2j2sUdDzgj3QdahB=tvyYJWg@mail.gmail.com>
 <CAOX2RU7ZU0Jj71YCAoP=qaqUomaHKTi=XMV8wGvwRg_fYpfoMg@mail.gmail.com>
In-Reply-To: <CAOX2RU7ZU0Jj71YCAoP=qaqUomaHKTi=XMV8wGvwRg_fYpfoMg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4210aa07-0c46-4f77-e002-08d7e5191099
x-ms-traffictypediagnostic: BY5PR11MB4323:
x-microsoft-antispam-prvs: <BY5PR11MB432339D6F904A5F5F9DE1E0DF0D40@BY5PR11MB4323.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(71200400001)(26005)(53546011)(6506007)(54906003)(110136005)(316002)(14286002)(8936002)(8676002)(966005)(81156014)(478600001)(4744005)(76116006)(186003)(66476007)(66556008)(64756008)(66446008)(66946007)(91956017)(5660300002)(6512007)(9686003)(4326008)(86362001)(6486002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qT8jzIMXY2TX1rakVWfBQl+zk5UZL13t9XygPXmVh9RxkoVJsWxQ+gjEq77KSsG9Ppp8yB0PRp8e7HKvb97j9DeHUmYh0zkmYA76dVIC/R2RUMgqT9W+E/Glwn9UgoM3jk6PNivWlQMVH9dQv6wlSPy/anXJJjodp0rqSPIqqjnE2F0XJpf2fjcpr099yV/qexoEbFaPlGe3qOkECk1RYU7b/nJNO4dEBlbeLBB+cYItgtUp5XQbeBVGDQu0Wpjk37AYth3xVYTEIXE6IXnMzxZ5IeZ8op62XNCd07iC+BxD9utM6d82/FgsIlO6+V/rFAJQf/AX7vZM2tZGGBPLZMHEjHh9+RB5moJkMA7rE1klAQa/Xx2hX+gnwL2f5e9V/xWeKJYaRsiGa47Kv6OpFdHnuh6dxNy6xS//lRzW9NsC37L/rnQ68sdthU+p/7/dHKZYdLhJPYqNH0h7t4dprs10G7QiUOKfUM0MEWJdHaqvCJBa8RTZ3u/SWtTQIHGDQXqHMj//3+q082D8/Lrwjw==
x-ms-exchange-antispam-messagedata: jUqVNNW+sMS2Jpqxwgg9dtY1hsBepRufjWMEfhRrzIgeuiy2iMdzX/XpxYD25o7ghiERNrvg/DNyTAFI6MEDdF9LDCaycNwDyzK60KYkpsgoKTnuvGvFagOR9kruJvHC2RKLUD2O2HKFvyTAdYVICQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D7326A15EDE1C749BB784FC988F28365@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4210aa07-0c46-4f77-e002-08d7e5191099
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 10:53:31.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWPfvFic4iPT1/ivWAmve+ynSbQTuwTLEZCkpxdHaQwLAdczvrLd79l2Hxn7xaalFRibMvzYdHGhAdW20Qy2hingka9q8jgKKi3IvSkMT2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Robert, Chuanhong,

On Monday, April 6, 2020 3:23:44 PM EEST Robert Marko wrote:
> > > I don't have a w25q256jv available and can't compare SFDP table
> > > to create a fix similar to mx25l25635 one.
> >=20
> > I just tried and unable to dump SFDP on my W25Q256FV,
> > probably because my chip is too old to have one.
> > Could you check if your W25Q256JV has this and dump it?
> > Just add some prints in spi_nor_read_sfdp.
> > If a 4-byte address instruction table is present, current kernel
> > should be able to discover 4B_OPCODES support automatically.
> > Even if that's not the case we may still be able to distinguish
> > W25Q256FV and W25Q256JV using SFDP table.
>=20
> It appears that W25Q256JV has an SFDP table and in it advertises 3B or 4B
> modes.

Mantas tried a fix for this, see it at:
https://patchwork.ozlabs.org/project/linux-mtd/patch/1586958510-24012-1-git=
-send-email-mantas@8devices.com/

Would you please check the thread?

Cheers,
ta


