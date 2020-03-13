Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C6EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32AE720746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="HGFsVt52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgCMKuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:50:10 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68]:57072 "EHLO
        mx0a-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726420AbgCMKuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:10 -0400
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DAkqG9022722;
        Fri, 13 Mar 2020 03:49:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=cOm3nM+8UQAf5yfr9vbOrVSZXVWYXq/IdPh3vdykGfE=;
 b=HGFsVt5258QBzeDhCpt8GTQTmry7+cgl8h1XgGqqlevJAopVRfzCd8TSCDJqVqnEaTjA
 W5+LS/7BvwQhsDmzhKf1xCpxSU8khUk40swSnaeJqypxXH4blDCpvwnKHcFKf2LEZ5JZ
 Ims6V6/PKWiKt47Iw3nJZN7YSx8/fveDtMT/6nc97dorw7StnLVD3N9ub8sPycu85HtH
 wZPIwwUyEAD9KaWbiNmjV4dpvU/SKbuL4hQWMP9jl23jKlGG2F/Hs5CuN6hgoiE+KK2i
 JbSm6GtKWJY/mv+ONJ5ATMWmjcOwng2Cq+qPbhG+kcU7yR4Fvr6QMDaiXUOqD/WB2a31 ZA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-002c1b01.pphosted.com with ESMTP id 2yqt8q9rf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 03:49:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJQMRNPf1QaUbKe/GW76sX7jJ/7S0I8c5QtYGGvmepvj9qGHDgPb5uVpo6MzB/nsq8hCMImBhBPLQFOSqnaDaF7I7uKX598ChvINpi07IQvk8e7Zngg7M9QsCFOJ3N7nhwvC543c3rzXiWy3NHFFN125tjIEb4EVllcusSYdNgWj2W98TqFZ+dKilSgmCTfmiLSeog4+aasZT00wUwnANvLxwp2ER8WZuCGXq9ExXDcsX2gVyXz4O8K06aYAAVboWp3Y7SuDmsLqrCg1hjp4el5OeMog+xm9B49RZN0YflYnSauBcxQppQza3xpVLoauN51IIKmU2KMEKJZI4Fb7cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOm3nM+8UQAf5yfr9vbOrVSZXVWYXq/IdPh3vdykGfE=;
 b=iWaUFCz6ten3lKgrU8dPju2C2dR8AzZpl7hrVOlv1ooJIcrzwKlx1dRWhph37OKBTMnny00KZbYtMz3RGhr2iR9m9PDgFOnMI6gth3eXolScCMJn/H98CIvtsjoZefXH+43rgbXqUq3Y1840zOpg1/zfaSMY5M8/k6a1qbTyWEtnhkSziQZ4fMuGIWPvkpdcCCJKE6zCi2F6stfq5vGQiF0tUfhW2zyj/utFB3F5P7/tcVfA9Wz3ll/sMy2KQbQ3piyhY7IKsbTs4uFjAUL5aCJ4Tiz30zOmTyKktaTSwZu8eTV01sSmc8SM9QOj4XBN9xT4LEw3RKG1zU9y/hqz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BL0PR02MB5601.namprd02.prod.outlook.com (2603:10b6:208:88::10)
 by BL0PR02MB4642.namprd02.prod.outlook.com (2603:10b6:208:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Fri, 13 Mar
 2020 10:49:33 +0000
Received: from BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c]) by BL0PR02MB5601.namprd02.prod.outlook.com
 ([fe80::ddf8:e6cc:908f:a98c%6]) with mapi id 15.20.2814.007; Fri, 13 Mar 2020
 10:49:33 +0000
From:   Ivan Teterevkov <ivan.teterevkov@nutanix.com>
To:     Chris Down <chris@chrisdown.name>,
        Matthew Wilcox <willy@infradead.org>
