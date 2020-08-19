Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88FEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ABEE206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p3VG64vv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cPW1/bNI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgHSJiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:38:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35051 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgHSJik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597829921; x=1629365921;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
  b=p3VG64vvGWOTIPtBW5qDEamv49tGrmK98FfYwXA5K8aeFNBbbG8USuTa
   Y1pvnKroZ7icnD2JRbgCBl4wVLcy+qxg2FoYjsBAM5TVaVyfEaCGrSmId
   +wk2eGArcnldPhjCo6YXwD0CovOpuNIe6EFK6WhYmOGPjp5IvyRR+mkK6
   LuN8P5yb7AYKzijGbRfwg9z4ncPT6cnhpDP7sPOQ/tLEicPPNHajlVQmZ
   yad1/IsW/RehaOzig6pG+F8e7GN841H04vu6v0/4X6EFQrdM11ccqo6mX
   iSL2NAf0M1DQTB/7pkBmkvaLFdYcLx/qEhZE8SB9X6KIti+a6ot5zLmF4
   g==;
IronPort-SDR: bUbJ2iaMIVh2Mjlyq7GyIl4Z+uqOCsDYlfYx39mCQYnJxzb6lZA1IK3Z+Bpj0W8D+37Em4gz79
 SsDNb19DM1a9nz9fC7hbPP4dT1dSDENZ448ezDTeYLojyxiWdxATxgr6GkK7bQ6ow/E5wyJQNy
 l2P3ZUAaA1XrZMYg1/eBHJz/p+mWRpK8hTerJBYgwlnzzr/AGWOMi3XWUmpDSxVzzh6dF0Aomm
 JI4CqlfnOY2N/u6dv4PV/Jucso9TaVWWlP0WOAbUMt2WDcNacEoomA8wMVe2AwCNQw5wz54EDg
 4NA=
