Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A471C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FA520719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U3Z7I/qS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eEBu1XLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDCUcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:32:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:37474 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgDCUck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585945960; x=1617481960;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ylG8HtgSwNNAsvhFRzAb+4W0lWFHYX3md4drwkGNgtg=;
  b=U3Z7I/qSn5JAelTG2XTmKobMqaaW13XTKpph1i0aCPkVaMAbrBlOuEHf
   4a5QPwh4jIyTO8S27YdP1ebzBtqtR/PV9sOpK7frs7SfzTBKcUm2gr2kg
   5bh6pvQOi7KZkuKcWh/yTkzNDGYv4HQisM2U8Qbnex1ys6V0F77BgeO6b
   3Gp3sztKe8hgk+uOMVoxwBdAZzs090voyfeQlxY03WKAGZ6IphVq6r0C0
   aEOJpB6+OUCJafBpUXKFw6LlLba+ZFBFTuYrQnyEMnQ+aLm+9UhOocn5H
   mi40JpWvXPGx++Y6vIxT+L7QQ+c6sUT0JKVqWzeu3dGej76OialWeyRLa
   w==;
IronPort-SDR: MfkCdQnleznSwbWjy2dARuMlINjU48IjJXfEfJMG8rPmtei5A6Eqx8o+YBdpXQvFcoEKUp8Du3
 3f/n3kVjMd/CFm7RPeayQ9kJkOWRDHivBI+AvH5NDtB9Jrupm9wjziKUmpC9JpcjFxA4ZXJlM1
 UFfmWiok0wRZs12B6Ie24r3q5nhUwsXGgkAa+YEuAuH9AQK1JFwdLnzrJD7C4aoCjgUavGNatC
 MwpoHfWm6TvM9XA3VCschQ7Mmzx3j3e3lqaxU+LIpLzlATZw4l3fOcDl5lBxoPFHVZpPZdjq0V
 KBU=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; 
   d="scan'208";a="243053733"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:32:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LL/d/CvF+Jbhpo0cEK9UJrJD45iyT7d+Hm1jl537FTIW7v1VTkJcW74pQlNCzk7GFQuKxDmigOadORh3uQ9sXv9BZa9NdT1dkAq2AV0OG2zQtVmiSxCe+rIUr5zRsEVZbsn2hSGlsgfVMz4PT4X+X3z92TgW8ILNxdf8vRLpUjOVE3Z3I92iacCu6E9QglIvgYTWNH9qv9NPibEzEeX1vG8HcaT+F+QNh8ORudRd4OZcJwRbgEydFPmpVtimQ7ScS1SYOJlhdgRRJvEuJUYonIMMDiIXcw/nE23W6iN3ULLYvynbvUzWdaEC0sJL77zYbCJleY5J0tpFByHSTRUi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylG8HtgSwNNAsvhFRzAb+4W0lWFHYX3md4drwkGNgtg=;
 b=katweua2Sb38hUSYuAqKbxcRnJEW7GCYbf3vu4RxBgsug1alWl7LcTiXfOr09cWrKVYmGMl6z4yqwDak9PbSlCuhJbsJqMiRWxKMBpopIB89d2YtX0OJ2b8fPDKQJLOxnrXwdi+g0NvajK2/SZGQqGPif/zV+vWYy1EdMszmbYn5aO3BYpN/dgW/CdrDQHUFnehr/jxKLdIyIaPLqWZGXbjzaSGDqhf9cnSu22dShRqpCe6Ppjnir4Ee8pVeuZohpcG4TeSPNZW/cNdDWvZrQpybLCX81tC2CvgwmoL/F6A+hLlawvm8Q2g3FPGSVHij0sTyo8b1lQRayW6JdPrqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylG8HtgSwNNAsvhFRzAb+4W0lWFHYX3md4drwkGNgtg=;
 b=eEBu1XLkDWHfENEUV7ZZqR2odHLqA7ZbMVm8qZowBg+mFJmOQ31tO0tJ0fdydHx+bpTbRgvEB0JAYIReWb4ILHteMtKxUZGJ3x4Ok+dybEbyKFHUhge6NuyzzvjIaGaP3q4zDZxqZASNa0/W8z0TdoolmQyRD9pDn0IhwXtWpts=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 20:32:38 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:32:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Topic: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Index: AQHWCSVL06kuVSKmBEqONSGslHKI9A==
Date:   Fri, 3 Apr 2020 20:32:38 +0000
Message-ID: <BYAPR04MB4965EDFD23CEC6422BE4523A86C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402193052.19935-1-ailiop@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a1ddf8ce-9533-4e6f-b20f-08d7d80e267a
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB4296FC77E8D3B62C5680F0B586C70@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(478600001)(4744005)(55016002)(110136005)(4326008)(54906003)(316002)(186003)(7696005)(66556008)(86362001)(53546011)(33656002)(52536014)(8936002)(66446008)(5660300002)(8676002)(66946007)(66476007)(76116006)(6506007)(81166006)(71200400001)(64756008)(26005)(9686003)(2906002)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c9cpWM3OqsL37p3YwT2vJz2f+IhxoQiidGIaMiVM2xpg0yY833kU8qYpbXKnJEboXw+n9iHk0gU3lXS0gpg5dDQLTMYxNK+PeNGp9LvK9AWc4YBznaLt/AgfbiSsI0jw/PFBShU9BRSdI7K9CrTZiXvwPqDXV5bBLaphzw41hXTnGmSWxiuQ+iZwSABNZhZtiwpuEEBHqceJLtumB/aVM59WDAypXm2PNDqCxM0zgXSEIjeMJLsWjw/hAjHglb+GDPf3BMl2zC3sELrc5wmu4EUeiN1pHc1UrdihPTunJag14g4Zfl1vi6sK9RIaYDCKy/hCAuqgeNp6thHEQy0TF2p46xOmhgvflCOBd9iGNAX/uvUK4honfN4t7IoHFeQepriX3RylDKfE1LMzQg4Qiz1fiJc+qDgo0RkUOt/NG3pCJQVTkOWYmO4rMqHsaqYU
x-ms-exchange-antispam-messagedata: Ko7m3DXITTVB/LAYA5khRsnVSvGApbtrD6CsqUKDH5JGdfSomrKBqPBGpxF/a1RqfZgskaSHGmpPGjZVgxYAFT7Q7QfOdzlDKHssLbXT0j/iPS0Vz2AbBuSXBCaNmLJ+jYAcxdhieTvRC9aheWi96g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ddf8ce-9533-4e6f-b20f-08d7d80e267a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:32:38.2081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Ls3/VWuE3mGVr0U3JfCCRPNLJEGNyA7kuFjktVUMp8vzydGc0AdG+/UsSM1cmGrleU1Ek/YBRs37vNSL5+MbyPtshbMKubBrlyzqaOAjTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:=0A=
> Add support for detecting capacity changes on nvmet blockdev and file=0A=
> backed namespaces. This allows for emulating and testing online resizing=
=0A=
> of nvme devices and filesystems on top.=0A=
>=0A=
> Signed-off-by: Anthony Iliopoulos<ailiop@suse.com>=0A=
> ---=0A=
=0A=
Please ignore my duplicate comments from other, I try not to read=0A=
other's comments before the review.=0A=
