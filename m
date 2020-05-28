Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3AAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 439F3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="S1emaa+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgE1LUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:20:43 -0400
Received: from mail-dm6nam10on2060.outbound.protection.outlook.com ([40.107.93.60]:6086
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388038AbgE1LUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:20:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOP69MZpOBlh7oSf+qsW/YYdgEqNhxz92zJZogapmXy4vEywGzq39+rMHfsLBdR94fTsIVGEjdvWQd0c7Dw/rbHbKCSosL9xJSOQelbKOF/rP7h2STpqmHiTDn9eSeRI3oe7vMXBgztkUO1bNcLQcIKRDJ+THJOeY18yv3aayzpJry/tPqpBSqlbaN3xNFZSKOIkm9/wtYB16hyBirVDyxQC+vs1KCeVKmnKw+qw53bwstX1bbzpmYV19gPkD6zWpxDoPAGlINsdvPDtpq8z30G9M09nLQdd5wS+5Uw5Xk4uxQoBlFITkTWh8MVcz3wp1AyVEOYsNXXy6G+NePFtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo5Dh9xGDTR81/adAM/fo7RTuDqeGnYI/OcCyaKkeoE=;
 b=ksJRWk+W5C+0iSwyAkFfQva0Q1SZYRrT3gFnz3IZ5YPntW2SQcYvl7rz9frBKNflo/uYu1HhUvzZBVmhiH7umXBGa8ro70IRRqLi5Lcjy0XQn2QI9ncQUjcsU/DB4Y/aen7QeKtFpyeto0aaOGYi3N3owoiT5XRG2nF/FurNWnpdLHG53SHZ827m1N0E72Xk3EHjtRXIHDmt2/9GFV+umrP1K0XQgVuUsZR09jBSYplPTzKejFyB1UIsX4Q9gQKGVEWuTtdO/oA7DLe3EN8t93C+bpGarUaGVIxPnDHlKgBy/7OkxuTKAVAmVcGy7rzL4nLk8bzDzCnE++DosVd1vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oo5Dh9xGDTR81/adAM/fo7RTuDqeGnYI/OcCyaKkeoE=;
 b=S1emaa+nEFJweaZgsdWfohjtWlFcKbsd40kk7hD+/WKrt8WBXjgJgwUOTy5XWH2DrLCDVhrcNA4whxZUCRJBT4OdY0d8O21ZiXehvoJxNZ5+AnxMKGhupdC3UBhSmhytlcyr61e1uX4xW6dfDpwyec59xx4j/gf26GIuRGbald0=
Received: from MN2PR05MB6381.namprd05.prod.outlook.com (2603:10b6:208:d6::24)
 by MN2PR05MB6877.namprd05.prod.outlook.com (2603:10b6:208:18f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.7; Thu, 28 May
 2020 11:20:37 +0000
Received: from MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff]) by MN2PR05MB6381.namprd05.prod.outlook.com
 ([fe80::7803:13e7:2e4d:58ff%3]) with mapi id 15.20.3066.007; Thu, 28 May 2020
 11:20:37 +0000
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
Thread-Index: AQHWKIdKPHhk+fo7OUe7+WKkK8SJkqilhT4AgABhFAD//6nZgIAAsMCggBXlzwCAAQnu4IAAQWZg
Date:   Thu, 28 May 2020 11:20:37 +0000
Message-ID: <MN2PR05MB63812E53E1526A18DD593BD6CD8E0@MN2PR05MB6381.namprd05.prod.outlook.com>
References: <d29f87f3f3abb4e496866253bd170faad976f687.1589305630.git.ashwinh@vmware.com>
 <20200513055548.GA743118@kroah.com>
 <89DE19F6-4CB0-4324-A630-C8574C8D591C@vmware.com>
 <20200513063455.GA752913@kroah.com>
 <MN2PR05MB63814CDAAF6828285929736ACDBF0@MN2PR05MB6381.namprd05.prod.outlook.com>
 <20200527153130.GA525531@kroah.com>
 <MN2PR05MB63818AE71850AD653E60E517CD8E0@MN2PR05MB6381.namprd05.prod.outlook.com>
