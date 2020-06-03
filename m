Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20801C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDDD520679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="S0ktNZZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgFCLaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:30:07 -0400
Received: from mail-bn8nam11on2133.outbound.protection.outlook.com ([40.107.236.133]:22438
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725833AbgFCLaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:30:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV7aQhbGpEpGzWIlD7btyK7f1ebXbWGpaDP+ym4aK2c8Gj5UU0bGY/bSdH8fDIHBnNAz0BS9pvvFS/P3kERljO7hLOkM/k/omuCndVRJPYqpBebFuu2XQprUn+xHgUsieKnBg/z0FdVZwIy5CKXekmPzDEPP8V6WDw78IrCm2rXIwSs3LVeQZ7fJrvW6DDG/9ayvoYWNjGuuurgCbrR6mCyP9da+ZiF0BlR5hL07IFUUaK4XPd2IUxDUR2IaCM5Ew9OIcy994dX1G66SPgRsnourFAFJxPrjmMNta7zQ6zDY2U98AwxrEcCTG4YXSZR7Zw+R9JPpHC8c9DKoSciSFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6diLltNI7WqqFVBoZjTQGoYyjFGgxEBUrA0J0afqmY=;
 b=WRquCLcTfSjMjYgKYqZET52rH94HrfsURfTpGjOiIEqxkgv9qyJdtuvT9kMcdVvemoqKiWBP80aUZKQN0jxMPXDYusH0tpxe+YCfTme9uW29sfwWq7nDz24SwCyctoC09KaYsKRgKQPqtHtMhXbHQh8SjoJIUFGXZ+E3gla4ne+daOhcX9uYYZWVpM3R+PnIg/eF94HkmxPKW2bREOauX9TEsDtz0Lear5SoIxnB+w+9ZtHMA/w1MUIew61xaN2Uh0lNT1MBuLYOMl7I4z1+rfR5FG40SwjrlUvqMZK3RcvCHo+RPY7pfFRj+7a3OwpaKnySfXd6C4b2K+6umpwBLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6diLltNI7WqqFVBoZjTQGoYyjFGgxEBUrA0J0afqmY=;
 b=S0ktNZZwRdST1twkX88QOvvxgODvYemJ7BKBguBmjORLtb1dVJdxkvINIT8eF3ODlbYxizlVH7c89QvYX59nh/JnVBRNWaCoIFrEZ5gcO8sUrO/G66Y+on2SzL8WNJR6vGdjjbLGFecfoUyWWTEX6lOA9pZu1L+cCE9I6sIeKig=
Received: from MWHPR11MB2047.namprd11.prod.outlook.com (2603:10b6:300:2a::12)
 by MWHPR11MB1726.namprd11.prod.outlook.com (2603:10b6:300:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Wed, 3 Jun
 2020 11:30:02 +0000
Received: from MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363]) by MWHPR11MB2047.namprd11.prod.outlook.com
 ([fe80::994e:6a48:f660:f363%5]) with mapi id 15.20.3066.018; Wed, 3 Jun 2020
 11:30:02 +0000
From:   Steve Lee <SteveS.Lee@maximintegrated.com>
To:     Takashi Iwai <tiwai@suse.de>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "rf@opensource.wolfsonmicro.com" <rf@opensource.wolfsonmicro.com>,
        "shumingf@realtek.com" <shumingf@realtek.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "jack.yu@realtek.com" <jack.yu@realtek.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        "steves.lee.maxim@gmail.com" <steves.lee.maxim@gmail.com>
Subject: RE: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Thread-Topic: [PATCH] ASoC: max98390: Fix potential crash during param fw
 loading
Thread-Index: AQHWOZjok5hm+3ydWEypvnQMZosX1ajGv8wAgAABMyA=
Date:   Wed, 3 Jun 2020 11:30:02 +0000
Message-ID: <MWHPR11MB204724AEA2415929253525E492880@MWHPR11MB2047.namprd11.prod.outlook.com>
References: <20200603111819.5824-1-steves.lee@maximintegrated.com>
 <s5hzh9kcrzb.wl-tiwai@suse.de>
In-Reply-To: <s5hzh9kcrzb.wl-tiwai@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none
 header.from=maximintegrated.com;
