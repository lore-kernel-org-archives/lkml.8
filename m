Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8272072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 04:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="HzsKnYKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgFJE6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 00:58:47 -0400
Received: from mail-mw2nam10on2085.outbound.protection.outlook.com ([40.107.94.85]:32097
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbgFJE6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 00:58:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBHe5i6diy7wDHyLk4NzLcEb7HXoglNnJd9PphA/O4jvyQKeKbMB5SSoexE/BcFhdfToHEhKTf+F1P1IDwO2OBDWG7aF6P+pVXfGgsu1+8EIkNqSw/AiPzQ2ELfsBiSyhJUO2O9194WshqqFD7QaPxBaUZM54MMUQzaWDZz7+/67B5iQWhSjZUSWrnfW3N+BGffJxHUA3gtYUiNtiJCRRuItunW6eIYUn5ogVS7qKBaRfTQdswz6uqAGiAzsf04xePveyoRv/VZQ4p4xDTk3no7hOt8G4ZXBgTR2FexKUI+r0dSbh/HlYfxj2f9NpQ3lZ7skO7thxCoZGfrPXdrRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAQhn9rlXyNAa6YXnp0jP7IFEtViPNZQB0XXfp4efMs=;
 b=GMocdbYCMseGhBvKrE3ZrO8IC83cqC0DQYnkk3glispP+430Fqwc2pnXFNeCGGAx8lZW77wYz9+wOYaQ7txdkDcJaUlohhhHhZ3LpruCI+3uGJ8SERNUQ+bHxkN/PIc3Vz2qXGhcLVwYc21w5L2z5MGK3AveIRwuf9tXHFxK4CE9Fcqe/3/QSvyEUPbADZrs91VDkJZq0RXf/8nKCWrmAz8O6YwkLrXamz99BilTGV0nJASkjX4gpjI9huhoOIZi3pZZJT7+8DflXMi/beuTww75+67xnUgyHSkrRAzorHPiu89J3suT4YedjRBtPozAA8HZ1STL67WrrO+ty9UsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAQhn9rlXyNAa6YXnp0jP7IFEtViPNZQB0XXfp4efMs=;
 b=HzsKnYKxcEWbhlTVLMxvrSm9856hsxHZTZ7n5CVUNioFAK8CFyrkLMK0sUXgauD0X9k/JLnbJtWKBmyvKfxGCwpCm4sWSmLgFMb0ZpFA9UwvbRjpuz3eTXnvbVwhq9q9uWXHi0G5+sxGxg6rtThXrNMp6esbX7t05kCQfIjWTnk=
Received: from DM5PR11MB2058.namprd11.prod.outlook.com (2603:10b6:3:12::23) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Wed, 10 Jun 2020 04:58:44 +0000
Received: from DM5PR11MB2058.namprd11.prod.outlook.com
 ([fe80::38ae:4906:7fdb:3199]) by DM5PR11MB2058.namprd11.prod.outlook.com
 ([fe80::38ae:4906:7fdb:3199%7]) with mapi id 15.20.3066.023; Wed, 10 Jun 2020
 04:58:44 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogZnVuY3Rpb246?=
 =?gb2312?B?IHByaW50ZXI6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xvY2tfYWNxdWly?=
 =?gb2312?Q?e?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50?=
 =?gb2312?B?ZXI6IGZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xvY2tfYWNxdWlyZQ==?=
Thread-Index: AQHWPWOPii6lUpWag0qF192Mw9Y0PajOU1GAgAGzxdeAAAR7AIABPnyA
Date:   Wed, 10 Jun 2020 04:58:44 +0000
Message-ID: <DM5PR11MB20589EB35828F823826FF4B3FF830@DM5PR11MB2058.namprd11.prod.outlook.com>
References: <20200608071622.33081-1-qiang.zhang@windriver.com>
 <20200608073305.GA252221@kroah.com>
 <DM5PR11MB2058F82DF00D26338119BF0FFF820@DM5PR11MB2058.namprd11.prod.outlook.com>,<20200609094848.GA533476@kroah.com>
In-Reply-To: <20200609094848.GA533476@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc59b38e-7f62-4081-557a-08d80cfaf3da
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-microsoft-antispam-prvs: <DM5PR11MB14348D42EB05461150E2F3B1FF830@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0430FA5CB7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x4vfUed4M2QZ3QfTQM3knYZbXkT74UXIPMwjkf9JHpzeAVhBP+WhelvpFJFPHuG7v3XFpPoqGl27IAPYZPw4+D0FulLbzgl6bx+mMKyMcADlkceAzpsb5fdGdSOQGk7VgO9BO6oYrnf8g15NeD5eP3OkwfF9HjF5+p/5gB4NVBoe3c+R6NtAr2KiXpQPIcTZ2e92TPhKAKbgZ9SYxZA43aAAnPmZpIru4t42C9dPA94jR0D2k+jdcnXwfSBgOFj44NhIvCR6GXSp8gSs5fwOfvbpUkRGL+QxmvtaOcxiKaiM4tknz9/apLRu5coZ6/mCuOA+8hBb3jMBE1jP7CocAvj7ckkilknFDVEJr60DyVfl9tKEtVvrDTblJcn/e2zLXtb4IVPuj8A6c9qP8bkGTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB2058.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(366004)(376002)(346002)(39840400004)(316002)(52536014)(5660300002)(54906003)(19625735003)(86362001)(966005)(8936002)(64756008)(2906002)(224303003)(26005)(66476007)(33656002)(6916009)(83380400001)(55016002)(66946007)(66556008)(478600001)(91956017)(9686003)(66446008)(76116006)(7696005)(4326008)(6506007)(186003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 68MmrNq8yf1sTUAnOKDWdrrO1uZAFkGvfTLggiOKVyZu8VYOiWEK1W92Ae2+26Aq/yAiTfseN5PYEY//6p2gf1+FT3p71cBjQiDGQlg6rXgEb2+YbwEnJPDPGuJ1Al3lce/A0Ms6hscqkzQcHveik2Qqj4ZX+05WwHC7PhODmiHEMe3VFZIgH9YlQSxqSS5Srb5JT/Ajx5Iq5XaLickXoVC+Lq0Oy9qPwU+AzwV6buGzX++0ngXxRkeKRabKVRm7J5yCpxbpkdMudKLkoO4FmQIV5VfstGLyd45MBaKkwVRFr7sklbFWmsaLgBYCXmu9qE8lX4YXnQjHVke2K3zfuqumvJsqq3ykZWFQfPc5Rxel9dDRypHvfW3KIvNaqjXCAAtJqWjZV37+l90hyNvfKc2aLu2M0pHaLd/kYt2ge8wS3oKerIxeb1ohW2JHln1CnNK9j7xMdiW5cjDPdpx9Bf7eEzaJXWqT0MvHcPisJaw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc59b38e-7f62-4081-557a-08d80cfaf3da
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2020 04:58:44.4165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ugnho1evnheL3SRXbk+Aa7URLM4POuLliBL5/6QOQKb8C5yjxqkQBaGfl2y7ylY7bPWtTxapc4H7WW6Jcl5VrWeXLqSc2C/yF7BM/bRmZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Y2RldiAgb2JqZWN0IHJlZmVyZW5jZSBjb3VudCBhbmQgInN0cnVjdCBwcmludGVyX2RldiIgb2Jq
ZWN0ICByZWZlcmVuY2UgY291bnQoa3JlZiksIFRoaXMgdHdvIHJlZmVyZW5jZSBjb3VudHMgZG8g
bm90IGNvbmZsaWN0LiAgaW4gZmlsZSB1c2Itc2tlbGV0b24uYyBhbHNvIHVzZWQgYSBzaW1pbGFy
IG1ldGhvZKOsICJzdHJ1Y3QgdXNiX3NrZWwiICBjb250YWlucyBrcmVmIG1lbWJlcnMuDQoNCnRo
YW5rcywNClpxaWFuZw0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQq3orz+yMs6IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0Kt6LLzcqxvOQ6
IDIwMjDE6jbUwjnI1SAxNzo0OA0KytW8/sjLOiBaaGFuZywgUWlhbmcNCrOty806IGJhbGJpQGtl
cm5lbC5vcmc7IGxpbnV4LXVzYkB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCtb3zOI6IFJlOiC72Li0OiBbUEFUQ0ggdjJdIHVzYjogZ2FkZ2V0OiBmdW5jdGlv
bjogcHJpbnRlcjogZml4IHVzZS1hZnRlci1mcmVlIGluIF9fbG9ja19hY3F1aXJlDQoNCg0KQTog
aHR0cDovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9Ub3BfcG9zdA0KUTogV2VyZSBkbyBJIGZpbmQg
aW5mbyBhYm91dCB0aGlzIHRoaW5nIGNhbGxlZCB0b3AtcG9zdGluZz8NCkE6IEJlY2F1c2UgaXQg
bWVzc2VzIHVwIHRoZSBvcmRlciBpbiB3aGljaCBwZW9wbGUgbm9ybWFsbHkgcmVhZCB0ZXh0Lg0K
UTogV2h5IGlzIHRvcC1wb3N0aW5nIHN1Y2ggYSBiYWQgdGhpbmc/DQpBOiBUb3AtcG9zdGluZy4N
ClE6IFdoYXQgaXMgdGhlIG1vc3QgYW5ub3lpbmcgdGhpbmcgaW4gZS1tYWlsPw0KDQpBOiBOby4N
ClE6IFNob3VsZCBJIGluY2x1ZGUgcXVvdGF0aW9ucyBhZnRlciBteSByZXBseT8NCg0KaHR0cDov
L2RhcmluZ2ZpcmViYWxsLm5ldC8yMDA3LzA3L29uX3RvcA0KDQpPbiBUdWUsIEp1biAwOSwgMjAy
MCBhdCAwOTozNToxMUFNICswMDAwLCBaaGFuZywgUWlhbmcgd3JvdGU6DQo+IFRoYW5rIHlvdSBm
b3IgeW91ciBzdWdnZXN0aW9uDQo+IHR3byByZWZlcmVuY2VkIGNvdW50ZWQgb2JqZWN0cyBpbiB0
aGUgc2FtZSBleGFjdCBzdHJ1Y3R1cmUuIGFub3RoZXIgIHJlZmVyZW5jZWQgaXMNCj4gImRldi0+
cHJpbnRlcl9jZGV2X29wZW4iPw0KDQpNYXliZSwgSSBkb24ndCBrbm93LCBidXQgYSBjZGV2IGRv
ZXMgaGF2ZSBhIHJlZmVyZW5jZSBjb3VudCBhbHJlYWR5LA0KcmlnaHQ/ICBXaHkgZG8geW91IG5l
ZWQgcHJpbnRlcl9jZGV2X29wZW4gYXMgd2VsbD8NCg0KdGhhbmtzLA0KDQpncmVnIGstaA0K
