Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A791C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1EF2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Plybihdx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NqT6lDWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgHSVmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:42:51 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:58456 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgHSVmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:42:49 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9EF10C0121;
        Wed, 19 Aug 2020 21:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597873368; bh=b1qdooem6dfF6MGTLWwft5PbO5/E6+ef/KPsQiil/ZA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=PlybihdxVETipAPqT9kF57zW0x5e90SZaAW+Y7C7RbOHkY3Y83QMvRXZULAhD4rH8
         zqJy/Uc0gDOn7n/y94jG9BGhalRx9ovIrUeiBTlpQb1HS2lY5Fbexo9bU/g/F4u/WH
         yCs9tPAN6vK8mwKYqJjvwa1SfJ0M/xNlzj9jZv0mApi1JjkYUPcEAYqvrWyBExXVDa
         bx9KzCN1XV4KlghXf7NZ+VM7aIkwUnRDWKxCN77MI7KY9mb5b4ZUfVJWyJoRtXFpqO
         2vm4UNnZSamjJnDn4ZLGrFZxcrlPyVYHcbv0EErgyquh8shwJzt6WtJb7i88jVS8Kq
         XUPWnBE3+ucPA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 91161A0254;
        Wed, 19 Aug 2020 21:42:46 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4B96D80FA8;
        Wed, 19 Aug 2020 21:42:44 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NqT6lDWa";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCh+uJCsP+3tiAlwNomVsr216hSuzSEVpyyw4GLR2IxB+yM8w21Y0YYxLxaJ24nLe3j2BIQCEDoKtth2nuLvucsG89kjEjL6rNspzQle9+Ic/fK/PFKS+3a89dhejKa1E8m8lUVJ2VVNCRmBMJt9LSmH8v70i6eqrdbGz4lpDnJNd21/Gmcl4q2qEC1CpK2qK+tRHQLSMZm/7vvhiPMIOqUcHku+sOK8m13y/HCzZ4357d7foBHusg1EudbhCIQPOmhyCbn/adEMYdwObCmUl6rdkOXhMgMvHRPBHMUjJkoICszeXb7jSq6CBfaoV3HFwaXx7B1HxpjkfcchJoDr6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1qdooem6dfF6MGTLWwft5PbO5/E6+ef/KPsQiil/ZA=;
 b=V/Q9Eji0LJRjRV9wGh7UMwYn1kffVFKG32mG1YDkJSDGYCh7oAk730BmVTtOaJTXzbgGJM9yV7p8KE7sgSfWCubGVzBeA2hvuSAN3fWeUo71uVxEeSQZ97m1romKMS/y0fBHVcID1ApyQWcj0Se6b38bxzgHuprkhOV9hC0dDYIgq02BkCC9oCYkikwoFfHsOLvJ7g0d94L4X9zkgiLR7xT2gbGqBLN73i4i1vL0meYw94IXaL0ahc+MlWFPxgmlHCqeVFEFjQTscd/816RXo9WIYUERdoIcecL9AKHH8o6eg1XiJb0Xf6FFmZ0lNZlupjmMcvFh1NylcKIK08DCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1qdooem6dfF6MGTLWwft5PbO5/E6+ef/KPsQiil/ZA=;
 b=NqT6lDWaRoZebjpikK91xKyV0u0tUcHtpdVS3ENnIWjauRQs1ax33dQrQFF+v/WJWEcDtWdBUJHRpKPJzQBqGro+jgtsn6rJICC9XTOgOt0kqhJtkQLnCaHtec81soNz1DUCJ+O+SLop2GwrXWOsIB5J6XHqVi6+FEERlaR1tXs=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 21:42:43 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209%7]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 21:42:43 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Topic: [PATCH] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Index: AQHWdega2upQyFI7nU28MH7ylEdDLak/94UA
