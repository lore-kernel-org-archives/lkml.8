Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE64EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B4DD2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="T2JOjgxk";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="IwwtK2Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEHT2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:28:32 -0400
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:7761 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgEHT2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1842; q=dns/txt; s=iport;
  t=1588966111; x=1590175711;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TS1qTdpm2wisa8diOiSQ1dQ8px9NWQokDooT8w2S2Vw=;
  b=T2JOjgxkq08p9r2wHLQpY+L3oYFoGD3HRrDfxKRhxQ3Ztv1/iiabO+cc
   XkldEd/JVrCbPusYF6R/fnrTsKehyOSIlTYO3BdnjY0ZbL7E9hUUKZAw0
   wRb9KBbQuh8GDKyIyGAgjDr49MtSMPQzsHs4JKfYXgrV0FNV2+m0DznPX
   k=;
IronPort-PHdr: =?us-ascii?q?9a23=3A8dvPah07xix5W09tsmDT+zVfbzU7u7jyIg8e44?=
 =?us-ascii?q?YmjLQLaKm44pD+JxWEv6d8hVPAQ53B4u5VlvHW9avnXD9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7Dq3G78yYIEw?=
 =?us-ascii?q?nuKBF1YO/yH92ag8G+zevn/ZrVbk1Bjya8ZrUnKhKwoGCz/skbiIdvMOA/0B?=
 =?us-ascii?q?zM93BJYO9Rg2hvIAGe?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0B1AABfsrVe/4sNJK1mGwEBAQEBAQE?=
 =?us-ascii?q?BBQEBARIBAQEDAwEBAUCBNQQBAQELAYFTUQWBRy8sCodgA4sxghGPNBSIcIE?=
 =?us-ascii?q?ugSQDVAsBAQEMAQEtAgQBAYREAoIOJDYHDgIDAQELAQEFAQEBAgEFBG2FVgy?=
 =?us-ascii?q?FcgEBAQMSKAYBATcBDwIBCA4KHhAUHicEDieFUAMuAaUHAoE5iGF0gTSDAQE?=
 =?us-ascii?q?BBYUjGIIOCRSBJAGCYolhGoFBP4QhPoROhXSRFqFZCoJKmBwpDoJOjWiMdq1?=
 =?us-ascii?q?HAgQCBAUCDgEBBYFZATGBVnAVgyRQGA2QQINyilZ0NwIGCAEBAwl8kA0BgQ8?=
 =?us-ascii?q?BAQ?=
X-IronPort-AV: E=Sophos;i="5.73,368,1583193600"; 
   d="scan'208";a="749108059"
