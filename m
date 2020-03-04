Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C095CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA18217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="nri5pI//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbgCDRZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:25:44 -0500
Received: from mail-dm6nam11on2095.outbound.protection.outlook.com ([40.107.223.95]:37088
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726561AbgCDRZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:25:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMjUb5E+q6F1m3y+428S90R26Md0nNdmkMf95NpzG6E4Cin7hs1qG82Uezvc45DXHSkyRwjuOMpfzIshRoti1It6W4FNog8HYOjOXQYNV3k9OyGmxty7Q8dC9cTo04gmJ8bmD/4uZmxmLa710hU5b/cJ/T8KSc2pHGDz6/x1iKP/idt2SY411zTP1S76lW6jqykdlEYfeqTjpg+xAD2bugeceO5O4ShU76rK8REIT2/n8BzPm428Wqu5/By8WOGqVgrNGh8p+TaNAT6zGBt+CbQnZFCdmVVNl8NGZ7YunxK//d6inLpxKZLUgNEw4rAPV24VU53WEIV59GSJ8yywtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HUjv6Gr3JdpMwYv3pNwCA0ugUqMPIdt10ugUKAD8Kw=;
 b=N2toLZYc6cZSRqnaq8q1USXe4m6WmoMazoDYLfDjLq9059UGiksPH+f7sv3x1AeLzqqXYsGWkIdE9rUZ/4hz9eqADiZfhUEUcEH217vnKOvh0LQDyOtJOC9ED2i+Z5jKQBgJ2zZJSKcayHT7A/oi65NvwltDkUKZ0WhJsC3h69+3UMZS9bIRddYskrYcd0LRw5w5plfSsHe/z3UYi4QMFnj2swnDMZt14JtlkUGOn1r9U9NfuUZLn87bbmCS9Wp9dzgdRa56zwgIm0P6IuvgaHKDOx8bJEgWz70C52kdsVXG4sBpmA27IKBOyWldtFXePQEe130aMip4NlX0etaH6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HUjv6Gr3JdpMwYv3pNwCA0ugUqMPIdt10ugUKAD8Kw=;
 b=nri5pI//emnChvB3K2ql8OSqzJVF/0sCwrAKpPN4yjUdUdzYEPDbtpFvY0BsQOXEYFLA4FtCmxIE9FpqwITCf0/PZpSeund0j/mzMpx4nc9Gxexb/7vz++H24Gp2agXVYpNkfPTsspiquTFZ9EIgb+LHv4tetSs9CIqe1fQJEeo=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1663.namprd13.prod.outlook.com (2603:10b6:300:133::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.9; Wed, 4 Mar
 2020 17:25:41 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::308b:ce00:680a:333e%6]) with mapi id 15.20.2793.013; Wed, 4 Mar 2020
 17:25:41 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Jonathan Corbet <corbet@lwn.net>
CC:     "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Thread-Topic: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Thread-Index: AQHV63v40W4+vR3Xqky9SMj7WmB1Yag1xeiAgAFeC7CAADI+AIABYrOQ
Date:   Wed, 4 Mar 2020 17:25:41 +0000
Message-ID: <MWHPR13MB08952CDE2E8F16781B704C18FDE50@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
        <20200302130911.05a7e465@lwn.net>
        <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200303130152.461c3494@lwn.net>
In-Reply-To: <20200303130152.461c3494@lwn.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 259b4b7d-668f-4c8f-b8ad-08d7c061108a
x-ms-traffictypediagnostic: MWHPR13MB1663:
x-microsoft-antispam-prvs: <MWHPR13MB1663526D8678701F047CF252FDE50@MWHPR13MB1663.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0332AACBC3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(199004)(189003)(7696005)(66446008)(8676002)(2906002)(33656002)(66946007)(66556008)(8936002)(76116006)(478600001)(64756008)(81156014)(66476007)(6506007)(86362001)(81166006)(71200400001)(6916009)(5660300002)(316002)(54906003)(4326008)(9686003)(186003)(55016002)(52536014)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1663;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhKkvO3MbAKSxROKe/KojgMNBSgM2bFXElq52tJJ1rUsKIJ7kwXnMwFXHrPZrreFXb5J8k3oh1MBblaJYSlXcVoI++Bkg2sJYtNDc7ElIdJ2y8y0F89euUdxHe0s2CTA7iIGhp5VK7lylU4I5Uiit/dyFhUDTMKmZ77ezgtWGiKLnzZrbrK1AHMIqUYpxJfaSaSqNXcnhZLO2bg2KUYinuFqmNvad2PeUOoJTb1IJrpWb2o8wav5U5RJ0O6upL9diwL+SUwOCksak96gLp+vX5NfonEY1M4Llwxgs1YW8wG2lFRD2043UKCi+7nNLIBponZPN4FNi21VF/bkqO9uAASpXDjB8OT8xVTwZZdYYfrVfBXBd/0FN3/biCIxtC/m25DYQuz8Id07uQBgYa3iiwESykU8flOrMY3dV5KbmKH8p9mSNiHVNa5w9XBkACqg
x-ms-exchange-antispam-messagedata: 96yto+57RqLqpoe9qlJpqSLiNJlVOKWkvcj0wGIFk73e4ml/4W6wh9H2hTq2BwBd/gUwZkuJzxMiutdIiOKi06tse+fuJUjzgsQM7sWBEAP3IZrijKzGpVgphofNQxf7C4GwZtXAU5kdj4nH7LkXcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b4b7d-668f-4c8f-b8ad-08d7c061108a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2020 17:25:41.7222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwvI/0Yxx9xdUFHNQ5GxOLasJOTrT2V8k2bDmlpcEQrpuXPF18QcleAURHnBI+ykR6FY5sHzrU/kJgCUCzcfeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1663
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Jonathan Corbet <corbet@lwn.net>
>=20
> On Tue, 3 Mar 2020 17:07:48 +0000
> "Bird, Tim" <Tim.Bird@sony.com> wrote:
>=20
> > The less fragile approach would have been to just
> > always add the '-p python3' option to the virtualenv setup hint,
> > but Mauro seemed to want something more fine-tuned.
>=20
> At some point I think we'll want to say that Python 2 just isn't supporte=
d
> anymore.  After all, the language itself isn't supported anymore.  Perhap=
s
> it's time to add a warning somewhere.

Probably.  IMHO always adding the 'p python3' would have been the
first vestiges of such a hint, but maybe it should be more explicit.
A more explicit statement of "watch out if your default python
interpreter is python2" would have probably shortened some of=20
my setup time.

Ubuntu 16.04 and Ubuntu 18.04 both include python3, but have
/usr/bin/python default to python2.  So, while the package recommendations
from the script were good (and sufficient), the virtualenv hint was somewha=
t
lacking.

And, just for full disclosure, I wish there was a way to mark this type of =
fix
with a obsolescence  flag so it could be removed later.  This is the type o=
f
thing that gets put into a script as a workaround for a transition period, =
but
keeps being run 10 years later when it's no longer relevant.  Heck, the who=
le
virtualenv recommendation might be irrelevant in the next version of Ubuntu
(but maybe the script already figures that out.)
 -- Tim


