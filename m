Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3E4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D588420671
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TtI53qhJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X8qXuMvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgEPMyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:54:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3124 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgEPMx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589633637; x=1621169637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oLutvybK/iz66TCmBpgB8Eka/Csc8IwUdDPgdlwCvuI=;
  b=TtI53qhJ7J42mziXH3JNOgxRf2okc3BME1dlkuMYWFJS8AfVkC2xeJMq
   JqPo/aHI5HkLdOKLV+Dm9cj5uRooYdPumt6sYQDeGTHa+5mkpnJqjxrBl
   ap3uhrOXXrUVyDmZrDwpG1DDh06DU/Fc90ih8+B9QGaCl6+09PVkNy3xy
   l1EC6mDllBW3EQsKO3cvqG7SMjLu6dhCquzrI/tUOYhRfpANUmlhJFKxg
   Mm216Yf1tS6dNOxHWmVb2CavRUCPRON26zmJ6hovAaT7NYV9Jn2k0D1XM
   Hk5kBk198sMZPsf+p7oO7o3TdNlTiwIvLVRhlZdfHo6ePfub2gFX5onYW
   A==;
IronPort-SDR: T7qNVw88P6DRkosWUtvN8T8p8OgyUi5xLjYdrTqV1Yo+6ojKrE2VmcEnXOqDpZmSlSAXx4YWnC
 fIUFZxlsrCRw3CxB2vH4GlUY2r0KobyWU+Dh2RnZMVuVx/vMW7xOG8MtuNiEW3vKXyPvu+GbEX
 rjQ2zkhNMKn3H5nAuU4USJnUtamRyW+s0WOVmXGRqdJ6YYPweMuxJ3IeN8UeWMOPdjOGDJGzeh
 9QAo9CiIACJrGDBo5+PyhYXpoCgz/J0410FpeHukkM97wXwqOzlgwUeXawmSqDK0OSu+r+RyZV
 TlA=
X-IronPort-AV: E=Sophos;i="5.73,398,1583164800"; 
   d="scan'208";a="246819804"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 20:53:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mx6jKdUIGijQKkPWU2vPd21R6NIVXGtHoxZlyMAGeA9fEJiK/vYjUdbexycYCgu61Fs6Q0IhRKxmRdf9fxDg1VxqdwAZNkW9Tv8j4fFQH485/GQ9RslHuZm9WTIEbvJSedenlJrLDcFf4KqCiIF44N69NOhEGRfucO1lZMpBWy85fs3T3fEh3b7frrlco0opL9WBSQEngU+A+Oe9jk0skmUAZLWQheQH7JvySbi8vPgkBFN06NzuAcSVyNcVOPKr1lBiKin4nNU9xMb7oKxKRTJTPzPuNQAsQtCQiU0g7sR+RythYYVX28cvn/ZUEM6dckoyZffjU6UHkYNaL5jpTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26n0gKT7ImWxE8iTslgYYzxrVBH/ZZEmrw/SaH670Fg=;
 b=X/f1EQpJu/mBvnISlt/1bsv+iSrC173sgzCyxcAzFbAu9ZdZ9BxTKCnhVsdGEriyTr6gan8dfh7N3xmZHq0Wa2grQ/91cFJyJBHUl7SBgOIFe2xb1+IdbnKDEXM7DbgJIaON4Kf8TZsPgXqDU2zHkC5/C0eaIBjm/ZSVSBTSLUJjDTxms0NGVDaH1svDrDQWFSCqe2WOT5S00AF6UfXo/3qM2NTmPTxYIovMbZJU53PLXfO/o1wnE+69SJxy0Nahi5K/vobroSneGlvXB2OXeYB4XoWsN3SttZQ2RbTkZm3qPLUZNlX34YxNkzxj4q2zTU1AlDG140RjefkvurDedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26n0gKT7ImWxE8iTslgYYzxrVBH/ZZEmrw/SaH670Fg=;
 b=X8qXuMvlF6OsUk46d0e+/jcSZStBq/GjMbtF/zFmvRi4kI0g+IPS7lwT2YTbCZBMEkkS+h+A2oxWe4x6oFxrGN2Po7Bh+SEIoOcWsmW/lfRKQsH+3MPDUZDO0zjccpjObFCPgU6y74++DbnvYzT0t80vIixWvkgettYCjqN9xAY=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB7051.namprd04.prod.outlook.com (2603:10b6:5:244::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 12:53:56 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.2979.033; Sat, 16 May 2020
 12:53:56 +0000
From:   Anup Patel <Anup.Patel@wdc.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/4] irqchip/sifive-plic: Set default irq affinity in
 plic_irqdomain_map()
Thread-Topic: [PATCH 4/4] irqchip/sifive-plic: Set default irq affinity in
 plic_irqdomain_map()
Thread-Index: AQHWK0zLO5U/5HLTgU2ZlWNfTCo9waiqpPmAgAAGVEA=
Date:   Sat, 16 May 2020 12:53:56 +0000
Message-ID: <DM6PR04MB6201FF82D1BB54F297673D928DBA0@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-5-anup.patel@wdc.com>
 <6e9bf7e1ea3493c63a23c19485f3c644@kernel.org>
