Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D7C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFD207FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="YukuC7lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgBUWPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:15:41 -0500
Received: from mail-bn8nam11on2126.outbound.protection.outlook.com ([40.107.236.126]:43913
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbgBUWPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:15:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8Np8a7UUvdNh8bjZZNvm6L5oX0AVkDX8m1VWaD3ENB+bjql763rrCcK/g59SiY4CIdSDLnYlXxjyzdc2bsBX484pmGbPDEo+k8DOPJNKEAdEaX39v4qi9a5TQJno1YC82BJQeQTP8F+XajJRJdHnHeUFz6ScYZyFczT1NzGQvEEp6rr7PuwzF0ic/VGah/eTVPbAhl8B/Mx0fhGYIeFuMYuz2MfcWjoiaPaPeycPq92onF46vvMh4XEeAGj1lSUES1z75XbRs0U3scUtr4m0iNSiWyiOFxZXEsV3kd6xZIs4aVGmZLzvC21W8UPPD65ZqQJoQulXAoEaWxiWo4ZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wio3UkIKTvq0wQc02Dky0IyTvnpx9JX2KZf8VhgNhYo=;
 b=maadNS+ywlH49R7B8n/sHJ1IA+8Nha2FfGeFvmg6VRbJ7Ynhk6QS3ZEEetwlpAcFmohAr51hxmiE05t7QVN/EeeEbFcXmnDOrRCab9evz2AWvg5T07halMr3YVzPUPxvdV8ytY3n5RJdnflsxJvlV32GRtW/km0Q+y9246LsEwedpiJuB82a+t/x3YwXCViLWqFsrFlzha0byB+3pOXkIISL/7FtpP3dcRZmj8edaK3D3LLQdzQlP5Z0/Psn5FtSAc3BwL55QX04YV5Y/u6J4RzF6/LhKyfjPNnW6H4G18xcapWnvVbVesb3qNAhw287fslzaMuN3zHZHp7Qi/tvaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wio3UkIKTvq0wQc02Dky0IyTvnpx9JX2KZf8VhgNhYo=;
 b=YukuC7lY4g0tMXGhAs6QYa7/RkRN+0TelHpZU2UgZNewhT5Ff7UeKWSNISck/6XEPpEGWXRWUb0sJl5qHLheMidPEfacovtZf5xVZ5FaFFJjy1xC2TrkoN9JqPEOMyQTTpqmabho0G/jua7dBpMaaDAahoa6qcsdP44ZcsfjXhY=
Received: from MWHPR13MB0895.namprd13.prod.outlook.com (2603:10b6:300:2::27)
 by MWHPR13MB1392.namprd13.prod.outlook.com (2603:10b6:300:9f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.8; Fri, 21 Feb
 2020 22:15:37 +0000
Received: from MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd]) by MWHPR13MB0895.namprd13.prod.outlook.com
 ([fe80::7544:fc2:b078:5dcd%3]) with mapi id 15.20.2750.016; Fri, 21 Feb 2020
 22:15:37 +0000
