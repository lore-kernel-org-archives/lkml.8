Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22FBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0B20857
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="g/UXZV1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbgCCRHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:07:53 -0500
Received: from mail-mw2nam12on2108.outbound.protection.outlook.com ([40.107.244.108]:16713
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728158AbgCCRHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:07:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ub2AzxsgpTUj8mThIzT5cq2CHlfcx0Nyzjl21HqUNpDndlc6RbSG4uPwGKXrPEixezm8q0xTfGv1/fucZMsM99SVuNI9vhFlvfwQ88c6frFSShUCtnZ+fqNhrdHkIeh5nZSpfpFpV0ReoUhckK1KuBOIg+OWzMKSInNcFuDMhok7x4zNcTXJ18HFanPduP4b4gfIt0ok3HYK9eHpE+KKv5ydgnl09kRVtR/ErfyDKfm/sW7rJrrslIdl1xKgB8Th95134CUxiNr+HcPWKKFs6vchawgn/7hBAa+RChVtI0F1bCWum8EczXy6hbk7TO5gu8NuPaltaUH1NMxByBbFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bph4EC4D9MvgfUXOnpnmnieDK6NCxv4Drzeu7jICb4=;
 b=VEEhlc5+CwkT31DeOGlmennH/om/IweKqlvvRNtUtXTG71MAe/TdVxvwMT67zvRGIddGamWI1u9tIdhuB5hYAaRP0hfLPxsAqY2dXZDOUcyYUd/8WkiEFy2rLKxst58Ge7bvuuXBRHwo+yjtQNpDsS3zG6A55adpCn8KjbFcXSYFc6n+2GRlqXybbvQKc/8lwY6tSBbtABHrk/340/tCRyd5rlQr8/dTI/QLozt8iYxlHxFj9RnSZa6yI++RctPwpuuS2mskQ9/cEh0nloh611Qn6qsHwUtRiJBMjDvphdHckpoTF3j10lTv+65oaREmZnKqhIZWNb1v49c2O+xIhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bph4EC4D9MvgfUXOnpnmnieDK6NCxv4Drzeu7jICb4=;
 b=g/UXZV1nN9DA1fj97AI1iZHV6PyZqv7tX2ixlZCz/QOTgDihnxOC7dGZziXBSpeSDilPY54P9rK34nOvxt9JjB/zy94d3c+Ju+XliGP2YcW0X3VLQYWb3OCFlUmyQLvlTXBsEf9tAFINZuNQBQY6zrU1aD3as11WE/UvAtNoNHg=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1005.namprd13.prod.outlook.com (2603:10b6:300:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5; Tue, 3 Mar
 2020 17:07:50 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e%6]) with mapi id 15.20.2793.011; Tue, 3 Mar 2020
 17:07:49 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>
CC:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Thread-Topic: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Thread-Index: AQHV63v40W4+vR3Xqky9SMj7WmB1Yag1xeiAgAFeC7A=
Date:   Tue, 3 Mar 2020 17:07:48 +0000
Message-ID: <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
 <20200302130911.05a7e465@lwn.net>
In-Reply-To: <20200302130911.05a7e465@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ff08347-6d84-48bc-6171-08d7bf9566de
x-ms-traffictypediagnostic: MWHPR13MB1005:
x-microsoft-antispam-prvs: <MWHPR13MB10058DF4796F0C24CB79BF5CFDE40@MWHPR13MB1005.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03319F6FEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(199004)(189003)(33656002)(54906003)(55016002)(110136005)(26005)(9686003)(76116006)(2906002)(66476007)(4326008)(6506007)(7696005)(66556008)(186003)(5660300002)(71200400001)(64756008)(66946007)(52536014)(66446008)(478600001)(86362001)(81156014)(8676002)(81166006)(316002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1005;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONi/wBpZyHc643v3HfnRe0zCrUP5exM6UCjgSQN8H/IXs2B4AmdDrFa5hs9LOloPhZ+VI6FnwgdjAL2woPduLUUXEVphMJ0j1kD4g8WT7tmyuwZRrSTUJ2W89F2pNpJhl2lpkCQfasgb/byslQ0n8rJJNkfSu2g8OvpRb7lJ7FezIxhZ5mQI1PmZ9GLYb/ydJZNwU8gwNU531+5ezF+gJyX12GBkN0HeScREeRatuqfilV6/Dmi5ej95edUzgJxf3jsHhn4r8ZXcU2CeNJy6QomkCuKxzZmJFsr77Wo21R6EaSiozfKZo6jmQcnx18EBBAVdL0ZqGEtSgNIhuqVVeEzSROfEaUYaONZM+H3Ijwuc0UhRs+Ry3LEAapCTHisETnKv1kYHuoR69CqIfT7yY1i3/Y8Vn5dQ/4UmKMDXqXLrSQ516LFzW3luzgCs5aEo
x-ms-exchange-antispam-messagedata: QuzXp0ptUeNNUgw4atf1QChSiDjovxBmrTa41/Y0NPOpdRMpS/q8sNnmvXqBvAFO3RgPU6EiRUzgG0bSWxkU0K+/C1rJMoCUXh2EcH+g+yMKoI7FAzBJvz7i9zZZwgmdbud93PqEPZI9ZKm7i6DEXQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff08347-6d84-48bc-6171-08d7bf9566de
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2020 17:07:48.8969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cNi7RzWCvnmF/PkCRMql9GpM//kuuIOapu2AqDPdWemlbdByc3sd5Jaug0zwt8X4ZQj32OxH4a0mhUBHBj03YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jonathan Corbet <corbet@lwn.net>
>=20
> On Mon, 24 Feb 2020 18:34:41 -0700
> tbird20d@gmail.com wrote:
>=20
> > With Ubuntu 16.04 (and presumably Debian distros of the same age),
> > the instructions for setting up a python virtual environment should
> > do so with the python 3 interpreter.  On these older distros, the
> > default python (and virtualenv command) might be python2 based.
> >
> > Some of the packages that sphinx relies on are now only available
> > for python3.  If you don't specify the python3 interpreter for
> > the virtualenv, you get errors when doing the pip installs for
> > various packages
> >
> > Fix this by adding '-p python3' to the virtualenv recommendation
> > line.
> >
> > Signed-off-by: Tim Bird <tim.bird@sony.com>
>=20
> I've applied this, even though it feels a bit fragile to me.  But Python
> stuff can be a bit that way, sometimes, I guess.

I agree it seems a bit wonky.
The less fragile approach would have been to just
always add the '-p python3' option to the virtualenv setup hint,
but Mauro seemed to want something more fine-tuned.
As far as the string parsing goes, I think that the format of strings
returned by lsb-release (and the predecesors that sphinx_pre_install
checks) is unlikely to change.

Thanks for applying it.
 -- Tim


