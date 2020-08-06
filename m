Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B0EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5320792
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b/7dhTmo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cZferUtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgHFCBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:01:21 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17254 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHFCBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596679274; x=1628215274;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
  b=b/7dhTmoEbWFIpSACWX5PBxqHQeaXS4npVDLVEX9I3RJngvlctrTT75F
   RJOh2OsS12loy7rwld6i2UvwxiyWtOcVgNh+o0O7koDisnFYJDb+D/bZd
   HI1m0fvjbGXItJrfa3vr6uiY2/FgGueyOS6eHqVaL7h5soMuj5VaB0cEV
   jdC+NCw3VuttVWNzJmtEfQ2NxLTBVW3R37sNeikXs4fVGd90isFBf6F/F
   XWg9sVQsiSJsLHAcd+n5aOi0ZctH3LSKzQ1OQ0b/rWs+QiL4z+yUqrz5Z
   9bAd66zrIYla6jUYguL2tS85P1fgHhZl1CgFEasCxh9dFZayfkCLTeNpe
   w==;
IronPort-SDR: ercSSR1c9DOYqTrjVHA+HGc7Yb9aPqY6lMAFv9clziynM5zh0Jb8QNh/yoHoN5XgOxCWgpEDgU
 BC8N6VRWcVa28Z8gH0FqyYbuqYRhZ3Evp293R1TQI4e6YlhFtRNQGG1exCdn2GZgOLqfpctt8d
 rfyigD0q6MCBcyid7aQSorptG2S3O+pn/FQAHnpoXR3r3mRwfUkcPfQHV4T/G/RvA4Ugc2MDw6
 +O7gwnws4Qyek8Fua5b1UM+dgpFGMFqSgM2rKA6M8dgBT+RplAootkFujIoS7mcxpTeXsllB3E
 GmU=
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; 
   d="scan'208";a="253612735"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2020 10:01:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmM7t2pItx4YtKqyHBsiDS6Hc+zjKvjfcOntF8KkVMmsTR4q4wF+tP0g1dkh3MxCxCPJGbjpAr97FU0Ww53ONMRvGh1wFf15Pa5r5pya1CvpHTkKkdUIXRM7JMc5jItuoESJTVHl0SZfgoIRkcmVUAePhH3OwSqDRPaMBINVXrX98m9jCfg/No37TbM8gXTUQtRhoTWR1EAd8nJUgOGgMy16QEkwdc1H55GShpPt5i1Qn69eqIRNB0ADkxEtyD+frz07hHpE6IHSRQjyGOqfdAKe1xendBIAc/XGlMRRBm0dm+FfyBCkVUjHz0Bq5i4baKvHIVIvTsNmVPNFkaGRMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
 b=DjMRmMH4w0baldCr21cdgs7ptNF+nYw1yJBo4T9zw/EDCD1RWFVpzZNiODnK/XZIeagTHky4gYbKrMAhXTFmfrfQ+ww5ZH7LcMi+WrXF2bp9VOTrQNutv/GrZcFcdz49IGOKZH9kiFZ53MVREKp9656nXGnflHTM+u2U924o+Z9Q10USpT0UCK3fl9f9EaiCSFWAN9Q1jVbel5qd7Q1Qg+F20H7aGeViZa+amLH3iGH1tozaAZ0NuIdSa5ZP5Zk9lUfT55QXrot1YaZws7yXnZxSEH+Y+wvR77KMcbsiHdc4I9FZztqqee5qKj50xFGrQFf61ZG2BSsGr5GfPxxK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUU65niR14ZvEgUOqy3aOFOYZkbINWsDgKOB8fd2lbU=;
 b=cZferUtODEXq9gm8lFFPXkKZqZeUW0UUh7+SGpfAhqALt7q/mzyVdMM1PrdEBr7hYm5yfde52Pivdq/u/7BHoKNQHImBrL1BIIBnpfTyx/cdc0CG9YoB8d0EMJHGGp4QJOzdGWTXle+SVWlIQau/7nlAbjtYc0qk6z0skLroO74=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5525.namprd04.prod.outlook.com (2603:10b6:a03:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Thu, 6 Aug
 2020 02:01:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3239.023; Thu, 6 Aug 2020
 02:01:12 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH] nvmet: fix opps in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa4WuB/SmK4DZYEq5V/CCHY245Q==
