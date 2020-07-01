Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B3D20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:48:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MsngOlu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgGASsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:48:33 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:2064 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgGASsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:48:31 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efcda7b0000>; Thu, 02 Jul 2020 02:48:27 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Jul 2020 11:48:27 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Wed, 01 Jul 2020 11:48:27 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 1 Jul
 2020 18:48:24 +0000
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 1 Jul 2020 18:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK6OvV51BaiDprPgWV1ixPHHi/nAvIQ0koTeFBzK02leHuBd1V+LTjfabc38rbwnYsBhzGTISkl5G+s5bGlCvSQlf4Q9Fy7zIXKKCtpa1B483ES+AJwjvcxyvnjsji/WZnCpciL2E13nmDgQ44KT3p07XfO+jC1ZTEk2LbD/Go6ltUOe1cEyBAKCJatw+2QlD5FAYkyaJuqK3X5rTsdxJ6WqgMtK470pzVezKj46yG7zOPSTYda/DkpzZiraw3W/3KTCE7PrT069kGVAglqHVzaDd5l6eG4kczJum82HztWpC3Ouj7FWE5x2uw/scEwqVu/H09zUNRDVhhvyaLjdBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMlAxghR2/clqNmApd87U8FikBSTSt/+1kn5kdOogfk=;
 b=IWkqyJRjOEc/fj7ZHFn6EeU3nACMjfmZ2JY2fYh3aVH6+IDXkx76+p2QgoMppeoVkxmGz3qYdwsfhRB4/1kxtAWYOvf9io+JEXCcY+8AtkQ9Udpj4grwPet5pw4WlL2NRSVBE0Mdq04TOxn+zwl56JvafLbPO5WtRz8GSeWNZGAaH8/nO1p9Jo9kF0xqUCrViDRUGkkIAHNrMTHWjdvSjAjcJ6UHeJH+H8wr1rbxM6fd3aBeL8EmlsftOmuFfHPQAltb660BtNNeK/m9GvTlYnIw7b7k7RhRONG2NGm0+lkG6/kI/pCvGN7nARPCvu+hoqeWy/PBirOsOIwu8NUqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BYAPR12MB2822.namprd12.prod.outlook.com (2603:10b6:a03:9a::17)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 18:48:22 +0000
