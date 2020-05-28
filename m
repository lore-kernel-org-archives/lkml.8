Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2DE2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="qL9bpDOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgE1Hai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:30:38 -0400
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:11105
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgE1Hae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:30:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKjk6MUL0AbvsMrWqyWtM4bATpX6RrrbAVB/43dCmzTRq7ytXLZcruG+EFHS0PV8bD1t1QC0v0Hjt7YUImEKUNZQ5GsrCl6X3iv9Ljmz8RKtLIAOvYq+zH+9ruUql5k5LKTVohf+XKRtfTjkbhG+Pjbfh/veXqdnsT+ququVkbnzPPuQEIdVSEzs5jSOMEudzPhIhUYYQUlM9T4Gj+z9nRviWFAAV5awr/BLIF87YLYvrXwdYdfmztGVj/i1TEI1GaE7p4ifFhJ7ywJR2m3DdcwwN12NNEp04bv18ipaM0c+dxqBWlSWnVjBUyTkQPEn62rJlhhHZnOOHseR9qeJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98TzveflbfTcwFSXAZ5jgvqD0Ew7ZhXLjnZNNGsnk6I=;
 b=WMN8suAVXgXFjaYVcYRkNCER2t81TTkjKdA4Q056pbDrZJF2ySu0zFsS3+KujRwVOT8tL7XkvJbETA3QR2AtecwfHGHbOK2QysfggKhMHK9+tQpw3CceWwFzbPuCYZTbEFGO2x/bKL8eHrcMr+BPEtqTWQQUQLXocZB+y/EUFKD3Q02fYkLLOxgDVEWJ19DPUSyA1IotzoH71ImDDexFmv12jw/PEwFCGfOXJ9L7d6ECT7fM9eykBXkGoyegzk8QofphXbf2w/B+PSXENRZ2pU6x/nStdBOdDryIrQKBQo0JPd80cclukuz82O/T62GAHmdk2e9/dhOSV//+ABov2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98TzveflbfTcwFSXAZ5jgvqD0Ew7ZhXLjnZNNGsnk6I=;
 b=qL9bpDOKU91UOaDXMga4q5ziIkypgw+wz3icQKMZadQTEYRiBU1T1czfP9rKX4OFI/4xeswqJ25hrpvbjYs5Iy3sxrCsSmpvBY6UHiQhVmR5tEYeEIENlasIR2xcfYjjbSGNR79K+SAMfGw9TILdtepXgAC8dg2ksabkZG7YVKE=
Received: from MN2PR05MB6381.namprd05.prod.outlook.com (2603:10b6:208:d6::24)
 by MN2PR05MB6381.namprd05.prod.outlook.com (2603:10b6:208:d6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.7; Thu, 28 May
 2020 07:30:31 +0000
Received: from MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff]) by MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff%3]) with mapi id 15.20.3066.007; Thu, 28 May 2020
 07:30:31 +0000
From:   Ashwin H <ashwinh@vmware.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Steven Rostedt <srostedt@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
Thread-Topic: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
Thread-Index: AQHWKIdKPHhk+fo7OUe7+WKkK8SJkqilhT4AgABhFAD//6nZgIAAsMCggBXlzwCAAQnu4A==
Date:   Thu, 28 May 2020 07:30:30 +0000
Message-ID: <MN2PR05MB63818AE71850AD653E60E517CD8E0@MN2PR05MB6381.namprd05.prod.outlook.com>
References: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
 <20200513055548.GA743118@kroah.com>
 <89DE19F6-4CB0-4324-A630-C8574C8D591C@vmware.com>
 <20200513063455.GA752913@kroah.com>
 <MN2PR05MB63814CDAAF6828285929736ACDBF0@MN2PR05MB6381.namprd05.prod.outlook.com>
 <20200527153130.GA525531@kroah.com>
