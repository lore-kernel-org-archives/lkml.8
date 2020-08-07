Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA320855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="X45ayHjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgHGDME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:12:04 -0400
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:9153
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgHGDMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:12:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh2VSLp9f+wzWvLN+6fCxPWVad/R9ZIENT0Q33swaQz4/pKzEhzBE6D2KRxjIHkfqiBtEDpEUh58Lrz9yqW2cFu3pE+CJyTvzDuJ/0gx7FFUzkuHJOuO9C+DTsuoelvuq1AdKG8GxwOBn9EMHaVuhxJeFPV2/zsPbv9vdGx9yQWdAG0YjqnQqGevldKPG9MeZzOhZIUa9o+Vcoq7p3L3nWrDkwjDpRy5XK827o+Hb3vGlcShLwILwyWbiXP7ATaVTj6931q0SrCbSul7zvdcruNf/HhHlyBZxdks3c3WvJ0XursbSc3Et9jlHnOd0dY5fSWqBh+3RnWHEbljoyJP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7HYtVQEeMam4dtIRc60ChScNvBFasoceWzyswtaGfQ=;
 b=ivngB0Rw+qgw16x65JO75zKWndNQrjuatn8ZUZxLs527vGut15xYUvc1rqng1uAOeIGxH+UCll5xZS11+RHQkkGRz/yKSBn4u3JfxHjvhdOa9h4Wm8fPHqGDQm4Ra53XzbV6TyOA99D3QvAJ4DN4qwbLvKw+P4JgpGWTn9CRpobHkWb818e4NeBqXK/Ri3BkFF7lFsoWrp/3uLAcglOQ+TdXzT8HQUOEemo5FUP1qZSrPxmPLEn2mYjz4WaVd+szxiKipMotH4qR+s3Nyi1SG0eRrv6fMaEbFTf4oyxREAR7Q9Ppht0BTQjEzhGtSsMWvihtSNbSNsF57XgXkeUUog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7HYtVQEeMam4dtIRc60ChScNvBFasoceWzyswtaGfQ=;
 b=X45ayHjbQ11qHQZmlRHigX+YdVtz/bCPLPy3H95sYt43rgafqxiIH49ixU95RgKllapPaGWyPkhxJLrEPBcBNdT07DVAOAC6UfFKADPryuxQ7M4xIoVIYglN+Tm/shuSA93NsEuI6fm7AyoQ9H3cKkI50npEhV6eD5mGN/MpCls=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 03:11:58 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::d87a:b368:655c:e12b%7]) with mapi id 15.20.3239.022; Fri, 7 Aug 2020
 03:11:58 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?16q3ojogdXBzdHJlYW0gdGVzdCBlcnJvcjogV0FSTklORyBpbiBkb19lcG9s?=
 =?gb2312?Q?l=5Fwait?=
