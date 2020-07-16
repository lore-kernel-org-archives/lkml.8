Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16EAC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BF720739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="aT4g0eU5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JG9WIYLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgGPMhu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:37:50 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:53574 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728505AbgGPMhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:37:48 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5B7544017C;
        Thu, 16 Jul 2020 12:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594903068; bh=IHMh0GCptOKF25Vidx64E1s50eH6CKHnM3K81mLq6MY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aT4g0eU5IDPT7nKQLLNjgkpKkeaOpv2uyjZdyWmFPRJNY/7ivYjsa891bEu9mi+qx
         W++4YlMY5nB1TgoIJMvY/zxjUNo5m4K9PBlmQGvhMKIgNAdA9xzYWqXgCDRh2s/DDx
         o0Z+zp1pdF6TuFyuBySdJIDcZ+u+KX3rlQiR/CdqYTtADchaY2N2h/dOMwATfqwz5T
         xWbBngoyMNxkIUlqXVvVXZplKhnXg046dkCTiGn8gpd3P4tEWIEL//mStlybMNgUsE
         asASY5j8Yg67frAaSRTTL1eCdjHYScqN1Nju54ezwD8esyGkjSEiT/F1GD3ez9AOag
         fgur1/nTO00eA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 97006A00A0;
        Thu, 16 Jul 2020 12:37:47 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2057.outbound.protection.outlook.com [104.47.46.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 647A380056;
        Thu, 16 Jul 2020 12:37:46 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="JG9WIYLu";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZhcPLjJKmcKhKTiyWZttaxs35qy5D5ngxVh/KTsQ8cfgb2cKiGZlHGdhyhEjRtNdKcZ8RWypv7jmM5dFndYbAEE/uIQ79iy/gE9nIIRgei3errzYq0Co87A3f7BzbjQIuPYRPhzHRmUn2RjwIq4qzXt2FnUaOXRYoqyBNyEDLNbS7z/oBDNp1WqHPivkqH6BlqnyGoZRnL4L/9P2AylMk+SxMqbJIYDnCGKwUGuKgI+YAEGMCAoT7Zp1LZ9wDo1Ou4d2ReqhQZuW6q7jmEiiJpkAy6laVho4JcDu9I+KR1faIEqlQ84FrDHVJDNdQRtjI8pOdlRaCoJXo2fV/3Tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHMh0GCptOKF25Vidx64E1s50eH6CKHnM3K81mLq6MY=;
 b=hRrcH7uvsFA608u2o5slgnBvb7Gt2/Se3QtRRfKCHK/RtUCWUmgbajSXkedm5f7/V8drbUJyY8rsbnMRqdVsUmLLAGIcoIHb8/WddlY/Or0leXzF67qd+zgv6oJQm4cU9RAqIZZ1Txia18N5r3iU0LgSsWZPJdhnmTQD6xmrmL9/mvGcplEl0asc3tv7u2F+u2P435qE2xO0iWcMQniXFIr+wYdeoCUQkbd6TLSEfGqspGg+ajVRYUe9cJ/yHrf+YMxumNaocmiSjD4pVu1ww6laSMajyH8aHCAxyGMyQx3lPc2kKyeAMaPfvLaDx4A0hMqYhkmudXW/oNlz59DTzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHMh0GCptOKF25Vidx64E1s50eH6CKHnM3K81mLq6MY=;
 b=JG9WIYLutDyNR5DM5g/Xfy4GdhV46i0pm49U/EzUPh9ygIk0TRe/0ijkKkGBwsAd/hpqAW9BaOgjpDOxZaqDIIt6qU2awXOedz5atc4zbYOBVP2M6B9iG0/NUQt5QzCzpjWM3HT71EGIHxzhcDds49aQE2UGk90W0n02QwT+OHQ=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR12MB1640.namprd12.prod.outlook.com (2603:10b6:910:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 12:37:44 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3174.025; Thu, 16 Jul
 2020 12:37:44 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] usb: dwc2: Fix error path in gadget registration
Thread-Topic: [PATCH v2] usb: dwc2: Fix error path in gadget registration
Thread-Index: AQHWW2oJamYfC8nRWEuRTA5WsVW2gKkKH/2AgAADw4CAAAE4gA==
Date:   Thu, 16 Jul 2020 12:37:43 +0000
Message-ID: <275790a0-bb66-e7d4-da78-1209cc1eb7b2@synopsys.com>
References: <CGME20200716120956eucas1p1c5fd8e24c16e6616041467f618034b44@eucas1p1.samsung.com>
 <20200716120948.28180-1-m.szyprowski@samsung.com>
 <b7571d9c-95ac-26ec-538e-60e1aae0cddb@synopsys.com>
 <4741f20f-6e8e-157b-6ecb-828ad4423210@samsung.com>
In-Reply-To: <4741f20f-6e8e-157b-6ecb-828ad4423210@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.94.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81ce55ef-a113-4299-52ba-08d829850991
x-ms-traffictypediagnostic: CY4PR12MB1640:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB16409294DD0924FBDC8A9561A77F0@CY4PR12MB1640.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eqr0zA1DZ60Rz77GkRzkOt4OMkxhi86UXanyng/AHgwOKtXp0xmvRr9MmG6BJhyR9+TVXCAcNDgDOvdlgb5rmQQkyorJrqOZzbVwaDq8ZXvRkJ4vHBl36gUYho9Rd0A9M3QfFoBXI967Ss9te4Sj2urbvz14Mm/1R2AcrBb+HrsFIADe+pOm44KzPlKZGDH2VslXPzP3MfLaf65AitJzMSGLCnhwrKGdR8eIkfrg5Yf8Wa+rKwDHAAuk1zDy6Wz32N4Bu6cOY+jqwikmUpC0w2peGpBM8FT2R/QqpepdWm0UUaOlymhSfx0cmPGIcavvth35z4UtNG1IMV7yOoAT/8lHIfQ4f/N/9o44Y0o+cA+m7tKj5PVnx82GHNhAiVdu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(376002)(346002)(396003)(136003)(71200400001)(2616005)(26005)(8676002)(6486002)(478600001)(91956017)(76116006)(110136005)(66946007)(54906003)(5660300002)(31686004)(6512007)(86362001)(4326008)(36756003)(8936002)(31696002)(6506007)(66476007)(316002)(186003)(83380400001)(66556008)(53546011)(45080400002)(2906002)(66446008)(64756008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7I1H8fW4pUDtdO8umLeRZoXG6DgM1Kqe9YHDkvhKg5rJ1eL28IBYh7z0SxRg6yfw2d2++jVth0OEOQ+83GdCXYPMCWE6Sr85FZ7nHNIhLH3iWDuDXAEyDovls7AKkQzbhZbqXu7WBDaOyI6n3KWAcUDMMMX/39AgGNzUm2EppWr0/Utit3b/DOydBLUceP4kZlB4Zkt/MqxC+U/weWXp9tmOCK4I/L7JksqJD+mzuVNJ8Q6dpZcUnyVNmqx/W/GcKjOTTrUpRMn7pKrqqkBiiQhPz/wqMlYS/UEZ/DIbjYvQpCeyBxte8HAg60sNDk8e4z/d+e+mrcgpzXPlR73u0CfRtk73d80pKD3YP8K5GXrLX74KGnuWBJMbDl18uvVqTeLgYDYxQD91tbw3A6XoWPL6gVOnoqaWAENaWoyzND/sr0jSItshYSDkSuLuFJMabk6pVHd6HJKxCWgOUvT5ay02NNIcossoL4F5/2Tgj6U=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29F76E41A4F8FB409CACAA2FE737173C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce55ef-a113-4299-52ba-08d829850991
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 12:37:43.9553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aD4nFQ/HEZZhVxxiifK/kCAzazySoUy/2toaOD18XomDiDMCneTBczoyxNnAkK5o1lMKlYORSwUXlaSQ1nD5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1640
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDcvMTYvMjAyMCA0OjMzIFBNLCBNYXJlayBTenlwcm93c2tpIHdyb3RlOg0KPiBI
aSBNaW5hcywNCj4gDQo+IE9uIDE2LjA3LjIwMjAgMTQ6MTksIE1pbmFzIEhhcnV0eXVueWFuIHdy
b3RlOg0KPj4gT24gNy8xNi8yMDIwIDQ6MDkgUE0sIE1hcmVrIFN6eXByb3dza2kgd3JvdGU6DQo+
Pj4gV2hlbiBnYWRnZXQgcmVnaXN0cmF0aW9uIGZhaWxzLCBvbmUgc2hvdWxkIG5vdCBjYWxsIHVz
Yl9kZWxfZ2FkZ2V0X3VkYygpLg0KPj4+IEVuc3VyZSB0aGlzIGJ5IHNldHRpbmcgZ2FkZ2V0LT51
ZGMgdG8gTlVMTC4gQWxzbyBpbiBjYXNlIG9mIGEgZmFpbHVyZQ0KPj4+IHRoZXJlIGlzIG5vIG5l
ZWQgdG8gZGlzYWJsZSBsb3ctbGV2ZWwgaGFyZHdhcmUsIHNvIHJldHVybiBpbW1pZWRldGx5DQo+
Pj4gaW5zdGVhZCBvZiBqdW1waW5nIHRvIGVycm9yX2luaXQgbGFiZWwuDQo+Pj4NCj4+PiBUaGlz
IGZpeGVzIHRoZSBmb2xsb3dpbmcga2VybmVsIE5VTEwgcHRyIGRlcmVmZXJlbmNlIG9uIGdhZGdl
dCBmYWlsdXJlDQo+Pj4gKGNhbiBiZSBlYXNpbHkgdHJpZ2dlcmVkIHdpdGggZ19tYXNzX3N0b3Jh
Z2Ugd2l0aG91dCBhbnkgbW9kdWxlDQo+Pj4gcGFyYW1ldGVycyk6DQo+Pj4NCj4+PiBkd2MyIDEy
NDgwMDAwLmhzb3RnOiBkd2MyX2NoZWNrX3BhcmFtczogSW52YWxpZCBwYXJhbWV0ZXIgYmVzbD0x
DQo+Pj4gZHdjMiAxMjQ4MDAwMC5oc290ZzogZHdjMl9jaGVja19wYXJhbXM6IEludmFsaWQgcGFy
YW1ldGVyIGdfbnBfdHhfZmlmb19zaXplPTEwMjQNCj4+PiBkd2MyIDEyNDgwMDAwLmhzb3RnOiBF
UHM6IDE2LCBkZWRpY2F0ZWQgZmlmb3MsIDc4MDggZW50cmllcyBpbiBTUFJBTQ0KPj4+IE1hc3Mg
U3RvcmFnZSBGdW5jdGlvbiwgdmVyc2lvbjogMjAwOS8wOS8xMQ0KPj4+IExVTjogcmVtb3ZhYmxl
IGZpbGU6IChubyBtZWRpdW0pDQo+Pj4gbm8gZmlsZSBnaXZlbiBmb3IgTFVOMA0KPj4+IGdfbWFz
c19zdG9yYWdlIDEyNDgwMDAwLmhzb3RnOiBmYWlsZWQgdG8gc3RhcnQgZ19tYXNzX3N0b3JhZ2U6
IC0yMg0KPj4+IDg8LS0tIGN1dCBoZXJlIC0tLQ0KPj4+IFVuYWJsZSB0byBoYW5kbGUga2VybmVs
IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBhdCB2aXJ0dWFsIGFkZHJlc3MgMDAwMDAxMDQNCj4+
PiBwZ2QgPSAocHRydmFsKQ0KPj4+IFswMDAwMDEwNF0gKnBnZD0wMDAwMDAwMA0KPj4+IEludGVy
bmFsIGVycm9yOiBPb3BzOiA4MDUgWyMxXSBQUkVFTVBUIFNNUCBBUk0NCj4+PiBNb2R1bGVzIGxp
bmtlZCBpbjoNCj4+PiBDUFU6IDAgUElEOiAxMiBDb21tOiBrd29ya2VyLzA6MSBOb3QgdGFpbnRl
ZCA1LjguMC1yYzUgIzMxMzMNCj4+PiBIYXJkd2FyZSBuYW1lOiBTYW1zdW5nIEV4eW5vcyAoRmxh
dHRlbmVkIERldmljZSBUcmVlKQ0KPj4+IFdvcmtxdWV1ZTogZXZlbnRzIGRlZmVycmVkX3Byb2Jl
X3dvcmtfZnVuYw0KPj4+IFBDIGlzIGF0IHVzYl9kZWxfZ2FkZ2V0X3VkYysweDM4LzB4YzQNCj4+
PiBMUiBpcyBhdCBfX211dGV4X2xvY2srMHgzMWMvMHhiMTgNCj4+PiAuLi4NCj4+PiBQcm9jZXNz
IGt3b3JrZXIvMDoxIChwaWQ6IDEyLCBzdGFjayBsaW1pdCA9IDB4KHB0cnZhbCkpDQo+Pj4gU3Rh
Y2s6ICgweGVmMTIxZGIwIHRvIDB4ZWYxMjIwMDApDQo+Pj4gLi4uDQo+Pj4gWzxjMDc2YmYzYz5d
ICh1c2JfZGVsX2dhZGdldF91ZGMpIGZyb20gWzxjMDcyNmJlYz5dIChkd2MyX2hzb3RnX3JlbW92
ZSsweDEwLzB4MjApDQo+Pj4gWzxjMDcyNmJlYz5dIChkd2MyX2hzb3RnX3JlbW92ZSkgZnJvbSBb
PGMwNzExMjA4Pl0gKGR3YzJfZHJpdmVyX3Byb2JlKzB4NTdjLzB4NjljKQ0KPj4+IFs8YzA3MTEy
MDg+XSAoZHdjMl9kcml2ZXJfcHJvYmUpIGZyb20gWzxjMDYyNDdjMD5dIChwbGF0Zm9ybV9kcnZf
cHJvYmUrMHg2Yy8weGE0KQ0KPj4+IFs8YzA2MjQ3YzA+XSAocGxhdGZvcm1fZHJ2X3Byb2JlKSBm
cm9tIFs8YzA2MjFkZjQ+XSAocmVhbGx5X3Byb2JlKzB4MjAwLzB4NDhjKQ0KPj4+IFs8YzA2MjFk
ZjQ+XSAocmVhbGx5X3Byb2JlKSBmcm9tIFs8YzA2MjIxZTg+XSAoZHJpdmVyX3Byb2JlX2Rldmlj
ZSsweDc4LzB4MWZjKQ0KPj4+IFs8YzA2MjIxZTg+XSAoZHJpdmVyX3Byb2JlX2RldmljZSkgZnJv
bSBbPGMwNjFmY2Q0Pl0gKGJ1c19mb3JfZWFjaF9kcnYrMHg3NC8weGI4KQ0KPj4+IFs8YzA2MWZj
ZDQ+XSAoYnVzX2Zvcl9lYWNoX2RydikgZnJvbSBbPGMwNjIxYjU0Pl0gKF9fZGV2aWNlX2F0dGFj
aCsweGQ0LzB4MTZjKQ0KPj4+IFs8YzA2MjFiNTQ+XSAoX19kZXZpY2VfYXR0YWNoKSBmcm9tIFs8
YzA2MjBjOTg+XSAoYnVzX3Byb2JlX2RldmljZSsweDg4LzB4OTApDQo+Pj4gWzxjMDYyMGM5OD5d
IChidXNfcHJvYmVfZGV2aWNlKSBmcm9tIFs8YzA2MjExYjA+XSAoZGVmZXJyZWRfcHJvYmVfd29y
a19mdW5jKzB4M2MvMHhkMCkNCj4+PiBbPGMwNjIxMWIwPl0gKGRlZmVycmVkX3Byb2JlX3dvcmtf
ZnVuYykgZnJvbSBbPGMwMTQ5MjgwPl0gKHByb2Nlc3Nfb25lX3dvcmsrMHgyMzQvMHg3ZGMpDQo+
Pj4gWzxjMDE0OTI4MD5dIChwcm9jZXNzX29uZV93b3JrKSBmcm9tIFs8YzAxNDk4NmM+XSAod29y
a2VyX3RocmVhZCsweDQ0LzB4NTFjKQ0KPj4+IFs8YzAxNDk4NmM+XSAod29ya2VyX3RocmVhZCkg
ZnJvbSBbPGMwMTUwYjFjPl0gKGt0aHJlYWQrMHgxNTgvMHgxYTApDQo+Pj4gWzxjMDE1MGIxYz5d
IChrdGhyZWFkKSBmcm9tIFs8YzAxMDAxMTQ+XSAocmV0X2Zyb21fZm9yaysweDE0LzB4MjApDQo+
Pj4gRXhjZXB0aW9uIHN0YWNrKDB4ZWYxMjFmYjAgdG8gMHhlZjEyMWZmOCkNCj4+PiAuLi4NCj4+
PiAtLS1bIGVuZCB0cmFjZSA5NzI0YzJmYzdjYzljOTgyIF0tLS0NCj4+Pg0KPj4+IFdoaWxlIGZp
eGluZyB0aGlzIGFsc28gZml4IHRoZSBkb3VibGUgY2FsbCB0byBkd2MyX2xvd2xldmVsX2h3X2Rp
c2FibGUoKQ0KPj4+IGlmIGRyX21vZGUgaXMgc2V0IHRvIFVTQl9EUl9NT0RFX1BFUklQSEVSQUwu
IEluIHN1Y2ggY2FzZSBsb3ctbGV2ZWwNCj4+PiBoYXJkd2FyZSBpcyBhbHJlYWR5IGRpc2FibGVk
IGJlZm9yZSBjYWxsaW5nIHVzYl9hZGRfZ2FkZ2V0X3VkYygpLiBUaGF0DQo+Pj4gZnVuY3Rpb24g
Y29ycmVjdGx5IHByZXNlcnZlcyBsb3ctbGV2ZWwgaGFyZHdhcmUgc3RhdGUsIHRoZXJlIGlzIG5v
IG5lZWQNCj4+PiBmb3IgdGhlIHNlY29uZCB1bmNvbmRpdGlvbmFsIGR3YzJfbG93bGV2ZWxfaHdf
ZGlzYWJsZSgpIGNhbGwuDQo+Pj4NCj4+PiBGaXhlczogMjA3MzI0YTMyMWE4ICgidXNiOiBkd2My
OiBQb3N0cG9uZWQgZ2FkZ2V0IHJlZ2lzdHJhdGlvbiB0byB0aGUgdWRjIGNsYXNzIGRyaXZlciIp
DQo+Pj4gU2lnbmVkLW9mZi1ieTogTWFyZWsgU3p5cHJvd3NraSA8bS5zenlwcm93c2tpQHNhbXN1
bmcuY29tPg0KDQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5j
b20+DQoNCj4+PiAtLS0NCj4+PiAgICAgZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jIHwgNCAr
KystDQo+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMgYi9k
cml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4+PiBpbmRleCBjYjhkZGJkNTM3MTguLmRiOWZk
NGJkMWEzOCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4+
PiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL3BsYXRmb3JtLmMNCj4+PiBAQCAtNTgyLDYgKzU4Miw3
IEBAIHN0YXRpYyBpbnQgZHdjMl9kcml2ZXJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
ZGV2KQ0KPj4+ICAgICAJaWYgKGhzb3RnLT5nYWRnZXRfZW5hYmxlZCkgew0KPj4+ICAgICAJCXJl
dHZhbCA9IHVzYl9hZGRfZ2FkZ2V0X3VkYyhoc290Zy0+ZGV2LCAmaHNvdGctPmdhZGdldCk7DQo+
Pj4gICAgIAkJaWYgKHJldHZhbCkgew0KPj4+ICsJCQloc290Zy0+Z2FkZ2V0LnVkYyA9IE5VTEw7
DQo+PiBDb25zaWRlciB5b3VyIHJlY2VudGx5IHNlbnQgcGF0Y2ggIltQQVRDSF0gdXNiOiBnYWRn
ZXQ6IHVkYzogRmx1c2gNCj4+IHBlbmRpbmcgd29yayBhbHNvIGluIGVycm9yIHBhdGgiLCBtb3Jl
IHByb2JhYmx5IGl0J3Mgbm90IHJlcXVpcmVkLA0KPj4gYmVjYXVzZSByb290IGNhdXNlIG9mIG9i
c2VydmVkIGR3YzIgaXNzdWUgY29tZXMgZnJvbSB1ZGMuDQo+PiBBbSBJIHdyb25nPw0KPiANCj4g
VGhleSBhcmUgdHdvIGluZGVwZW5kZW50IGlzc3VlcywgYm90aCBmYXRhbCBvbiBteSB0ZXN0IHN5
c3RlbS4NCj4gDQo+IFRoZSBmaXJzdCBvbmUgKHRoZSBsYWNrIG9mIE5VTExpbmcgZ2FkZ2V0LT51
ZGMpIGNhbiBiZSBlYXNpbHkgdHJpZ2dlcmVkDQo+IG9uIGFueSBzeXN0ZW0uIFRoZSBsYXR0ZXIg
b25lIChsYWNrIG9mIGZsdXNoIGluIFVEQyBjb3JlKSBkZXBlbmRzIG9uIHRoZQ0KPiBsdWNrIGFu
ZCBtZW1vcnkgbGF5b3V0IG9uIHRoZSB0ZXN0IHN5c3RlbS4NCj4gDQo+IEJlc3QgcmVnYXJkcw0K
PiANCg==
