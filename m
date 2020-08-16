Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894E2C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E6920735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="cD2JhdXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgHPPYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:24:54 -0400
Received: from mail-db8eur05on2099.outbound.protection.outlook.com ([40.107.20.99]:13792
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728346AbgHPPYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:24:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DheZQYolNl2J9PZ+bbjilZU2es5YxBIZR0nI34OGko9GaF88LLr4gEIuFnQOfQih9nu3YdwvOIdPHtwz//CG3z6kxN/YmOp9hEgfuTz7usR19MraO8Os4Txax8QGGj8c3BkaksbVwsIiuInAYj9bmkem9Umol8cdOFQEFnmw4PuylWpf11ppqpGb43JcLfbyQwCt9PjBlDNbHRXcgShrnXY/GmFqMImxw8n7no0WscoLiUpQKlM9hdqQZw/GuQFui9MQcx40VeVwkZJnSmesiVoAKEKEusYGj4jJbnOoGcN9C5VrRVGD3kFuyMs+8nwngd+pmBS6GkovJn9cXCvaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlCHmLFM6R31COdLu1T9g94az2qqp4D67Jcd9oSWWSg=;
 b=noMRqrKa9ttyb//21bv1BbuKO3yWp+gi06i8T9HBehPAZaYlTYApn2npEvsh+334LVzHUwMwQ27w9AZOyi6+47C+3SbmpayZ6A+BUy/Yq+CNCcD1lPKzTMQwQ+ZK/dQprKlDaKoV4gREOqX6hgPeh7rs5vRmI5U6KQw3s3AlSz4XU02pO7nC9kYXZNaILOtogabi5mDQgaCDy8ymJzcerTL0tWKp40MQRZfweY45CZs+X1OtUfVcrNLX7NzEd6v3L6vyK8+1/48Jw7XOCkdQGe0AZf7LJJel552KkimsfOOGMLRILkdnBm+eYZ4waBIV9hQjIWD+QSPq4vo2pEDzOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AlCHmLFM6R31COdLu1T9g94az2qqp4D67Jcd9oSWWSg=;
 b=cD2JhdXLqmDWoY8uFqeJxArMxdeYYXjzm5G+Q85+Hb7lyE04Cqt2gKLm3gubkd5BHY3sbB5ecshxkoHKspLSYyrb33g6mV8f0buJnHHt0F21aCBXA6gHEheeMj0Dux5Vn4M145iFHhC/nZMJpuwIhP+l60EqReZtUFM4MNW+BFc=
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com (2603:10a6:10:ef::22)
 by DB3PR0202MB3547.eurprd02.prod.outlook.com (2603:10a6:8:11::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Sun, 16 Aug
 2020 15:24:28 +0000
Received: from DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9]) by DB8PR02MB5468.eurprd02.prod.outlook.com
 ([fe80::68d4:6b:d077:19a9%4]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 15:24:28 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     Oded Gabbay <oded.gabbay@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        SW_Drivers <SW_Drivers@habana.ai>
Subject: RE: [PATCH 6/9] habanalabs: remove redundant assignment to variable
Thread-Topic: [PATCH 6/9] habanalabs: remove redundant assignment to variable
Thread-Index: AQHWcy3gitgkETMvJEyKANWQb1c/Pak6uhXQ
Date:   Sun, 16 Aug 2020 15:24:28 +0000
Message-ID: <DB8PR02MB546804F22F4B4B363E42DA37D25E0@DB8PR02MB5468.eurprd02.prod.outlook.com>
References: <20200815175938.16619-1-oded.gabbay@gmail.com>
 <20200815175938.16619-6-oded.gabbay@gmail.com>
In-Reply-To: <20200815175938.16619-6-oded.gabbay@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
x-originating-ip: [46.116.96.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1cf95fd-be58-4144-26fc-08d841f87763
x-ms-traffictypediagnostic: DB3PR0202MB3547:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB3PR0202MB3547EC5B6BD3D6FF0CA7C5EAD25E0@DB3PR0202MB3547.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z18mdCTWFgVbot392B39nH8dGjLUKB33sIeWkoxbtw9Ja3wQOXJokcm6HVdvug1wEPghAfalYi7CTqihWTnQARP92G7jC4KBVeleF5NzyBJNUECHc3yoH4UIytmccf8KXAum48cVAXQJffz7ZPhsgtVW3CnbPvKwo4H+87akSFuHJOh71FqspZQX+0nzk5sSY4iC8rmSF15xKtduTmhAOtD02bVBTALN4WuqxaBePafW0eM5s8g8W04U/HYfa1yP2pzVgJc/sK65Yt0FrKeEoEadjikJ2YNbzFXEvamCBixWdqa7ChVwfy401H/i1e94xF8Fga2L5Tcf1mPSxHbO6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5468.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39850400004)(7696005)(86362001)(110136005)(52536014)(76116006)(55016002)(6636002)(8676002)(316002)(9686003)(5660300002)(53546011)(6506007)(8936002)(66556008)(558084003)(33656002)(2906002)(66476007)(66446008)(26005)(64756008)(478600001)(66946007)(186003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UaLvNLSD9Y24+QgYsezXBZEd80mp/URsi55WFnmXAjE+yuFzz44hv1f/urWP0LyYk1OOEKcPCu1KvmF5YmFgYwJF1bUjOSZeMiSXin7SETYMOyMYrsI3gBmtgOhxqgJ0DAFmxugp8f3vtb7ximtBj1kXfVaxJz9n/MpK/H03yXIXH5fSaX16Et5usE5D2gufHEhEXCO73rFqD+M4UjYF2+2Z97GqS2pwD+wHlt9w+T8noDb+hAbOYm4ek6O8EGNwQ/6cQ/iH/8q7pXfaaBNXmcufXxR2u86EHURD/8PMnIDcN/i0cwJ8xfbi7o6WCMCVHhC0x3H16V5/RiUKFCrhYnoXQcv/Qkl9tt+onn/It0NRwmH/iKwjfCn/N1kGjTFuhf9pV38pTng2ULMl84I6yK1L1b6zazP5zAx68DSdtnu5/iH5QvcCFIdbXE20RKDwnzKLB1uv1D39GGU3gTTLJQ8NbO+qq5fNNxcZAjOWmGVEHzzfMEonTxSi9nDVTC95noipnP5LQF3ICKU1chzrrnVJLpEZhWsOB52TPlY6vyMhGAxYX98eVWkVDtNmnnVFBIKvzIhq+pAxrkwIQXC9ICbKLkvJkPGkbsmYX6daAwhVPojJuneOQmRX0iyKrTbDE7O6OyT+mCoReKUMLelKSw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5468.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1cf95fd-be58-4144-26fc-08d841f87763
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 15:24:28.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eXN5SQ2vi4336UuhcmFUQC69OSkW8kUnLLs7qMI7FRSBQ+EsA8ZWmLYuWtOm6XNYfwfyoaqczcdAHAgCSF1bmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3547
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 21:00 Oded Gabbay <oded.gabbay@gmail.com> wrote:
> new_dma_pkt->ctl is assigned a value and then is reassigned a new value
> without the first value ever being used.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