CC:     David Rientjes <rientjes@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "oneukum@suse.com" <oneukum@suse.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Topic: [PATCH] mm/vmscan: add vm_swappiness configuration knobs
Thread-Index: AdX3zHNqbuFpQvKERxyPueA21j6FDgAD0RWAACPlSzAAAfzUAAAA7+kAACrp4sA=
Date:   Fri, 13 Mar 2020 10:49:32 +0000
Message-ID: <BL0PR02MB56011828432D343371088516E9FA0@BL0PR02MB5601.namprd02.prod.outlook.com>
References: <BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <alpine.DEB.2.21.2003111227230.171292@chino.kir.corp.google.com>
 <BL0PR02MB5601808F36BE202813E9D562E9FD0@BL0PR02MB5601.namprd02.prod.outlook.com>
 <20200312133636.GJ22433@bombadil.infradead.org>
 <20200312140326.GA1701917@chrisdown.name>
In-Reply-To: <20200312140326.GA1701917@chrisdown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.254.189.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c43d75cb-871b-4aff-9e8f-08d7c73c36f9
x-ms-traffictypediagnostic: BL0PR02MB4642:
x-microsoft-antispam-prvs: <BL0PR02MB4642EEDDF562BE217404A279E9FA0@BL0PR02MB4642.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 034119E4F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(4326008)(5660300002)(2906002)(6506007)(64756008)(66476007)(8936002)(66556008)(66446008)(66946007)(8676002)(54906003)(7696005)(81156014)(26005)(186003)(316002)(110136005)(9686003)(76116006)(86362001)(55016002)(71200400001)(478600001)(7416002)(81166006)(44832011)(33656002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR02MB4642;H:BL0PR02MB5601.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nutanix.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ONvCNTjk/2P5wXDcko+i2eqUMtvDZNqPTK+tQWupk8jOX3J0Oq/b9CkMoH+SLbsS0LLDcjvOdz01Jw2qHKO/But1jEfuZpqTaJ6OsSzYSgl/Vq9Jm4LLQkweHLb8fPAt7fogMXhfWtmfg7BgJGn7fWBS3YBqJaLGUjiCw1Q4gzpGJpkubJdz3aqoGMuza4kobj5qnoCZd4csZ8M99nrGRb7yBqLETMQhMq4ZPXWOfRSv7hWENYMZL0zsoBupmlyW5gVwKcY4sld/XQRUejXsrQQTe5DVj4w+oYVr6HH8BXdDF2zBrZ2Zrn2dvwokbjtY+f2s73swkDFQCq1UmUgb83GmK9hhgymDqBd9kLneaNQuv09tDQvvs7mdh+5JOm1+dQeGpdqEpxQ7um6zUAvGv0IwN8waXOT6knCdBTBrS5QLiRMgoYkMg6tVi3l++Vhd
x-ms-exchange-antispam-messagedata: REq4pho8XWRlNDilrWIOIesw3B+DQ+64lImfRFROgdCrvpJj9R58PyUrXyNoVNwfnykj6tcbZGmZRQs9yO2/3FwC+ld+N82kixHAkF0NrBUbBK2tm+A8A7s6uJLoW+mjL/TVKzH+h9eWuASRq/E57A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43d75cb-871b-4aff-9e8f-08d7c73c36f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2020 10:49:32.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /PlyYGk1cUVwPYztCcXTJ/qkOkRypmX3GN9feTl3D3yoJIZu5c6y7AYGJp4PiitkRv7mPm7MBQiOI69ORWRPHSX0rJQBLsiZgiV4dHZSGA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4642
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thurs, 12 Mar 2020, Chris Down wrote:

> Matthew Wilcox writes:
> >On Thu, Mar 12, 2020 at 12:48:22PM +0000, Ivan Teterevkov wrote:
> >> This is exactly what I'm trying to avoid: in some distros there is no
> >> way to tackle the configuration early enough, e.g. in systemd-based
> >> systems the systemd is the process that starts first and arranges
> >> memcg in a way it's configured, but unfortunately, it doesn't offer th=
e
> swappiness knob.
> >
> >This sounds like a systemd problem.  Have you talked to the systemd
> >people about fixing it in systemd?
>=20
> Hi there ;-)
>=20
> In general most of us maintaining cgroups in systemd run with cgroup v2, =
so this
> isn't a problem we run into in production. The swappiness controls in gen=
eral
> don't make a whole lot of sense being distributed hierarchically, so they=
've been
> phased out entirely in cgroup v2.
>=20
> If there had been a patch years ago implementing this in systemd we'd pro=
bably
> have accepted it, but cgroup v1 is dying and I am really not in favour of=
 adding
