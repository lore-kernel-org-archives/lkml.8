Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C647AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D3D221E3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgIKIV1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:21:27 -0400
Received: from mail-eopbgr1310094.outbound.protection.outlook.com ([40.107.131.94]:27519
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725562AbgIKIVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:21:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDyl7wHCWqxb70FuwCgNceX6IqIolCoBT6EBbd3qg9Ofjmaprwd5njN5BAk4PQp6I9Oet9l25+7BqmZjiAXaKgvZbIzVaD0bc3iJMaKeAJ0dhqipJEUCcafXTBDa0ZhjCWxj9UfQ5bYZ9rrVnMqhIuLB842IY/6sNvSUwcmDFcAi6jiw90AfgiquvGJxES3nsCJ2/9ucXJBgUEpK0+P2uYqdKwGIf6Ek1ZOrqX0pI6urcSTb3GW8VEwpZAiH3Y084M64J/IXqo8E2/SkN6bFMVJkjK0ms+6UCEekdBXIgaeHFAX0sPAFoNxGqBD9HE/aYi/D10IbOIOlMra8CcozRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIIRRq4waapDUQZyCpl09E9og3a81y4WoizfSd8wtkc=;
 b=FiruDCC50Qel1fFR2u1J4WttAWh1BS5V9aGv84x5MdQ3FlqdLEHORfmaCZElzXcI4JmDmRA2/JjPkLM/7UUEW+UB0c0H3SksXpRciQHWqg+hzSaGp6M6v7M7pGeMYQMVPrqBppgICbwd5UVmnnyDkry5vb+mqeLSCR80pUJxHdoUMVo767TUVOxsO0FDC/LvYkxxvVEDVln4IcbB4vYLE4WNxUuUVBncvG3ac3WIDcPXqT/LOGFAPhtLh+hxS2tzfnb9d4sji6Nz2ApwnOM13EWz9ROm8hs0VsanyYjvyJfl8djjyfhSXJrw8xChJP74HYs/47MKE7ACZfXVfTFdtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com (2603:1096:203:b8::10)
 by HK0PR06MB3668.apcprd06.prod.outlook.com (2603:1096:203:b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 08:21:17 +0000
Received: from HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::1c00:7cfc:b795:e043]) by HK0PR06MB3779.apcprd06.prod.outlook.com
 ([fe80::1c00:7cfc:b795:e043%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 08:21:17 +0000
From:   ChiaWei Wang <chiawei_wang@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>
CC:     Rob Herring <robh+dt@kernel.org>, Corey Minyard <minyard@acm.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Haiyue Wang <haiyue.wang@linux.intel.com>,
        Cyril Bur <cyrilbur@gmail.com>,
        Robert Lippert <rlippert@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: RE: [PATCH 0/4] Remove LPC register partitioning
Thread-Topic: [PATCH 0/4] Remove LPC register partitioning
Thread-Index: AQHWh+7F/kBF9JQr+U229w2dj+FSMali0RCAgAAL8QCAABZ/UA==
Date:   Fri, 11 Sep 2020 08:21:17 +0000
Message-ID: <HK0PR06MB37796D91EC7290A69F2655E491240@HK0PR06MB3779.apcprd06.prod.outlook.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
 <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
In-Reply-To: <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: aj.id.au; dkim=none (message not signed)
 header.d=none;aj.id.au; dmarc=none action=none header.from=aspeedtech.com;
x-originating-ip: [211.20.114.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 28851d9a-bce5-4118-6ab1-08d8562ba80c
x-ms-traffictypediagnostic: HK0PR06MB3668:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR06MB36683DAEBAF5E38A12D2767E91240@HK0PR06MB3668.apcprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gkhnZDM875oc5U0x8uG0LVW7LO9LSO9m0GuMDgk307Uvi8vzZFE4c9IXQYx0vA7fgBtkRZDTVq4wqKbVmDKVD2j6HMkNtBz4HTt2yjirEA/KLeXVhYUWyb6+jyurmUAwBCXhbqerVz3o6tLmrh911j7nECqrg2KJ1SHmvNfA3c++E6o6sTREoMrHfFKWSJQck508LDTWXC+HpjyC45ydAXIkRto7PALJ5lYvYGvtcNuuglYa7YIS5mhBJVslKjT703KrIcCrYnp2d2uzz9wY37MzQU/Wfj0mURxu2mNAk1wq+gi/lsjaEnBjbpWpUriW4gD3qX46yCS0K2G25gqKG9fY5ZNMaRDK3QUIeQdLOeSZ/hxmbYfnxvYqZGHtE6gu7h2ltu5aEFZzhXVMVw4FpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3779.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(346002)(136003)(396003)(366004)(376002)(34096005)(186003)(53546011)(8676002)(4326008)(316002)(55236004)(6506007)(86362001)(83380400001)(26005)(478600001)(107886003)(8936002)(55016002)(54906003)(9686003)(7416002)(52536014)(2906002)(33656002)(966005)(66946007)(110136005)(5660300002)(76116006)(7696005)(66476007)(71200400001)(66556008)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Z6e5qNnkx32WACAaz4M5CIFhGyGpwzKBiLNXUgwhMHgEEZZMVxgoC+7Q4uj4TuhVxe2CS4p32aemvIObvVySdLTkRxdPwMmFBgAPeGQLKRNcppvxKUXkE2REH502OQ58CszL4XPSBYH1+jwk6LnY8mA/h3VzI+D1ZAPw0TGEi5m29ntAUOf0a8G9m22Exf5J7fz5iqqCLI1lqHxWvkO2fF5YgO0u6kKIz2FXmKg/W1oNtbiT+2ghKufeNLv8JRxgYy95mtxohGgbc/3mYKV9zyvP+Kcr/1SYlvxR8ZC+hXqCwcCuru2k3kmtgiU2jx/tbzjlPJx0aEQll4iJ4oy0wxlfeIXeZo+qsm868VyXpLFvvv/eXXhLIVdOSgGKtVjGGaFjYSIL/FJL2N4j7H7YD2xAhm9GNbQU9vU20JLyo9wrw/JTi7oKkFao7Qnd6BlKIdvTtYwARcFlqzVp3YJd+JY5/CkTK/JsnqhXhCVg3KVSM4FZTDqDhSSP+LTR8HuVTv9o1trdMZhGQLWO6taysLS00tUdMlOKv4sZ4T+f9d1xZC9gA6RKDnIOd4j+bYlRTVL3UhlFl9JFYak6A6PL5Vmn0o2Fy+oggeEkVSkWCSMWPEsosLGn/ONFA4Lu+4cjiBd24zfJbeOGZSU/5+jglQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3779.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28851d9a-bce5-4118-6ab1-08d8562ba80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 08:21:17.5204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kC+9CrIn/n8VDgOIOqjsyC3MH/iMKeC56MDh6MgGf+9dyqgBV4P4c9rbF+9DaORZ3WgirihTlA39t4pc+DQdvW89uTErMhvjhRCSZBYhfXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3668
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for your prompt feedback.

> -----Original Message-----
> From: Andrew Jeffery <andrew@aj.id.au>
> Sent: Friday, September 11, 2020 12:46 PM
> To: Joel Stanley <joel@jms.id.au>; ChiaWei Wang
> <chiawei_wang@aspeedtech.com>
> Subject: Re: [PATCH 0/4] Remove LPC register partitioning
> 
> 
> On Fri, 11 Sep 2020, at 13:33, Joel Stanley wrote:
> > Hello,
> >
> > On Fri, 11 Sep 2020 at 03:46, Chia-Wei, Wang
> > <chiawei_wang@aspeedtech.com> wrote:
> > >
> > > The LPC controller has no concept of the BMC and the Host partitions.
> > > The incorrect partitioning can impose unnecessary range restrictions
> > > on register access through the syscon regmap interface.
> > >
> > > For instance, HICRB contains the I/O port address configuration of
> > > KCS channel 1/2. However, the KCS#1/#2 drivers cannot access HICRB
> > > as it is located at the other LPC partition.
> 
> Thanks for addressing this, I've regretted that choice for a while now.
> 
> The split was rooted in trying to support pinmux while not being across every
> detail of the LPC controller, and so I made some poor decisions.
> 
> > >
> > > In addition, to be backward compatible, the newly added HW control
> > > bits could be added at any reserved bits over the LPC addressing space.
> > >
> > > Thereby, this patch series aims to remove the LPC partitioning for
> > > better driver development and maintenance.
> >
> > I support this cleanup. The only consideration is to be careful with
> > breaking the driver/device-tree relationship. We either need to ensure
> > the drivers remain compatible with  both device trees.
> >
> > Another solution is to get agreement from all parties that for the LPC
> > device the device tree is always the one shipped with the kernel, so
> > it is okay to make incompatible changes.
If it is possible, I would prefer this solution to avoid adding additional if-logic for the compatibility support in the driver implementation.
As the patch can be less change made to register offset definitions and leave the core logic untouched.
> >
> > While we are doing a cleanup, Andrew suggested we remove the detailed
> > description of LPC out of the device tree. We would have the one LPC
> > node, and create a LPC driver that creates all of the sub devices
> > (snoop, FW cycles, kcs, bt, vuart). Andrew, can  you elaborate on this
> > plan?
> 
> I dug up the conversation I had with Rob over a year ago about being unhappy
> with what I'd cooked up.
> 
> https://lore.kernel.org/linux-arm-kernel/CAL_JsqJ+sFDG8eKbV3gvmqVHx+otW
> bki4dY213apzXgfhbXXEw@mail.gmail.com/
> 
> But I think you covered most of the idea there: We have the LPC driver create
> the subdevices and that moves the details out of the devicetree.
> However, I haven't thought about it more than that, and I think there are still
> problems with that idea. For instance, how we manage configuration of those
> devices, and how to enable only the devices a given platform actually cares
> about (i.e. the problems that devicetree solves for us).
Another concern to make centralized LPC driver implementation more complicated is the relationship with eSPI driver.
AST2500 binds the reset control of LPC and eSPI together. If eSPI is used for the Host communication, the behavior in current "lpc-ctrl" should be skipped but not for KCS, BT, Snoop, etc.
And this will be much easier to achieve by devicetree if LPC sub devices are individually described.
> 
> It may be that the only way to do that is with platform code, and that's not
> really a direction we should be going either.
>