X-IronPort-AV: E=Sophos;i="5.76,330,1592841600"; 
   d="scan'208";a="248484596"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 19 Aug 2020 17:38:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejtR9MPLq0LYNZ7yyIxcEBC+vppjKsh+f0tUZV7v6kg6yHunFKvHxdY8fR3XSdPBs1VhdlydmaNE/YkfxSNqplDwehrhvQFeYgPWJjAnyZPwUSJl2I7XLi3vfIfV22Ji34h9UN3+Dz2IZhY8yB4t9E/T93wibeUIbHExlDy7xbq7CCwFYf4uNixfwa7Q2wTwRkN23Y1YtSUB/e3beW4rJStVbLnBACNtzX0H5gL2/J/hdrkXhRMa3MRkn34V6Kr7szZB9kUUEvixFdrFnJYA/5qVaVLSb43+3RcO7oBKVRYxZpdI7sr4qC3+IyKV3cFqW9KWXKYZOcnP4L3ObjN2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
 b=OxFp901yOwy/9fX4PgzDZ05WQkkIbCKFrw4YitEEm9g5BzWIr3LoshUN1z7HDy6L/nC8HBI+LAUYDsXgcC6MW7pqr1IfUDJAmpCUAPpWL57FKxTgBm+CFly+g8I2Rvb43B+1/9B0AAo138urwL4qu/SJaqB9nYThidjgeMaBjovtzt6mzY56fKNK0jfM84q+qLiOjPQfM9MNsg3HNYCbXeuPNYXYH0z5DTUFTounjSo0k1z+o3uDz5L6mVR4cNnHYRnaN1wMo6DBb0TKObr33UgpfDrJ1wemc2JP0l58pcMj47thWRbK05v/aahJ0hZcH3esXZBIpa8ZtsYi+k0pUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUMgYPrZncmTGmmiQJesWkdRcuh2Ky62n4lwlGknIAw=;
 b=cPW1/bNIFwB9rQI2XpT0PggsS3+12Z2g8YrSiv5c3QblQBA/++WRiH8VnZEFecZhoIWQgkB5D9gIaIGr9t57FlehAmvIFrMFJloHQN54ZZhjVWGfyCWUHmHpWq015mA4zNL2RqfiW2tuR6BvTi8PspmDAW4wyduJwjVs78HCVU0=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0246.namprd04.prod.outlook.com (2603:10b6:903:38::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 19 Aug
 2020 09:38:36 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3283.028; Wed, 19 Aug
 2020 09:38:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>, Christoph Hellwig <hch@lst.de>
CC:     Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Topic: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Thread-Index: AQHWdSEIMmCxi6h3l0CfpdyAr+vLMA==
Date:   Wed, 19 Aug 2020 09:38:36 +0000
Message-ID: <CY4PR04MB375148979AA403CF47EADE0BE75D0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
 <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 263465a4-c7b6-4df8-5ce7-08d84423a5b7
x-ms-traffictypediagnostic: CY4PR04MB0246:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB0246F739F8469AFF85C04C86E75D0@CY4PR04MB0246.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQUssL9EGbKO+fAu6zU4QjfL+yx6wHNr7kDcbN67rz5wDBQCzwPCpZ3+XUiDeuGpG1h7YucmOZ8UYMwv+k+rsceLLvjlo8JfUcH2hf2nIaYh9gxI/Xy5smAad0CaxD5+3jsWxeg0TbaVRkwZo62Kw+bRXfG7yr2rwA885HcaTCTvkvAsOzrOy1bm/Wy+heWh9n84s7kJEJ5uJK8F3eYRHrRLmoEXNOlQCSiIChavK02mhGqYqlNZj2OXcsZwdYAH2xOSMlzLs5UzzcuwxXnlhcO2hMrJYIH70cNbquFObMBmFY6YAYCDPoA/jCvCYUPSotIK9N+2nUP14ez3wRh/vQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(9686003)(55016002)(76116006)(91956017)(5660300002)(52536014)(64756008)(66446008)(66556008)(66476007)(66946007)(8676002)(86362001)(478600001)(33656002)(4326008)(2906002)(8936002)(71200400001)(186003)(110136005)(54906003)(83380400001)(7696005)(316002)(6506007)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Qh4nAqWeMSp1NQ8d4JcOxvqQTdDmPEoEuQ4a9EOr95ien61CnbKlrjd+fXsocNP3qLDyH8fe3G0VQLAK8dQVylN+yK/JF8fdyC8OnwcQo4cI6+IeGvATtPgX6OkeOO+ih2y+dFPCcMI3B69xkKC/WUnWYsWKIOMpnYb88xAAQLNW8OZvQxOIE7TdSRuwTsn28nPPM40/ne+8h9TYAOyE0OR0aKPOd+CGGLu19snZkzqhxGKu4xkdEps0jqv4U0BaABNEozUgOLVHTmJYkYD4aRvDlHXi15fQhQpLZuWLk5xl0wKNzpjRJjg58hMFJAePR6JG6IKoG1tm8m5WXSwsAIUFYfWcxsz6ya6nMlgzI1lQNlhn05xoFZpjBkSV7nRaE89QosCTxxVMyoUljZ2WllKOxypWCZrWx3gkgkQnI7kIttviqyMD005cIRS2nCANObaYBc30eU8ub5bhYHiIOd6BPaVXOkqu7u+U0vv9y9mc39q0qq28NVm/e3tv3QT1H83D5ColK5ryWl2b/sDhah2G27k7Y38YvofYEXrGp67QoA0hhFnOfxwoC4HlkjiLRVPBJ8QGj3eTKDI+XKeH+X+RNnnzes5FZBsZcKe4/thlWaMAQZ/zWz2G68uAEfnEkbcSGIQuvJIxRdXWwKdnmw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 263465a4-c7b6-4df8-5ce7-08d84423a5b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 09:38:36.6147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoZTIqluihwIyNrt6yn6pUMYkOGsFB4wf+8BPTTSJ8ZELiVzGEJ1rR9Dr0ljVpu6aNhJYesKA3JXyo4gzyyKLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0246
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/08/19 18:27, Kanchan Joshi wrote:=0A=
> On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:=0A=
>>=0A=
>> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:=0A=
>>> Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.=0A=
>>=0A=
>> No, it is not.=0A=
> =0A=
> Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?=
=0A=
> I see that null-block zoned and SCSI-ZBC both set this requirement. I=0A=
> wonder how it became different for NVMe.=0A=
=0A=
It is not required for an NVMe ZNS drive that has zone append native suppor=
t.=0A=
zonefs and upcoming btrfs do not use regular writes, removing the requireme=
nt=0A=
for zone write locking.=0A=
=0A=
In the context of your patch series, ELEVATOR_F_ZBD_SEQ_WRITE should be set=
 only=0A=
and only if the drive does not have native zone append support. And even in=
 that=0A=
case, since for an emulated zone append the zone write lock is taken and=0A=
released by the emulation driver itself, ELEVATOR_F_ZBD_SEQ_WRITE is requir=
ed=0A=
only if the user will also be issuing regular writes at high QD. And that i=
s=0A=
trivially controllable by the user by simply setting the drive elevator to=
=0A=
mq-deadline. Conclusion: setting ELEVATOR_F_ZBD_SEQ_WRITE is not needed.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