Received: from alln-core-6.cisco.com ([173.36.13.139])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 May 2020 19:28:30 +0000
Received: from XCH-ALN-002.cisco.com (xch-aln-002.cisco.com [173.36.7.12])
        by alln-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 048JSUcA011817
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 8 May 2020 19:28:30 GMT
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by XCH-ALN-002.cisco.com
 (173.36.7.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 May
 2020 14:28:30 -0500
Received: from xhs-rcd-002.cisco.com (173.37.227.247) by xhs-rcd-001.cisco.com
 (173.37.227.246) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 8 May
 2020 14:28:29 -0500
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-002.cisco.com (173.37.227.247) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 8 May 2020 14:28:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQ3uxVoypOaMjjZZsPM/IVIVTJr5RUvqDryiMeZUc5pHWSEhaokRHNXvkCuywyo4LV+5zTg3kVXwtUikQf35RiGRKlbVH8LLFkWu5b7dM2tmoZMbdZQJ3NQCdyIhm2WJvvU98TThwEJYpz6aOFj94GTtgeewJ9yGYsfyP3GpI5S8ta3L63iCvfMIz9RLWXDhiCp2Mgz/gejegHa0sYWpqOgeSH4rFhY/h7DOmrlkzC2RPxq6nmMLZcF9xK5qcUbuV/N34mhTv4h2CsimIww53rA0EWrr7tc8fH9eUrJPl/rHACNIkJotrqkRlHGz1n3WFk7zlMleVJ1ZgEHP3xicrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpZS0OjABjZ8ieGxoRHZZKh76p1z+Issuc2QSnojrCk=;
 b=jdi+JnqEyKwc9a3WKqPKA083lIADvL1ZUZoFKH+Bj3AedVkEIxnR+cgktbSfmXzQssJOU/+bhuaefr+KseJbbhFF99D+o4MnX3PHcOZ3VG7MH7jWYXZoualdRqUjWx55352XdrZ05UxLPZ3up7UpIjBZEDEL6cmD+ZFdC1mCNIlAyj+iJjAtinaLYqjm+7qQMEZvP7lTaV0KwkPE19hQLcEJibypY7bNdZEBWAyyCkD7rQrkLk5HhNdv469nqRCfP3FjatUx8OKl55patbiORrQ51aNedUsat2c7kgs2UJ5Rv7MTRvIY7XvHY6hsvN8DArfm4PllhmR7OxufEyQstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpZS0OjABjZ8ieGxoRHZZKh76p1z+Issuc2QSnojrCk=;
 b=IwwtK2TjhsLV55mocjp/7LwTJSdKPM/wsHSbg5pcecthU15j7WcftmYzaDwwX+NpM5YOnxDycdfGg0EJ0PNkHkxBX+w7wYhjtxO2K1uKqORmYpF6I8duUNYgjzlqA8CrbbVQRLminljS9qXe17/pQel/S4vIJwGH8r7BipHCTFs=
Received: from BYAPR11MB3205.namprd11.prod.outlook.com (2603:10b6:a03:1e::32)
 by BYAPR11MB3223.namprd11.prod.outlook.com (2603:10b6:a03:1b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.29; Fri, 8 May
 2020 19:28:27 +0000
Received: from BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::e40c:b886:639e:9472]) by BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::e40c:b886:639e:9472%5]) with mapi id 15.20.2979.027; Fri, 8 May 2020
 19:28:27 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
Subject: Re: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Thread-Topic: [RFC-PATCH] mtd: spi-nor: add conditional 4B opcodes
Thread-Index: AQHWJW7Z+Cwh12LwKkae6PRXuOQSAg==
Date:   Fri, 8 May 2020 19:28:27 +0000
Message-ID: <20200508192827.GH9016@zorba>
References: <20200507162047.30788-1-danielwa@cisco.com>
 <20200507180346.gwni4hf6kb6gd2e5@yadavpratyush.com>
 <20200507181356.GZ9016@zorba>
 <20200508190735.tpgeuirsnyjexfz4@yadavpratyush.com>
