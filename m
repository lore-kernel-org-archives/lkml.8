Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CB620708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="yRzo9VsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgAXKRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:17:30 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:54667 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729351AbgAXKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:17:29 -0500
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 63/02-07000-434CA2E5; Fri, 24 Jan 2020 10:17:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRWlGSWpSXmKPExsWSoS9YoGtyRCv
  O4ESTgMWTd6vZLO5/PcpocXnXHDYHZo8Jiw6we9y5tofN4/MmuQDmKNbMvKT8igTWjK83DjEV
  TFSpuP/uEFMD4yfZLkYuDkaBpcwS/67+YYVwjrFIbHn4gQ3C2cwo8bv3J5DDycEicIJZYtN8b
  pCEkMAkJom9Kz8ygSSEBO4ySiy+zgJiswlYSEw+8QCsW0SgmVFi27J57CAJZoFyiWk/fzOC2M
  ICPhIvOq+C2SICvhKXlxyDsp0kLvV1MUNsU5Xo2dcBtoBXIFZi37pt7BCblzFKzL73BWwbp4C
  hxK5ry8CKGAVkJb40rmaGWCYucevJfLC4hICAxJI955khbFGJl4//sULUp0qcbLrBCBHXkTh7
  /QmUrSQxb+4RKFtW4tL8bijbV+Jp52woW0ti05M9ULaFxJLuVqB7OIBsFYl/hyohwjkSk79dg
  SpRl2j5OI8VwpaR6Nw7H+qcJSwSS84yT2A0mIXkaghbR2LB7k9sELa2xLKFr5lngYNCUOLkzC
  csCxhZVjFaJBVlpmeU5CZm5ugaGhjoGhoa65rompvrJVbpJumlluomp+aVFCUCJfUSy4v1iit
  zk3NS9PJSSzYxApNQSiGL7w7Glm9v9Q4xSnIwKYnyds3VihPiS8pPqcxILM6ILyrNSS0+xCjD
  waEkwbvjEFBOsCg1PbUiLTMHmBBh0hIcPEoivKtB0rzFBYm5xZnpEKlTjMYcE17OXcTMcfn6v
  EXMQix5+XmpUuK8AoeBSgVASjNK8+AGwRL1JUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvB
  dBFvJk5pXA7XsFdAoT0CkuSmCnlCQipKQamJZdXBH76JzeMW5L036Dvwf6VnKqNMivPdm56tY
  7PvaFqgu3+l0V9Twn96XRber6hRo33cXcRRZveOI/+2pseM7e/t2idVvF7ge2m33zeGUsyHps
  T7TX1RMxIb82/j/2fOeZC5OkPx+ZvS/g5Ar5x5nre2Mdffv/FN889+TltcWmTdrTp122/M2gF
  lCyKEYy9NukO2d3Xunf4KF5fJPC7q/7nB5PUtgm1zS7S906LmyF7cSrVyOPZaiKBJXJWh6I2R
  y09A33zp+iCSt6J5/skm1eet1k95E1Z9jSelaZ1Jy1jVeZoORixeUleixe88f6Gnm7uMvcq7O
  T98gc8fvVb7rBPiSXNWzOx4n73qrf405TYinOSDTUYi4qTgQAMxhB9E8EAAA=