From:   "Bird, Tim" <Tim.Bird@sony.com>
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RFC: Fix for sphinx setup message
Thread-Topic: RFC: Fix for sphinx setup message
Thread-Index: AdXpBDdLywF8zW5LQ+SWSa0xf1943Q==
Date:   Fri, 21 Feb 2020 22:15:36 +0000
Message-ID: <MWHPR13MB0895675B302AF38BB1D141BBFD120@MWHPR13MB0895.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tim.Bird@sony.com; 
x-originating-ip: [160.33.195.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8435d89-fbf7-4ff1-586e-08d7b71b9405
x-ms-traffictypediagnostic: MWHPR13MB1392:
x-microsoft-antispam-prvs: <MWHPR13MB1392DF1A6741CD3B033352D6FD120@MWHPR13MB1392.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(66446008)(66476007)(64756008)(8676002)(5660300002)(52536014)(7696005)(478600001)(567974003)(81156014)(66556008)(966005)(81166006)(71200400001)(186003)(9686003)(6506007)(4326008)(55016002)(2906002)(15650500001)(66946007)(33656002)(26005)(110136005)(76116006)(316002)(8936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR13MB1392;H:MWHPR13MB0895.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: sony.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 84dmhCI/x+jAXVFHl7Jfz+VaunnzznP6BGX0Er0EVPqhJbT+V0E5PxXJnSo8svheQwJPFiKtJoCfaSbD3vsM+fKRVzYsmm2utPSBBHWsdzpFulmaI+i3udX1jRi+rxfRiR24hy3k4OAKLz1FC5OQWNixw5zlBed1y+rMxVVFDflfJ4Id+dfJOGdp0I4svOoiBeOuD8dATP1q39Vk1z/D240gHCC97ePxqpwYqmRF3dy+x1TD9gjQoD/FzM2QyKggqC+TaXQm94rEKKMGfRFKaXtGuhB/QhCTSRBOmBhekSpOyiZb/QvYDZO+zrrBybTV3vi78Xy2p4iNTkF/leHNvm1UVJaRXBOmXHnL1XHI2WxB2FN+zkmz0RTBx2Ra+9rX7lQE5/uuosz1B5OqkNtnlwdmViY2OINHZRWJjTRUTHx1ZnVn+3SrP/nkgyzFuMeu3uhYRqz47sjlrZjNUEtltMCDwzVeNDMamY0rp1zyRi+fTQsBYWTDjLVQJZi9n2jpajGfDhtbiryaU64jRAHxFg==
x-ms-exchange-antispam-messagedata: GMz+ptskI6IXCzBWAsiSBrYP5ECKQCoVW2VezYyQBOnmitgOop6HmbuF8bdmh3lwjBUq6OBYAQuzqKiv/FNMnesb0cvDNutrcraAqs6FWYraWvPYUdfTsb8lF2dInEeehV82mPKCk7R7zv4HktwzTA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8435d89-fbf7-4ff1-586e-08d7b71b9405
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 22:15:36.9663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYxh3ImlHzLLVAMtUqrbs+Sqq+k39fWSFsB7VdcuYar2363jV+v/HUAbhdQ9+v3teylNDIW1woIq/WI2oHwMvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR13MB1392
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend: Sorry for the dup.  I forgot to include the maintainers, and I had=
 the LKML
address wrong.)=20

I was trying to set up my machine to do some documentation work,=20
and I had some problems with the sphinx install.  I figured out how to work
around the issue, but I have a question about how to add the information
to scripts/sphinx-pre-install (or whether it should go somewhere else).

Detailed messages below, but the TLl;DR is that I got the message:
-------
You should run:

    sudo apt-get install dvipng fonts-noto-cjk latexmk librsvg2-bin texlive=
-xetex
    /usr/bin/virtualenv sphinx_1.7.9
    . sphinx_1.7.9/bin/activate
    pip install -r ./Documentation/sphinx/requirements.txt
    ...
------

The pip install step didn't work, and I found that I needed to have everyth=
ing
based on python3 instead.  When I replaced:
    /usr/bin/virtualenv sphinx_1.7.9
with
    /usr/bin/virtualenv -p python3 sphinx_1.7.9
everything worked.

This message is coming from scripts/sphinx-pre-install (I believe on line 7=
08).

Should I go ahead and submit a patch to add '-p python3' to that line?

Are there any downsides to enforcing that the virtualenv used for the
documentation build use python3 only?

Thanks,
 -- Tim

Gory details:
I'm running on a machine with Ubuntu 16.04, and I have both python2 and
python3 installed (with /usr/bin/python linked to python2.7).

When I tried to do:
$ make htmldocs
I got the following messages:
...
You should run:

    sudo apt-get install dvipng fonts-noto-cjk latexmk librsvg2-bin texlive=
-xetex
  =20
    /usr/bin/virtualenv sphinx_1.7.9
    . sphinx_1.7.9/bin/activate
    pip install -r ./Documentation/sphinx/requirements.txt
    If you want to exit the virtualenv, you can use:
    deactivate
---=20
Following these instructions, at the 'pip install' step, I got:
$ pip install -r ./Documentation/sphinx/requirements.txt=20
DEPRECATION: Python 2.7 reached the end of its life on January 1st, 2020. P=
lease upgrade your Python as Python 2.7 is no longer maintained. A future v=
ersion of pip will drop support for Python 2.7. More details about Python 2=
 support in pip, can be found at https://pip.pypa.io/en/latest/development/=
release-process/#python-2-support
Collecting docutils
  Downloading docutils-0.16-py2.py3-none-any.whl (548 kB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 548 kB 2.2 MB/s=20
Collecting Sphinx=3D=3D1.7.9
  Downloading Sphinx-1.7.9-py2.py3-none-any.whl (1.9 MB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 1.9 MB 30.7 MB/s=20
Collecting sphinx_rtd_theme
  Downloading sphinx_rtd_theme-0.4.3-py2.py3-none-any.whl (6.4 MB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 6.4 MB 25.6 MB/s=20
Collecting alabaster<0.8,>=3D0.7
  Downloading alabaster-0.7.12-py2.py3-none-any.whl (14 kB)
Collecting Pygments>=3D2.0
  Downloading Pygments-2.5.2-py2.py3-none-any.whl (896 kB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 896 kB 35.1 MB/s=20
Collecting Jinja2>=3D2.3
  Downloading Jinja2-2.11.1-py2.py3-none-any.whl (126 kB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 126 kB 26.2 MB/s=20
Collecting requests>=3D2.0.0
  Downloading requests-2.23.0-py2.py3-none-any.whl (58 kB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 58 kB 774 kB/s=20
Collecting packaging
  Downloading packaging-20.1-py2.py3-none-any.whl (36 kB)
Collecting snowballstemmer>=3D1.1
  Downloading snowballstemmer-2.0.0-py2.py3-none-any.whl (97 kB)
     |=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-^=E2-=
^=E2-^=E2-^=E2-^| 97 kB 1.1 MB/s=20
Collecting sphinxcontrib-websupport
  Downloading sphinxcontrib_websupport-1.1.2-py2.py3-none-any.whl (39 kB)
Requirement already satisfied: setuptools in ./sphinx_1.7.9/lib/python2.7/s=
ite-packages (from Sphinx=3D=3D1.7.9->-r ./Documentation/sphinx/requirement=
s.txt (line 2)) (45.0.0)
ERROR: Package 'setuptools' requires a different Python: 2.7.12 not in '>=
=3D3.5'

