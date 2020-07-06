Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B55C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BBD2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="qJAL9bSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbgGFO3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:29:39 -0400
Received: from mail-dm6nam12on2048.outbound.protection.outlook.com ([40.107.243.48]:47712
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729201AbgGFO3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQbZVlWFVprl7ZKMUf9pcoqrszCqweAqVS1nJYmd9WG0FZqbJHgTo5CYinwmvwoMxkbMDUpN1T9yfA5r+5SlZKyL/+8dRnG2aHmPMSZIs48iDZF+bXgCP+f1Fe61owQ7ILyHLhHPB0j/hCwdLSlK5ZDF3UMO+YFUUzMY7FH/Fkp097W0H3FejpiDcAWi1uEfHPZxL7NcxMFNjqm+h0Yw+jnKTUlYxoPPFCqnBy99wvje09qfrazCJsHsfBa+BEb9g/6I7eDH3YXl7vz++ILYpoAB/jClL4CuqqY6FkgT9e6qW6rig9A0RbRwqMK+vaSTaIhxLucvPMIATwft8wkFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Dx544Hh/IDUA2Pr5WTHrouJvb7zZ3ycTfNo5DsdUM=;
 b=Y14eT7vlXLKxPH+Y+OtoFm9e5PRuXfJjkq+Dc4GDU2dTHKuFDnWlL4ooJgScDZUnIGdV+fcELvcFiQ04d+DEdna3z22DmmpFYPKoS4FNenNm8aVi5gDjZP0eF5Lff9OMcxrOCmfXexQYb0U4NUC9Rozw/xoSZ+88xUplcdymkVNWklqa+a3Q5X1OsMvMqPeW9xbnXKxbtrSsAHmJZ/y650jP0B4wchANxm3YaNuPWG0GhF5eyCCHqmu9tvPy6P0pIPOSTLE3cKqr6DdCHht/z0qZRAk7AZ5dMLzkvbG78gwVbmf5yMoupBhee/jLJoenNWNTeFqazowe2qh43++6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7Dx544Hh/IDUA2Pr5WTHrouJvb7zZ3ycTfNo5DsdUM=;
 b=qJAL9bSVR+rqKW/NDxuObr9nnSkVJ6AgQtlRZCCydZOoac4j3grK9tGYm4yUPsqy5ncawUOtHgU0486Z4vKRkIutgLNbYQcO8kFylgCc6MRCrtBjW9Srmaz/yjlly6H5e9AIbvIy+W9cRlkr0f9NmkDLUsp/D6vJgXhLTfcKcXQ=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4104.namprd11.prod.outlook.com (2603:10b6:a03:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 14:29:36 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 14:29:36 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IGZpeCBt?=
 =?gb2312?B?aXNzaW5nIHNwaW5sb2NrIGluIGZfdWFjMV9sZWdhY3k=?=
Thread-Topic: [PATCH v2] usb: gadget: function: fix missing spinlock in
 f_uac1_legacy
Thread-Index: AQHWU2vcjKFwJdWIC0ms8vCJ2RZbE6j6WmEAgABBxzc=
Date:   Mon, 6 Jul 2020 14:29:35 +0000
Message-ID: <BYAPR11MB2632AD4B8022D3CD82E420EAFF690@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200705061616.833-1-qiang.zhang@windriver.com>,<20200706103130.GB10624@kroah.com>
In-Reply-To: <20200706103130.GB10624@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [106.39.149.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ffcc1b0-8d54-4447-9805-08d821b90216
x-ms-traffictypediagnostic: BY5PR11MB4104:
x-microsoft-antispam-prvs: <BY5PR11MB410460F6379E44E0746ABC9DFF690@BY5PR11MB4104.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eag2PFQDxYpdk3r0PKhMv3JGxGDe92oc4pynDTA9XHwsqC0pbE9BmooLFuxufAkjTNi5RRV7cJMr3HKLHMwjsC4gy2lIc53C6qvtqNjJUxXQIKD23I06Opvm/rPuqvOuDXwn61K8Q62bkdJ69R6ZbUU9acHIiaUzelv/MooQBtb8pTjivYO/jVc2s0OEyEI3jcDjNOIvQwEfmlV78MV/SgPFLH3IY9qr5+MwkK59jhbCH0kmnRHaKy20uPgBvKPbmhPyPX4U0QjHw2epj8JM0YBQSWyzm6Uy+PdV7NQYTHBnyL+mRcjSUmwLAmYYeRstRP1ptx3ySoUiU6KEZhl1Hg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(376002)(396003)(136003)(346002)(366004)(83380400001)(71200400001)(478600001)(316002)(54906003)(4744005)(33656002)(7696005)(52536014)(64756008)(66556008)(66476007)(4326008)(66946007)(8936002)(6506007)(66446008)(186003)(86362001)(76116006)(91956017)(2906002)(6916009)(9686003)(26005)(5660300002)(55016002)(224303003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: juKj1NXw+98Pq85+6A8JtV9MV1jaxSAu5i3Q3YMT7fRzak7r2kthiJNNS94fkWIjE0TDuU46/dqxXe3Dpl2EVDpajTPrCoUexB2K2dkLSfVmw4XVKpqd7XYu9IjvkCvYQ9JJRCFfBsQSCE1B3OLw/7Bc10H6TUQ0rfuNAtNKtQNJyaTnG/jnbkDAZIRGhS8tmbVSAuXAETiA8gJVKmyE+eBbRodfa9K50HSPuGwwghHSVsYICnxla7yAHOwRBV/aL1qsisW39xG4AU2vEEbAe0wKB+RQNHcuyBJpy4hEz86jYhdWG9CKwfZ295Oi6JbqVD5Xf7lrkBZG7rViCHkDY5wLcUlB02A9JNJtVxi94mpp1w7oPChwppzs3RhzxQEVtyFNyKv2WZhiiPzeigXq+D08d8tseuhOhfhENe9zCRY79wOWS3mK7s6N3XZ8GvRNTPKtlJY5pTXR3MUofXMQtt5d90YiyUzxAGPj9x0JAb4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ffcc1b0-8d54-4447-9805-08d821b90216
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 14:29:35.8887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSHKoV9bYJNmQSGdLAesfaQpJ3JRJ/RAhURzCtnQM2ngXCeDRrvjzaF1LJmZCu17LfQXIZ8Z9xcLv7NErSHEodGKmndPa7UKgXq30IK0S0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciB5b3VyIHN1Z2dlc3RpbiBHcmVnIEtIDQpJIHRoaW5rIHRoZXJlIGlzIG5vdCBu
ZWVkIGZpeCB0YWdzLiBJIHdpbGwgcmVzZW5kLg0KDQp0aGFua3MsDQpaaGFuZyBRaWFuZw0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQq3orz+yMs6IEdyZWcgS0gg
PGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0Kt6LLzcqxvOQ6IDIwMjDE6jfUwjbI1SAxODoz
MQ0KytW8/sjLOiBaaGFuZywgUWlhbmcNCrOty806IGJhbGJpQGtlcm5lbC5vcmc7IGNvbGluLmtp
bmdAY2Fub25pY2FsLmNvbTsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0K1vfM4jogUmU6IFtQQVRDSCB2Ml0gdXNiOiBnYWRnZXQ6IGZ1bmN0
aW9uOiBmaXggbWlzc2luZyBzcGlubG9jayBpbiBmX3VhYzFfbGVnYWN5DQoNCk9uIFN1biwgSnVs
IDA1LCAyMDIwIGF0IDAyOjE2OjE2UE0gKzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20g
d3JvdGU6DQo+IEZyb206IFpoYW5nIFFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPg0K
Pg0KPiBBZGQgYSBtaXNzaW5nIHNwaW5sb2NrIHByb3RlY3Rpb24gdG8gdGhlIGFkZCBvcGVyYXRp
b24gb2YgdGhlICJhdWRpby0+cGxheV9xdWV1ZSINCj4gaW4gImZfYXVkaW9fb3V0X2VwX2NvbXBs
ZXRlIiBmdW5jdGlvbi4NCg0KVGhhdCBzYXlzIF93aGF0XyB5b3UgZGlkLCBidXQgbm90IF93aHlf
IHlvdSBkaWQgdGhhdC4gIFdoeSBpcyBhIGxvY2sNCm5lZWRlZCBoZXJlPyAgV2hhdCBkb2VzIHRo
aXMgcHJvdGVjdD8NCg0KV2hhdCBrZXJuZWwgY29tbWl0IGRvZXMgdGhpcyAiZml4Ij8gIFB1dCB0
aGF0IGluIHRoZSAiRml4ZXM6IiBsaW5lLCBhbmQNCnByb2JhYmx5IHlvdSBuZWVkIGEgImNjOiBz
dGFibGUiIGluIHRoYXQgYXJlYSB0b28sIHJpZ2h0Pw0KDQp0aGFua3MsDQoNCmdyZWcgay1oDQo=