X-Env-Sender: Adam.Thomson.Opensource@diasemi.com
X-Msg-Ref: server-31.tower-239.messagelabs.com!1579861043!566497!1
X-Originating-IP: [104.47.17.112]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.25; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25100 invoked from network); 24 Jan 2020 10:17:24 -0000
Received: from mail-db8eur05lp2112.outbound.protection.outlook.com (HELO EUR05-DB8-obe.outbound.protection.outlook.com) (104.47.17.112)
  by server-31.tower-239.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Jan 2020 10:17:24 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJcqef8UDHUeoUnY54vFWQnHJJdErgL7AUtK0yU8uvAa4HsxBwiM20wtK30bmTeiUleXpB4jzTRi/u118OUQm1zW6enHYl1K7pJ04Zjy6EJ7XINGa63qrWPq2M+rwsf7V9MRXdVMM1NegFaX9WjIfKtubiMk+6nreGAK6qTUWnXVgh71NPuZnzwTsDW/2lEYm4SIwkRuRyRjSfVCwC/JqQFqwlme3uQ3XX1/eP8oN8CGBAtr8f54hKLxUgq1OzDDkzkEQwPSffmw3jhCNEZolnLJFZXN/9dlijTX8gcKDzHKfeNoesuMw7IYWrerQ3aMa5jfr8GWwxOzsbT9dKUa5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjKKL1ihIxk8QUxNbD3G9PVe6whTlQ/gE0nrLcqIaP8=;
 b=gLSjNFTDrxI5b65d/z6bnEsRoDhDomDEOM+OlErbLr1LZGCK4cwbAGavCYi4yXT9xOoqxeyrXhza8IxWE1OwrKNwWLBYxj4isHgFbmEkl6ZlZru32AyjTvunEHmwozHqFKlF9hwbcwGYLdsWEo/sYlJ8ULOZsAS33weEXNF6nXty5teruVFjMpq18rtfgQIIBj0krgec3ZDJ5Iv7EMwy//xjzNCgsbcDbQEfpO7w+vDsNDEEJ3JBA/iKKGDvaC5XkMWAckIjiTF2kpQ4tnXJwZ25ByQKqOln/QUiw5qc7unWn9lXE4xXK9m3LxUFCRj/EGH/cQYM+5MQmmd9GemavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjKKL1ihIxk8QUxNbD3G9PVe6whTlQ/gE0nrLcqIaP8=;
 b=yRzo9VsU07Sch2Mrojban0sV1xY8ssQz2R2nHzkLEMD7x38rZXHpzawz/2iI3kToC0uzHRBxsIQuhB0TcYqv7pAR9CfWwxw/EV9I38pwGOKp5sY9va0ePtVbvF2MfbSkf1lKmK7BNc8HUx44Cm5MD0tEdoF6Gz0bYyFUugBfN8E=
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM (20.177.116.141) by
 AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM (10.255.122.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 10:17:19 +0000
Received: from AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9be:9fca:6def:97c3]) by AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9be:9fca:6def:97c3%5]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 10:17:19 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Helmut Grohne <helmut.grohne@intenta.de>,
        Lee Jones <lee.jones@linaro.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
CC:     Support Opensource <Support.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Thread-Topic: [PATCH 1/2] mfd: da9062: enable being a system-power-controller
Thread-Index: AQHVxVLd8ZSwK+YMLk+kKi398FPZzKf4e+UAgAEg3QCAABbyAA==
Date:   Fri, 24 Jan 2020 10:17:19 +0000
Message-ID: <AM6PR10MB22636902FCF576272AC8F373800E0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <20200107120559.GA700@laureti-dev>
 <AM6PR10MB226306BDE8575CED80071148800F0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200124085310.GA27231@laureti-dev>