In-Reply-To: <6e9bf7e1ea3493c63a23c19485f3c644@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.108.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44658fb3-2b7c-40c3-7d10-08d7f99831c2
x-ms-traffictypediagnostic: DM6PR04MB7051:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB705154010AE5064007A50A5B8DBA0@DM6PR04MB7051.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbRx6V9r+e1XjVyUC3ww0zgSJDSJApt15jEBUFW7Jucg8C/TKLQ7sUCp5UUD4nUu+uQCdLv3ETP6+zVePFzdRaEz9qNlelAL0oDk6ffL+kAimAtVZeyQnF8B4iXb5MGzCSFbRd+dV5hUk7JEr4X9UlqCybzsNOVlkiGQu5tRp6E0TMrRFBT2vDniVn44ICHuvj9r2KfAfbfuG+JJxmRvEFVSKKhc4fC9RaMrEMzxGgwIUGJnCBqBhTW+VR87rl9dgLtl9sBbEoneIf2w+MSmMoRz/xqFDCw50LbYRFnvecFwkoVnrsyAr8kUu8W26vreEA8l2i5nzjSqKU1e0W622m3lDMjXnbO05VnzK7c68S7599tXB43L7D8TS4bhE8WYM0v1be6bxzbE+/O2DZd4y2s1z1WWJCEGFJHGILjYTZ45WFeWaM+gqdmDutEs2GNK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6201.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(52536014)(8936002)(5660300002)(2906002)(33656002)(7696005)(54906003)(186003)(55236004)(86362001)(6506007)(26005)(316002)(53546011)(478600001)(66556008)(66446008)(9686003)(4326008)(66946007)(8676002)(66476007)(64756008)(76116006)(71200400001)(55016002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: fJ6B335IN6pkkaXYMY+L3Fra5UjoK1TBWgTHPV8PHaDy2SXFBvh1E0V2aiOFE2DpnMlRFJS9yQBgKqasuCFj/DOlGxbBq+aU6Ge7iG/unLeXpb/vnnUETljnwZdEkybpPry+3Ruay6+A3tXdgCqWQUPO2ZWW3W3U2WKqH/6NlmCFcEAVQKptl5UrRgmn4pDuxpmUIFG96y4H1S4ozRXPfT5IOJVUh0/AWnWeX/utoOuh2wSldaGd+h9te8EwxU/74nXwj4XyVHqplPGgKKrYs7pll4vgEiGsK9rds/yqLwJ1bWl43wT80r2elAY2sbXsKISZCRL1uD3VsnduKBJx0NsXFNjVaYZqPysmn542EmeNy36BSqoJaoyTo0CT7YztLJxl3tcYx751HcAiFMUVfVy8XSMhyvK3SgEx5TEF82ZvYI0+qy+aV8n+av4UNwEDwJa9+Mgj5Qn59wHF3AvrDoW9lFUCPj3DDGTwM1/atfAco9OWdlhdK8YArVZqfwLh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44658fb3-2b7c-40c3-7d10-08d7f99831c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 12:53:56.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe6JHGYILBBBYFAr3N3yM8eCy+6Xueb8V6oYecDcGscLByJxjzjDOKpzNxT853FRRiLXtLHZixTu+scKyRemuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Marc Zyngier <maz@kernel.org>
> Sent: 16 May 2020 18:01
> To: Anup Patel <Anup.Patel@wdc.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Thomas Gleixner <tglx@linutronix.de>; Jason
> Cooper <jason@lakedaemon.net>; Atish Patra <Atish.Patra@wdc.com>; Alistai=
r
> Francis <Alistair.Francis@wdc.com>; Anup Patel <anup@brainfault.org>; lin=
ux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] irqchip/sifive-plic: Set default irq affinity in
> plic_irqdomain_map()
>=20
> On 2020-05-16 07:39, Anup Patel wrote:
> > For multiple PLIC instances, each PLIC can only target a subset of
> > CPUs which is represented by "lmask" in the "struct plic_priv".
> >
> > Currently, the default irq affinity for each PLIC interrupt is all
> > online CPUs which is illegal value for default irq affinity when we
> > have multiple PLIC instances. To fix this, we now set "lmask" as the
> > default irq affinity in for each interrupt in plic_irqdomain_map().
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c
> > b/drivers/irqchip/irq-sifive-plic.c
> > index e42fc082ad18..9af5e2fd2574 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -174,6 +174,7 @@ static int plic_irqdomain_map(struct irq_domain
> > *d, unsigned int irq,
> >  	irq_domain_set_info(d, irq, hwirq, &priv->chip, d->host_data,
> >  			    handle_fasteoi_irq, NULL, NULL);
> >  	irq_set_noprobe(irq);
> > +	irq_set_affinity(irq, &priv->lmask);
> >  	return 0;
> >  }
>=20
> Isn't that a fix? If so, please add a Fixes: tag, as well as a CC to stab=
le if you
> think it should be backported.

This is certainly a fix. I will add Fixes: tag like you suggested.

Regards,
Anup