In-Reply-To: <MN2PR05MB63818AE71850AD653E60E517CD8E0@MN2PR05MB6381.namprd05.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=vmware.com;
x-originating-ip: [106.51.141.116]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ae88b23-9a59-47d7-4a5a-08d802f925c0
x-ms-traffictypediagnostic: MN2PR05MB6877:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR05MB6877772F7360796F61AB57E2CD8E0@MN2PR05MB6877.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbQrHt9VzRyisIgjAB8lsUL6guPf8/yh6L6W+RaiUpIM9cT0HntKdM+e8dAj6IHRQuk9VzwY8YiNApaJwGxTIf2qG7/xbqiKJ8Xa6ohTJf9Cc/E1bjfX3n1m2RFVYcE5f+F+/ss6TCwFy070btU1SwbroIecVP4E4bBxqZ/hUeyTAg/XkNXH72fgfZ0QdQT4htbf/XmH8aw31iNV2/pS1ux0Aivm+fq7C3yZ3NbQqxokgyh+tRHckfGgHfT4AlpEFhjHsltdVyG9Kg+kpx2RVMpP3oAxAq+Z2jgh1DbdjLPw7Z6awTJGQqfXngunwo0IUQlKCzJOckK9r+y90O5pjKiqpZ059L1fwqNC26AthLS25//by8ihgSQiigOJGxnhuYJu2dF33HXjEy+TOM7gXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR05MB6381.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(71200400001)(316002)(7696005)(86362001)(2906002)(186003)(26005)(83380400001)(9686003)(4326008)(2940100002)(64756008)(45080400002)(5660300002)(76116006)(8676002)(52536014)(66476007)(53546011)(966005)(6916009)(55236004)(66946007)(54906003)(55016002)(66446008)(66556008)(8936002)(478600001)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: x2L1EK5KzGWptHKcTY00Em2RIyH2xG7uXUfMVMQ7+JiX/GgkMayO6qfoiCrVN+d2S7kjHxDk8zRRiU5SrOBCu/t/zsWk58xQC8UUhHJ2jaVgpsHVgbEZeBngx/AAkFI9LDl8axF+Hw/bigjEQWI/ZyAp+FdW5+xXz3ZPofrvaIQarT0uqlu17/qLenwbIPsy/KtI67SGxCu2IMTPn8/IlgQuaeZXsBDqIF403E/SzynNIfgGGU/DFGw6I7KRqkNaRri1WSuta57Ex9+VjiBsgPBKpl0FPJ0CKsMs704AMzSL/1h69NlGrcHl9zbUVB1xyj9obkf/M9Cr8U5xLfMp8fw+7F5mWO3mPAQxYAOihBtOh/9UDtKiwBrib5xWhG7kah/xzdo9S+7b3PL2+Qa4yY810QmP6t6csv8b4FI/NxErePH1BsWSwFyYKdN5ocwCD4rCqpfOaQCg16BeR9IAs2+GFmD0LGnytTvy9OSVuzwz8Ad9l6ly38MUxxMU5yeD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae88b23-9a59-47d7-4a5a-08d802f925c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 11:20:37.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tWLfp6yKByd1o2zMyiEJ/l+nP8/VJ32hku4yLnTjE12vrbBW83T7AeXpgli8p3OiWi+fUIUU4MT+9/DGp50+Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB6877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ashwin H
> Sent: Thursday, May 28, 2020 1:01 PM
> To: Greg KH <gregkh@linuxfoundation.org>
> Cc: x86@kernel.org; dri-devel@lists.freedesktop.org; intel-
> gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org; stable@kernel.or=
g;
> Srivatsa Bhat <srivatsab@vmware.com>; srivatsa@csail.mit.edu;
> rostedt@goodmis.org; Steven Rostedt <srostedt@vmware.com>; Linus
> Torvalds <torvalds@linux-foundation.org>
> Subject: RE: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()'
>=20
>=20
>=20
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, May 27, 2020 9:02 PM
> > To: Ashwin H <ashwinh@vmware.com>
> > Cc: x86@kernel.org; dri-devel@lists.freedesktop.org; intel-
> > gfx@lists.freedesktop.org; linux-kernel@vger.kernel.org;
> > stable@kernel.org; Srivatsa Bhat <srivatsab@vmware.com>;
> > srivatsa@csail.mit.edu; rostedt@goodmis.org; Steven Rostedt
> > <srostedt@vmware.com>; Linus Torvalds <torvalds@linux-foundation.org>
> > Subject: Re: [PATCH v4.19.x] make 'user_access_begin()' do 'access_ok()=
'
> >
> > On Wed, May 13, 2020 at 05:08:19PM +0000, Ashwin H wrote:
> > > > Ok, but what does that mean for us?
> > > >
> > > > You need to say why you are sending a patch, otherwise we will
> > > > guess
> > wrong.
> > >
> > > In drivers/gpu/drm/i915/i915_gem_execbuffer.c, ioctl functions does
> > user_access_begin() without doing access_ok(Checks if a user space
> > pointer is valid)  first.
> > > A local attacker can craft a malicious ioctl function call to
> > > overwrite arbitrary kernel memory, resulting in a Denial of Service
> > > or privilege escalation (CVE-2018-20669)
> > >
> > > This patch makes sure that user_access_begin always does access_ok.
> > > user_access_begin has been modified to do access_ok internally.
> >
> > I had this in the tree, but it broke the build on alpha, sh, and maybe
> > a few others :(
> >
> Thanks Greg for including this patch.
> I am sorry that this patch caused the failure. As I see this is not a bui=
ld failure
> but tests have failed.
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 421 pass: 390 fail: 31
> Failed tests:
> 	<all alpha>
> 	<all sh>
> 	<all sheb>
>=20
> > See:
> > 	https://nam04.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F
> > %2Flore.kernel.org%2Fr%2F20200527140225.GA214763%40roeck-
> >
> us.net&amp;data=3D02%7C01%7Cashwinh%40vmware.com%7Cd8f60bb8a4584
> >
> 7caa10f08d802530997%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C0%7C0%7
> >
> C637261902960990057&amp;sdata=3DVjv9v0QhebfcOGSq1UUDKshTDA%2FOV
> > 4aKbqzKKJkEQxM%3D&amp;reserved=3D0
> > for the details.
> >
> > Can you dig out all of the needed follow-on patches as well, and send
> > them all as a patch series for 4.19.y so that I can queue them all up a=
t once?
> >
>=20
> I will check for follow-on patches and get back.

This seems to be the issue in alpha and SH
https://lore.kernel.org/lkml/6a4fe075-a644-1b06-305b-9e55b8c9575b@roeck-us.=
net/#t

alpha and SH had buggy implementation of access_ok

Thanks,
Ashwin

>=20
> > thanks,
> >
> > greg k-h
>=20
> Thanks,
> Ashwin

