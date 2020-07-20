Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBCA208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 21:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rBtZ/URd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oBmQS4Tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGTV6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 17:58:40 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32779 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 17:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595282319; x=1626818319;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=45dWPGxVKj5CeUsx8GRPCPcqJSQ4hOGmZ2+CaHH+JPY=;
  b=rBtZ/URdIoWEPlNIpgt6Ej4VMv/TH2OmrlBCJaIltdxykWTuVTsMdNxE
   8nG4L18KKgu7wZsNKS4D/pvmFGzWNqirraY5Aq1/dWp1FhXaWxbMmTv9g
   A1woOAmRmNch+Lm/fH9ZSk2YBH+toVcgu7yLr9WrvKxsop19iy7xdWTI8
   uCVKawb9IKBxWOJekDS8YFcBDd7idvkw34Di+UyvKiQXX8zNi/CYpf64H
   NeLvQJi4pN47/FwEZuksKYLdVKtQ1TEn/WkeYjlSh3kmfrsL0y1Ir9M8U
   OFsI9FMnI7ixm7YVvG9H5xEO74C+pcXSNHUem+njEAt5Aa71dcGsktmta
   w==;
IronPort-SDR: Wgd3wbnyVO27AwQAmYOUlZr66JtXUrmiIA+gM9K3UgDRDEmeRnZqiNxZIwX1pAysXksb5t0Pml
 BwXFLGAlavSHAv3Q6EoDf6NPgwS6v3QUXfQVDW1teo9xT6fkgH5e2DI0s8mPnZTgm4lWU9ULzq
 7Uj6qf9ps3+BQGcJb5lNATTcNyoFLv3S8kk981EY2+pPPUEsG40mB+eIkitkzR+6WlrSMdOaHb
 LH928S2aEYFFCtOPms97q9CvY8H6IAuUoYm+I8tKsgBq4hOmSLxeLAe4cAY7gRHmGXlGxVhcur
 ihk=
