Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9278C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B6B20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 01:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RRcSMSWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDJBcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 21:32:10 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:58179
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbgDJBcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 21:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkW7crIIbhObwEdZUXyd5BaUiLF+sCjp0qc0DA9RV3iQKuqY/c3yr0iKqfH0johChyV7UJ1q8jjDAp6DsMxQwEprI2VwKpLWM25qN3zq1BfLm78/ZsmXZh+NK95D1NO52FHtQiI2oTK8FI3B7D1nZzdBnOCp1NNIefjRLZRwbtvmyYk2QpFgF9Pg7XZ/KFbZdElLk4WdAqHaf1LSWOkdraFd/26FbULDbnCifj/Zg0j9ZagTiCZP4XFrInKCjxPpVgR4BeWW82cZE83K3paablNrrlmz9mD24vPLRhx6Kzd1sQzeO9RV/LURH3MjkpF+uB//4S9j8dNb2Qvsfxn76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BthebZYLasqzsmPBQOfk9TUGY2ED9oEi8m32hPjddKU=;
 b=M6JjLWogLNLYG7KCwP9DcxsYjiSJ6/salfFh1J32fYSR5ErdyKexCrecVaItWIHNpuZf2WkdrLm0XyseqhQk2hOiUg0WJq3kNjFZ7wwt4aVT0pDtUopEqoCkaUOxP1stJCPW7aCXastJYhH9N2HVtSPSGcl6QPwl5vquEMXLl09idcr0u3LgQWiELrGoLEhsxnndHWZIbJQszqhlf9SApAMp0+fbzL3i5TmbMH/h53VuZK6cSJH3po04qt/H69cUM+bshnDAjU8piTKHQ18jsP/w2i6Kuh/elLGXRq29pOewPVvuE8k8skIVAcoQ+C281VejKprPynU+fgJTZInujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BthebZYLasqzsmPBQOfk9TUGY2ED9oEi8m32hPjddKU=;
 b=RRcSMSWqyWBs6bw+MNzezpidR+NqLi6ENvEtxrem7P+Stm0hxPHQhqSRSIzDWmTm5wAIFklDLaKkdlgS5Lcr/FKDZ2KQijOJ9K3lkiLVWbcC1U23F02TMJj9yPLxqfnRxLeAwlwF10Tktpbr8Ci7iukm8uwnF8LT89o87zj7zPc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (2603:10a6:208:70::15)
 by AM0PR04MB4065.eurprd04.prod.outlook.com (2603:10a6:208:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 10 Apr
 2020 01:32:02 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 01:32:02 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 2/2] remoteproc: use filesz as backup when translate memsz
 fail
Thread-Topic: [PATCH 2/2] remoteproc: use filesz as backup when translate
 memsz fail
Thread-Index: AQHWDkktpZBH/gJE+EqHoCmC5/cfIahxkGoAgAACJtA=
Date:   Fri, 10 Apr 2020 01:32:02 +0000
Message-ID: <AM0PR04MB4481B8AA8ADB836ED8398ADF88DE0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1586420572-28353-1-git-send-email-peng.fan@nxp.com>
 <1586420572-28353-2-git-send-email-peng.fan@nxp.com>
 <20200410012226.GV20625@builder.lan>
In-Reply-To: <20200410012226.GV20625@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 89264a48-70b8-43c0-e623-08d7dceef853
x-ms-traffictypediagnostic: AM0PR04MB4065:|AM0PR04MB4065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4065137A53D19C26D0540F5088DE0@AM0PR04MB4065.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4481.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(5660300002)(52536014)(64756008)(66946007)(66446008)(66556008)(66476007)(76116006)(81166007)(71200400001)(478600001)(6506007)(2906002)(7696005)(9686003)(26005)(186003)(55016002)(86362001)(4326008)(316002)(44832011)(8936002)(54906003)(6916009)(81156014)(8676002)(33656002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QEE3ucW9rkJogsmSJ5fQkzmElKMqrVSWNnf/rPoX4ymFtQpsJyUQzTqEudz/KaoWb5IQDxLKbIE47MKwpSPBrFHb7HPbNsogGiApeIf5LNr+h+Ahv5MQwxwuaF5aOGEmlHfAx3943FdmmoWJYLf5hvpckCfqg5r730vsXmamVzat8WV3cidBkLgkPxO5HiNQ56H6gNhUQekTQfv4XnmFCP71jub4cMyPvWDgZvQuNQNATWI55U0WLzjBFSnUrDabYgzyyRIZTpYP54OBkAH4iQUvVq+3gBu8OJtJTcng+J+IvwfyyzRWuI4g1eVvyB+1y2CD9082VMAnXUIZjWlQSDl81PGRPDqTPXBG4+9JG7X6EM0BqQyZQY48isfp9EM/9sJj03pOD/H2QOY55vRoKxeqwZGseGb6plpv/JzbWblBygw3jDpkrWbTkU+Xa5H/
x-ms-exchange-antispam-messagedata: ycywC0YQlNgWSBN2aMc9lh9HDuHQ0GnZxa1MIIbABjvaUMJSEKGF46rXHIYfrtxP2vq4TqTy/G0LlFLqORInXb36QC6ELzNQVDbqz64wUG9LD5Xbu2zc6SVr3CpZpHjbgLQ5R0wF8oGmdeZ7bfQM2w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89264a48-70b8-43c0-e623-08d7dceef853
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 01:32:02.2160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u88Djsx5171xmtmTviOCwOdI6kKGzj3mRmW9GGFyTdsr5FboZNj9hCWe+r7vm2jgEKEp8HDrMgez3MlfhCaqxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

> Subject: Re: [PATCH 2/2] remoteproc: use filesz as backup when translate
> memsz fail
>=20
> On Thu 09 Apr 01:22 PDT 2020, Peng Fan wrote:
>=20
> > Since we no need memset if memsz is larger than filesz, we could use
> > filesz for the da to va translation when memsz translation fail.
> >
>=20
> To me this implies that the firmware has a segment that's larger than the
> memory that it's going to run in. I think even if we're not writing to th=
e entire
> memsz, asking da_to_va for the entire memsz provides a valuable sanity
> check.

da_to_va implies that Linux should have the va map to da. However
that will be case that Linux is not able to touch all da, it only able touc=
h
half. Then Linux should also map all da?

Thanks,
Peng.

>=20
> Regards,
> Bjorn
>=20
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_elf_loader.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_elf_loader.c
> > b/drivers/remoteproc/remoteproc_elf_loader.c
> > index cc50fe70d50c..74d425a4b34c 100644
> > --- a/drivers/remoteproc/remoteproc_elf_loader.c
> > +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> > @@ -229,8 +229,16 @@ int rproc_elf_load_segments(struct rproc *rproc,
> const struct firmware *fw)
> >  		if (!ptr) {
> >  			dev_err(dev, "bad phdr da 0x%llx mem 0x%llx\n", da,
> >  				memsz);
> > -			ret =3D -EINVAL;
> > -			break;
> > +
> > +			ptr =3D rproc_da_to_va(rproc, da, filesz);
> > +			if (!ptr) {
> > +				dev_err(dev,
> > +					"bad phdr da 0x%llx mem 0x%llx\n",
> > +					da, filesz);
> > +				ret =3D -EINVAL;
> > +				break;
> > +			}
> > +
> >  		}
> >
> >  		/* put the segment where the remote processor expects it */
> > --
> > 2.16.4
> >