In-Reply-To: <20200527153130.GA525531@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-originating-ip: [106.51.141.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d88f7f6-a633-436d-9d3f-08d802d90061
x-ms-traffictypediagnostic: MN2PR05MB6381:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB63810BD4EEF2549E881B566ACD8E0@MN2PR05MB6381.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30eYHan09ATRIk/TCdhG32ogQzu1h5okFSXu7BDdNZZC5TgdzHjxd5v35/LK8UFqUQBcHvLkj8sxg+JGg03CtPhkDOk20hVCCDWIYHYuJ3k91y2tKAKe7IdOlCPCZ13QXpQTP+jFgTuqVNtd5dtymSWGH0hqaNncrAP+JON6PB7OIPyDvYj1huArkl3TjbdgUiRvEtWrARU838fuhRreLyPQJHTfmrzzHt+vRDL5WFq0lD2pOpe5rJBT+o9c43BMKNvo105AA87Oybrd2DM/AIgYJXnJGQscyveZtZSAv1lwzn4SFxD+DcVGXjqoN523/mJgwOboEdk4vgKTrWe+MqLKKOP7k2dsR/XQSsaR3ICKch9XAcywdqyphmheeriv9oLV7iuzNLyrSaT92zD4tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR05MB6381.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(76116006)(186003)(9686003)(8676002)(66946007)(66476007)(66556008)(64756008)(66446008)(52536014)(55016002)(478600001)(4326008)(45080400002)(83380400001)(8936002)(53546011)(55236004)(316002)(54906003)(6506007)(7696005)(966005)(26005)(6916009)(71200400001)(86362001)(5660300002)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: gXkt6fF5GSuSg8UoibAidEIcmLNH4NNFvmTq28ZRZ0KjAy/UtnO++fk2FRJC2laOVAUi6v5a8YtB7sZ03/H3BCN+P5IU6vI+5Y9X8ayf+Mo42m0Z4cf/uxBxe0slds1hT3Gsv/lRbSAHqAFH++DkHUTVELC2UgHVspOeZs8SE/h6g5iJ+sW2CjVVac8dg6lZD9Z5pS2+hfg9sVr9kAsAhrfQEYH/q+mEP3iNTsl6Vw7bXPWFnSK9uXSUc7jF8ZLn7GRijgcJ96QXDeRb2YJ+s3F3CUZ5JcZwORah5tBmo5LtHeKICZuE1XVGJwzhcXZMXT9TgK8XBu19VwX1fbcgu+FBsgBw00iIRfIvcFDCRMM5MRYMJMjY5GDQbDXvhry9S+pFwVcIcShOx0xugyoTDP6CjyiApWOU/W6+oTVADk1VYK+iifd7evVDvPJDfiyG+MmS9Z+WT8QrShxcmrpUV3lIRvxFVhpkJO8HQ16gnGwl4F0f7v0nc1QYVe9n2Sq3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d88f7f6-a633-436d-9d3f-08d802d90061
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 07:30:30.8562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjFv6e+SesgX9iIoBw95kBUdvtKDQaFRmSn5+WHLVwAXpBSoEBgTKKxQuc3rHsHsOYgFj3E7mJAfZobO6LysNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6381
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, May 27, 2020 9:02 PM
> To: Ashwin H <ashwinh@vmware.com>
> Cc: x86@kernel.org; dri-devel@lists.freedesktop.org; intel-
> gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; stable@kernel.or=
g;
> Srivatsa Bhat <srivatsab@vmware.com>; srivatsa@csail.mit.edu;
> rostedt@goodmis.org; Steven Rostedt <srostedt@vmware.com>; Linus
> Torvalds <torvalds@linux-foundation.org>
> Subject: Re: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
>=20
> On Wed, May 13, 2020 at 05:08:19PM +0000, Ashwin H wrote:
> > > Ok, but what does that mean for us?
> > >
> > > You need to say why you are sending a patch, otherwise we will guess
> wrong.
> >
> > In drivers/gpu/drm/i915/i915_gem_execbuffer.c, ioctl functions does
> user_access_begin() without doing access_ok(Checks if a user space pointe=
r
> is valid)  first.
> > A local attacker can craft a malicious ioctl function call to
> > overwrite arbitrary kernel memory, resulting in a Denial of Service or
> > privilege escalation (CVE-2018-20669)
> >
> > This patch makes sure that user_access_begin always does access_ok.
> > user_access_begin has been modified to do access_ok internally.
>=20
> I had this in the tree, but it broke the build on alpha, sh, and maybe a =
few
> others :(
>=20
Thanks Greg for including this patch.=20
I am sorry that this patch caused the failure. As I see this is not a build=
 failure but tests have failed.
Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 421 pass: 390 fail: 31
Failed tests:
	<all alpha>
	<all sh>
	<all sheb>

> See:
> 	https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F
> %2Flore.kernel.org%2Fr%2F20200527140225.GA214763%40roeck-
> us.net&amp;data=3D02%7C01%7Cashwinh%40vmware.com%7Cd8f60bb8a4584
> 7caa10f08d802530997%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7
> C637261902960990057&amp;sdata=3DVjv9v0QhebfcOGSq1UUDKshTDA%2FOV
> 4aKbqzKKJkEQxM%3D&amp;reserved=3D0
> for the details.
>=20
> Can you dig out all of the needed follow-on patches as well, and send the=
m
> all as a patch series for 4.19.y so that I can queue them all up at once?
>=20

I will check for follow-on patches and get back.

> thanks,
>=20
> greg k-h

Thanks,
Ashwin
