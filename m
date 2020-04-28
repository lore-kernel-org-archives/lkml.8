Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E7D2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v1Rg1TvI";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="ffnoH1T2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgD1IjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:39:19 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:57968 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgD1IjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1588063159; x=1619599159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9mAoBKiiXAITBhmOXBBYXo/woQKF+aJ9zyza5eFJtUo=;
  b=v1Rg1TvIFLw9BQrEKwYJPsWTQ5ouo1/vq0a06vVl5WK6+9c3fsc+siSy
   59B5VoaekngmlTH7ocpvv6CpJM5yniw5zl7nCmF9poqreBZcAKq3TCusZ
   JnbmT3VhrSJEgeR91plr9Omk2liE1aq6v0nyyFdgWo03KwXXOF5A8jxdF
   s2jzUIeargR0zIUUatfI0SqB/ZEmUGwsNZ/LuJHOFEGXJDN96RZrC0VUc
   6z7VIvY5A3mHkF87jN8yyiui2fNQtySajb5TVVUxAhNmlOEOq1OuFUy6S
   KvOwG0STFsqCCVJIGBruq4O0dsry3OGIu/wHCkRjbSwrTgbuRDSi7JlOm
   A==;
IronPort-SDR: 16fMfTBLvV/IwIfnHlANox+sJKLsHaMsFmkNs0EF6jyBZU0FeRbbIqNrFksr6PMMh0lxocecxB
 4+f+c9ZJ6iz3sPbCJX0He9bH3OaruPnjGs+u6hDW8cjhL93rbewfV3EnWvz/trTOtyZPGxFKK7
 Efi3SKLvigq2k7ginCBr4TVsCaWb+PVXX1oyYN5kSxXwIpjf6ltHN/Mw6wJPnQJ4u++umrP4Gz
 hl1SUF/wnW7A3BQHOgDBVgIdj6EW1EwZ4udvLAvrrhX8SEaa1QN0SmpFPC7mZ5R+HnQkbLV4b0
 16E=
X-IronPort-AV: E=Sophos;i="5.73,327,1583218800"; 
   d="scan'208";a="74071085"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Apr 2020 01:39:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Apr 2020 01:39:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 28 Apr 2020 01:39:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmEb545VzcUsIWAtCh4COyuzQY/0orVnR708Sxwsy90W6cKJkwFeoguJAnKsv10qHhnmBDrt3gXi/yIgP6EnoLMv4Tkb6EdPix97+5xZsNeAdJ6zRhDQZs7Vvf/MEOhI4vGf3tf66xcCSBaAsjdUgGNNU2NoDLvIpCDvY5qzd1fVwjDD3LsURuIYOkV7le4NXlibjIivmt5mXq0KnN+ETsiu+ySPSN3jhv2sw1ym0b17GlZEvgKLJCkW7nfOwgLw4mGRZZ2aGr9BaoAiWCDeJ0OmPe8gORLEhczdha4Zzcub7tzRFR/7svnpBrL/3H8dQbKEWLYWdpzBYpWsHAVXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlV3lYmdUUx/oyLOR8dP0j1reOVjjNKvsOhtsI9LIAk=;
 b=C2ah7z15z0r0P+x+aLsT+fHigLzaBogvHcLJYUdGdzj4sQzvqdv/o8EhrOezzQvTjJ9fpLiTbzTFR5teIc9XjbAsOrW4uH1zaYpO8mBpa6LSJ759gyXJiGqChWUBtX/F+SZw9twkDagAPo+tdrJDrtKEHbT1dEBgdWF/ubRoeDB1JgYvg/VCIvmg64u4g8z0GMCpae0W5/Qv3VX9ZiVlxx+8oQZ9IUrrj3dbT/k/4EJGlNGmQnU7NUzO50fmqZRbNoMx77QvzIf4NIYBqo+nH1tdo0UVhpAAsMa8+MS3mDLej1t/J9wG7g8/lGGCCth4Lix+uFQB0HKUO2ZaVpz47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlV3lYmdUUx/oyLOR8dP0j1reOVjjNKvsOhtsI9LIAk=;
 b=ffnoH1T2zq5GAs7RtOOWjlwh3omhhx6AiDoj2jmd57LfQjLr0eEdwAuFue14dTLns+bxwF0xGGoN6j8m97nbTAKLougqXGLCpjiWLDrmQg83lMNdjL558ht8wjxTdq30+ojJj9qcLCcrdcLIVBvQLVjhzMZ+hFnAUbO0sMIj6KQ=
Received: from BY5PR11MB4419.namprd11.prod.outlook.com (2603:10b6:a03:1c8::13)
 by BY5PR11MB4354.namprd11.prod.outlook.com (2603:10b6:a03:1cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 08:39:15 +0000
Received: from BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536]) by BY5PR11MB4419.namprd11.prod.outlook.com
 ([fe80::d847:5d58:5325:c536%7]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 08:39:15 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <linux-mtd@lists.infradead.org>
CC:     <masonccyang@mxic.com.tw>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <juliensu@mxic.com.tw>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] mtd: spi-nor: macronix: Add support for
 mx25l512/mx25u512
Thread-Topic: [PATCH v2 0/2] mtd: spi-nor: macronix: Add support for
 mx25l512/mx25u512
