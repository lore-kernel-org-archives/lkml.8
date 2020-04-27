Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B871DC7C7E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC062051A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 07:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="zp52gtWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgD0HnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 03:43:11 -0400
Received: from mail1.bemta25.messagelabs.com ([46.226.52.113]:62759 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbgD0HnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 03:43:07 -0400
Received: from [100.112.197.243] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-west-1.aws.symcld.net id 67/26-40649-70D86AE5; Mon, 27 Apr 2020 07:43:03 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTf1CTZRzn2fvu3YvHvNcN42kHxu3IktjaiM4
  35Lqdd3EvlmlSdmeGvoNXNm4bYxs5GFwELNMJ4lkcCshvDOyElhGaCa6JoEechCOFQhlZjmwc
  lTXlrL17h9V/n1/3/X6e554HR0TzmARnrBbGZKB1UmwFqnkWXy/DqjqzFO9fSSIbxipRsqKtB
  yPrZ7wo2d3iwchvzzZgpH9xP4/8+1y/QCWgTndd51GV7rt8ytm9H6MGGj8RUL93exDqN+eard
  gOvtagzrfu5mumygOYMRBp7Zsrx8rABfwAWIEDogOBX93+BuHIEAqdN5bC5DMAH1QFMJagxDA
  CvUO3Qo6IaOLBiT8qAEdmAbw9fCVIInGMSIKzR3t4rBFN9PPgrGOKzxoIkQUHPEsYi8WEFi44
  6kJ6NJEHR4erUQ6nwmZ7q+AAwIP7noT3e9JYWUjQsOHEEZRb5gJw4r3vEDYTSWTAy5XrWAiIO
  HjNE8ttioE35pp4LIYEAdvPjSEcXg3veB+GtgJiFyzzNYT1JDg6OQc4HA8//nAfxuE4ON7kCO
  ub4dW6GcFy/vPpeT6HSdjusKNsBUgkwIeuIk42wh/avOHxa+EXnrFwnVhYG+jgsyeBRDkKR5d
  q0RqgOPaf2hxOgs1fLmIcfgZ2tswjx0I3sQqOHJ1DmwHaDUi1SZursehprU6mVChkSmWyTPkC
  KVOSKXK6WKaWM4WyvYzZIlPK6b1mublIn63LkRsYixMEX1mOcai/H7hP+OUu8DjOk64Wyt/uz
  BKtVOfnFGlos2aXqVDHmF3gaRwnJi6464EENeQbGCkUZjuCuVUmJpex7tHqgu92OQrxKGm08E
  /WFpqNtN6szeWsy+A5vOZOYyuCn7l4vBURhSZJYoRvslGCjWoKDY8GLf+BcRAnEQtBRESEKMr
  ImPRay/99H4jBgVQsFBwMTonSGiyP9vmCVXjBKsVPtLFVLPS/lqSMV6qvqShq/HnSXVB/d/P2
  6tTnB11CpSUvUEolD7zjW0yfuho4q/d0Sf/61S/b1PvAH38wusdWpFifU74tYROVjmvbxWLhe
  ZVq8Y2U8cReVWO87Qi9xvD1i+2Xntp+81QJnfXqTNrKDvL6lo+Y2UvF9s5Io1t569TABzuqre
  mdh0reHdn4VsTuuKrB0sThgt74EuSnlzIOfx87uGCbtq/jXfNWuhbQNK/vMHnvfuuWCfvGoZ1
  1eerHmF+23ctPoW6uJVoFGzwjaT2TfIekSvOK7aLfacuoPa+1970+ssfzWsK+tuTTiy+XyTP4
  qZ9OF3SpDp0hWjKzqcwNJ/syf2RO7kz1SlGzhlYmIiYz/Q/s/wANfgQAAA==
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-20.tower-282.messagelabs.com!1587973382!3987379!1
X-Originating-IP: [104.47.8.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 8232 invoked from network); 27 Apr 2020 07:43:02 -0000
Received: from mail-am5eur03lp2055.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.55)
  by server-20.tower-282.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Apr 2020 07:43:02 -0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I870/sAjagzytXgC3+7p2Mnr4h7BqPxPf2zXHYtkEYAlRE6TV2tun4Lg+NHmR4pA5nNXkBmqcvhJg/hG+TT7f0aHQG0SPlCIzZMjrzE8y5M5x75/XbpOPX1y0atY/282gMol7VpZWQxdj1YBLMUsb5RWE38qXQ3UOi6moQKCtwUak1Uim0VeJ6isxrMJL310CwBayGuuWsZe30J6IesP0fVU2g1Zc+AXQd6RpzXKbXP4+0j+kmhnSHANryJC4N8p3cEd/dQE9wcNUZs6tgC19SjlT7ECwI6bYXHe1VFrGp7rAjog8tzDdyjvpC4yhO1PdLlCaa86ZG8sdoB73i1wLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv0nqezkOZD0WXT43Dzip10hrpdAXXCp6O7O971iyiE=;
 b=ey7okcvyPK3PgO9p2W6uONtIzdk5Cjr/zDtHaukJBYou/aWikOHPap8ZB6gP5IvPy5XTggznlKgUGLySW/pe9EyoYFAyK29iVFLZYo7fuWRirFEfBl2cC4ygWGsEvxlQuBAofxEyQ0/Yfv/PY20/WQzZ8McHW57c06xjt7z/jXkCk41Jliqv8eNxOXqV6rsiuF5lm9LPtclH6aigmT5UYf21daIiPjlClnlUhnbUxiWQGZCklHQrbCEhYvriU0NzEu7XO6fBb4lp4U6yvthkRsymnFRGo0UtvQUoavIwWj8H2jCIQ/QwTyqsW429UVAoTtk9z5PYc5DtaNtN/WJUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv0nqezkOZD0WXT43Dzip10hrpdAXXCp6O7O971iyiE=;
 b=zp52gtWgXupteTm9Cr7BBYZ9bCaMZ7qgqLyZjhzCwu1BTtg+oW7O9dzPHzH6P+0/FfHiHzp2Aewshb6QG2pmGGvy8FyVx5AWjL4aQP3iL6s2XmS4A2xOk0KZoxtoH5Mk/MhFNQn+2yR4r2hUHA1cezzImRCSXtJO7mK0ZP++dxI=
