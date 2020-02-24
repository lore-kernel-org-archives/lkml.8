Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E77C38BE0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B5020656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="MNdkEFwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXTut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:50:49 -0500
Received: from mail-bn8nam12on2104.outbound.protection.outlook.com ([40.107.237.104]:48961
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgBXTut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:50:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrYeQyQfVHOFICIfSBp2Ec9FbB2XhCNG76LaQhCMfrx0mI9/iXtc+MXwJr//9yQBy6sEhaG8UeYwBA2iB80U6YgeRnjtDmPlgbhsvdLFQ1jknWGyhzvCJ1p97LRpZr1qRXiRex5hJAQV7+fes9SYr5CbsDrCHo4yjOMtYtB+dXVKmahyYVdalbjcbpQofp/+78R2YWXLZCJUsHxfbwDpdtwXziZXMDeiNrBkZ8NVA86b3fkabNh51+1eisDcb+VuDBanZxMcwfOIBWlEI3caG7rYt+qVhfAI9oU5sSL/sX0TrvyE5oX2GWdHuhFbu0ynkIK8yTQ/rGn63MCdx62Llg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jUKH2zk3wZSYXjBQHxclE7JLWYTGPl4xeyf5tawmr0=;
 b=YarcSOcqboujC/E/y1D/X7NAmr0sHrIKqvI+IYHezK6aNlEr2XTPJVPgoSblWILFiqXKGtrYlYHvO+h6kO3KLjEAPVA4TuBRLTrUZlJrLMNIuN0aCfKCod5BXHypC8XIC5K+ydzPklOO8PLrOk2qcBkUkWxBGs65UwgN4RfVoATx+rcewxcifuXkbNhWAGuSQY0/JaIaAGklOJB1cRJa9O3CVlEGDOouq/8489i9SQVslkk76RFcSD75qSAfKDNAuOTxVrgO4nvcPcFfgCvJJ279GrZjYwZKWsq3APi0KU5gcbsfkI0EHjB/kXjX9W14TnvlxNRHtd+WbIsiVWSUiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jUKH2zk3wZSYXjBQHxclE7JLWYTGPl4xeyf5tawmr0=;
 b=MNdkEFwO32Ky2CqUXyJ85RMTgKJHPQAFDs+UMRfYYf5wvxP8izZNLX5kgjYz3WwWCvfEoV4Lb09aBvvxi2OdUAhJ3Zdlnf8fhPfkWSNFGs21/CkzkNnrDx9DMOesRPnak6Jh5y+8bdQxaXSSmaRFVeShikgr2fnQK3dKhy2mFCo=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1325.namprd13.prod.outlook.com (2603:10b6:300:9a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.11; Mon, 24 Feb
 2020 19:50:43 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 19:50:42 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: RFC: Fix for sphinx setup message
Thread-Topic: RFC: Fix for sphinx setup message
Thread-Index: AdXpBDdLywF8zW5LQ+SWSa0xf1943QAS9IAAAAA7mwAAfcpaAA==
Date:   Mon, 24 Feb 2020 19:50:42 +0000
Message-ID: <MWHPR13MB08958844310C695A2DDCAA90FDEC0@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <MWHPR13MB0895675B302AF38BB1D141BBFD120@MWHPR13MB0895.namprd13.prod.outlook.com>
        <20200222081644.4ce926a0@kernel.org> <20200222082324.42fb46b2@kernel.org>
In-Reply-To: <20200222082324.42fb46b2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.66.122]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7a712d9a-d2a5-4670-5c66-08d7b962d503
x-ms-traffictypediagnostic: MWHPR13MB1325:
x-microsoft-antispam-prvs: <MWHPR13MB132569947FA62C17FA107FFAFDEC0@MWHPR13MB1325.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(54906003)(316002)(52536014)(55016002)(71200400001)(86362001)(5660300002)(6916009)(4326008)(9686003)(33656002)(6506007)(478600001)(81166006)(81156014)(26005)(8936002)(15650500001)(66946007)(7696005)(66556008)(76116006)(66476007)(64756008)(66446008)(8676002)(2906002)(186003)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1325;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RJEErrp4TR6EjUI0GkohNLaOMmhlq4b6jVikMq/d6U9lJI6tzy8WIfwhwDXyInqIP4SrPoGVYbhhfxD+zvBknUblTt+vIhQk0OY98ZeUWfzFdT80hdT0Eiuj5wGWS6XRnI1TmKBkhYIlHpuKSyZhWnvS7LnO9C9zAfrido2ZNkDfd365QnNtw4FPezj62M6dizJR+zxo9URFBiCbJ5G82V3snfW/uzld2O0Z+/fzAcNrW2Gs8q+maRpUvxlJerEItrYStHwOlGf+h8Vl7T+xZ2Rhl53nOyy6dnhDfYQz965gsD0/ieajddPpNU7KLfFPOTrYnTW8gMRLeJ+/O1kBDknROg7jmDJBdqWuKCov5pQ7ARa5O8uab7iP6/j3avbcXg9Cxi3IUg8mvbx9WGjJ64EHWgV2I96dr0o4zvCfcwP+fmKgHeOTejIYzKeLO8bCNuOTxIHZ3b9m0XxAc1LnXwXRhGqakUeq1RPwBCI7XLYDZYpP7Qr2BkkcWJ6QhH1lSAVGP9k36zkWCmZREh5Lgg==
x-ms-exchange-antispam-messagedata: lg8COlfPD2DwuxtIZwzQgqNqpTMGt2MvTMgJ88vfnBVjvnww9SPkjPbyRRsIO8/Khmp1M5XhSjp1RtMKP4ZsaWegGyqMajskHZySWCGIMHM0uumcAcxXgWqTqI9jGSEQwmhUNqBNUN5aO8H1Mps6qQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a712d9a-d2a5-4670-5c66-08d7b962d503
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 19:50:42.5536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TnZ5q4FxxMwp4szvV/Wrn/3EWTD0xbfkfmBYpRi513g9jtha56/+Sm8cEPOQWKYh3oSydA/NcJHQsuChHfhoHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1325
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mauro Carvalho Chehab <mchehab@kernel.org>
>=20
> Em Sat, 22 Feb 2020 08:16:44 +0100
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
>=20
> > Hi Tim,
> >
> > Em Fri, 21 Feb 2020 22:15:36 +0000
> > "Bird, Tim" <Tim.Bird@sony.com> escreveu:
> >
> > > (Resend: Sorry for the dup.  I forgot to include the maintainers, and=
 I had the LKML
> > > address wrong.)
> > >
> > > I was trying to set up my machine to do some documentation work,
> > > and I had some problems with the sphinx install.  I figured out how t=
o work
> > > around the issue, but I have a question about how to add the informat=
ion
> > > to scripts/sphinx-pre-install (or whether it should go somewhere else=
).
> > >
> > > Detailed messages below, but the TLl;DR is that I got the message:
> > > -------
> > > You should run:
> > >
> > >     sudo apt-get install dvipng fonts-noto-cjk latexmk librsvg2-bin t=
exlive-xetex
> > >     /usr/bin/virtualenv sphinx_1.7.9
> > >     . sphinx_1.7.9/bin/activate
> > >     pip install -r ./Documentation/sphinx/requirements.txt
> > >     ...
> > > ------
> > >
> > > The pip install step didn't work, and I found that I needed to have e=
verything
> > > based on python3 instead.  When I replaced:
> > >     /usr/bin/virtualenv sphinx_1.7.9
> > > with
> > >     /usr/bin/virtualenv -p python3 sphinx_1.7.9
> > > everything worked.
> > >
> > > This message is coming from scripts/sphinx-pre-install (I believe on =
line 708).
> > >
> > > Should I go ahead and submit a patch to add '-p python3' to that line=
?
> > >
> > > Are there any downsides to enforcing that the virtualenv used for the
> > > documentation build use python3 only?
> >
> > Actually, the script tries to detect if python3 is installed. Currently=
, it
> > does it by seeking for a python3 variant of virtualenv. If it finds, it
> > changes the recommendation accordingly. The actual code with does that =
is
> > this one:
> >
> > 	my $virtualenv =3D findprog("virtualenv-3");
> > 	$virtualenv =3D findprog("virtualenv-3.5") if (!$virtualenv);
> > 	$virtualenv =3D findprog("virtualenv") if (!$virtualenv);
> > 	$virtualenv =3D "virtualenv" if (!$virtualenv);
> >
> > This works fine on older Fedora distros (and probably CentOS/RHEL), whe=
re
> > there is a python3 variant of virtualenv. On Ubuntu (and Fedora 31), it
> > will just use virtualenv.
> >
> > So, perhaps if we add something like this (untested):
> >
> > 	my $python =3D findprog("python3");
> >
> > 	if ($python)
> > 		$virtualenv =3D "$virtualenv -p $python";
> >
> > it would make the trick. Please notice, however, that this could cause
> > troubles with some distros that might have a version of virtualenv that
> > won't work with the above. So, perhaps we should add something like the
> > above inside give_debian_hints(), and either ensure that other Debian a=
nd
> > Ubuntu LTS versions will work with such change, or add some checks for =
the
> > Ubuntu/Debian versions where we know this works.
>=20
> Indeed it seems that, with some versions of python, virtualenv -p python3
> don't work:
>=20
> 	https://stackoverflow.com/questions/23842713/using-python-3-in-virtualen=
v
>=20
> This could well be something already solved on most distros, but I think =
it
> would be safer if we only add "-p python3" if it is Ubuntu 16.04 or upper
> (and doing a similar test for Debian).

OK - see the patch I will send shortly for what I came up with.
 -- Tim

> >
> > Note: the version of the distribution (and its name) is already stored
> > at the global var $system_release.
> >
> > Cheers,
> > Mauro