X-IronPort-AV: E=Sophos;i="5.75,375,1589212800"; 
   d="scan'208";a="142957049"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2020 05:58:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XTUsPh9OEFxQoRXZsbsw48QZp62W41cqAvIYQlaiYahm0KfCgI5tORj2Vn7djT6RCIMQ3z17Mx7NYZv+ZdBSl9lzNTVcmsWVZo+OOqgvL7GaGHupt0PeYRBic6oz4V/aobxpd/GgBafhL5sBpJ43mMVKX0spZo5yoDjXH17GkA116tE1WhBHfWr5J1osg3uGBK779ZxLjR59xBKMhFkVncUbbtb6sN+DBnyNN/P56oU+H+l+F87+bwHJSAcY0+hDC4a1s7/OwHm6Zexf5H/Se/+8YDN6G/dqBwyxgWB0StfU8sXmA3m6jbRSEy44UdsbZC3smWXiBl4+6OIwIRJuww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45dWPGxVKj5CeUsx8GRPCPcqJSQ4hOGmZ2+CaHH+JPY=;
 b=HvF9a7wGfm2twjOr96LT9OZK3hWtzWj1x3dIuShW9g/S2TnZSLqc5NeTnn/+vje6gLfnhqTgM3jGBBEspionT49o7q86IqPxcaQsrZHP6IRZDHIvW5vnf9WoO5aQUCgxbaT65HF+zfnOXyNuCcZmfXZojiluESXRD+1GzPu6/NodhDP4hW0wjgOP+mCzhFY1Nre8jnTzyxcjVGWEeWbUyQiBKp21Z323mSRTgWSgf1c7Jd+z5fErdiTJt+NH+zto2vHDAihPcPidJ7d/jaiNbnCVarGGZvHcm+TvqSOMclc/YpkdRwSYq+0pyzHeaEbDhiEmaIn8adpERah4epN+rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45dWPGxVKj5CeUsx8GRPCPcqJSQ4hOGmZ2+CaHH+JPY=;
 b=oBmQS4TfMNS4BFGSFyenHq9gkBX7AKTqFZgmIiP+eNj07XIAL8NL7Hoe2opUy7YEVRiYOTP/bTDOREX5K9NMN/EojFj2t848mqaLeNOm/CifD2XYeJnzcfvZXwOn2ZksIGRfmxnU8oEWBqRzqsq0c6Us9E03fph8KDqyra7ZDZ8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3861.namprd04.prod.outlook.com (2603:10b6:a02:ac::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Mon, 20 Jul
 2020 21:58:29 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 21:58:29 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Topic: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Index: AQHWW7Bs3rS14btVx0e0NQ0AiEjaXQ==
Date:   Mon, 20 Jul 2020 21:58:29 +0000
Message-ID: <BYAPR04MB4965E4374C4A99F326507A88867B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fc5a610-276b-433f-2423-08d82cf809a5
x-ms-traffictypediagnostic: BYAPR04MB3861:
x-microsoft-antispam-prvs: <BYAPR04MB386198FC620D47F5ABF1CFC0867B0@BYAPR04MB3861.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Adh52lO7BWuTC0+1+T965zdIQ0RBJdBj3trxrNNMTezC8fFOybXFLJYSGwWeF1uZTVo+G8EzAX8QsZ7gUV30QvrUeh+OoGeR4upZhbsJ1iWO1x6hVLGSH37ocqh0O7/SehnYSp4AimL3lsYwYIjHE/fxsF/ksQ6Oq1SdnPZn5LuWWwcTJGwf9g+uUHNw+oo+gqjU8srYyOf9bdKDsREsX2jy1tfnI3MhXxao5PFyeyBH26b4ck4B5UrQK7TLjVaSPTMfMdumXdSdqgpCFKZ+uv4BaXtWCQct7kSgHoz+BrxxV2CLn7jaVmFkswGRBvWl0xyNuTvo3o4t9e2TdqwqbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(346002)(39860400002)(366004)(136003)(7696005)(8936002)(66946007)(71200400001)(4744005)(4326008)(55016002)(9686003)(33656002)(66556008)(66446008)(76116006)(86362001)(316002)(5660300002)(2906002)(8676002)(64756008)(6916009)(186003)(66476007)(6506007)(53546011)(52536014)(478600001)(54906003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ARnRtBDA/SfUYVALMbwzVpAwEHYfd5YccC1pKIbPwC5fUe5aNj9VYqMhowa00BGwgB77Zd0QOyCZp4t5cJvoyPs78vr4KbN68TbQTYmWDC1umkaJB1Qpqv6/j5cjEtPtVUMeleWFzX94T4OprDuhqH4n1ckUBGMH2lIJSm+EtxTcTRBX4VsFcmUNSOuRXlS+KhZ2yZ2RdK0eAop8RmLWtwJ/OtHGDLtmkBq/sXUDhr6ELt83P5lQNSpX2FMEJ62sLkH6JJfl+EX1Vs6WXePRuLNdweTAgpnmnhvOb4K3ZXRdailVtvsHIGnHjM2T1qSgEvfCq/g3M9rx/Gt63WBznzMPr74ZA0d55bHQTewCiweZ/6PTw+l2lYeInW+zEfVUKlN/bHM3ZpbYVwUx4QBmwNaJarARlq8Cg9IeNS/i/5u7ULp6ukFngz1ibrTg1M3b/1K065Fbx+7et78lRwpz0lScdKbdo/ZmPLybjZiek7s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc5a610-276b-433f-2423-08d82cf809a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 21:58:29.6315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBs5w+BJi8Sa/h/AECz5ctPtjhuJW9ZWMGV3qZRFoj1XexiaIcIm/s73BokpgQkSauSZI8L/mkSPl6lD4KYGBhye1OUFWlXeFuRDnAGXZwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3861
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/20 14:41, Logan Gunthorpe wrote:=0A=
>> That is a neat idea! should be easy to do (and we can then lose the host=
=0A=
>> xarray stuff). I don't mind having it on a later patch, but it should be=
=0A=
>> easy enough to do even before...=0A=
>>=0A=
> I sort of follow this. I can try to work something up but it will=0A=
> probably take me a few iterations to get it to where you want it. So,=0A=
> roughly, we'd create a passthrough_q in core with the controller's IO=0A=
> tagset and then cleanup the fabrics hosts to use that instead of each=0A=
> independently creating their connect_q?=0A=
> =0A=
> Though, I don't understand how this relates to the host xarray stuff=0A=
> that Sagi mentioned...=0A=
=0A=
I didn't understand it either how having a passthru q can get rid of the=0A=
struct nvme_ns search when nsid is embedded in the nvme_cmd in=0A=
the I/O path ?=0A=
=0A=
Sagi can you please explain ?=0A=