Date:   Wed, 19 Aug 2020 21:42:43 +0000
Message-ID: <3917c516-7251-5b13-2192-0820c125eced@synopsys.com>
References: <20200819051739.22123-1-wcheng@codeaurora.org>
In-Reply-To: <20200819051739.22123-1-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [149.117.7.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55af8d90-6195-4525-ce3e-08d84488cdea
x-ms-traffictypediagnostic: BY5PR12MB4274:
x-microsoft-antispam-prvs: <BY5PR12MB42748B88CE5EC3162A594BD1AA5D0@BY5PR12MB4274.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DWL4jnrnQ/7f2zKwd+Dc1PIhBfZqZR51yHQRpvl0NY3qZIOMWFEPFOo+p5OtS0zNEV9lNW24vK28p02nRZmDRnjKtqrlDqW3y5VA1sZxMaMAeIiQFLO7999xf/RFGoCVbPL85Ts4ZrNh0Iy9KepLphVWqUMB/qQ09vvW5fD9iAgGPO3oKShmtdFXWLisesCMTimwP+ddXIhQSVw/JSBjHnKz1o2u1DACjQljyzk4wMNrHMlZ5Id5a7O267MgtiutXtURQpchZxdKNmhTb2gznndYxUM9c5/oM5xj0YtKiuDC+NYKQQlKWrAYneJulhg3vSY/A5cxKCaLoXcdmx+hOnHVr8Wylv1vYHKhBrARs3NOmw9GguPQWMGLEZ3uFCos
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(54906003)(8936002)(110136005)(6486002)(4326008)(86362001)(66946007)(76116006)(6506007)(71200400001)(66476007)(26005)(36756003)(66446008)(64756008)(66556008)(6512007)(316002)(2616005)(83380400001)(31696002)(5660300002)(186003)(31686004)(2906002)(8676002)(478600001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WQmjf8DB5IK3kAc0MKVr6zTYqZuHpSsUlbYqF9x1zQrfBEe7qKgpEzfPYPG8gWgnky+ROp0pLov8+B2x+hBveQMuWdZIlJmfsUdjsm4PKQ+IVUuvZPAZqo4hmX9o8IjPG7Ju3VTrFwGsLHsP5xyDySYPzP0uI41wCD+Uw9GEWaISTrm5WwL8UOQkl4f2Z1Ud2+SJ24ISKYLDh/vAH+U6pdbJ9RD9Pmc8Z/OnOK7LcLu+xF4IGg1lGnXOah8/nmiXdvBPICDB6SZ/mEVS2xvxkZlGARn9EAcMYQw41aUn8JRW05+TacZNnwtINRPcN8v1DwMH/wZAaqpdRLhhpF4GFYpwg3nXwTV2nJS4dYmyQZCLzlvntJZEuRurbhf4pPcr5Y/PowXDayXLkMj7V6Jq3ksn0H9CjpkvYYpCZeUdYg2UfUxwJ1TZiz3hW+GmLFQz+2I7JuV6yoSFg+cS4eaBYqjgOSk7Rok99z2YgzVuDJaF1IjQklL6z3j6lK5la4tLrcx7GuDbNn7eiQXiIRPXFW2kOhNig1YfBVyzVI/Z9uTPAfdCHFUcX4k7oxFsJ4Kutbr8bSvfV3C600WNzAKOH8TAIOae/7Oh3LohWcJ/nkpA1iUah3dJq2T1Ng9rYM5nSmlCuQuotibpVNlnKKJwcw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2605C6DA02067F43B6A417EE147B7913@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55af8d90-6195-4525-ce3e-08d84488cdea
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 21:42:43.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zkBMCJ/f8TfezOrViKL95HkrSkF68gfVVzJm7iLOF7Xm7K5Qtifvb1sqCG9BiUyGvDWhhRIhH43L5MFZ1CYGVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCldlc2xleSBDaGVuZyB3cm90ZToNCj4gSW4gdGhlIERXQzMgZGF0YWJvb2ssIGZvciBh
IGRldmljZSBpbml0aWF0ZWQgZGlzY29ubmVjdCwgdGhlIGRyaXZlciBpcw0KPiByZXF1aXJlZCB0
byBzZW5kIGRlcGVuZHhmZXIgY29tbWFuZHMgZm9yIGFueSBwZW5kaW5nIHRyYW5zZmVycy4NCj4g
SW4gYWRkaXRpb24sIGJlZm9yZSB0aGUgY29udHJvbGxlciBjYW4gbW92ZSB0byB0aGUgaGFsdGVk
IHN0YXRlLCB0aGUgU1cNCj4gbmVlZHMgdG8gYWNrbm93bGVkZ2UgYW55IHBlbmRpbmcgZXZlbnRz
LiAgSWYgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGhhbHRlZA0KPiBwcm9wZXJseSwgdGhlcmUgaXMg
YSBjaGFuY2UgdGhlIGNvbnRyb2xsZXIgd2lsbCBjb250aW51ZSBhY2Nlc3Npbmcgc3RhbGUgb3IN
Cj4gZnJlZWQgVFJCcyBhbmQgYnVmZmVycy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENo
ZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+DQo+IC0tLQ0KPiBWZXJpZmllZCBmaXggYnkg
YWRkaW5nIGEgY2hlY2sgZm9yIEVUSU1FRE9VVCBkdXJpbmcgdGhlIHJ1biBzdG9wIGNhbGwuDQo+
IFNoZWxsIHNjcmlwdCB3cml0aW5nIHRvIHRoZSBjb25maWdmcyBVREMgZmlsZSB0byB0cmlnZ2Vy
IGRpc2Nvbm5lY3QgYW5kDQo+IGNvbm5lY3QuICBCYXRjaCBzY3JpcHQgdG8gaGF2ZSBQQyBleGVj
dXRlIGRhdGEgdHJhbnNmZXJzIG92ZXIgYWRiIChpZSBhZGINCj4gcHVzaCkgIEFmdGVyIGEgZmV3
IGl0ZXJhdGlvbnMsIHdlJ2QgcnVuIGludG8gYSBzY2VuYXJpbyB3aGVyZSB0aGUNCj4gY29udHJv
bGxlciB3YXNuJ3QgaGFsdGVkLiAgV2l0aCB0aGUgZm9sbG93aW5nIGNoYW5nZSwgbm8gZmFpbGVk
IGhhbHRzIGFmdGVyDQo+IG1hbnkgaXRlcmF0aW9ucy4NCj4gLS0tDQo+ICBkcml2ZXJzL3VzYi9k
d2MzL2VwMC5jICAgIHwgIDIgKy0NCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCA1OSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdl
ZCwgNTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+IGluZGV4IDU5
ZjJlOGMzMWJkMS4uNDU2YWE4N2U4Nzc4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2Mz
L2VwMC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gQEAgLTE5Nyw3ICsxOTcs
NyBAQCBpbnQgZHdjM19nYWRnZXRfZXAwX3F1ZXVlKHN0cnVjdCB1c2JfZXAgKmVwLCBzdHJ1Y3Qg
dXNiX3JlcXVlc3QgKnJlcXVlc3QsDQo+ICAJaW50CQkJCXJldDsNCj4gIA0KPiAgCXNwaW5fbG9j
a19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gLQlpZiAoIWRlcC0+ZW5kcG9pbnQuZGVz
Yykgew0KPiArCWlmICghZGVwLT5lbmRwb2ludC5kZXNjIHx8ICFkd2MtPnB1bGx1cHNfY29ubmVj
dGVkKSB7DQo+ICAJCWRldl9lcnIoZHdjLT5kZXYsICIlczogY2FuJ3QgcXVldWUgdG8gZGlzYWJs
ZWQgZW5kcG9pbnRcbiIsDQo+ICAJCQkJZGVwLT5uYW1lKTsNCj4gIAkJcmV0ID0gLUVTSFVURE9X
TjsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgYi9kcml2ZXJzL3Vz
Yi9kd2MzL2dhZGdldC5jDQo+IGluZGV4IDNhYjZmMTE4YzUwOC4uMWY5ODE5NDJkN2Y5IDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ICsrKyBiL2RyaXZlcnMvdXNi
L2R3YzMvZ2FkZ2V0LmMNCj4gQEAgLTE1MTYsNyArMTUxNiw3IEBAIHN0YXRpYyBpbnQgX19kd2Mz
X2dhZGdldF9lcF9xdWV1ZShzdHJ1Y3QgZHdjM19lcCAqZGVwLCBzdHJ1Y3QgZHdjM19yZXF1ZXN0
ICpyZXEpDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2MgPSBkZXAtPmR3YzsNCj4gIA0KPiAt
CWlmICghZGVwLT5lbmRwb2ludC5kZXNjKSB7DQo+ICsJaWYgKCFkZXAtPmVuZHBvaW50LmRlc2Mg
fHwgIWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQpIHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgIiVz
OiBjYW4ndCBxdWV1ZSB0byBkaXNhYmxlZCBlbmRwb2ludFxuIiwNCj4gIAkJCQlkZXAtPm5hbWUp
Ow0KPiAgCQlyZXR1cm4gLUVTSFVURE9XTjsNCj4gQEAgLTE5MjYsNiArMTkyNiwyNCBAQCBzdGF0
aWMgaW50IGR3YzNfZ2FkZ2V0X3NldF9zZWxmcG93ZXJlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywN
Cj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gIA0KPiArc3RhdGljIHZvaWQgZHdjM19zdG9wX2FjdGl2
ZV90cmFuc2ZlcnMoc3RydWN0IGR3YzMgKmR3YykNCj4gK3sNCj4gKwl1MzIgZXBudW07DQo+ICsN
Cj4gKwlmb3IgKGVwbnVtID0gMjsgZXBudW0gPCBEV0MzX0VORFBPSU5UU19OVU07IGVwbnVtKysp
IHsNCj4gKwkJc3RydWN0IGR3YzNfZXAgKmRlcDsNCj4gKw0KPiArCQlkZXAgPSBkd2MtPmVwc1tl
cG51bV07DQo+ICsJCWlmICghZGVwKQ0KPiArCQkJY29udGludWU7DQo+ICsNCj4gKwkJaWYgKCEo
ZGVwLT5mbGFncyAmIERXQzNfRVBfRU5BQkxFRCkpDQo+ICsJCQljb250aW51ZTsNCj4gKw0KPiAr
CQlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2MsIGRlcCk7DQo+ICsJfQ0KPiArfQ0KPiArDQo+ICBz
dGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19v
biwgaW50IHN1c3BlbmQpDQo+ICB7DQo+ICAJdTMyCQkJcmVnOw0KPiBAQCAtMTk1MCwxNiArMTk2
OCwzNyBAQCBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2Ms
IGludCBpc19vbiwgaW50IHN1c3BlbmQpDQo+ICANCj4gIAkJZHdjLT5wdWxsdXBzX2Nvbm5lY3Rl
ZCA9IHRydWU7DQo+ICAJfSBlbHNlIHsNCj4gKwkJZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCA9IGZh
bHNlOw0KPiArDQo+ICsJCV9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZShkd2MtPmVwc1swXSk7DQo+
ICsJCV9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZShkd2MtPmVwc1sxXSk7DQoNCnJ1bl9zdG9wKCkg
ZnVuY3Rpb24gc2hvdWxkbid0IGJlIGRvaW5nIHRoaXMuIFRoaXMgaXMgZG9uZSBpbg0KZHdjM19n
YWRnZXRfc3RvcCgpLiBBbHNvLCBpZiBpdCdzIGRldmljZS1pbml0aWF0ZWQgZGlzY29ubmVjdCwg
ZHJpdmVyDQpuZWVkcyB0byB3YWl0IGZvciBjb250cm9sIHRyYW5zZmVycyB0byBjb21wbGV0ZS4N
Cg0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIFRoZSBkYXRhYm9vayBleHBsaWNpdGx5IG1lbnRpb25z
IGZvciBhIGRldmljZS1pbml0aWF0ZWQNCj4gKwkJICogZGlzY29ubmVjdCBzZXF1ZW5jZSwgdGhl
IFNXIG5lZWRzIHRvIGVuc3VyZSB0aGF0IGl0IGVuZHMgYW55DQo+ICsJCSAqIGFjdGl2ZSB0cmFu
c2ZlcnMuDQo+ICsJCSAqLw0KPiArCQlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycyhkd2MpOw0K
DQpJdCBzaG91bGRuJ3QgYmUgZG9uZSBoZXJlLiBNYXliZSBtb3ZlIHRoaXMgdG8gdGhlIGR3YzNf
Z2FkZ2V0X3B1bGx1cCgpDQpmdW5jdGlvbi4gVGhlIHJ1bl9zdG9wKCkgZnVuY3Rpb24gY2FuIGJl
IGNhbGxlZCBmb3Igb3RoZXIgY29udGV4dCBiZXNpZGUNCnRoaXMgKGUuZy4gaGliZXJuYXRpb24p
Lg0KDQo+ICsNCj4gIAkJcmVnICY9IH5EV0MzX0RDVExfUlVOX1NUT1A7DQo+ICANCj4gIAkJaWYg
KGR3Yy0+aGFzX2hpYmVybmF0aW9uICYmICFzdXNwZW5kKQ0KPiAgCQkJcmVnICY9IH5EV0MzX0RD
VExfS0VFUF9DT05ORUNUOw0KPiAtDQo+IC0JCWR3Yy0+cHVsbHVwc19jb25uZWN0ZWQgPSBmYWxz
ZTsNCj4gIAl9DQo+ICANCj4gIAlkd2MzX2dhZGdldF9kY3RsX3dyaXRlX3NhZmUoZHdjLCByZWcp
Ow0KPiAgDQo+ICsJLyogQ29udHJvbGxlciBpcyBub3QgaGFsdGVkIHVudGlsIHBlbmRpbmcgZXZl
bnRzIGFyZSBhY2tub3dsZWRnZWQgKi8NCj4gKwlpZiAoIWlzX29uKSB7DQo+ICsJCXJlZyA9IGR3
YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0KPiArCQlyZWcgJj0gRFdD
M19HRVZOVENPVU5UX01BU0s7DQo+ICsJCWlmIChyZWcgPiAwKSB7DQo+ICsJCQlkd2MzX3dyaXRl
bChkd2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgcmVnKTsNCj4gKwkJCWR3Yy0+ZXZfYnVm
LT5scG9zID0gKGR3Yy0+ZXZfYnVmLT5scG9zICsgcmVnKSAlDQo+ICsJCQkJCQlkd2MtPmV2X2J1
Zi0+bGVuZ3RoOw0KPiArCQl9DQo+ICsJfQ0KPiArDQoNCkRyaXZlciBzaG91bGQgaGFuZGxlIHRo
ZSBldmVudHMgYmVmb3JlIGNsZWFyaW5nIHRoZSBydW5fc3RvcCBiaXQsIG5vdA0KanVzdCBhY2tu
b3dsZWRnaW5nIGFuZCBpZ25vcmluZyB0aGVtLg0KDQo+ICAJZG8gew0KPiAgCQlyZWcgPSBkd2Mz
X3JlYWRsKGR3Yy0+cmVncywgRFdDM19EU1RTKTsNCj4gIAkJcmVnICY9IERXQzNfRFNUU19ERVZD
VFJMSExUOw0KPiBAQCAtMTk5NCw5ICsyMDMzLDE1IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRf
cHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+ICAJCX0NCj4gIAl9DQo+
ICANCj4gKwkvKg0KPiArCSAqIFN5bmNocm9uaXplIGFuZCBkaXNhYmxlIGFueSBmdXJ0aGVyIGV2
ZW50IGhhbmRsaW5nIHdoaWxlIGNvbnRyb2xsZXINCj4gKwkgKiBpcyBiZWluZyBlbmFibGVkL2Rp
c2FibGVkLg0KPiArCSAqLw0KPiArCWRpc2FibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ICAJ
c3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAgCXJldCA9IGR3YzNfZ2Fk
Z2V0X3J1bl9zdG9wKGR3YywgaXNfb24sIGZhbHNlKTsNCj4gIAlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwllbmFibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7
DQo+ICANCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiBAQCAtMzUzNSw2ICszNTgwLDE0IEBAIHN0
YXRpYyBpcnFyZXR1cm5fdCBkd2MzX2NoZWNrX2V2ZW50X2J1ZihzdHJ1Y3QgZHdjM19ldmVudF9i
dWZmZXIgKmV2dCkNCj4gIAlpZiAoIWNvdW50KQ0KPiAgCQlyZXR1cm4gSVJRX05PTkU7DQo+ICAN
Cj4gKwkvKiBDb250cm9sbGVyIGlzIGhhbHRlZDsgaWdub3JlIG5ldy9wZW5kaW5nIGV2ZW50cyAq
Lw0KPiArCWlmICghZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCkgew0KPiArCQlkd2MzX3dyaXRlbChk
d2MtPnJlZ3MsIERXQzNfR0VWTlRDT1VOVCgwKSwgY291bnQpOw0KPiArCQlkd2MtPmV2X2J1Zi0+
bHBvcyA9IChkd2MtPmV2X2J1Zi0+bHBvcyArIGNvdW50KSAlDQo+ICsJCQkJCWR3Yy0+ZXZfYnVm
LT5sZW5ndGg7DQo+ICsJCXJldHVybiBJUlFfSEFORExFRDsNCj4gKwl9DQo+ICsNCg0KV2h5PyBB
cmUgeW91IGdldHRpbmcgYW55IGV2ZW50IGFmdGVyIHRoZSBjb250cm9sbGVyIGlzIGhhbHRlZD8g
QWxzbywNCm1ha2Ugc3VyZSB0byB0YWtlIGFjY291bnQgb2YgaGliZXJuYXRpb24uIFRoZSBjb250
cm9sbGVyIGNhbiBnZXQgUE1VDQpldmVudCBhZnRlciBoYWx0ZWQgdG8gYnJpbmcgaXQgb3V0IG9m
IGhpYmVybmF0aW9uLg0KDQo+ICAJZXZ0LT5jb3VudCA9IGNvdW50Ow0KPiAgCWV2dC0+ZmxhZ3Mg
fD0gRFdDM19FVkVOVF9QRU5ESU5HOw0KPiAgDQoNCklmIHlvdSdyZSBtYWtpbmcgdGhlc2UgZml4
ZXMsIGNhbiB5b3UgYWxzbyBmaXggaGFuZGxpbmcgcmVzZXQgaW50ZXJydXB0DQo/IEl0IGFsc28g
bmVlZHMgdG8gZW5kIGFsbCB0aGUgYWN0aXZlIHRyYW5zZmVycy4NCg0KVGhhbmtzLA0KVGhpbmgN
Cg0K
