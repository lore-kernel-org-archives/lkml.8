Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4AFC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2163B2145D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JhRYRdl2";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="SFN0lOG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgEGSOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:14:03 -0400
Received: from rcdn-iport-1.cisco.com ([173.37.86.72]:24956 "EHLO
        rcdn-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgEGSOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=962; q=dns/txt; s=iport;
  t=1588875241; x=1590084841;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GXdNlxcBEYSgPFPiebcVwmxlpLrmnUXOZovSyEDGJ48=;
  b=JhRYRdl2yYKLgYaH8aoDWH0Y394e2mkbRWjiq9gt9aPxuATXzMs02f+4
   ND1vZutyEsReg0SATTotu6C9/NEm4f2Vyfbu0IGZxlKtJNDHuuyDzE84j
   8GBdtH3HVS6cXtwVh6EzZ+ietX6Tk7kp6rRdvV69zwFV48Na6s8NSqbh3
   Q=;
IronPort-PHdr: =?us-ascii?q?9a23=3A2CfjZROJSkuoU8cXBLcl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEvK433k7AUYzF8+hNl/vLqKCmUmsFst6Ns3EHJZpLUR?=
 =?us-ascii?q?JNycAbhBcpD8PND0rnZOXrYCo3EIUnNhdl8ni3PFITFJP4YFvf8Wy74TcMAg?=
 =?us-ascii?q?/2KRtoPeSzEYnX3Iy70umo8MjVZANFzDO2fbJ1KkCwqgPc06tegYZrJqsrjB?=
 =?us-ascii?q?XTpX4dcOVNzmQuLlWWzBs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CtAQCFT7Re/5pdJa1mGgEBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBARIBAQEBAgIBAQEBQIFHAoFSUQWBRi8qCodfA4sxghGPMRSIcIJ?=
 =?us-ascii?q?SA1QLAQEBDAEBLQIEAQGERAKCByQ4EwIDAQELAQEFAQEBAgEFBG2FVgxCARA?=
 =?us-ascii?q?BhR4BAQEDEigGAQE3AQ8CAQgOCh4QFB4nBA4nhVADLgGlQAKBOYhhdIE0gwA?=
 =?us-ascii?q?BAQWFLBiCDgkUgSQBgmKJYRqBQT+EIT6EToVykQ2hSAqCSJgKKQ6dEq0zAgQ?=
 =?us-ascii?q?CBAUCDgEBBYFpIoFWcBWDJFAYDZBCg3KKVnQ3AgYIAQEDCXyLT4RrAYEPAQE?=
X-IronPort-AV: E=Sophos;i="5.73,364,1583193600"; 
   d="scan'208";a="755692647"
Received: from rcdn-core-3.cisco.com ([173.37.93.154])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 May 2020 18:14:01 +0000
Received: from XCH-RCD-002.cisco.com (xch-rcd-002.cisco.com [173.37.102.12])
        by rcdn-core-3.cisco.com (8.15.2/8.15.2) with ESMTPS id 047IE1bj021674
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 7 May 2020 18:14:01 GMT
Received: from xhs-rtp-003.cisco.com (64.101.210.230) by XCH-RCD-002.cisco.com
 (173.37.102.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 13:14:00 -0500
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xhs-rtp-003.cisco.com
 (64.101.210.230) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 14:14:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 7 May 2020 13:14:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hq0E1shPYyQlqlOQSuQ8CUjvy2ugxVQ/JOR+tnkvbczm8oN6sa0cqvc/56/3BX1OY17RaeiIzsi2zHmgrbVFEYY+NI6VEjE2RfYOcHOUpYt+c3KEkPwv11jqB7kPO1psOHCiBV8z6ilpZc/8o5cIUupX8pqccc3wdDm+x+uEgUkv7oKoxTFg86Z3kIpX5IUT/aXOrD9UVKwYWTNHlurkfAcNKgZdE7dOLYe0rMFECAjfb0tIzncokV7Q+5Re+9/oPCCBtC5V0WnA/oD3xEQ2cgV8ePVtbcsk5uacGzNgl66xXPtYnIxd0lufjd5Eo6bVp05dyd8BY+pz3rjUwbLQSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXdNlxcBEYSgPFPiebcVwmxlpLrmnUXOZovSyEDGJ48=;
 b=FSaIBsbFSXyLT7wMg7W/i0Ko3+zmh69HJvtfubPQeQvONi7AmSZVDl0s6hAZesqKYwv83l/92S6QkLUbmBgsVuSDRBk7A2oBWPHWUYjD3K7AVbTUypSAJbh1RJpKoxXHVEICR+GMVJbGroxm1SA8uhAU7esBBCWjk+WPS/GZlTV2oU7kVrMVB5T4tPsfEZm0R7z3LdDwoNFdwtStxNft9QMX/+ICtDKa2n2TURMG/HCNTTwiO214i9UV59Jm+PVvgE6QPELihfUeE/rIoGzk0JjGgWiw5NkFqFuVlaVPorpaXfTNJtc3GXXBhd8lwdUsYnagq722IGGVHUs66Ps8aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXdNlxcBEYSgPFPiebcVwmxlpLrmnUXOZovSyEDGJ48=;
 b=SFN0lOG5risCcQtn/pksY3J7cOvaRKLWe5VtKKyD6U/7CN77sXw7+GCTl8w1muYceNmU6goF8FbQ43nlPhsXPAx2OhuvHND55k2ABQOrlTiNiy5AoZg6aMeNEBwavqWWS0uDkzPkVnMS9jkXD7fYttaeYl4M11iLUGTqZL6ypAI=
Received: from BYAPR11MB3205.namprd11.prod.outlook.com (2603:10b6:a03:1e::32)
 by BYAPR11MB2982.namprd11.prod.outlook.com (2603:10b6:a03:84::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 7 May
 2020 18:13:57 +0000
Received: from BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::e40c:b886:639e:9472]) by BYAPR11MB3205.namprd11.prod.outlook.com
 ([fe80::e40c:b886:639e:9472%5]) with mapi id 15.20.2979.027; Thu, 7 May 2020
 18:13:57 +0000
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
Thread-Index: AQHWJJtGYFQgheIq+0WUH0ne4iHf/w==
Date:   Thu, 7 May 2020 18:13:57 +0000
Message-ID: <20200507181356.GZ9016@zorba>
References: <20200507162047.30788-1-danielwa@cisco.com>
 <20200507180346.gwni4hf6kb6gd2e5@yadavpratyush.com>
In-Reply-To: <20200507180346.gwni4hf6kb6gd2e5@yadavpratyush.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: yadavpratyush.com; dkim=none (message not signed)
 header.d=none;yadavpratyush.com; dmarc=none action=none
 header.from=cisco.com;
x-originating-ip: [128.107.241.180]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0371217d-c7b8-4349-ccb6-08d7f2b26931
x-ms-traffictypediagnostic: BYAPR11MB2982:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB29826D65761428FE825839DBDDA50@BYAPR11MB2982.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4WYBrpUCOxRux+upY+uZsOF2xcFG2zbuQJBJpxzFNysrRp0dqqPQdE8iEavCBJSSMXhXA8tQbF6n4wgdWeKPmqCnwB329gVpfXvTZ0NdGvIbBQeGSG6TB6qOIradkeoavTh2taBdLMPWbSCupbfmCZz9IMuu1D0dIEutJzdzCy7Y7RvtDrZtiMPVC0LeGcXrxrIkaRifeN1ZcmHTobueD1kBvjeRF24bZIgCe4RSnmxfzY3WhKbN71nqnIKQazS/mHRPxVrvkFpPZ/6RuxpfIxQvvEqFSkDAtEnavtyTG2qbQ0fnXLpYd7DI02OpNFtTYy5i4dy1wX83VjgGRmwFBopb6RY9E4nXgt3BhAKQgMe9wQY1ktVAbqsW4N/FXIAgHjvQeND8eVNU3srLDCyANSVjjFrKzl5eKjGLy0sUGb5FqKVLJ1wEn8/B2ZrylBjI8ArzXdukNrGx9Wfs9mubl7HL/UIgQtu5xOnEqGtcV4/lowe4YBzmlz9Y/rY1MHASujk0d0cUL84EbrfZ70hKNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3205.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(366004)(136003)(396003)(39860400002)(376002)(346002)(33430700001)(33440700001)(6486002)(4326008)(4744005)(8676002)(9686003)(6512007)(66476007)(26005)(66556008)(76116006)(66946007)(2906002)(66446008)(64756008)(186003)(478600001)(316002)(6916009)(6506007)(1076003)(83290400001)(33716001)(54906003)(86362001)(83320400001)(83280400001)(83310400001)(33656002)(8936002)(71200400001)(83300400001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: DtUqvAxrxbmox3OzvNJI9ZRs42iIyg8B0qMtDatwH5Vp0zwBbYsB7yFO3GMv66ZRMyO4CrUu5FLCaKGSY7a/Livo4iUnd+vS+/r0sZq0R9GCTql4mcaubV4DYhSVcAkBRrghdHZsxEbNYbaE7msxKKbq8zx4sCZdJ6yyzJOCuIiXf7vUkBJ9EPUJ8lv5e4sZ5AUckMkh1BVVzFQK1cFaIZgZzT7iXYUPGpWaQ8k8Xo/tJCK2O/lDvxFWhHBSZvI0SWX6ty6CtPaSuKkyc5XIMzBnK86ZE2EyDVSk/coPt8toMw694pGm2FUK1Eeaeen0UqtQMVNXi1mCzOQgt09Vl3oQz4qCAcq1NHZ/f6MDP5srbSwSg0IY1BzSyqIu+aSQ/waw++WECz0aRQTCvxMmFY4GI/LoxEovklOG2tVCtwHzKFTqL6hpW3PfrPunTWgPN+q9OM7a+OQNq/Kt9V5Jj0Nqto3FbqGhgrG42RdJLdACppJQ5qPUvE2IN/plbxnWHpauKgoJfS9m1EVLYl33q+eAFPKh8eHkTuMo96Xffuc4lcyd0oNEe+mouWtP/UkdRFb3vbwS+HzoKJFinUfdC086n9dYjatpjIG8Nymp1Ev3bFKsml6bmxvgnPJzB9uhQE10By/Xhb9X7E0hXbtif9NpExCKsYlK1wvaWNZcyPZCzTH1CD/H8OHjOLocLIoBdxVtYjNzJh5TKnJi5MkdW+7nQ2SzxkhAbrvwMm2Dhpf9ej+y0rHJ7qk2zR3QajomC2jIUy78TjBgtPvvva0VuLkjIwxV6PJ2sFpdE7WJA/HDW4H/w8ymWuvuEUonWu1i
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B7E923AE7F6B3B48A1052C4130E01958@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0371217d-c7b8-4349-ccb6-08d7f2b26931
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 18:13:57.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mQTeL6dO+6LPABct66ZotViBJ+ncE+Vue2Y2A2hpLnld6gBI/US2zgVrXhauHGdxVxfrS5kPpSOfijPcpizLdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2982
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.12, xch-rcd-002.cisco.com
X-Outbound-Node: rcdn-core-3.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





On Thu, May 07, 2020 at 11:33:46PM +0530, Pratyush Yadav wrote:
> On 07/05/20 09:20AM, Daniel Walker wrote:
> > Some chips have 4B opcodes, but there is no way to know if they have
> > them. This device tree option allows platform owners to force enable 4b
> > opcodes when they know their chips support it even when it can be
> > automatically identified.
>=20
> Do you mean that two chips might have the same ID but one of them can=20
> support 4B opcodes and the other can not? Is it possible to detect this=20
> in a fixup hook? I think it would be better to do something like this in=
=20
> a fixup hook instead of via device tree.
 =20
Yes. The chip I added the option for is an example of this, it's n25q256a. =
I'm not familiar with the
fixup hook mechanism, but I would assume you need some way to tell between =
the 4B
opcode chips and the non-4B opcode chips. For n25q256a, we have not found a=
 way
to do that.

Daniel=