x-originating-ip: [211.35.184.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbdef38d-8173-4df2-85a0-08d807b174cb
x-ms-traffictypediagnostic: MWHPR11MB1726:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1726EBC751E1C804DD8B2D8D92880@MWHPR11MB1726.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VoavqXsLKpowzGNevrLDt5aeN2Gy1b7Z3dmKj+s+EoN56pCaz+eNDZHUxK1w9+R7ZqUDd0/cLLp92skR6MkGd2ztDn8ukQsELCKK03TCMmFecYfQyobu+flPCE9tk0VIlXuFZs3jzeedng1I/uQICrRs/7DeA1cG1IrLHGVIihGaaA6CCrJcj9XtXdCuYGesSi9sSIpAxV8f7xbf6LTxducYPSnB2gOo8FjIJmYOYm8Xfu+qwxNqu07+kpLMlEnNxxKWCnVoz9D91lw4uNMPX/oFuQDsx5hzIqMdCDc/8HQJBNhcCy7psE1OMvJeN+BG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB2047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(8936002)(316002)(7696005)(8676002)(53546011)(6506007)(6916009)(55016002)(66446008)(71200400001)(4326008)(64756008)(5660300002)(52536014)(76116006)(33656002)(66476007)(66556008)(66946007)(86362001)(26005)(7416002)(9686003)(2906002)(186003)(83380400001)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C8DBCaXblOBHEfUIwohOl0VWi1VLhsLGHOFP3T1JjAIxCZNf/KbU2fLA3nm8uiG53/+1xQaXgz40JoYQ05KbjMQ8Gtq5HBW12PzZtfwPTKD+I4ATtriWBHBUuMV1x2FT/tew1UUa4U+t2Mrh293Yh356PTghjrYOUTPy3GvsJ5J3yglEBxqoWhNazQiayxf2xoACvTlIcUQCRJJwGsWMt8QHzDcp9VwESpi1NDdGItKgNBgVmEbUtZLNOOIJKAJJkMPqNtzsGGmUpvhX3BXS0blf8gX1sUFORjGrVOc2w5eP6qkbIZVy24+KbGMea5r6uB/7MfASPrrPvZaUeiJIZa5X0QdHmC0p4E6Z9SqeD4si5Iedq2G0nJq0etvkRbVl8TbKEKIx+zbhaExBdgFJ08p2lBYEvcq0Fqe7M7NlSsB7Ao80F549wKCBjOw38FO5MLyovc5TLYdblhxnFVBzyXKoeQc4EjuFyVMsiKmPWQPWoIC032u0pZ9EOr3RGIP4
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdef38d-8173-4df2-85a0-08d807b174cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 11:30:02.0547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z2APJKQKVhifXvDwe7ZDQ6sxWXc4MaZQlfnPeyokLx5OdX3L2G5yw75VB6buphIKnrktWrlTT5zCLNrb4mZcNWKKUkJHHJvPazy3h858yeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1726
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Wednesday, June 3, 2020 8:24 PM
> To: Steve Lee <SteveS.Lee@maximintegrated.com>
> Cc: lgirdwood@gmail.com; broonie@kernel.org; perex@perex.cz;
> tiwai@suse.com; ckeepax@opensource.cirrus.com; geert@linux-m68k.org;
> rf@opensource.wolfsonmicro.com; shumingf@realtek.com;
> srinivas.kandagatla@linaro.org; krzk@kernel.org; dmurphy@ti.com;
> jack.yu@realtek.com; nuno.sa@analog.com; linux-kernel@vger.kernel.org;
> alsa-devel@alsa-project.org; ryan.lee.maxim@gmail.com; Ryan Lee
> <RyanS.Lee@maximintegrated.com>; steves.lee.maxim@gmail.com
> Subject: Re: [PATCH] ASoC: max98390: Fix potential crash during param fw
> loading
>=20
> EXTERNAL EMAIL
>=20
>=20
>=20
> On Wed, 03 Jun 2020 13:18:19 +0200,
> Steve Lee wrote:
> >
> > @@ -847,7 +861,6 @@ static int max98390_probe(struct snd_soc_component
> *component)
> >
> >       /* Dsm Setting */
> >       regmap_write(max98390->regmap, DSM_VOL_CTRL, 0x94);
> > -     regmap_write(max98390->regmap, DSMIG_EN, 0x19);
>=20
> Is this change intentional?
> It wasn't mentioned in the patch description.

 It should be another change. I will re-send the patch.

>=20
>=20
> thanks,
>=20
> Takashi