In-Reply-To: <20200508190735.tpgeuirsnyjexfz4@yadavpratyush.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: yadavpratyush.com; dkim=none (message not signed)
 header.d=none;yadavpratyush.com; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [128.107.241.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 924b21f8-dcef-4b65-7240-08d7f385fbf2
x-ms-traffictypediagnostic: BYAPR11MB3223:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3223BE3B8E68410830C462C7DDA20@BYAPR11MB3223.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvuoiaX4c4Cj0TVFtIzARDWV1h8WhnHXmvt9otSEQsXd9tpS5wGp8HMJaD46qZHN9kLDt7y6koN66l5AEt0AMrYF1Oa+VYKVVD+PWJ80njUXg0A2uTgUcaBBkjGsZOp8OGxdgWcPX2tFhmb39OJ9ydWD02/bZN0NCwNAuOb2R9k+SwPBykYrKW6oWTWXcdOlKq6j4YqcaUpc1E6Ooblegi0bNHAzj55NYTqJ3JNFkXped9S0GhS60aQJiZq5tE7rSvk+8uvMH/6Q5C3KEdWvtEHLU6NRXqBkGoM94ry0xFRWGo0A4St1ZT/Tri1SiobJi8Um0bv8KgyQWPQ1RSnia+PM/7nxr3PuehMRpPkMmUCJoc9smn/rz3hDVg6hdmyl/pZ9OJtyW21ZjtwPxt18fMsyUtFoWf3ll/nPlM2ehfRlBAYZ84fSZn2L/DqUPscqzl2kdUrktXuSdyMwlp94SsdWDZLO79VNW7LWTwBppHQ+95kjheYV3z4FkSMsbyBCh+/rDSv32EFIglKGBdblAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(376002)(396003)(346002)(39860400002)(136003)(366004)(33430700001)(5660300002)(2906002)(4326008)(76116006)(186003)(33656002)(71200400001)(86362001)(1076003)(66946007)(66556008)(316002)(66446008)(66476007)(8676002)(83300400001)(83310400001)(54906003)(83320400001)(8936002)(9686003)(64756008)(6512007)(33440700001)(33716001)(26005)(6916009)(6506007)(478600001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ay9i8OtZ7LGSYlquaFCLskFI8ByD4QXTjjCx/JlIcnmgqxiMcl9O5mJFH2Ar8iD/rTsK3xVzk4ygCceNuoR1C7ITlSz/aqExK5tvzWdw43L9pHP2CXLv2LS5IBQuhIgNHNareYG3hfAub1uoBghF+mtPrQL+iSabWIRVW/GEfvX/e4TW2ldteql5yhckhJcQLuYtdXgRIEBiweLTpTJg+xix432nzkbvIYNgjJy1raZf0qSMoz2U5BHIG1fm2UU5SQM8CSZw8G1m+pGWq7yIviJF804f1qGxod2WJI8+yFrlC/B41CHcVY6uK16eQkbx4HIXcCs036gCcIvdbHZp1hkkw9bWw2a5BqfY6vKS+tJG8iaC+cAHQiZJHFZZNHZ1Hw7zF6qmAGma+Cn7zXQqAJgyYxKVANin3uW5ihBvWT0VhPsvv/GeKBzqbUtkof1gAEmMKM5A/jiUr8ifTnnfobZMcq/ox0DQAS8XTOF9rJbn+F67C/ePvq3SSoenb4WU
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6B11C1EBAE0E464DA452B67A8F78F5FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 924b21f8-dcef-4b65-7240-08d7f385fbf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 19:28:27.7705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jzk/uhnG9Ae3iUvKN5SEikE75RMz6P8trluiql6kcxYXNLIOz8yteFz2HwO2R68RGlTWMKVMtgDeg+Nmv1YAhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3223
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.12, xch-aln-002.cisco.com
X-Outbound-Node: alln-core-6.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:37:35AM +0530, Pratyush Yadav wrote:
> Hi Daniel,
>=20
> On 07/05/20 06:13PM, Daniel Walker (danielwa) wrote:
> > On Thu, May 07, 2020 at 11:33:46PM +0530, Pratyush Yadav wrote:
> > > On 07/05/20 09:20AM, Daniel Walker wrote:
> > > > Some chips have 4B opcodes, but there is no way to know if they hav=
e
> > > > them. This device tree option allows platform owners to force enabl=
e 4b
> > > > opcodes when they know their chips support it even when it can be
> > > > automatically identified.
> > >=20
> > > Do you mean that two chips might have the same ID but one of them can=
=20
> > > support 4B opcodes and the other can not? Is it possible to detect th=
is=20
> > > in a fixup hook? I think it would be better to do something like this=
 in=20
> > > a fixup hook instead of via device tree.
> >  =20
> > Yes. The chip I added the option for is an example of this, it's n25q25=
6a. I'm not familiar with the
> > fixup hook mechanism, but I would assume you need some way to tell betw=
een the 4B
> > opcode chips and the non-4B opcode chips. For n25q256a, we have not fou=
nd a way
> > to do that.
>=20
> I'm assuming this patch is related to [0]. If all you want is to address=
=20
> memory above 16M, why not switch to 4-byte addressing mode instead?=20
> Taking a quick look at the datasheet tells me this can be done via the=20
> "Enter 4-byte address mode" command (0xB7). Then just use the regular=20
> read/program commands with 4-byte addresses. Does that work for you? Is=20
> there any reason you _have_ to use dedicated 4B opcodes?

It might, I don't think we need anything beyond access to move than 16M. Yo=
ur
proposal would be to have a hook which enters the 0xB7 command?

I guess the question would be do all the chips have this ability.

Daniel=