Thread-Index: AQHWHTh/VSG0leWZk0SQc8D/btymog==
Date:   Tue, 28 Apr 2020 08:39:15 +0000
Message-ID: <2988068.fH3nZIc59V@192.168.0.120>
References: <1587631123-25474-1-git-send-email-masonccyang@mxic.com.tw>
In-Reply-To: <1587631123-25474-1-git-send-email-masonccyang@mxic.com.tw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04ef1e79-88ce-4b9b-d604-08d7eb4fa24d
x-ms-traffictypediagnostic: BY5PR11MB4354:
x-microsoft-antispam-prvs: <BY5PR11MB435443C9DD9930CAA6980631F0AC0@BY5PR11MB4354.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4419.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(346002)(376002)(26005)(5660300002)(8676002)(478600001)(81156014)(14286002)(6486002)(9686003)(54906003)(4326008)(6512007)(71200400001)(6916009)(6506007)(53546011)(2906002)(4744005)(8936002)(86362001)(64756008)(66446008)(66556008)(66476007)(186003)(66946007)(316002)(76116006)(39026012);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YCzMIdP/kHoPafwUIsp1QhBHNMPww6RauKajl6bRTIDpl8b6pEGjdibky7BIOCrU6NoFYuxKKQ1ZqqymvQ5ZLff5/suNhiYBqgMchGnXalOwa256E9MqwlZnKCfkSPZqc/+gqpnzDSZeqJ3BqvaisQzLC0IxG9dQFYgekec5fxXU8GjKuQbzoYmn897vdv+qW22snjTYh7anHl0bkbtqE6+Sbdi3ez04C+mFsFBjDubx0DcoxJG7JOHPUEXnSwHYw7164FVvs0SpNAzJDq2YFqnoTCtiRDkt43ffT8fAZD5MDBywZht3fHACjr86Cnda4XPBJdg26PER7MgVZ0d33BkD0COFW119yz1zu53mY9PCJMzi4yLGmd1r/N5CL+wS7fUP8Ejx+g/fkBdpSZLBDDi5zP+qGx/Zyp/Qgf4rR8iaAqbeUx0VFVRexwRRCOzFSpfD0u/8bkDqL3YRSM1HCB9DrCTVVgHjaMk3Ds8PohjciSvlDez8ezWEJ0zGXW46
x-ms-exchange-antispam-messagedata: h2ZsEwd/vj2T7vvE0uGLI+F3YwJjkVIpY/zeFXWHj+Fxd//teFhQdGnlwC6KCOO6wCJp5FA/SkiKyZx+6l6eT+WibCxAXjMCNCjEg0oXZFrGJ1FjF0INioEryRIWN8/xqYyFUStdAn7i/LiA9j5oterhK1qsIqA6FrzvUfZTaXoiiZwrW2GXM8msSgQhs90UWvTLTKMR2Fr0SSyU35j6aVVECPtoKPgkRutSybGv02KhmAcF4FqH2RjtRiFuBPAxuramyzOa024/O15bpatiQnqSJVrzaz+EKMBilMgUvCXPRwaEOPjV7XpxU+8ngN5LsinlWOx2u7kFRHjqQl8MoG+Jld4WXWLt/lpFoo0laNbOr3C48GGpHEwoi0ECBsPH0Bg2/iDzpWfdG251Lsmgryr1KwZWAUiveOEOZJCE1qfjOyQizJh0XcIU9nJE2CXneTE4KE/L3/uoqZ8BzBUc9quulCBwH+QCgzJoyTJ5aEUIYii+PTBKUBApxLF9Pa2u/HOOvVqt6RtP+TbV4KCcXCjfgmB2LshuJEMthckh8MGbclIbLBA+KKGt10XNlQ/iXPkd6pZ4AnGoUfJ1V9v0NPy2WZVcvWFXw+j+/UvZ5bFdRKl0Jr+wGmdjDzC4i39uyORAG5AK08/SI5oOEt2Fl4Le5LmSgyqX7agdev7Om7iQb+LDFaY3MBNRew0/PwHXHQe/p8zUuIbIAPuYLZ9J6RFdgtlqO8K4R5ENqjUwWTKmKiFCqWRyXHeDAVn9f/EO3hJgLe+gmiPeZHvG02YbELE2Q4ozJ8e1nq35qFT6hno=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E2FB5D15A8DC23429EA6A2281603C4B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04ef1e79-88ce-4b9b-d604-08d7eb4fa24d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 08:39:15.1929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWKE9WUK8rnD4q1DPDFyTTYiWLwbm9MGS6lN7w0NuJB8pUTXDeTwOlTDRAeuFeQUNgYDEq3gpI9DoMphilXWHBJ85F5TehERdpMFya+QK9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4354
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, April 23, 2020 11:38:41 AM EEST Mason Yang wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi,
>=20
> mx25l51245g/mx25u51245g is a mass production for new design and
> replace mx66l51235l/mx66u51235f(phase out).
>=20
> Validated by read, erase, read back, write and read back
> on Xilinx Zynq PicoZed FPGA board which included
> Macronix SPI Host (driver/spi/spi-mxic.c).
>=20
> change log:
> v2:
> Add which controller we tested the mx25l/u51245g.
>=20
> Mason Yang (2):
>   mtd: spi-nor: macronix: Add support for mx25l51245g
>   mtd: spi-nor: macronix: Add support for mx25u51245g
>=20
>  drivers/mtd/spi-nor/macronix.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Both applied. In 2/2 I ordered the entry alphabetically. Would you send a=20
patch to order all entries in macronix.c in alphabetical order? It's a mess=
=20
right now.

Cheers,
ta