Received: from DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:58::12)
 by DB6PR1001MB1157.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 07:43:00 +0000
Received: from DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88f1:274:a471:30f2]) by DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::88f1:274:a471:30f2%11]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 07:43:00 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Joe Perches <joe@perches.com>,
        Roy Im <roy.im.opensource@diasemi.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg KH <gregkh@linuxfoundation.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [RESEND PATCH V11 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
Thread-Topic: [RESEND PATCH V11 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
Thread-Index: AQHWHFzKWDHCy4oKzU2KFcnXdPq4VKiMkOmAgAADMQA=
Date:   Mon, 27 Apr 2020 07:42:59 +0000
Message-ID: <DB6PR1001MB1077E881E48BEC44632B80CA85AF0@DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1587949032.git.Roy.Im@diasemi.com>
         <3e4e181ae9b25b51298b90be43396f46c91e2ea9.1587949032.git.Roy.Im@diasemi.com>
 <d80d0862bd73bb17b8e840771ae7b27fe7447734.camel@perches.com>
In-Reply-To: <d80d0862bd73bb17b8e840771ae7b27fe7447734.camel@perches.com>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.230.217.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1d7852-965d-4323-c1c0-08d7ea7e9c0f
x-ms-traffictypediagnostic: DB6PR1001MB1157:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR1001MB1157DA93D9144354B6794D17A2AF0@DB6PR1001MB1157.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR1001MB1077.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(376002)(396003)(366004)(136003)(346002)(107886003)(5660300002)(64756008)(2906002)(66556008)(71200400001)(66946007)(316002)(54906003)(478600001)(110136005)(76116006)(66476007)(9686003)(55016002)(66574012)(66446008)(33656002)(86362001)(6506007)(7696005)(186003)(81156014)(8676002)(52536014)(26005)(8936002)(4326008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTGGn53ZIudIVuRNZmcXOqfvvimDvGzpY1LVMb3glc3Yb6Oy1cCR8hVrTTkqEBTlIV353cvb6qHi/X3sfVG9VwTR2tnZo3peATAjG6eSFgRKyooE415pGljjzumF4sbL1osDuIqIFCrF24HrMuFv1GQG8HeGlKny+M1nnx5aeXVxevgtLAELPDFRGHxMF53ioz9KzeGRruUnNMSL9sxjlYTi/740O2GRt5HgrpZZyD6WhngqMIsrbmLuUJ92iyT0rbLOWCZh73K/vfn0Jno/ZSr4TEmYhwztCS9Zk+mOvh+9EgYA6dw0/FMLRgPvQMqi99REdNnMrqGsfudsYC/FkW214sJ2NvRB1hAFEJyPQvO0uLOmCmBlvCtU8cewcR4It0KVh55s9LFjA6oIka0ANsAzl+zoiYN0im7dkOV2SaKkWCrs2hCAfAOxwWUZ4Q6QetCaaN7DcgT3vQc3tFnHiWqpManXWqLlJ5cec8HhhGN3JwFZCWcFnv1IAuW5UXl6njgSxwn0iXfziQhch/YpOg==
x-ms-exchange-antispam-messagedata: gMGsk5sZZrk9ZWVsa0whnIQyT++XMsI/mDDd1k8YMlj/O0JaQTUoAI/fCzrGa6kkxyMxdctypnAKxLH8W6a/t8iTW+xmA9wSM4tY2pSG/2S6SCHF94mshvTV4UxuLUEc/xus7dKdbCPa7SVikCwAY1KAnLuD2v9eUe06yTbv+2mE7/mzXn4ioBa6i14+fXUqsX3/8nkyilZ0QEHMafRZ2+z5/AQJ2mdOEg4U3xsI49WlHNau+IFVIM+q4Zj41m5MiDQfb0NnN22UJQy7w18q97Qla7c9MfxskQSJh6wU4TuNA8ncNBlbPri9tkJnUeu9BGlvZGlF1hHI8+2Ckd4G5NHiLnrbKxql1tKORkyEtV6X6a4aAGkPR19126fU0/xi8HkaSKoY5/m6mFLJMXHKBl84LfjnQGYhEnw3QdR0Um3ESgAQwcn2YwocT4Vb9SVlF8wCR5NsXdVj3tXrfzRh9fV1XqrgT35pdq492djK8R20XRkNoc/yN5+eEQdaPENU22znDOQiqWBE+rPr7BO4P8/dIjGpOqwpTkUtkfW6U+c+y6GrvdUXIpdsYczctX0asp9fJVSU9YaIiwvxb/YdsGNxGJrcFrUdSPjGucJI2RQE5LllkNVTOkNTdCYft6IB2lc5oQZmydFzc7IZ+zXii/CTAedxLGut/tr21Z8FibR+R+EuWxuMdv2fiUtjDNV17YD5PN5cQdhaBrIthtqK20HypLCrNW+iQFqI6HuzIt6V4Ddwx2c+O2sFLmLDKElSH0jdPNHbEtbHDvhpivJWSdH5zHEm7Q213Hl3WyhK5Hk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1d7852-965d-4323-c1c0-08d7ea7e9c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 07:42:59.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tBg1FvGdnqJ687oDrvyXvfRSvQ3T6nRoldDa3b74D+YUdhIhtbJ2tCnTQTa3anqAMpK+a5RjOb9z+ldwt2j8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Monday, April 27, 2020 4:24 PM, Joe Perches wrote
> On Mon, 2020-04-27 at 09:57 +0900, Roy Im wrote:
> > This patch adds the da7280 bindings doc and driver to the Dialog
> > Semiconductor support list.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -4944,6 +4944,7 @@ S:	Supported
> >  W:	http://www.dialog-semiconductor.com/products
> >  F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
> >  F:	Documentation/devicetree/bindings/mfd/da90*.txt
> > +F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
>=20
> trivia:
>=20
> Please keep the file lists in alphabetic case sensitive order so please m=
ove this new line up one entry.

I will move this new line up one entry.

>=20
> >  F:	Documentation/devicetree/bindings/regulator/da92*.txt
> >  F:	Documentation/devicetree/bindings/regulator/slg51000.txt
> >  F:	Documentation/devicetree/bindings/sound/da[79]*.txt
> > @@ -4954,6 +4955,7 @@ F:	drivers/gpio/gpio-da90??.c
> >  F:	drivers/hwmon/da90??-hwmon.c
> >  F:	drivers/iio/adc/da91??-*.c
> >  F:	drivers/input/misc/da90??_onkey.c
> > +F:	drivers/input/misc/da72??.[ch]
>=20
> Up one here too.
I will do that too. Thanks.

>=20
> >  F:	drivers/input/touchscreen/da9052_tsi.c
> >  F:	drivers/leds/leds-da90??.c
> >  F:	drivers/mfd/da903x.c

