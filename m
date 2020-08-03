Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2304C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1759A20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EDAwaaCM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ekJmcvjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHCTJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:09:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5033 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596481755; x=1628017755;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
  b=EDAwaaCMm+8ZPrd0nabo5p3k6WUv4MEo0PHYMvGeJP0BPvQucFIgHdHR
   Hj2PQlxukdZQQbEEK7yOubaSsneYhVwghrIkCd0Fa5XZOHbtBRlPDqoZG
   D4GSJE0CYGOCypqsievM/fgefNwkYYdstKw9AVEVolnfcZNRbxmsOhdoU
   ql6yfGvYpE/pWRW3IsEE+aWRgxAKYkRPT3g0YgzeI9pqc9mPd6wpBz4c2
   ni9o0uE5E+w87cBPn2v5KjT1XSk73i0gzSU9MCr0ahLF9hvJYwF8DRR+O
   9B9ZoRwfjL/LMMn2rGf/5X/RBw1942/94kgUDlBLojE804SMuXSEKqeRN
   Q==;
IronPort-SDR: Rl5GWXs3McN3vl1hMlbBKf+/dIYbghlhw5x0FG+x1zJjoqMF0dni/yjMfqzw/GrxE5l9NAp+0P
 0K19t1FiUVwcLtYyfSWaXw8lstkqprBDc2vKDl9DVscVcHwjt/iuEkuF1aMv65X6Ksyxi8FT4U
 5ojpuzgPqs3aSD6XpBaBVlHlcbmClxNLPmzUh+sjdHqDrp1dzDNCLcLD+E96dT/+WKKwDingiq
 7XaXvWOsnzRLxXe+KKKp+5T2arAI5r0tViDOv/FO+5Wo203IA4BSSHb0mS3vMLiIu/IrclWb4A
 HmY=
