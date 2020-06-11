Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F42C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D799220656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="baPlItRo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lvb/wg1q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgFKW4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:56:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:35854 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgFKW4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591916205; x=1623452205;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5EOYsciQAwzIaqmJ1n2b6PlqnxPig37qLDW5/8YHWg8=;
  b=baPlItRoHLOJ8VopzrItYRwTQaY3dchC0v2x00RIZiv3EdTgIXcF31Fe
   V0BALp83IzzN9aH7uWNR0yS6Y5vASX3LsiBoREaO5uSqAONhxSxC3WTir
   74zffNa+AKq+pJY1XNdd1ZSZQM5Ua7iqoEnKVnPuAaiAY/IeO56WIuQUA
   Q08FqK2xDxGrVktRli8NDsAyHSF6hgWoldCJIqlT7XkRj7MHuU+X6gm/H
   Zc1jGpiIz8DwE22KogIfmTVsHjFXW/VK7/vesYDpLnDWHGDss+xE/jMB0
   kBshatIDLPbkW7unRq9MOVcS0qqfWVRhp28rX6NUQKsQs50RPaboDR3Ki
   Q==;
IronPort-SDR: ccP+5hwTWFsCo9sCoDjZBP+SjICszFTMuWevMBd8uPr6bdS0PFdyKfEjBLMP7Ci3zmee1mIaJ5
 k6viuFGp8LB2FZqtB8gh9pzHh34fLBvFVDLSaWypEWtowMv7+UZbhv2/sjkYMzfYN3XSwXIIhk
 iv62uk7gOjLG8FzBio24+NMECAdsfHCSWV1GgcWJJdymTCXdfsVQMIfXIOmMWULg33E0cghaPP
 DLmGl9uzZKp4e/tp1d3WRo3u5CGOLjEBTHIVEMfD4dj9GTYNH/o5Ak6X5ZRySkycxwTXRp+e92
 QAw=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="144099693"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 06:56:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODv7ZfYTqheRQdLCc9pGjIcY27PoLgcrojr4vqvmax9Ju7bqMtRYJXek2lq899kwRNLzn7pdO8WsoCjBTTTN1DtjlPXhzrtJAroYL5Du2MV2iBbuPFqTH+yFUtfZaYM3L1niWEO4hqnO1OyrHU6i0ky1VU76N4lnOfLnCFJtLWDv/D+mK0KDwKx6DuHfD2ydOW7G0XMTfHT24PnrnLmUzaOVZ9pzao7rpTqh7XF+GkhuVw3kv9B5KfIIQQGNtzv3FmL7V2MDMJHXUDiMqjZkHPHjoAa+//cUiGSdQoxHtxYOO5k7Gh7ZPCmqbLsA/6WTkOKqnoidUYpdnuKWia1QMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx8bAATdo1EjNtaPCc0wc478l7PrOpaJyZbRnpHrGM0=;
 b=AlEtzqafvnANY9Wz/ghFrKjPI70/bN4+peM8gN8aP7Kq4tzp1ZYHFLVvsXAgWE3s4Uayrd+1OllFGTpXn8CpVOP8BbtMCnbpOTPX/NmeAkFcXpGSZ0CgRgeGcfZUVe6gaMpln5cHr0JO+wTbrz+vPVGqyLJqNLsnl5t+7YgDBhe6ugp0G2nGvH+twvPR1BZv32DifF5r53T4bDZ32eFkjOFZf6FYn4DdjQlTiOdA9Ez4qpHPkP+7rVM5WKIVO/2x3Cd55eygeFWxKZjihbidANjn77CSnIKZDvjYiFD3eU1XEtoGClIVepus7Hr74dqcbLHCtg5lRp5vg72LpPHYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gx8bAATdo1EjNtaPCc0wc478l7PrOpaJyZbRnpHrGM0=;
 b=lvb/wg1qxPrD0RxKRDZk0voGLkIFXfq7ebvfamsKAktYQY1cv3dt2r5VzgsJ6nRA9shCyxoOYQMg4gfQggM7U3uPAp1XmYK0ZvNfZUTRAFRRzA/CsdDRtgP9la/N7h7YqP/t2445+mcc7b32N7108onlTRtkEDEvWj5QdswqXuc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Thu, 11 Jun
 2020 22:56:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 22:56:42 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 2/9] nvme: Create helper function to obtain command
 effects
