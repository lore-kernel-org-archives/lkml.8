Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB96C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD2712184D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mg3AZMB4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XCaVo5Yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGMX6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:58:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:5394 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGMX6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594684701; x=1626220701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HAJsM7p3yWWbZecr/YgR+Y7RjgEW/A+Q1KqtkulViMo=;
  b=mg3AZMB4fQ2jltNEy/3MacZO8VkvWfSiPW9BCh5BeOSdFrTVGan71DuQ
   gGhbWRBL17b03Q96VKFJjcr7rW3v/Qkj4pP8x7xeiXbdIrgN67DBQoXPJ
   OIbTjYyxGxMOKETUy6CFdbi9IBy/K/h3TT0f5wAQjLwpObv860DDIBQml
   zDJxtq19fOq71F8bN2cUhHmUQNFWiydfbFchx9ScNK4OLd6vZwCcpMuHq
   BWT6uRZOHIuV4QU8TvDHnY48AskrLXcK69wJRMrUlfWnVFYiBQi+oWjFf
   bJEixzNeV2oFWo5Qajt7ED8+3kWoK0mKccTJrmvG1Jtp8AP38kd4ALcyH
   g==;
IronPort-SDR: +zgTvq1jYazdqFL9i4YBdxgh1Bog+uJb3Oysxn8mUxCgtxI2U4lYQLHuxlS+j9polN7UKhTKNY
 MkWPBDkw2b5LXfCqz+lMC7CmLALGLWvj1MCpe9LlsjCcZlwTyH2JqSWjphkjIn68ZxlCcCgjE2
 up710bLSleEtgYPVFOzHP9NxF63/2Dvd+P1mx1r9L5Vj6F0CoCTVuQcsvJ8E7h2W3/Nkwwjjgh
 lyu9aBdJkVhTErWD2cCytqDty9qVT9IyxaJnBwOSHlpbYFFpjdGYoJQ/sWxKf/sDtmUK3v3DyK
 /zs=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; 
   d="scan'208";a="142509185"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 07:58:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAStohHlD1tNhrAkEyCEQIonqlU1CNdN2+6e9QG1wA11+Q/3khaVUoR6ZDhiirflWf7L+vEeuX4hVEUE6boHrk/2yOJ5hs/3mbkx5ULfOlHJ5TGEX1LHhmI6boKmXavNkF27LEOMMWxC/HebtNdxbgA5qo3uGniHH+mclSPQf5MaVQ2TBKBO1hYES778X0b2MQUlmtLyQhCmaasFsj2gIGeTHQ6hrhWu22+vdL5DaADIILVFz7C0sPBGrAYN2vB7qM80x1g6BTbZG5qRwk3KX+vAOJeH+OzO13h0RjIwTkpgdA5krz0eoG+Xpenw+diHSSnKEx95/AXfjdM/bopuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InDBfV4kQvJs7Jw4ECirMpO9f0ffhZxguX/LQAjAgSA=;
 b=h+A2H+UGFSPWnYGp8B8gbnllP+I09pgctbB8MuF2FmKlN0CUvrtozmtCT5iz01YSI/leilXGUTHFq11fu5Dg/3SLc1bOKxIWfPz1NGXzQY5wVd+XPRb540brvuTI4zSrhExNwHJtHi/pEvFzRSMQeyp+u4J9/Vncn4II1KhqANQaSPUfmZxGiGOxezbW64PxtpmIMciIoxBSmgjwNh4kecX7sr4WNVefHLLMpUobNWxav/feq7iUxzMo/mIWRiqLknh1gulB4oUad/4HEC1cVmKnj/Iut5EfoUGMTlLNUygaxKQxhhOpkERfK9JD7ryINwbitezxcMWVL+GcaDtRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InDBfV4kQvJs7Jw4ECirMpO9f0ffhZxguX/LQAjAgSA=;
 b=XCaVo5YkhxhzIdV8TzDEINpg+UzoJ4euLHHkg6hVdlUPdQqmpO0yEL2QZijtuIRnBnvGSZhsiSlr/wUPCxwbjWdAs9g4XwRIczr2k3sMTUmEBfTnwhiW9LWW+PFdNC+tgNEN7ddiL1OEpnYM3N9TT3Iw84N9ZVJc+/dA4KpnnIU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 23:58:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.026; Mon, 13 Jul 2020
 23:58:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