Date:   Thu, 6 Aug 2020 02:01:12 +0000
Message-ID: <BYAPR04MB4965A923FA197947CB02CCFB86480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806000804.6345-1-chaitanya.kulkarni@wdc.com>
 <4c0eab62-d29a-f1d9-7856-78af8d6fcf48@grimberg.me>
 <BYAPR04MB4965F41CEFC7DAE474CD3D1586480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c31c1600-7b9c-f2cc-57fe-e8c16d857d2c@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f8b4e96-1216-4ee1-6ad9-08d839ac9878
x-ms-traffictypediagnostic: BYAPR04MB5525:
x-microsoft-antispam-prvs: <BYAPR04MB55257E49D1F9AC3D91D53DBE86480@BYAPR04MB5525.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9RDdVcGj6x7G9PSERFO6czgLx3xeiT3vnp0yLGu/Qzdz8TDacvi3fSXy9dsSShllSgK8XQnVtfE5ILlRoz171whqDvhCgDvcLSuv4OtZ7ZgWDjk4SRdI57crGGrJjijW4gKOQMUcuHJgLeTmA+cFTSgxiw809ctIPKs7saEVeiROBrG9EzTpmAWslqlgB1IrjnYEfTXZ+6hRadcpebJBbMtNzXXl5xa0ALmzBLx0eL9VHdrfo7nrXPUB8Qyz/REIUlBUDSjY53UTClToaUc5Giyg9L5CFlLbB6I3GGKO0mpjL1jhyhx/93jjR4YKYOdRwUwGZs+tQEU2PL/jqICxKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(110136005)(9686003)(53546011)(55016002)(26005)(478600001)(6506007)(33656002)(86362001)(186003)(4326008)(7696005)(558084003)(66476007)(66446008)(64756008)(66556008)(71200400001)(8676002)(76116006)(316002)(66946007)(8936002)(52536014)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Vq8kDyKDrCfBMUe+1oUZSy/y18OpUSwM28H55XdbCaFHy6THZIwMN2Jer5yWvyq/YtP/JHwbd9L2uQEkqXvxPuE1GIDBaEZ9vqGP4VgQdsBLybCBMYTTLExtgoiJPWh8BOhePnf7qXORrUUZwWyvl9GVnx8nwVdZCAnAlqMy1Fr7pHrx6Z0FdnLyI1YCUJ69+Tkza51vJ6rr2VN7vSL1iWSQCVMifDyAUxSwRjtmkRsXkm49zky4pykh1KxwptiecKx8issy6+WflOTE26dtvBHtk5WRWCjCRNzpHgJQSXFGfeFf7JdS7B4YCS1GIAS40bZTKqmGUDN4zPkwSyVjxVSl8SBLWFJ6yDe2hIF2JYxdShMypZJKVvBU7Fa8YoBdkcOp2C3n3iOGFEkx3GF3HgkWYStg/03mWQ0muTkf4sfBSBpST9PmJ9BhvnCyVxHPrWSMRW6lJwiTG1hDzptP2yYNAxVwcktDWkaUf7jp3utSLBJErBWWG1RbKicjUeD9YNP/EV69MJzBa3Bjy8Ty3IY5aNfZjqaWKvnlM1g/8sjOp7z51okCzhPDt1IQPflQu2nrCsttcN3DO9144J47TGFgqOzhHHHA3eXjWHJCUqXQpw3NyBD8Z1ofdlTyXOYXWh4HCC7btQtMEs0dnXaXzg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8b4e96-1216-4ee1-6ad9-08d839ac9878
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 02:01:12.7213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PceZo+IiY3xEhkEKjXMnbzkZGmgxAwcc69nelwdqXy8Jf4Wem2Iuxxz3fKKUMpwinIc5YUeRhuL4URIqIXx9x3Irj843GzAocSX2KWwiU/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/20 18:15, Sagi Grimberg wrote:=0A=
> It doesn't have the patch. can you resend?=0A=
Okay.=0A=