> more code to massage its rough edges. We already have enough problems
> generated by it already.
>=20
> However, the following kludge in tmpfiles.d should work to solve your
> immediate
> problem:
>=20
> 	w /sys/fs/cgroup/memory/system.slice/memory.swappiness - - - - value
>=20
> Taking my systemd hat off and putting my -mm hat on: let's not add more h=
acky
> APIs at cgroup v1's behest, or we'll be here until we're pushing up the d=
aisies.
>=20
> Thanks,
>=20
> Chris

The above approach doesn't work for me in el7 with systemd 219 or ubuntu 19
with systemd 242 because presumably the systemd-tmpfiles services start too
late. Please find the snippet at the bottom of the email.

The only approach that seems to work is to set up a service to run:

$ find /sys/fs/cgroup/memory/ -name memory.swappiness | while read -r name;=
 do echo 0 > "${name}"; done

I think this is quite ugly because there might be a race condition with
the systemd that could be creating the slices while the find is running.
One could suggest constraining the depth and going from top to the
bottom of the memcg but this still looks inherently unstable.

This is why I ended up with the vm_swappiness patch (which I don't
quite like myself) but this appears to be the only rock solid option
unless I've missed anything obvious. There is no doubt that cgroup v1
is due for replacement and vm_swappiness is frightening but they still
have certain advantages to employ until they are history.

$ systemctl --version
systemd 242 (242)
+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +=
GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PC=
RE2 default-hierarchy=3Dhybrid

$ cat /etc/lsb-release
DISTRIB_ID=3DUbuntu
DISTRIB_RELEASE=3D19.10
DISTRIB_CODENAME=3Deoan
DISTRIB_DESCRIPTION=3D"Ubuntu 19.10"

$ uname -a
Linux ubuntu 5.6.0-rc5-custom #1 SMP Wed Mar 11 14:59:15 GMT 2020 x86_64 x8=
6_64 x86_64 GNU/Linux

$ tail -1 /etc/sysctl.conf
vm.swappiness=3D10

$ cat /etc/tmpfiles.d/10-swap.conf
w /sys/fs/cgroup/memory/system.slice/memory.swappiness - - - - 20
w /sys/fs/cgroup/memory/user.slice/memory.swappiness   - - - - 30

$ find /sys/fs/cgroup/memory -name memory.swappiness | while read -r name; =
do cat "${name}"; done | sort | uniq -c
      1 10
     32 20
      6 30
     21 60

$ find /sys/fs/cgroup/memory -name memory.swappiness | while read -r name; =
do echo "${name}"; cat "${name}"; done | grep --before-context=3D1 60
/sys/fs/cgroup/memory/system.slice/systemd-udevd.service/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/sys-fs-fuse-connections.mount/memory.swa=
ppiness
60
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2d3\x2d28\x2d1804-116.mount/=
memory.swappiness
60
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2dlogs-81.mount/memory.swapp=
iness
60
/sys/fs/cgroup/memory/system.slice/sys-kernel-config.mount/memory.swappines=
s
60
--
/sys/fs/cgroup/memory/system.slice/snap-core-7917.mount/memory.swappiness
60
/sys/fs/cgroup/memory/system.slice/sys-kernel-debug.mount/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcharacters-399.mount/memor=
y.swappiness
60
/sys/fs/cgroup/memory/system.slice/swapfile.swap/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gtk\x2dcommon\x2dthemes-1440.mount/=
memory.swappiness
60
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcharacters-317.mount/memor=
y.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/systemd-journald.service/memory.swappine=
ss
60
--
/sys/fs/cgroup/memory/system.slice/dev-mqueue.mount/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gtk\x2dcommon\x2dthemes-1353.mount/=
memory.swappiness
60
/sys/fs/cgroup/memory/system.slice/snap-core-8689.mount/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2d3\x2d28\x2d1804-71.mount/m=
emory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-core18-1668.mount/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcalculator-501.mount/memor=
y.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/dev-hugepages.mount/memory.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-gnome\x2dcalculator-544.mount/memor=
y.swappiness
60
--
/sys/fs/cgroup/memory/system.slice/snap-core18-1223.mount/memory.swappiness
60