Thread-Topic: [PATCH v13 2/9] nvme: Create helper function to obtain command
 effects
Thread-Index: AQHWKhRkkBYMhr4OK0y6kDVy5Q4NnQ==
Date:   Thu, 11 Jun 2020 22:56:42 +0000
Message-ID: <BYAPR04MB49658F968DC104E99B5C923286800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-3-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c9f43330-309f-4889-c8c2-08d80e5ab55e
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-microsoft-antispam-prvs: <BY5PR04MB6884F34F72BECFAFE8D8154386800@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vSTDmaKhRlt0W9vjPaR33wp78JTljIAtDk15LQ2Z1o7+lWUzwVVRKCtxSs/6AZa+M1rTiyTUguzglp3xJMVSN6D2h0k7vTuLCDyVEMPeZApX0ro9NQG8Zl9KYLP/NkYzYxlUENQ1Os60abHLG7twUnrmK9cwnYNOsbcTLgm4HSJOt3fV79sHoyRn1HfI6d3sYbh6ETyz8+TKLVNbh/tLMRZzIbwPB/muQUwR5ve0JjhjxKjIu+3mVpy7Ym41R+3cJzx1VaLKgF73fQe43Y8Bi7sfhPpgKRJU6xwRu3XtD5ZQkZQsw1VAMcb8QCQWcX30DBk3g4k4AdBVP4N95N4GJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(478600001)(316002)(110136005)(186003)(26005)(6506007)(53546011)(7696005)(4326008)(83380400001)(33656002)(71200400001)(5660300002)(52536014)(76116006)(66556008)(55016002)(66946007)(8676002)(8936002)(66476007)(86362001)(9686003)(2906002)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uG22U/WforE1YCuFUModoJKQKu3v05pYSXegP5cDYJFZDCu8w5igl2IU9Zh5MsDDS/UVwBz06Y+U6GXQ1HnOzMQiSFWyL8sc0+spApDpRgyZ3UDm32V55zaHtxZitGZkYWHZfv/aPIGoJecHZ6XhJ6MxKOXDtQUs8NCu3bKiEbD47klJpI3QuV+Y9Dp9NYoO0S8cAtOU+SU2wTTL9xUYm7Mq+5YCJ1EAVFu+8oDzd9S+CFj3CMEjrII8xyqmJFG9VLF9VzGe9wRWx+exg0gNkf+Bnh6E+NyOfrmoTsBBZhrPNFiaCspepWoh0yZpQSLk9CumDah0PNienvP3bG1mrEhKVeJped5eJ7UMvdm6/ZDedO6RbqrPEYBdrXt0AN2eorY8OkF4/870zAz4w7/BH0GHqhJk0/TCWyWEMs4RPEkfM+0PEyy7PBqvjuw2S5CYkmr0GRaocj3+sc/u4MkcmkK9Ubm85VwnurepRTJgF+M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f43330-309f-4889-c8c2-08d80e5ab55e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 22:56:42.4639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQGZKOfuTgV4V9TZuaJBKUjtjSoKkVQI4PYZLthydxLQvOoHz4IeEjrlwBN0XCNZrUmZz4OHK0KUX3j/448w8KQTMAaXJdRh57Wzzedgdkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:=0A=
> Separate the code to obtain command effects from the code=0A=
> to start a passthru request and open code nvme_known_admin_effects()=0A=
> in the new helper.=0A=
> =0A=
> The new helper function will be necessary for nvmet passthru=0A=
> code to determine if we need to change out of interrupt context=0A=
> to handle the effects.=0A=
> =0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 39 ++++++++++++++++++++++-----------------=
=0A=
>   1 file changed, 22 insertions(+), 17 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index d22859543e4b..5062a83c3634 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -1317,22 +1317,8 @@ static int nvme_submit_io(struct nvme_ns *ns, stru=
ct nvme_user_io __user *uio)=0A=
>   			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);=0A=
>   }=0A=
>   =0A=
> -static u32 nvme_known_admin_effects(u8 opcode)=0A=
> -{=0A=
> -	switch (opcode) {=0A=
> -	case nvme_admin_format_nvm:=0A=
> -		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |=0A=
> -					NVME_CMD_EFFECTS_CSE_MASK;=0A=
> -	case nvme_admin_sanitize_nvm:=0A=
> -		return NVME_CMD_EFFECTS_CSE_MASK;=0A=
> -	default:=0A=
> -		break;=0A=
> -	}=0A=
> -	return 0;=0A=
> -}=0A=
> -=0A=
> -static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *n=
s,=0A=
> -								u8 opcode)=0A=
> +static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *=
ns,=0A=
> +				u8 opcode)=0A=
>   {=0A=
>   	u32 effects =3D 0;=0A=
>   =0A=
> @@ -1348,7 +1334,26 @@ static u32 nvme_passthru_start(struct nvme_ctrl *c=
trl, struct nvme_ns *ns,=0A=
>   =0A=
>   	if (ctrl->effects)=0A=
>   		effects =3D le32_to_cpu(ctrl->effects->acs[opcode]);=0A=
> -	effects |=3D nvme_known_admin_effects(opcode);=0A=
> +=0A=
> +	switch (opcode) {=0A=
> +	case nvme_admin_format_nvm:=0A=
> +		effects |=3D NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |=0A=
> +			NVME_CMD_EFFECTS_CSE_MASK;=0A=
> +		break;=0A=
> +	case nvme_admin_sanitize_nvm:=0A=
> +		effects |=3D NVME_CMD_EFFECTS_CSE_MASK;=0A=
> +		break;=0A=
> +	default:=0A=
> +		break;=0A=
> +	}=0A=
> +=0A=
> +	return effects;=0A=
> +}=0A=
> +=0A=
> +static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *n=
s,=0A=
> +			       u8 opcode)=0A=
> +{=0A=
> +	u32 effects =3D nvme_command_effects(ctrl, ns, opcode);=0A=
>   =0A=
>   	/*=0A=
>   	 * For simplicity, IO to all namespaces is quiesced even if the comman=
d=0A=
> =0A=
=0A=
Seems like you have changed the existing function body from=0A=
returning from switch to returning at the end of the function along with=0A=
the name that is why diff is large, which also adds an extra variable =0A=
named "effect".=0A=
=0A=
How about following ? which keeps the diff small and removes the extra =0A=
variable and keeps the existing code as it.=0A=
=0A=
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
index 78fc38b8356f..f47013fdc5ee 100644=0A=
--- a/drivers/nvme/host/core.c=0A=
+++ b/drivers/nvme/host/core.c=0A=
@@ -1326,7 +1326,8 @@ static int nvme_submit_io(struct nvme_ns *ns, =0A=
struct nvme_user_io __user *uio)=0A=
                         metadata, meta_len, lower_32_bits(io.slba), =0A=
NULL, 0);=0A=
  }=0A=
=0A=
-static u32 nvme_known_admin_effects(u8 opcode)=0A=
+static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns=
,=0A=
+                               u8 opcode)=0A=
  {=0A=
         switch (opcode) {=0A=
         case nvme_admin_format_nvm:=0A=
@@ -1343,7 +1344,7 @@ static u32 nvme_known_admin_effects(u8 opcode)=0A=
  static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns=
,=0A=
                                                                 u8 opcode)=
=0A=
  {=0A=
-       u32 effects =3D 0;=0A=
+       u32 effects =3D nvme_command_effects(ctrl, ns, opcode);=0A=
=0A=
         if (ns) {=0A=
                 if (ctrl->effects)=0A=
@@ -1357,7 +1358,6 @@ static u32 nvme_passthru_start(struct nvme_ctrl =0A=
*ctrl, struct nvme_ns *ns,=0A=
=0A=
         if (ctrl->effects)=0A=
                 effects =3D le32_to_cpu(ctrl->effects->acs[opcode]);=0A=
-       effects |=3D nvme_known_admin_effects(opcode);=0A=
=0A=
         /*=0A=
          * For simplicity, IO to all namespaces is quiesced even if the =
=0A=
command=0A=
-- =0A=
2.22.1=0A=