X-IronPort-AV: E=Sophos;i="5.75,431,1589212800"; 
   d="scan'208";a="144111947"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 03:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDKhv1Za89aTTHJTc4tUu2sWgj2nnQZhOlJ/BM2jGq5jCvF3nDPAkxOIuo+PUwAT8HeDohyuRBEbHJFG1quaJc0GQpQtEy0n9n/5HQ/1s1MQOfZpgDtSBXU0VFrOronXkPXuRKXiSH8N835dxUurXEMcawNUopENHNEoWGFBSxXWeBm4RBNTEybN96qF4DO27kP8Pw2eYZQS5MaPSRXk2rstz0KK8qrMYu3CMHuFyl8ktRc+JAne50ZdQ408EdkbTXfkoC1Uigj8fKMkF5AOzI2haY3yB7f8Am8WdHRmsd5uH/gafCtxmyPA7eRGxzJsr37i2hP/4GMTysJBucYutg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
 b=Qotxu8daRk6GltHYZ5Gbsbs9122K+lQFD6u0a0WtaXqkcarvJqx92I4EO0A7XHPovFW5IGXbS1fqN7YmBkMq8NBg0KOIxzWZ5hqjRSRKnLIu/XlJxsJgBFOltm1bWBEw2mvT5c4p3KblIg5ueFtEqGlHnj8W+mkbHAn9rbuJrEIH7fTIMmmTc6/fNKLprWLkF3vUZxZhhthUFKZw9209GkJ2d9RUhclv8ybw3OijEjK+GHCy8IHJ0qXEXvR89/krGQgPEA+7eiqL7iE+6wqN+k6I26lrak9JbuRF3sY4ah9dZ+p+MM+PG0GgmnqEyaSwVAusbOcVfEPwJyDtksQI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc2HGqcllPGRn7NMvlZ8PHb/aPWe9/k1MqmtPcDFsw4=;
 b=ekJmcvjGAS6Zo+XAklzGzvfESZ9Og1y/lF2xpVL8YSJOrwa8I85FpW7oGPh0rVpv9cj/27oTpFDiD0ByTpV5Ao5pW7JClPdDSn9pPWUzuzuKOv6Lszmixwdngc7J3tfDjzny7vi9Wo8YUxv8y2W/sTXRICfrtu9gYL+G+3283Ag=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4984.namprd04.prod.outlook.com (2603:10b6:a03:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Mon, 3 Aug
 2020 19:09:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.021; Mon, 3 Aug 2020
 19:09:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
Thread-Topic: [PATCH] nvmet-passthru: Reject commands with non-sgl flags set
Thread-Index: AQHWZdvsD55yoOyrOkWKIunX4pxYqw==
Date:   Mon, 3 Aug 2020 19:09:10 +0000
Message-ID: <BYAPR04MB4965818BE01F3098F1E9E6E4864D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200729191009.4485-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b24dd8b1-dea2-43e0-5d7d-08d837e0b427
x-ms-traffictypediagnostic: BYAPR04MB4984:
x-microsoft-antispam-prvs: <BYAPR04MB4984BA4E756D0C44A3998EB6864D0@BYAPR04MB4984.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:428;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MBocN9vefVKFYP7/KeWSCvNNK7PcB7aiKgt5c6z+WN1AwaS4zwtbNVCiygO8QSxPdoJD+nJ6XnhpllO4h0OegCH3SBi4PRGRnOQcuSze64+ejZIXuCl5u/QPK9OfD23Oi849kI/glubp0WqNKqTZTh1ndCHVS0dOUZTFDInAvyipLhoWVkb0S0fN3a8Z5FdV9R72XLPLWvELIg8X/bP5vcscPJSCyDs4Z4XEAW4Ud4hm9y+It/asOO8Ec5iFmHNsdnl6Dh7euz4YrQmu/15ZfLLZRVyVGguq0b8c4tG9TQlDVGfWUIE5WpJ9VY10MsCB9p9lseHwyDd1oGnl/f5Vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(4326008)(316002)(53546011)(7696005)(33656002)(6506007)(54906003)(110136005)(478600001)(86362001)(5660300002)(55016002)(2906002)(71200400001)(26005)(8676002)(9686003)(186003)(76116006)(66946007)(66446008)(8936002)(64756008)(66476007)(52536014)(66556008)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: b16F8QgCY+xRRkSoa2nt1FYSJ60JnLvX+xyyUHrTMuFqW9BlWcqJgX+NbBt+CyHGxgGAPTCEgZTATSv9jKXpBCfasHvDr1O42e3m+R/7fJG771IVYI6fsKla8184hT1zSWRi8sql2ydZkoCeQUcxRiqaIw9SZYM4klJOvyro2lTpJVVGoTTkMkdeCfqI2tTPY9Gc/Axs5srevoGqc6nWYNVZYt9ANE3+S+CDN3TwkWi9AXVVyQCsylFOtD9bE9n/XF53vRuqUBN6SwfcMWdQGItFDrshibzK38jShc8L2FJkcSQoAQht+o8AacTWj+vV2h8v7EP7Kg7QwPC9p6fjK2P1CVJRuhTZIekRnNbH1Mzh6PWeOiIIrhOIqEZ0dmhAM2/CWr0mB8SmKWQ/ZMMPcmaJ/N6k2zJzOYLke/1fNBGzprzQosz+AjgRT+zvwa8ewy+o9NpnQ4fEaBw9AuM3bJiSr9gUPbZ1XW2s56t9IvWDnYS//zxn5lb4cio7oS6SB8+jO+l/hRG0mGQNQeyZpGPNJpCLTAXf/4GQomZEyT6Yim4xwpX8hbldt+N9H476Cp7LimEoTtv18Miukh9z/UsneUdyBjbPTVXoFVegVDofST93RNyVLVbV+jBPDK53TKBjw2IvAWqgJ5Zgggz6CQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b24dd8b1-dea2-43e0-5d7d-08d837e0b427
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2020 19:09:10.5963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Keappg51iJZ2WwLo0H2XYcHKSyyFFRgeMTgWIjG9XMivpfTbr4qmhtitV6C0YJz6+Uy7P/r4c76odgmR7H6ZlOm5j+4d0gES380xY/4Ptps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 12:10, Logan Gunthorpe wrote:=0A=
> Any command with a non-SGL flag set (like fuse flags) should be=0A=
> rejected.=0A=
> =0A=
> Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")=0A=
> Signed-off-by: Logan Gunthorpe<logang@deltatee.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