In-Reply-To: <20200124085310.GA27231@laureti-dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.228]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443898b1-66c8-4b73-993f-08d7a0b6981d
x-ms-traffictypediagnostic: AM6PR10MB3365:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR10MB33652DB8AC1E858B019523E5A70E0@AM6PR10MB3365.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02929ECF07
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(376002)(39850400004)(199004)(189003)(33656002)(54906003)(110136005)(55016002)(7696005)(76116006)(5660300002)(8676002)(9686003)(81166006)(81156014)(66946007)(316002)(52536014)(86362001)(66476007)(66446008)(64756008)(66556008)(186003)(2906002)(8936002)(55236004)(71200400001)(53546011)(478600001)(26005)(6506007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR10MB3365;H:AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LY6//+jDGaOGKI5y56oPivKPF2tj/r2Y2a4D31u0f9p7cF06nZUApoO4V1clD+440f7JUbzsf9KOP9ME3lMM37vEJolsjZZl3pIvpQYw+X48+xhtYmdn6xHXkbTB0yreu0iWebLRzN+IvWj0NdJnf31cZDuDgIMLbFKMTC5ocrwfXPt/Lvpo46dAfgc/nSaz+5Gb9SxnXnVA8mPv99Q+ju0pqRE/PYXQPafgFHrkbdCvlO5s41JphamD74d/k/Dy7DacIBcJghfyDhoOxdrosbx1Q7XEz1zuDYO6IaC8sNpyLkzo4DcIrQvHDLzxsxEXcwN2BHivZuRl30gPVtUpQ67aIoWUKvsoyVL/xlCFgYZsQwmMd/Lu8yzbBpd1JbfP5bjFPBuN6lWwUvS8iKeocAZOaLSgT4xWsAl7ZEsUL6/Btj89TjZTS6T28CmC/U37
x-ms-exchange-antispam-messagedata: w/Uv0ayL1d1c40VUrwdc20OXe7N17cJFI8nS3Sr25RwF8VedMUqQnBeltBN1ETgtTEG+JJ4ZHLtTbiCnRKk7pJ/6aNECVTHRaq8C0aYtKh7N/CIlqjDEdBHJkj5naOdmp4nn78kMiGww5tP+3DFqFA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443898b1-66c8-4b73-993f-08d7a0b6981d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2020 10:17:19.2193
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4UboVo4ZsA9dK6NzYZWWUcuN+2ZM9EsSC5KA7oMX6c9GOsLxtSX7OOqEZ8NTwPJTnLMK++EtNikKx7LnDe30+h+wWp65QTWOv8EdDk2CRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 January 2020 08:53, Helmut Grohne wrote:

> Hi,
>=20
> Thank you for reviewing the code.
>=20
> On Thu, Jan 23, 2020 at 04:51:37PM +0100, Adam Thomson wrote:
> > I have concerns about using regmap/I2C within the pm_power_off() callba=
ck
> > function although I am aware there are other examples of this in the ke=
rnel. At
> > the point that is called I believe IRQs are disabled so it would requir=
e a
> > platform to have an atomic version of the I2C bus's xfer function. Don'=
t know
> > if there's a check to see if the bus supports this, but if not then may=
be it's
> > something worth adding? That way we can then only support the
> pm_power_off()
> > approach on systems which can actually do it.
>=20
> On arm, machine_power_off calls the pm_power_off callback after issuing
> local_irq_disable() and smp_send_stop(). So I think your intuition is
> correct that we are running with only one CPU left with IRQs disabled.
>=20
> I have tested this code on a board with an i2c-cadence bus. This driver
> seems to use IRQs for completion tracking with no fallback to polling.
> I'm now puzzled as to why this works at all. Given that I'm using
> regmap_update_bits on a volatile register, it would have to complete the
> read before performing the relevant write. Nevertheless, it reliably
> turns off here. So I'm starting to wonder whether there is a flaw in the
> analysis.
>=20
> I also looked into whether linux/i2c.h would tell us about the
> availability of an atomic xfer function. Indeed, the i2c_algorithm
> structure has a master_xfer_atomic specifically for this purpose. The
> i2c core will automatically use this function when irqs are disabled.
> Unfortunately, very few buses implement this function. In particular,
> i2c-cadence lacks it.
>=20
> So I could check for i2c_dev->adapter->algo->master_xfer_atomic !=3D NULL
> indeed. Possibly this could be wrapped in a central inline function.

Yes, I'd be tempted to make this a nice wrapper function to hide the
particulars, were someone to implement this.

>=20
> I concur that quite a few other drivers use a regmap/i2c from their
> pm_power_off hook. Examples include:
>  * arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c (i2c without regmap)
>  * drivers/mfd/axp20x.c (regmap without i2c)
>  * drivers/mfd/dm355evm_msp.c (i2c without regmap)
>  * drivers/mfd/max77620.c (regmap and i2c)
>  * drivers/mfd/max8907.c (regmap and i2c)
>  * drivers/mfd/palmas.c (regmap and i2c)
>  * drivers/mfd/retu-mfd.c (regmap and i2c)
>  * drivers/mfd/rn5t618.c (regmap and i2c)
>  * drivers/mfd/tps6586x.c (regmap and i2c)
>  * drivers/mfd/tps65910.c (regmap and i2c)
>  * drivers/mfd/tps80031.c (regmap and i2c)
>  * drivers/mfd/twl4030-power.c (i2c without regmap)
>  * drivers/regulator/act8865-regulator.c (regmap and i2c)
>=20
> For this reason, I think the practice of using regmap/i2c within
> pm_power_off is well-established and should not be questioned for an
> individual device. In addition, the relevant functionality must be
> explicitly requested by modifying a board-specific device-tree. It can
> be assumed that an integrator would test whether the mfd actually works
> as a power controller when adding the relevant property. Given that we
> turned off other CPUs and IRQs, the behaviour should be fairly reliable.

I never like assumptions and they tend to catch people out. A lot of the ti=
me
driver developers will use another as a template/example and so the same
possible mistakes can be duplicated. I don't know for certain these are mis=
takes
but the code seems to indicate that could be the case, and there's a good
reason that atomic I2C transfer code has been added into the kernel. I also
prefer code that helps people identify where a problem might lie so having =
a
check for I2C atomic support would be useful to indicate if there is a prob=
lem.

Lee, do you have any further insight into any of this? Am I barking up the
wrong tree here?

>=20
> I think that requiring atomic transfers for pm_power_off would be
> relatively easy to implement (for all mfds). However, I also think that
> it would break a fair number of boards, because so few buses implement
> atomic transfers. As such, I don't think we can actually require it
> before requiring all buses to implement atomic transfers. At that point,
> the check becomes useless, because the i2c core will automatically use
> atomic transfers during pm_power_off.
>=20
> Given these reasons (consistency with other drivers, testing and "don't
> break"), I think that including the functionality without an additional
> check is a reasonable thing to do.
>=20
> Helmut