Thread-Topic: upstream test error: WARNING in do_epoll_wait
Thread-Index: AQHWavjOocYpF+4E4kCmcEqd8cRrxakr+Bc4
Date:   Fri, 7 Aug 2020 03:11:58 +0000
Message-ID: <BYAPR11MB26328A938028DD73AC6C3CF7FF490@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <00000000000080940e05ac1c301e@google.com>
In-Reply-To: <00000000000080940e05ac1c301e@google.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 549faf9a-2b24-4b9e-dded-08d83a7fa5a4
x-ms-traffictypediagnostic: BY5PR11MB4226:
x-microsoft-antispam-prvs: <BY5PR11MB4226866BBEF9F6B5CD17F96AFF490@BY5PR11MB4226.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IRSdgjx7YbI0uwhK6iUmvwbJUvdD3RzVAC5J7Ljrxi/75yiXu9VIYCFJasPJ3viCuoP/rRd32q6JDKYdw/9H6iyMSNcmydNDjYMLEgqVZ7HPp97rReRYaxaBv5J/Z/PQbQKrZ/GA2qakxbBhVZLA2qTQoVD7Y07cvROwAIkw1UgGxO2tsNS+mngyRmOg0rJ78W/8Mw22hRP3zC49M0QHMvwGkyrlaxQGHsXs6se8BjH1FgIwM6PDIXXfp3mTeEHw9CKUUjK1oo4d5lzwFSqcqDpc1RrbLLfSWA9n7z31hltcy2yaaB7a9jkbh1bMabnXP7WQqfYYJCfQSEt16XLSX96t5koxp4ZT9SVDqLOBM62aJPeW9w02xG6WAXosHdx/Dyv732jsjnnfoaMADs/GN3JfvI4hxWuT9IHlyLz5ntdodG7cWBpOseDdx7n6wlkyYdwePVhtBc1H38ieBHVbtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(39850400004)(366004)(346002)(136003)(52536014)(66946007)(76116006)(966005)(5660300002)(478600001)(86362001)(66476007)(66556008)(66446008)(64756008)(2906002)(4326008)(8936002)(83380400001)(33656002)(83080400001)(55016002)(9686003)(26005)(316002)(224303003)(110136005)(6506007)(186003)(71200400001)(91956017)(7696005)(99710200001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: FR4efr4V6eq0N6NYcfSTNeCsYlaSxO1n47zws+1kTbZfD3P4m1mujmdDYcjAvSQBitRn7wj9MiUqbGnck8lHIaBAkfzotxpXnjzcZQzfCFd/BhA99SxPzEi4UzpsEFtx2J4ffqGB0zDhEaFwN0nxWVXD4IxvBzayTToS6f6tVln3EQOXmEV9c00k3vwQ2zGzNgqnOYrb2bH5ZZg+xbN/jDRZUSc/8/D4QyZ28JsOLdIYERmQlhkBMpuWv4FyXIbacdlfgG1u1/WFzXmhAIGn8X+NAyEc3vI0Lb1JwkZFTL7jUWOTJSK5dUiu8AUd1V0XMIdTdduGkI1/V1r5k2wo7I08k7ZoJfwHu8gEF8ipnjsV4VhssYU6Q/YGC+84PjLdYQlV4UVsuHr4a1z9wuX2EL+ZoWaD9oYD2QeZ5Fi9lz/Q9m60TJ5yu8Pns0XUlucsDVMrBGdiS34zUGJHFZ08l0t5ZxsGjg1GHYYrW63Xvx+4Uis7iKbaBFnk0HSLLI9cBWFHi9Q7bagxv/Z1mWsr04fDpzy9O60kxQBDrd1DDlfg0OoeDz3H2/0ul7Wmuh1qrdTXzNTPcg5PH+8680KzfsCGA8l0e78FqX/1QUNipuhbpSLxHNDET/q6BryDvqwPDvnVsQ0CvC/ASq2Z/mIgvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 549faf9a-2b24-4b9e-dded-08d83a7fa5a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 03:11:58.5379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aElT4egJmCP5Kby/nz8uyb+pQUh1E7ikK4QThhyPBE3s8cuOpN6fmKpRbWzdbYUKnAZAPIyYmwXzV6ZEx01D5nekHLqdqi+qRqOSqwI9mP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgo+X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+t6K8/sjLOiBsaW51
eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5r
ZXJuZWwub3JnPiA+tPqx7SBzeXpib3QgPHN5emJvdCs0NDI5NjcwZDgyMTNmNWYyNjM1MkBzeXpr
YWxsZXIuYXBwc3BvdG1haWwuY29tPgo+t6LLzcqxvOQ6IDIwMjDE6jjUwjXI1SAxNToxOQo+ytW8
/sjLOiBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgPnN5emthbGxlci0+YnVnc0Bnb29nbGVncm91cHMuY29tOyB2aXJvQHplbml2Lmxp
bnV4Lm9yZy51awo+1vfM4jogdXBzdHJlYW0gdGVzdCBlcnJvcjogV0FSTklORyBpbiBkb19lcG9s
bF93YWl0Cgo+SGVsbG8sCgo+c3l6Ym90IGZvdW5kIHRoZSBmb2xsb3dpbmcgaXNzdWUgb246Cgo+
SEVBRCBjb21taXQ6ICAgIDRmMzBhNjBhIE1lcmdlIHRhZyAnY2xvc2UtcmFuZ2UtdjUuOScgb2Yg
Z2l0Oi8vZ2l0Lmtlcm5lbC4uLgo+Z2l0IHRyZWU6ICAgICAgIHVwc3RyZWFtCj5jb25zb2xlIG91
dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0P3g9MTRjNWE3ZGE5
MDAwMDAKPmtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5j
b25maWc/eD04YmRkOTk0NGRlZGYwZjE2Cj5kYXNoYm9hcmQgbGluazogaHR0cHM6Ly9zeXprYWxs
ZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTQ0Mjk2NzBkODIxM2Y1ZjI2MzUyCj5jb21waWxlcjog
ICAgICAgY2xhbmcgdmVyc2lvbiAxMS4wLjAgKGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xsdm0t
cHJvamVjdC5naXQgPmNhMmRjYmQwMzBlYWRiZjBhYTliNjYwZWZlODY0ZmYwOGFmNmUxOGIpCgo+
SU1QT1JUQU5UOiBpZiB5b3UgZml4IHRoZSBpc3N1ZSwgcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5n
IHRhZyB0byB0aGUgY29tbWl0Ogo+UmVwb3J0ZWQtYnk6IHN5emJvdCs0NDI5NjcwZDgyMTNmNWYy
NjM1MkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCgo+LS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBd
LS0tLS0tLS0tLS0tCj5XQVJOSU5HOiBDUFU6IDEgUElEOiA4NzI4IGF0IGZzL2V2ZW50cG9sbC5j
OjE4MjggZXBfcG9sbCBmcy9ldmVudHBvbGwuYzoxODI4IFtpbmxpbmVdCj5XQVJOSU5HOiBDUFU6
IDEgUElEOiA4NzI4IGF0IGZzL2V2ZW50cG9sbC5jOjE4MjggZG9fZXBvbGxfd2FpdCsweDMzNy8w
eDkyMCA+ZnMvZXZlbnRwb2xsLmM6MjMzMwo+S2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IHBh
bmljX29uX3dhcm4gc2V0IC4uLgo+Q1BVOiAxIFBJRDogODcyOCBDb21tOiBzeXotZnV6emVyIE5v
dCB0YWludGVkIDUuOC4wLXN5emthbGxlciAjMAo+SGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2ds
ZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgPkdvb2dsZSAwMS8w
MS8yMDExCj5DYWxsIFRyYWNlOgogPl9fZHVtcF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc3IFtp
bmxpbmVdCiA+ZHVtcF9zdGFjaysweDE2ZS8weDI1ZCBsaWIvZHVtcF9zdGFjay5jOjExOAogPnBh
bmljKzB4MjBjLzB4NjlhIGtlcm5lbC9wYW5pYy5jOjIzMQogPl9fd2FybisweDIxMS8weDI0MCBr
ZXJuZWwvcGFuaWMuYzo2MDAKID5yZXBvcnRfYnVnKzB4MTUzLzB4MWQwIGxpYi9idWcuYzoxOTgK
ID5oYW5kbGVfYnVnKzB4NGQvMHg5MCBhcmNoL3g4Ni9rZXJuZWwvdHJhcHMuYzoyMzUKID5leGNf
aW52YWxpZF9vcCsweDE2LzB4NzAgYXJjaC94ODYva2VybmVsL3RyYXBzLmM6MjU1CiA+YXNtX2V4
Y19pbnZhbGlkX29wKzB4MTIvMHgyMCBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pZHRlbnRyeS5oOjU0
Nwo+UklQOiAwMDEwOmVwX3BvbGwgZnMvZXZlbnRwb2xsLmM6MTgyOCBbaW5saW5lXQo+UklQOiAw
MDEwOmRvX2Vwb2xsX3dhaXQrMHgzMzcvMHg5MjAgZnMvZXZlbnRwb2xsLmM6MjMzMwo+Q29kZTog
NDEgYmUgMDEgMDAgMDAgMDAgMzEgYzAgNDggODkgNDQgMjQgMjAgNDUgMzEgZTQgZTkgN2YgMDEg
MDAgMDAgZTggNTkgYWIgYzYgZmYgNDEgYmMgZjIgPmZmIGZmIGZmIGU5IGM4IDAzIDAwIDAwIGU4
IDQ5IGFiIGM2IGZmIDwwZj4gMGIgZTkgNTggZmUgZmYgZmYgNDkgYmYgZmYgZmYgZmYgZmYgZmYg
ZmYgZmYgN2YgZTkgZjAgZmUgZmYgPmZmCj5SU1A6IDAwMTg6ZmZmZmM5MDAwMGUxZmUyOCBFRkxB
R1M6IDAwMDEwMjkzCj5SQVg6IGZmZmZmZmZmODE4NTYyOTcgUkJYOiBmZmZmODg4MTIwZmFmYTAw
IFJDWDogZmZmZjg4ODExZTE5NjQwMAo+UkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAw
MDAwMDAwMDAwMCBSREk6IDAwMDAwMDAwMDAwMDAwMDAKPlJCUDogMDAwMDAwMDAwMDAwMDAwMCBS
MDg6IGZmZmZmZmZmODE4NTYwZDggUjA5OiAwMDAwZmZmZjg4NjE5ZWI3Cj5SMTA6IDAwMDBmZmZm
ZmZmZmZmZmYgUjExOiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogMDAwMDdmZmZmZmZmZjAwMAo+UjEz
OiAwMDAwMDAwMDAwMDAwMDgwIFIxNDogMDAwMDAwMDAwMDAwMDAwMSBSMTU6IDAwMDAwMDAwMDAw
MDAwMDMKID5fX2RvX3N5c19lcG9sbF9wd2FpdCBmcy9ldmVudHBvbGwuYzoyMzY0IFtpbmxpbmVd
CiA+X19zZV9zeXNfZXBvbGxfcHdhaXQgZnMvZXZlbnRwb2xsLmM6MjM1MCBbaW5saW5lXQogPl9f
eDY0X3N5c19lcG9sbF9wd2FpdCsweDkyLzB4MTUwIGZzL2V2ZW50cG9sbC5jOjIzNTAKID5kb19z
eXNjYWxsXzY0KzB4NmEvMHhlMCBhcmNoL3g4Ni9lbnRyeS9jb21tb24uYzozODQKID5lbnRyeV9T
WVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg0NC8weGE5Cj5SSVA6IDAwMzM6MHg0NjkyNDAKPkNv
ZGU6IDBmIDA1IDg5IDQ0IDI0IDIwIGMzIGNjIGNjIGNjIDhiIDdjIDI0IDA4IDQ4IDhiIDc0IDI0
IDEwIDhiIDU0IDI0IDE4IDQ0IDhiIDU0IDI0IDFjID40OSBjNyBjMCAwMCAwMCAwMCAwMCBiOCAx
OSAwMSAwMCAwMCAwZiAwNSA8ODk+IDQ0IDI0IDIwIGMzIGNjIGNjIGNjIGNjIGNjIGNjIGNjIGNj
IGNjIGNjIGNjID44YiA3YyAyNCAwOCA0OCBjNwo+UlNQOiAwMDJiOjAwMDAwMGMwMDAwNGI3ZjAg
RUZMQUdTOiAwMDAwMDI0NiBPUklHX1JBWDogMDAwMDAwMDAwMDAwMDExOQo+UkFYOiBmZmZmZmZm
ZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwMSBSQ1g6IDAwMDAwMDAwMDA0NjkyNDAKPlJE
WDogMDAwMDAwMDAwMDAwMDA4MCBSU0k6IDAwMDAwMGMwMDAwNGI4NDAgUkRJOiAwMDAwMDAwMDAw
MDAwMDAzCj5SQlA6IDAwMDAwMGMwMDAwNGJlNDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTog
MDAwMDAwMDAwMDAwMDAwMAo+UjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAwMDAwMDAw
MDI0NiBSMTI6IDAwMDAwMDAwMDAwMDAwMDMKPlIxMzogMDAwMDAwYzAwMDA5Y2MwMCBSMTQ6IDAw
MDAwMGMwMDAzMmMxODAgUjE1OiAwMDAwMDAwMDAwMDAwMDAwCj5LZXJuZWwgT2Zmc2V0OiBkaXNh
YmxlZAo+UmVib290aW5nIGluIDg2NDAwIHNlY29uZHMuLgoKSW4gImVwX3BvbGwiIGZ1bmMgdGhl
IGxvY2tkZXBfYXNzZXJ0X2lycXNfZW5hYmxlZCBkZXRlY3RlZAogaW50ZXJydXB0IHN0YXR1cywg
YWx0aG91Z2ggYmVmb3JlIGVudGVyICJlcF9wb2xsIiBmdW5jLCBpcnEKICBpcyBhbHJlYWR5IGVu
YWJsZWQsIGJ1dCBpdCB3YXMgbWlzc2VkIGxvY2tkZXAgaXJxIHN0YXR1cyBzZXQuCgotLS0gYS9r
ZXJuZWwvZW50cnkvY29tbW9uLmMKKysrIGIva2VybmVsL2VudHJ5L2NvbW1vbi5jCkBAIC03Niw2
ICs3Niw3IEBAIG5vaW5zdHIgbG9uZyBzeXNjYWxsX2VudGVyX2Zyb21fdXNlcl9tb2RlKHN0cnVj
dCBwdF9yZWdzICpyZWdzLCBsb25nIHN5c2NhbGwpCiAgICAgICAgaW5zdHJ1bWVudGF0aW9uX2Jl
Z2luKCk7CiAKICAgICAgICBsb2NhbF9pcnFfZW5hYmxlKCk7CisgICAgICAgbG9ja2RlcF9oYXJk
aXJxc19vbihDQUxMRVJfQUREUjApOwogICAgICAgIHRpX3dvcmsgPSBSRUFEX09OQ0UoY3VycmVu
dF90aHJlYWRfaW5mbygpLT5mbGFncyk7CiAgICAgICAgaWYgKHRpX3dvcmsgJiBTWVNDQUxMX0VO
VEVSX1dPUkspCiAgICAgICAgICAgICAgICBzeXNjYWxsID0gc3lzY2FsbF90cmFjZV9lbnRlcihy
ZWdzLCBzeXNjYWxsLCB0aV93b3JrKTsKLS0gCkNhbiB3ZSBzaG91bGQgYWRkIGxvY2tkZXBfaGFy
ZGlycXNfb24/CgoKPi0tLQo+VGhpcyByZXBvcnQgaXMgZ2VuZXJhdGVkIGJ5IGEgYm90LiBJdCBt
YXkgY29udGFpbiBlcnJvcnMuCj5TZWUgaHR0cHM6Ly9nb28uZ2wvdHBzbUVKIGZvciBtb3JlIGlu
Zm9ybWF0aW9uIGFib3V0IHN5emJvdC4KPnN5emJvdCBlbmdpbmVlcnMgY2FuIGJlIHJlYWNoZWQg
YXQgc3l6a2FsbGVyQGdvb2dsZWdyb3Vwcy5jb20uCgo+c3l6Ym90IHdpbGwga2VlcCB0cmFjayBv
ZiB0aGlzIGlzc3VlLiBTZWU6Cj5odHRwczovL2dvby5nbC90cHNtRUojc3RhdHVzIGZvciBob3cg
dG8gY29tbXVuaWNhdGUgd2l0aCBzeXpib3QuCg==