CC:     "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Topic: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Index: AQHWWN9KvInmw7yU802p8iILluvbIQ==
Date:   Mon, 13 Jul 2020 23:58:18 +0000
Message-ID: <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1127165b-a821-4467-a63a-08d827889d9e
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB65497D2A3FAA9D7F246E3CE386600@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LohTDdsy7Hl+mHtq7YZHnwKz39l39fD5JFBPICYqF9zG7x5Rm0EBtRwy0CvK45X1OuV92G16GNZGdc3f1Dt/IjaIeW0b3kUuOnCI+90V676XvYqCodJhMOpjEYpPJVA1CFAvRFTtGmKp/MEvWtJ0sujy6losjQiQrr23ezMouy7AJ6pnu66gDAvzVJVdqLU4b9CfrgoTrL2tjaci8qxLh6Udl4E5FZdyiHy8+WCwN9MkxCijLC2lk+lH76UZoSJEt8l4IozbntxK0Pqhd4yvmDEDD+A7k454FjbCEvaKWbCS8laAyU9g4itu4H8JwCuxa92zWDSfKBzrePQHe/w3hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(8936002)(478600001)(9686003)(4326008)(55016002)(86362001)(110136005)(8676002)(54906003)(66446008)(26005)(6506007)(83380400001)(66946007)(2906002)(33656002)(52536014)(53546011)(5660300002)(7696005)(316002)(186003)(71200400001)(76116006)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JbScmvP6X2lthZzqK0ZQEYcxrhTIW+xFQhDy7NQyqSWbmqAB4I4YCQSs2yEi3rQuuKWqTlPWS15S2jZb1ZtRjOfhV1ISCKpVPGRMwctTgfyyJuIB48Xcv4daWK3FLyWALiaaVJ//HQcCr+/JzzjXQHpOz0kN8I5qjdeXs/n+UyuFT9uAuplTc1A1kBE3gzqoAxocnmRNciRu5LNERx8q29oviPbBJd2qs0XHGmNwZNzVuhAOBxtRF+U26JNNuFNJhAFdmwcUHYS6Tj41mw/Y7SRe0DlG//RkLYG4gtN2xM0vpP9v92n8JKi8l/dU1vqyfHmhn4lUTCaKywUYvYxIF7x1kHoVLrCQ4RVhyUwC1Eqo34C7djjrrmTLWrOBe7NrD4BZXVsnIE7Ut4Bok5905mwAWtrQvmkqYywn+xnZ7pPUaR8vJjDmrXOlCTH8imEH6hBwDGymTDl5xk7FE7O88jSoMOkXozrtN+gGEQvhkHE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1127165b-a821-4467-a63a-08d827889d9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 23:58:18.3952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IzbIoHQIBCfmH9/Eim4nLpUMtjFRmCVJ57JXjzS5T9SwCPQ//SvGnpQpZGVExCnKZSxlCD/lw1lsSTsekILZaQR6VSeZI5Crw48Mvw5CqkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/20 23:31, Baolin Wang wrote:=0A=
> We've already validated the 'kato' in nvme_start_keep_alive(), thus no=0A=
> need to validate it again in nvme_start_ctrl(). Remove it.=0A=
> =0A=
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 3 +--=0A=
>   1 file changed, 1 insertion(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 3d00ea4..a95e26e 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -4313,8 +4313,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)=0A=
>   =0A=
>   void nvme_start_ctrl(struct nvme_ctrl *ctrl)=0A=
>   {=0A=
> -	if (ctrl->kato)=0A=
> -		nvme_start_keep_alive(ctrl);=0A=
> +	nvme_start_keep_alive(ctrl);=0A=
>   =0A=
>   	nvme_enable_aen(ctrl);=0A=
>   =0A=
> =0A=
=0A=
Since start keep alive is so small to make a function call how about we =0A=
in-line the call ? untested patch :-=0A=
=0A=
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
index 09abf2ca33f5..c7289c23658a 100644=0A=
--- a/drivers/nvme/host/core.c=0A=
+++ b/drivers/nvme/host/core.c=0A=
@@ -4311,8 +4311,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);=0A=
=0A=
  void nvme_start_ctrl(struct nvme_ctrl *ctrl)=0A=
  {=0A=
+       /* if ctrl keep alive time out is set start keep alive */=0A=
         if (ctrl->kato)=0A=
-               nvme_start_keep_alive(ctrl);=0A=
+               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * =
=0A=
HZ);=0A=
=0A=
         nvme_enable_aen(ctrl);=0A=
=0A=
root@iouring nvme (xarray) # git diff=0A=
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
index 09abf2ca33f5..08e1a6826b08 100644=0A=
--- a/drivers/nvme/host/core.c=0A=
+++ b/drivers/nvme/host/core.c=0A=
@@ -1031,14 +1031,6 @@ static void nvme_keep_alive_work(struct =0A=
work_struct *work)=0A=
         }=0A=
  }=0A=
=0A=
-static void nvme_start_keep_alive(struct nvme_ctrl *ctrl)=0A=
-{=0A=
-       if (unlikely(ctrl->kato =3D=3D 0))=0A=
-               return;=0A=
-=0A=
-       queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ);=0A=
-}=0A=
-=0A=
  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl)=0A=
  {=0A=
         if (unlikely(ctrl->kato =3D=3D 0))=0A=
@@ -4311,8 +4303,9 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);=0A=
=0A=
  void nvme_start_ctrl(struct nvme_ctrl *ctrl)=0A=
  {=0A=
+       /* if ctrl keep alive time out is set start keep alive */=0A=
         if (ctrl->kato)=0A=
-               nvme_start_keep_alive(ctrl);=0A=
+               queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * =
=0A=
HZ);=0A=
=0A=
         nvme_enable_aen(ctrl);=0A=
=0A=
=0A=