Received: from BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2]) by BYAPR12MB2822.namprd12.prod.outlook.com
 ([fe80::70bd:803f:78b6:ebf2%2]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:48:22 +0000
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     Sachin Nikam <Snikam@nvidia.com>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Bryan Huntsman" <bhuntsman@nvidia.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pritesh Raithatha" <praithatha@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Yu-Huan Hsu <YHsu@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Bitan Biswas <bbiswas@nvidia.com>
Subject: RE: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Topic: [PATCH v8 3/3] iommu/arm-smmu: Add global/context fault
 implementation hooks
Thread-Index: AQHWTnL3VCCI3Y3jhE+XVIWcwjPCvKjw1msAgAA8hACAAf2WwA==
Date:   Wed, 1 Jul 2020 18:48:22 +0000
Message-ID: <BYAPR12MB282244D2B008E1C8CA57916BB36C0@BYAPR12MB2822.namprd12.prod.outlook.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
 <20200630001051.12350-4-vdumpa@nvidia.com>
 <4b4b20af-7baa-0987-e40d-af74235153f6@nvidia.com>
 <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
In-Reply-To: <6c2ce909-c71b-351f-79f5-b1a4b4c0e4ac@arm.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Enabled=True;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SiteId=43083d15-7273-40c1-b7db-39efd9ccc17a;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Owner=VDUMPA@nvidia.com;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_SetDate=2020-07-01T18:48:17.8986883Z;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Name=Unrestricted;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_ActionId=f93d34b0-b07a-440c-a2f3-1629f40dd0fd;
 MSIP_Label_6b558183-044c-4105-8d9c-cea02a2a3d86_Extended_MSFT_Method=Automatic
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [216.228.112.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56572b60-cf84-48ee-babf-08d81def5459
x-ms-traffictypediagnostic: BYAPR12MB2728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2728D2868A2C448D3E5071F3B36C0@BYAPR12MB2728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /fnYqZMxFRokfK4vl4l/s2ze8k2PZDSU2chagW0giNnRtEzNgMBJXDcENTMP/0ihGaT/xRmd+luYLsClf+s/0oKWoEbQ1GnIs+Tzxd4Wf8WYhK1t1Mtw9uHC2cvxAqaWb/1RfvHhxq41H8n1x+w4+7pYOkfGfSLlUfcIr4L6IYbSkxA9nu5eESO0Zb/1n4OCz1btdIwTemwO0nL7/A/hj6p+G8VnXcyywS84xzFY7P30xN0YZOiToehpB8JYFYh2m97eGQNMScmqsBQilaY5LM3bVorO19MODv3FWY2gWGixiHJIjvsILAXFyfGxIbn7Fv8NTwS5qlEBB+wRhYEUPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2822.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(110136005)(54906003)(107886003)(86362001)(33656002)(9686003)(6506007)(52536014)(7696005)(66556008)(66476007)(66946007)(76116006)(316002)(66446008)(64756008)(83380400001)(5660300002)(71200400001)(186003)(26005)(2906002)(8676002)(6636002)(8936002)(478600001)(4326008)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /weF3qAHvMFY0B+nAZBnndnjSKOp3ydPVTRUV/Lnf77qaC9/VB2J8VI+i9CRPhlZJSWKeEKA1LRdtpTYnCRuCbsAfYo6QLwJFKXMNS/a05W6iwpKwPtxEVDH9+/QlaR0pGMAcjcbZ6Trhw1gauaKDUrxUw4JUjwlV3ea3TImzmGjG4P8RNIZqT4MjuIIm5gJSMTbRHI9AyNqmlAvmo43EuvcHXjaKzarnA7Yz2BAFys11lyhVDA5HlSAoGcskiuNBbMpFbDbSB4CPGsbszmWCLJFkd0btuz0MuhIHSAr2mEEgr9NK6+JKSBWG3rreVbGRAgS+5DrV9CGY00aOSM/RMZ5qKTAi6dWmVwlW5gBCg8UxyaNUgmDqSBYiBARbPXwf4sQpkBwcXa62VJ2dYmvoEds1kkiAcDwipVmGVlf/k2M8tmtOHXeDHDZ8Pv0QjhZCjtUfzOno7iMSdWHHAN2GxEcnL7wIJ16UiwMnkqwUEGmryg39Z0sZ51Yk5b7ruqc
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2822.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56572b60-cf84-48ee-babf-08d81def5459
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:48:22.0332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tf2hrNOpJ/csNdF/I/uEgUTPlRrpy+vTScF29tFrefxWJQox9dJHLbseV0tAXKVcu/bLyPSeh80NeAX3jTKkEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593629307; bh=HMlAxghR2/clqNmApd87U8FikBSTSt/+1kn5kdOogfk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
         authentication-results:x-originating-ip:x-ms-publictraffictype:
         x-ms-office365-filtering-correlation-id:x-ms-traffictypediagnostic:
         x-ms-exchange-transport-forked:x-microsoft-antispam-prvs:
         x-ms-oob-tlc-oobclassifiers:x-forefront-prvs:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=MsngOlu5HIKxiwszy0g4rgSSwkKQGok8T/J5WxXqBDHiRhmoOURHqj+9X7cCMnBE8
         Bc3oImAZyQWIxSi0EnM9L9P4iZc2761/V1uFMk52cXxlLGVqVmXEpzYG+5z1LeJm34
         ROYlZ5xUlYVgwjIgA1KVI2QWsq7F/iX5iMnNe6WraimVE0Zts8n47PNKyE583AhDTy
         zouTcULjPoA67SnYITKPCxnOqP2Zf41JTeDhnL20FRJPJhEJ4woy9SDN7cZD/aFGlW
         2no1cHvsZMzxOAs6q5vBTCJXoSI+1NEv6r7vyJP6VUA5sGWtmb8JvZ7+/qWQ4nsefU
         rrlEKfgNBaxWA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4+ICsgICAgZm9yIChpbnN0ID0gMDsgaW5zdCA8IG52aWRpYV9zbW11LT5udW1faW5zdDsgaW5z
dCsrKSB7DQo+Pj4gKyAgICAgICAgICAgIGlycV9yZXQgPSBudmlkaWFfc21tdV9nbG9iYWxfZmF1
bHRfaW5zdChpcnEsIHNtbXUsIGluc3QpOw0KPj4+ICsgICAgICAgICAgICBpZiAoaXJxX3JldCA9
PSBJUlFfSEFORExFRCkNCj4+PiArICAgICAgICAgICAgICAgICAgICByZXR1cm4gaXJxX3JldDsN
Cj4+DQo+PiBBbnkgY2hhbmNlIHRoZXJlIGNvdWxkIGJlIG1vcmUgdGhhbiBvbmUgU01NVSBmYXVs
dGluZyBieSB0aGUgdGltZSB3ZSANCj4+IHNlcnZpY2UgdGhlIGludGVycnVwdD8NCg0KPkl0IGNl
cnRhaW5seSBzZWVtcyBwbGF1c2libGUgaWYgdGhlIGludGVyY29ubmVjdCBpcyBhdXRvbWF0aWNh
bGx5IGxvYWQtYmFsYW5jaW5nIHJlcXVlc3RzIGFjcm9zcyB0aGUgU01NVSBpbnN0YW5jZXMgLSBz
YXkgYSBkcml2ZXIgYnVnIGNhdXNlZCBhIGJ1ZmZlciB0byBiZSB1bm1hcHBlZCB0b28gZWFybHks
IHRoZXJlIGNvdWxkIGJlIG1hbnkgaW4tZmxpZ2h0IGFjY2Vzc2VzIHRvIHBhcnRzIG9mIHRoYXQg
YnVmZmVyIHRoYXQgYXJlbid0IGFsbCB0YWtpbmcgdGhlIHNhbWUgcGF0aCBhbmQgdGh1cyBjb3Vs
ZCBub3cgZmF1bHQgaW4gcGFyYWxsZWwuDQo+WyBBbmQgYW55b25lIGluY2xpbmVkIHRvIG5pdHBp
Y2sgZ2xvYmFsIHZzLiBjb250ZXh0IGZhdWx0cywgcy91bm1hcCBhIGJ1ZmZlci90ZWFyIGRvd24g
YSBkb21haW4vIDspIF0NCj5FaXRoZXIgd2F5IEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIHRv
IHJlYXNvbiBhYm91dCBpZiB3ZSBqdXN0IGhhbmRsZWQgdGhlc2UgbGlrZSBhIHR5cGljYWwgc2hh
cmVkIGludGVycnVwdCBhbmQgYWx3YXlzIGNoZWNrZWQgYWxsIHRoZSBpbnN0YW5jZXMuDQoNCkl0
IHdvdWxkIGJlIG9wdGltYWwgdG8gY2hlY2sgYXQgdGhlIHNhbWUgdGltZSBhY3Jvc3MgYWxsIGlu
c3RhbmNlcy4gDQoNCj4+PiArICAgICAgICAgICAgZm9yIChpZHggPSAwOyBpZHggPCBzbW11LT5u
dW1fY29udGV4dF9iYW5rczsgaWR4KyspIHsNCj4+PiArICAgICAgICAgICAgICAgICAgICBpcnFf
cmV0ID0gbnZpZGlhX3NtbXVfY29udGV4dF9mYXVsdF9iYW5rKGlycSwgc21tdSwNCj4+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGlkeCwgDQo+Pj4gKyBpbnN0KTsNCj4+PiArDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgaWYg
KGlycV9yZXQgPT0gSVJRX0hBTkRMRUQpDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gaXJxX3JldDsNCj4+DQo+PiBBbnkgcmVhc29uIHdoeSB3ZSBkb24ndCBjaGVjayBh
bGwgYmFua3M/DQoNCj5BcyBhYm92ZSwgd2UgY2VydGFpbmx5IHNob3VsZG4ndCBiYWlsIG91dCB3
aXRob3V0IGNoZWNraW5nIHRoZSBiYW5rIGZvciB0aGUgb2ZmZW5kaW5nIGRvbWFpbiBhY3Jvc3Mg
YWxsIG9mIGl0cyBpbnN0YW5jZXMsIGFuZCBJIGd1ZXNzIHRoZSB3YXkgdGhpcyB3b3JrcyBtZWFu
cyB0aGF0IHdlIHdvdWxkIGhhdmUgdG8gaXRlcmF0ZSBhbGwgdGhlIGJhbmtzIHRvIGFjaGlldmUg
dGhhdC4NCg0KV2l0aCBzaGFyZWQgaXJxIGxpbmUsIHRoZSBjb250ZXh0IGZhdWx0IGlkZW50aWZp
Y2F0aW9uIGlzIG5vdCBvcHRpbWFsIGFscmVhZHkuICBSZWFkaW5nIGFsbCB0aGUgY29udGV4dCBi
YW5rcyBhbGwgdGhlIHRpbWUgY2FuIGJlIGFkZGl0aW9uYWwgbW1pbyByZWFkIG92ZXJoZWFkLiBC
dXQsIGl0IG1heSBub3QgaHVydCB0aGUgcmVhbCB1c2UgY2FzZXMgYXMgdGhlc2UgaGFwcGVuIG9u
bHkgd2hlbiB0aGVyZSBhcmUgYnVncy4gDQoNCi1LUg0K
