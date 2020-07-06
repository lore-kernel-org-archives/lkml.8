Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DF6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5762070C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="afV5a9+S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGFIBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:01:32 -0400
Received: from mail-dm6nam11on2080.outbound.protection.outlook.com ([40.107.223.80]:7993
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728299AbgGFIBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mv+oYvdHlQWK9gpE+N2K9q0CEmwz+3GeoCgylVNvo7rL+EeuG985gkBBqvzoiXhBkRfL+jZgCKfwpihicEx3NRHEjuivUOxHQ0Uvd68dyWhVC94xDWJNCJz4hX+tTW38FVLyBPZtXx13VuCCAVS6thROUVH5FwROpDJ2bWJ9I4Z6NOII8qQ9LQIjONLkqQQXxt/BvI2vfG5QSbZIIdboHVh1LbLWwmirRgUgU8/kM1UZkBV1vk0FKk3p7DfXLpRxZWqFdvuLldLapcVOqRC6GSeWiydJHfJoRyzGjQQKpo4JD5oipj2FOhOlX6tE6PUma0c82LE6A68dI2a2qghQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21ujyhzIpduBuwCSf32gvDncIv16w8y3JzWoqjlBoB0=;
 b=j8/ulF3QEhPcalSl9aOWG1hxxjhl5XRhtTcocPTrRwZ3N6PspHnDmBfpuxxp2oGfcav5JMPhZzjTaVmSsqM6EPSn80iSAaInAVMlcKErx/oG6wFDwKQ6/M43mvIhd1nFjGYLJ+1CuXAcWnrUIQHqpWeO6DLo3WFGlRwSs/aIfA+Qpl6SBv1dlrQHTpXEvfib7EmMmiDt/Mo6XLicQPtkFxIgJQ6BgtHhVYI7oLYuLRChIqBbo27IQPNUlsn6GuDSAU17JKszQP9CVgABgbVfc3aXf/pNrDg35gENoGlMHF+tIV6X1N849BPYVxDtkMLMvUxlP2vRKaU3yXHmJbs3ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21ujyhzIpduBuwCSf32gvDncIv16w8y3JzWoqjlBoB0=;
 b=afV5a9+SpUTBskV4lZhsFYZym/VlflYwue7Eode521Eg9uYnI5uqtmThH3ORUuN/gG5s1nVHFmqsZeXAXt2yGaunMsAkbxHiH0RPemNevUZoWoYvDdnyDHP6OPWrahr0GA7SES1321DdHxseeACsm6pK0zXGGAb1cICH5xoXbRw=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3912.namprd11.prod.outlook.com (2603:10b6:a03:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Mon, 6 Jul
 2020 08:01:26 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 08:01:26 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IGZpeCBtaXNz?=
 =?gb2312?B?aW5nIHNwaW5sb2NrIGluIGZfdWFjMV9sZWdhY3k=?=
Thread-Topic: [PATCH] usb: gadget: function: fix missing spinlock in
 f_uac1_legacy
Thread-Index: AQHWU0garYTc8CykzUCzjiGJP5dO1aj6Ks+AgAAFnrE=
Date:   Mon, 6 Jul 2020 08:01:26 +0000
Message-ID: <BYAPR11MB2632AED160FE3ABB846E26C7FF690@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200705015941.40485-1-qiang.zhang@windriver.com>,<20200706074015.GA1949998@kroah.com>
In-Reply-To: <20200706074015.GA1949998@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19948017-9f92-447c-5f1f-08d82182c896
x-ms-traffictypediagnostic: BY5PR11MB3912:
x-microsoft-antispam-prvs: <BY5PR11MB3912BEFAD4A40A7776DAEB9DFF690@BY5PR11MB3912.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxDscslQPO6Vw+4X/Pu1LU+BZRflBoL/VYJwJ8KmU9HNg95ZuhIgCf5AOIs0lNLd4/uuGTzVni8GASVA9SVLJjGtObqKFlWg+QUkGqSks2iE03RAprjsXuDLzLess0I+mAcDgoDLoSO6g03E4ZIyRc/XFE4lsAEts5AIuBZfOjJeJNZonWDYPX626MZnQN5B/OxKR1hHlRU3/Zrqh6ct6+FwDEoib8QNQ+8t2slVDzjymJIQW6sC46XGI8vgMlstDhwm5MFsmhXc+JLG1cPfQ6lCeIK4p3+NAGstv9CN2Yfg9Reg9kAKRRYxjxYRsNpU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(366004)(396003)(346002)(39840400004)(8936002)(2906002)(5660300002)(52536014)(6916009)(83380400001)(478600001)(54906003)(86362001)(316002)(33656002)(6506007)(7696005)(55016002)(9686003)(26005)(224303003)(186003)(64756008)(66446008)(4744005)(66946007)(4326008)(91956017)(76116006)(66556008)(66476007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 5bfovg4oi9ytWPix998Q/15AZeV8A+f9xIlKuS4eQbw7VtHtbCI0DAjwFKnTDBgJcEC8Mkwg+drKuHzAZv32rvQnAxepzvviK1Tb2gNhBqK1wuIZHCWUT8lrhh6coettagRKoYKdiiQdERHgj8uECSBwjktixqP9EXajHDfUC1oPCalEeuV4cwVw3oesgRz/GKBzP7WX2sFchND2bx6rAPb/r8IvpviWZ+ud3XLAjlUg6R8qCl98Ee3COYBGZH958XAfh56tCfuQrxX598+gV+GcnVxZee/cRM0AzCvsBmya+EzC2mBrA7ml3Wf3707TlTjzPm3uFsZCilKgvYPIKpJ5H6/oCR7lehPijHxQtfMWe7YYWBUX9WM4NfDgkoHqOQ681YxEAVTKr2aGfTA0W2qPekCfUtiuXheejaYNUHp8W5M0Y5XTlDE+HrFVQ5Y11gnVZInRYjZUJbIPhgeG01n4e5DqHQxRmAy/bHUTiY0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19948017-9f92-447c-5f1f-08d82182c896
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 08:01:26.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4aqcfgO8oseeI6bSSpZy0/3A+Bi4PjWDDuLNkl/FRSXjKnE1G/Aobke8fqwmco0TRoHIHNCoNi/zpxoVXczZpr0tznhvgT6TMfK6zp4hcbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksIEkgd2lsbCBhZGQgY2hhbmdlbG9nIGFuZCByZXNlbmQuCgpaaGFuZyBRaWFuZwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwq3orz+yMs6IEdyZWcgS0ggPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPgq3osvNyrG85DogMjAyMMTqN9TCNsjVIDE1OjQwCsrV
vP7IyzogWmhhbmcsIFFpYW5nCrOty806IGJhbGJpQGtlcm5lbC5vcmc7IGNvbGluLmtpbmdAY2Fu
b25pY2FsLmNvbTsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZwrW98ziOiBSZTogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IGZpeCBt
aXNzaW5nIHNwaW5sb2NrIGluIGZfdWFjMV9sZWdhY3kKCk9uIFN1biwgSnVsIDA1LCAyMDIwIGF0
IDA5OjU5OjQxQU0gKzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20gd3JvdGU6Cj4gRnJv
bTogWmhhbmcgUWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Cj4KPiBTaWduZWQtb2Zm
LWJ5OiBaaGFuZyBRaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVyLmNvbT4KCk5vIGNoYW5nZWxv
ZyB0ZXh0PyAgSSBjYW4ndCB0YWtlIHBhdGNoZXMgbGlrZSB0aGF0LCBzb3JyeS4KCmdyZWcgay1o
Cg==
