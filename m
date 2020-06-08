Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF06BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A884206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="kya0L573"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgFHGyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:54:39 -0400
Received: from mail-mw2nam10on2055.outbound.protection.outlook.com ([40.107.94.55]:22497
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728159AbgFHGyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:54:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giNGmzJZQJxd3f5vssNH1YrMZHqmKEAGy9ZjFpZWp57jHW7yEKeqCipc5mnjEb7xdRWYZ9rEL5dpAOEpu2sz2zcoyDWzXutphYqJJw6us71jdhabdHuaOS2KaQwEqMKHghbU1KVWxCOUXZ6ihhuW41pbv7XBJANe0GhzPwcw9I0E4NjkU5/pjQCRmzy0RSI+FSoliANRJ1JyVgG3RHTAadCeA8zTRz9tAHoNZnihuYfbqsd+WkF2mgIMiWlTWggB1N3A69iXR9JhssOSgRieF888EzXMbE6BalA+8ST70I6pB4J7wVXvmSygtZ7O0NPe9ozwLJEArZ0MYjgD1pb5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4jPbrcjs/YFiTM/3A9d0iU2+aTecaiSv5EtzEgqU1M=;
 b=KB+FSG/315VChma9jfi7SDVlPRq+JXzVOpxrCgybFQlHHsYFAJHfFtw6/UW7cvlZJQqXt5njHDBW2h16hJ54lXd1ELADD9ePw+Hl3jByhg7GoTG9TAa021GJv28Sxe9pfOrNr8salE7mmV3vH1SACmNtwN8mSm1+aF0NzMoavHQHFnNIJ1ynvV+kdS90QYJvvN6dt7nkdsOWwuwJlpqbrhJCHcZrmJItfKt3oDzIphuj1ahkp9h1NOKRShbvvYakGtEl0VBGrnUi+8sjeLXkLtRU151SlvmQ+Ck5Mwm16JudiS5wWsa+P5aKjpKUtK9IOSwpDeDUpietPIaivbgRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4jPbrcjs/YFiTM/3A9d0iU2+aTecaiSv5EtzEgqU1M=;
 b=kya0L573f5opjogRaFnQSzF3Ldj9N5/Q/b3R6AMHEZQj0WByWVXmgibAWvWx/E5gNZfyRLBz4PQ38bl9c7NpWZjlXXGCcGtkFrRY9JsiEux+RRPU/HnKeq67i+W9Y7Y0GiChnmgG0KU/IGzabMqjrVzwTStABqwUQGNbYUPyub0=
Received: from DM5PR11MB2058.namprd11.prod.outlook.com (2603:10b6:3:12::23) by
 DM5PR11MB0073.namprd11.prod.outlook.com (2603:10b6:4:67::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.23; Mon, 8 Jun 2020 06:54:36 +0000
Received: from DM5PR11MB2058.namprd11.prod.outlook.com
 ([fe80::38ae:4906:7fdb:3199]) by DM5PR11MB2058.namprd11.prod.outlook.com
 ([fe80::38ae:4906:7fdb:3199%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:54:36 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungtae Kim <kt0755@gmail.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246IHByaW50ZXI6?=
 =?gb2312?B?IEZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xvY2tfYWNxdWlyZSgp?=
Thread-Topic: [PATCH] usb: gadget: function: printer: Fix use-after-free in
 __lock_acquire()
Thread-Index: AQHWOxd3pvSJzCcPhkuwExEvp5/TI6jOTEjR
Date:   Mon, 8 Jun 2020 06:54:35 +0000
Message-ID: <DM5PR11MB205835FB50BA296232BC3163FF850@DM5PR11MB2058.namprd11.prod.outlook.com>
References: <5207d179-0a7d-b5ff-af34-102fb21028b5@web.de>
In-Reply-To: <5207d179-0a7d-b5ff-af34-102fb21028b5@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4a628c1-cd69-4d6b-6a5f-08d80b78ce74
x-ms-traffictypediagnostic: DM5PR11MB0073:
x-microsoft-antispam-prvs: <DM5PR11MB007380024575F3714820B8A3FF850@DM5PR11MB0073.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z3dPATE8LavtU7OYfDEcLUaRx74MBs6JsO/pyyamsH4EjtDzHkfgJmP09cd/v3wZq4wF8Aeomijf2Fqy9gSHpmF3ZIDh+SBVbsvdhNOFkJAQdE2enwd+9DLi8ZShm8aP0G82nEnq6MXIEqevre++pd50Am40WKpWmlJ+NRjkWbZp5ys4M8y2PMUOR/2JcRPAEmtx4ro9oCTroE7QbHAUh0Iacj/d8sDQLVm/Uknn1v+BeXpdJ0jbeb+k2ZKiJtz35ztTPPpeq5hTDJiHhdurl2tQvpFvcFo8TG0TSpTTrfwrT0WmX/gAm+5L5CyyAy4ulsv/la77th3OWH/4nFfV/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB2058.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(136003)(366004)(39840400004)(8936002)(478600001)(9686003)(71200400001)(54906003)(4326008)(86362001)(7696005)(33656002)(55016002)(110136005)(4744005)(83380400001)(66446008)(66556008)(64756008)(5660300002)(52536014)(316002)(91956017)(2906002)(26005)(76116006)(66946007)(6506007)(224303003)(66476007)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: mYV6bxxXDMqEsHqZsBX9RtoMuHWgRL3eVtADwr1T3M0TAdM0m8sF41tjIz6HUxXwCiPWOu1u8xNZZ0rsu4oRha7JGvXKiLpnoe9w3uSd0Xd+aaBrLNj5A3pgO34AmElfrqrpbudosKa/2kFkVBmRRVww/RbLqRVmhdIWorrX2khJH73HVnmO5mnqJnq9r3qIAX4CGR/+zeFahs0e1TJM1lerYdf3UrpVJb+8PeUDKb6DWWiMOJrzCFGA98iQlw3mZ18Ayerodv+0l6dngPjj5sxosjiM0HZmwj6+Ffejdlz3UVoPbS6cR3oQ5e/GdrHUhgfNLmpADxgJTEpkWh/HJkmFA9WYMNi9UDyLd3ZKpYbYyXl1hRHqNVKann+22eSWNCAZIJOlYfEHjf1NaINmCB/gBAwv8PHV89elb7Q6w+wRvcqIK/Z/bFQEBCiOD9rU7fnCFZqLPGgaYrQHb39391vNQbIqDprEuYvS8Ymub28=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a628c1-cd69-4d6b-6a5f-08d80b78ce74
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:54:35.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yk42BQH+VTtTpveuCtncE915DvdMQs5yfsEGbxAw89FK10MoIdeZWYs5oH6o5Z+pkJ6rCilJs2eo9pWTt4Gx/vbe7ccQaNEHW+lx6He7BTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFya3VzLg0KSSBkb24ndCBuZWVkIHRvIGFkZCBGaXggdGFnIHRvIHZpZXcgdGhlIGNvZGUu
DQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogTWFy
a3VzIEVsZnJpbmcgPE1hcmt1cy5FbGZyaW5nQHdlYi5kZT4NCreiy83KsbzkOiAyMDIwxOo21MI1
yNUgMTY6NTcNCsrVvP7IyzogWmhhbmcsIFFpYW5nOyBsaW51eC11c2JAdmdlci5rZXJuZWwub3Jn
DQqzrcvNOiBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBBbGFuIFN0ZXJuOyBGZWxpcGUgQmFsYmk7IEdyZWcgS3JvYWgtSGFydG1h
bjsgS3l1bmd0YWUgS2ltDQrW98ziOiBSZTogW1BBVENIXSB1c2I6IGdhZGdldDogZnVuY3Rpb246
IHByaW50ZXI6IEZpeCB1c2UtYWZ0ZXItZnJlZSBpbiBfX2xvY2tfYWNxdWlyZSgpDQoNCj4gRml4
IHRoaXMgYnkgaW5jcmVhc2Ugb2JqZWN0IHJlZmVyZW5jZSBjb3VudC4NCg0KSSBmaW5kIHRoaXMg
ZGVzY3JpcHRpb24gaW5jb21wbGV0ZSBhY2NvcmRpbmcgdG8gdGhlIHByb3Bvc2VkIGNoYW5nZXMu
DQoNCldvdWxkIHlvdSBsaWtlIHRvIGFkZCB0aGUgdGFnIKGwRml4ZXOhsSB0byB0aGUgY29tbWl0
IG1lc3NhZ2U/DQoNClJlZ2FyZHMsDQpNYXJrdXMNCg==
