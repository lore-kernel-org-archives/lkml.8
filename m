Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31934C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC69C206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Si1c3H/c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Skudzonv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgDCUX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:23:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:35360 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585945437; x=1617481437;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+6yBOTqUG3YgkG19QszLign4dTsPY2z0u9rhGPgELcw=;
  b=Si1c3H/ciMesgUzCSxaKHCg9ehBBIjdePMxYn8dX70I754l3hmtHYxxp
   sX5ta82KjzegA81unmoPnJDr3NAsZXefKlJC1c59mdBVpnag/vzgDjCqw
   nkZcpl7qSGXuwK8s++fgIHqR6PloqihR0zOVOpunAp3J1bYWXRQJ5JNtP
   7JaGddSoyRdFLJCTAAHLeV2cm5BSELqnBk2oxbBXerganjEDPic62CbU/
   bl9jnJfrFMeV0rxylQ4/gWUMUzemu7Q9CssHf1U3Fndwxu70vfEBSGVm5
   rNO/UkzGTMgs/2JhI4QPH//BVcWgbxYpkM8LM1hg+8Jkrjb+08ahz3N4r
   Q==;
IronPort-SDR: SQgmhj96AvSH1WgVm4SU8TtMw98WvrPSpMCWlLDv2pMghWq51l34KiXfqpGWYY8f69Mto5VEXX
 U2EWa3El56YobtkTfi02DoLZ9CQtkegcS+y904R1Djk71vdK+RWcEt8tNFzP3HZIWVMHkttvWJ
 v/JQ2HWD0TAOwoMC6uPuoPNxSc4UEQtchRiD9X0QLl/rDFziyp2g1F4pCW6wfnXLtSZvEMEEkQ
 0ZsdAkY6orV5fWK0QDIYBYYryo8tUIhdqyHjw65POVDqpKCOkFn0AT0hHC7NyUFUAOyIWXql4Z
 QCI=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; 
   d="scan'208";a="134854242"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:23:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huUoV4CaLqbKnBos+acl+hb7c6tm9kieKYzAuceivUTiSRTlVM6KUUnAU+73n0NyaeVLwI77x/VfVTardSbWYcwEx9uYDa+YIyFCnbqmAkVMFUn0JbEJ39MsQtmY4CT4O4zUKMBZsxChkwAPbdDYdd3Qu6pzlBUqlE9NXND/5a0XOqTgi8j7X17cZISIE0UN+waN1pYxaliFm9CVMcWFB9QKrP3dz2RIUkkojkDYJi52qz1r+5/+ElyiQ7l/LVUWFpKGkHAI/pPW+V+vYxPXfTP53qHRe45ptQpE++VSSa51hxiBXbx7Rf6v+HqJeoNkzJpv9eGkQ/NVkEQstJOHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLDQYu5AJwZw1qfu0XPaiqAJg1wkmZ0H0UuGsLgopDE=;
 b=f0iBEj7GGUVclcsSpVYidKVOQT4lCWJGRei9c7SGeEZmhzswR3wZU2ETrHaWUAcj9BOfa6mTPgx2SyTKCJf3ieLQeDlcvRzL9zGMjrnVVBs6YcALHKebQP+4ntTevxEcv7eoT1CeJAVLsDEhsizk7xHRoLY3eDlY1nxIHrQ/RUDWmvhYGt0eQGbYHNFwpOziBhoyjpImY9wfrh3gEby5NWQwdpP0EdmEZ/Z1pEZNOaDMYfbxqw08U1rWL708w+utMJmsmNZTrEG8h1jAwDHhl7ii46TFzhN1NtLSagYKXY3an5VlGJeN9f6jtDTPj3r6LJzbduWL0K3shNbXtLLR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLDQYu5AJwZw1qfu0XPaiqAJg1wkmZ0H0UuGsLgopDE=;
 b=Skudzonvf7UpDYUt+8XrfvYhOLwRFE2gUUbj98I/NYFUpHmOTvJAMXkQkMfIN0czKLfS2kbTUbnbnQr69BZDhM1+G9RCi0PCzZRmokJI3ai+MYu7OUMS4BgOBnCEoef3GYnUHCIjvHt5ok0fNjYWAlpP0SOQV7ZjC3A+LUsu6vU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4040.namprd04.prod.outlook.com (2603:10b6:a02:ac::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 20:23:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:23:53 +0000
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
Date:   Fri, 3 Apr 2020 20:23:53 +0000
Message-ID: <BYAPR04MB49652594CD66C48E2F6996F086C70@BYAPR04MB4965.namprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 339cf102-52d7-4974-91d8-08d7d80cedbe
x-ms-traffictypediagnostic: BYAPR04MB4040:
x-microsoft-antispam-prvs: <BYAPR04MB4040F9B911BE25A787EA753C86C70@BYAPR04MB4040.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(5660300002)(4326008)(9686003)(55016002)(81156014)(26005)(71200400001)(33656002)(4744005)(186003)(8936002)(8676002)(110136005)(54906003)(86362001)(81166006)(52536014)(66946007)(478600001)(66476007)(66556008)(64756008)(66446008)(7696005)(76116006)(316002)(53546011)(6506007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eB6WATlimWSptODnx2BoFDV/tUBE5D6L1Rg0+63vpFPd/kiNERinoyz6bmXFxEOyIWMQfjRqXTb69CmJvAdp3SpD9psAcLe6u4WNHOQQnm/EwSlQPevStW64nqtZtETTj8Gtrg1xxB8iX/qmZA9vIURevNW2rKG9Dfl/a7hsFWdS9/9EF+50H1nCGVllz6vSh5nLpOXsrdiPOGt3L0UqG5DMNZXZfgNcZ0+HTn7T0c82mwlvi+pqOEXEQdC+cUCwtCRnaq9HzYJvaLfcm4B4SWv+d5qKYDVk6KnCAJjJigtO7Nn/+iDC1OTUJ4jhV3IwsSmZNK2A6HLzIfxcbz0dH9xDwnoWhisqe+uC3tWVCJqojJyb93mmuLnZVJpCt54FJIk0LeNx9IDFJzwS9tPTdRibjZsR685mGWqdVtLg3cz1zi2mHacANmpBm2I6gI8t
x-ms-exchange-antispam-messagedata: e4jFnJ3LGmU9wbaEUiwTVTUa6MPQt21ghJQQgrqIV3MBnquKFmZALMQeYLWck7AeItnKXdutd4etP6e0wjI31642Kvq5BB3by3yVc8QGnjkJhQe0L+duMcVAGP8U1m2s2P88TRs2aFwa7OtrnQZw2A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339cf102-52d7-4974-91d8-08d7d80cedbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:23:53.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8rWAhaekCxGJVym9qt6rJJNcrACaalGY/piNip4WA9p719wrvqKMbG6S7oGAkXOeYv6AHI7fJBgfL3gKCw6pVoAAJoEB62PuwL4oBQTtSBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:=0A=
> +void nvmet_bdev_ns_revalidate(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	loff_t size;=0A=
> +=0A=
> +	size =3D i_size_read(ns->bdev->bd_inode);=0A=
> +=0A=
> +	if (ns->size !=3D size)=0A=
> +		ns->size =3D size;=0A=
=0A=
How about following one line which is still readable ?=0A=
=0A=
ns->size =3D i_size_read(ns->bdev->bd_inode);=0A=
=0A=
> +}=0A=
> +=0A=
=0A=
