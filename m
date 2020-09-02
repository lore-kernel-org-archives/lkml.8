Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CEDC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E60206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RVeitWfG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c5K/ZX3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgIBBz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:55:59 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59556 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726122AbgIBBzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:55:20 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B38B04013B;
        Wed,  2 Sep 2020 01:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599011719; bh=t3sdnn/ulWKM7fUhoLzWGbjGZGUZLPMFg5g3fec425s=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=RVeitWfGrlx6x0n916dwHt1fWGCSJeIQ+hKSYh0cUXL6CMgXO9fc21EY2k6aocewZ
         QTo5uKq35y//n8VJ0LsfOCqw62dGRS+0Eg2YZRsu850itDFki568WK7u0DL5lx08RA
         6AZZVuxNV90FtSe0hTRocvQrCndHGt18GgZvdSeYynVX5+UdZYXbahJhzOMr/NsKwz
         PocmodybkNpPNqIriHuaRRf6/E2AfwgrPGTAH6205jM82yasF6LMhVsPWckcSo4IHs
         sCHBEDeSVRBXOv40kcGantwS/QB+jdie96qmzuqJkhgqvFNLLtJgBVkKFsFQcWZnl1
         ti5r26aH4b/Eg==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id F0672A007B;
        Wed,  2 Sep 2020 01:55:18 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id EE394400AF;
        Wed,  2 Sep 2020 01:55:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="c5K/ZX3w";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUb1X0xWUDl3Jl4oyCpUfKB7hyfRCfRZcvfVIqom9z9r513IyR7Q6zAA8c67SEcHEg7Ua48aYS83oEzX3QbAQ3Z0RjUVYXkTpoB3lN738sDnl4QMF51UztNiT1PkF+rd49SOX54eK7vgXx6kHN/lErNUEnF5pLzQu8tK5S3JmjpcRD9t6vMJ315GYi71+Rt3CgsSwmVgFsKEX2zE5vbH3iaq7LISuThvQAjcpiL+OlBctyHJv9wKRXSOFwKcIZu+jZBrdwLRTu0WISZC5JGZenNFJ/7qkZMK5Tg3w+hjflOg+88pQbOzdqCfkiZOEu8NDCWMCO9/gY+1HHV/suU4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3sdnn/ulWKM7fUhoLzWGbjGZGUZLPMFg5g3fec425s=;
 b=fgtOfqVj7XReGFHEcl2JQKPrI7ejDJ/iRVym3CqR8cXcI1/IJUUNE2fRLQfTdycn1eWyUVkDSFLv6ac/bKaFjOW8w+LOx+txEq03uSVxcT2I60fzrVo8Io9FkxKDFU2JwRq91xWxuI5gl0YGLgC2TlOHDEyxICx3OI7Y40lhSOOjw9AiKnr4/ffzjIkAMJowBM6COfmDLKr8ciS224u/a+A/ETCqDOnwfgLXUDyYZrSz8vtWT+aPPJyXxh8QpLEZEae9hlHpu2P9r+pFSjnZ/f0d9fVIYbsNqef0sryGQdkhmH+gDUBFZBNPt9IAw1OnUgDERT+fjkE4kxYBoU4nKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3sdnn/ulWKM7fUhoLzWGbjGZGUZLPMFg5g3fec425s=;
 b=c5K/ZX3wa0ASBxtgAS3f0dK8NO8UtYqk5u+bH0eVnkj2SLJQFJrk224imnVlfF+F/WlBP6UZ3rcGTjRjkQ49A2oXW3rBKwQCu1meDk68f5WC/i91q3q/ioEYutlsKGGB8pZQT3q1k0HiKtfqbQ4RwBlZQT5vpFLi8NtP2g10MqU=
Received: from DM6PR12MB2924.namprd12.prod.outlook.com (2603:10b6:5:183::23)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Wed, 2 Sep
 2020 01:55:16 +0000
Received: from DM6PR12MB2924.namprd12.prod.outlook.com
 ([fe80::fc33:b670:9830:9c17]) by DM6PR12MB2924.namprd12.prod.outlook.com
 ([fe80::fc33:b670:9830:9c17%3]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 01:55:15 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v2] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Topic: [PATCH v2] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Index: AQHWfYzfOHRuk9qxlUy/aHCACERYqalPnX6AgATCBYCAADxAAIAAAVeA
Date:   Wed, 2 Sep 2020 01:55:15 +0000
Message-ID: <57529302-d43c-c0fc-ab31-ab45a177fd05@synopsys.com>
References: <20200828224440.22091-1-wcheng@codeaurora.org>
 <e7e0cac8-b0f1-3173-a54a-ccf061807c0c@synopsys.com>
 <d9ff68b0-6f5e-bf6d-9dfb-daac8b0a7abe@codeaurora.org>
 <ee3b5178-1c8e-0758-1181-b28af2a51572@codeaurora.org>
In-Reply-To: <ee3b5178-1c8e-0758-1181-b28af2a51572@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cb984ac-e9d4-4c6f-db7d-08d84ee33cea
x-ms-traffictypediagnostic: DM6PR12MB4481:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4481FDE7D9262F4C1B6F3D9DAA2F0@DM6PR12MB4481.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5R67Barov4UQo0C/Fvm9312Lxd3aHqdKTP8V51k9yAhJPShl7KR5XDtXOmv6l5UBLbxWTLRkpZNRSZ/vNFq35R1O0M2PZKrOLW45p8XY3HalQ3UbowswxM21nc0o4vY0bAx4PRC5gKwNwv0HsOaKPCQb0MoRL9/LUvFPxnYHdVEn7rcCd40YX85jC7T8NY/Rq9ptclUDXLwtkCodvMZ4qyahHo7DMiuEuSgOsJyFn0hXMBPX1VUS2HkdWjAiCefSTRflKvN56xBYW1vZX9cpCBerW+19ODT7uqFxAp1IgGmPTVOTbisulSTi6ng9sjaWhHaQTzt4vxwlDEvYE2fIM21tPx7mp+OudU+VT0V/mm/PWQbB841lmHODVTOdGFB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2924.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(39860400002)(366004)(66446008)(6486002)(6506007)(6512007)(66946007)(31686004)(2616005)(478600001)(4326008)(8676002)(86362001)(186003)(66476007)(64756008)(316002)(53546011)(110136005)(66556008)(26005)(54906003)(71200400001)(8936002)(76116006)(36756003)(2906002)(31696002)(5660300002)(83380400001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Rysaoe7UrewV7U61nFQW8FJ3yGPIdZhK8U+AjxWvlDQX1e9ASg9Ym5S6mR9DQLU14+L/kArPQUKbNqzlkmqfHqoH24w2FISI7hzYx6m1hEc6Fvmc6OeWLVW57oeGsfv9aK0QYUQTOgS+42Opx0XNHPb0iDo3EGcqJmkc/ygh9DPM1YL6HXR130NzjNIk41feQMiWzIMMvweLOM07yCqEiwT+5Y9p8444G4LyheputWKF4f6AehrRrbxklVP97K4Bpyv0T+bhjDi+GVCVGlUrI2K0Ij7uVvA+83U425gYDCJKjdRseUZfJwKpcPW1GQFdy4v30GORsET8GSvzBxpHNih2yZbgXL5sm6NliQVyuxKcPXMAvJ9aM5WbDHg4AKS78PoVGiKF3Xp+8auS/ZHPZYkTTabEYvL3y93CBE4eXPZyPMUg6+RIGzlyKpivsjNZXEcz88YDoMBDeuCbyrXLg0+55DFp8aT7nNXBAcswibcLdY7DAebUyPXNiONwLBkqehBlEE55e+cOQqaYx/6T6sxdcxztfqfEF2IGO7+cy1e362JV64/z/s1BKs7WBU61kwOpBux745pVx6H1AiB5sylS5fL2smvciNTrS2Ohu5cO0tZF9/u63IbBbxN+0udH2jjr4H8ps+s9+QUrzydriQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7BA43DC40DB5C4DB74402160CE472C2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2924.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb984ac-e9d4-4c6f-db7d-08d84ee33cea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 01:55:15.7673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1ewwPlP3VF482oR9lvXfIBgE1e02e7z1rUjeSEk8dLRCbv3ny+1Ua8xwtScgc8a+aGnDdU/VP30JgvAArM94g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPg0KPiBPbiA5LzEvMjAyMCAzOjE0IFBNLCBXZXNsZXkgQ2hl
bmcgd3JvdGU6DQo+Pg0KPj4gT24gOC8yOS8yMDIwIDI6MzUgUE0sIFRoaW5oIE5ndXllbiB3cm90
ZToNCj4+PiBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+Pj4+IEluIHRoZSBEV0MzIGRhdGFib29rLCBm
b3IgYSBkZXZpY2UgaW5pdGlhdGVkIGRpc2Nvbm5lY3Qgb3IgYnVzIHJlc2V0LCB0aGUNCj4+Pj4g
ZHJpdmVyIGlzIHJlcXVpcmVkIHRvIHNlbmQgZGVwZW5keGZlciBjb21tYW5kcyBmb3IgYW55IHBl
bmRpbmcgdHJhbnNmZXJzLg0KPj4+PiBJbiBhZGRpdGlvbiwgYmVmb3JlIHRoZSBjb250cm9sbGVy
IGNhbiBtb3ZlIHRvIHRoZSBoYWx0ZWQgc3RhdGUsIHRoZSBTVw0KPj4+PiBuZWVkcyB0byBhY2tu
b3dsZWRnZSBhbnkgcGVuZGluZyBldmVudHMuICBJZiB0aGUgY29udHJvbGxlciBpcyBub3QgaGFs
dGVkDQo+Pj4+IHByb3Blcmx5LCB0aGVyZSBpcyBhIGNoYW5jZSB0aGUgY29udHJvbGxlciB3aWxs
IGNvbnRpbnVlIGFjY2Vzc2luZyBzdGFsZSBvcg0KPj4+PiBmcmVlZCBUUkJzIGFuZCBidWZmZXJz
Lg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBXZXNsZXkgQ2hlbmcgPHdjaGVuZ0Bjb2RlYXVy
b3JhLm9yZz4NCj4+Pj4NCj4+Pj4gLS0tDQo+Pj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4+ICAtIE1v
dmVkIGNsZWFudXAgY29kZSB0byB0aGUgcHVsbHVwKCkgQVBJIHRvIGRpZmZlcmVudGlhdGUgYmV0
d2VlbiBkZXZpY2UNCj4+Pj4gICAgZGlzY29ubmVjdCBhbmQgaGliZXJuYXRpb24uDQo+Pj4+ICAt
IEFkZGVkIGNsZWFudXAgY29kZSB0byB0aGUgYnVzIHJlc2V0IGNhc2UgYXMgd2VsbC4NCj4+Pj4g
IC0gVmVyaWZpZWQgdGhlIG1vdmUgdG8gcHVsbHVwKCkgZGlkIG5vdCByZXByb2R1Y2UgdGhlIHBy
b2JsZW4gdXNpbmcgdGhlDQo+Pj4+ICAgIHNhbWUgdGVzdCBzZXF1ZW5jZS4NCj4+Pj4NCj4+Pj4g
VmVyaWZpZWQgZml4IGJ5IGFkZGluZyBhIGNoZWNrIGZvciBFVElNRURPVVQgZHVyaW5nIHRoZSBy
dW4gc3RvcCBjYWxsLg0KPj4+PiBTaGVsbCBzY3JpcHQgd3JpdGluZyB0byB0aGUgY29uZmlnZnMg
VURDIGZpbGUgdG8gdHJpZ2dlciBkaXNjb25uZWN0IGFuZA0KPj4+PiBjb25uZWN0LiAgQmF0Y2gg
c2NyaXB0IHRvIGhhdmUgUEMgZXhlY3V0ZSBkYXRhIHRyYW5zZmVycyBvdmVyIGFkYiAoaWUgYWRi
DQo+Pj4+IHB1c2gpICBBZnRlciBhIGZldyBpdGVyYXRpb25zLCB3ZSdkIHJ1biBpbnRvIGEgc2Nl
bmFyaW8gd2hlcmUgdGhlDQo+Pj4+IGNvbnRyb2xsZXIgd2Fzbid0IGhhbHRlZC4gIFdpdGggdGhl
IGZvbGxvd2luZyBjaGFuZ2UsIG5vIGZhaWxlZCBoYWx0cyBhZnRlcg0KPj4+PiBtYW55IGl0ZXJh
dGlvbnMuDQo+Pj4+IC0tLQ0KPj4+PiAgZHJpdmVycy91c2IvZHdjMy9lcDAuYyAgICB8ICAyICst
DQo+Pj4+ICBkcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jIHwgNTIgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystDQo+Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDUyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9kd2MzL2VwMC5jIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0KPj4+PiBpbmRleCA1OWYyZThj
MzFiZDEuLjQ1NmFhODdlODc3OCAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9l
cDAuYw0KPj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4+IEBAIC0xOTcsNyAr
MTk3LDcgQEAgaW50IGR3YzNfZ2FkZ2V0X2VwMF9xdWV1ZShzdHJ1Y3QgdXNiX2VwICplcCwgc3Ry
dWN0IHVzYl9yZXF1ZXN0ICpyZXF1ZXN0LA0KPj4+PiAgCWludAkJCQlyZXQ7DQo+Pj4+ICANCj4+
Pj4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+Pj4+IC0JaWYgKCFk
ZXAtPmVuZHBvaW50LmRlc2MpIHsNCj4+Pj4gKwlpZiAoIWRlcC0+ZW5kcG9pbnQuZGVzYyB8fCAh
ZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCkgew0KPj4+PiAgCQlkZXZfZXJyKGR3Yy0+ZGV2LCAiJXM6
IGNhbid0IHF1ZXVlIHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0KPj4+PiAgCQkJCWRlcC0+bmFt
ZSk7DQo+Pj4+ICAJCXJldCA9IC1FU0hVVERPV047DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9kd2MzL2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+PiBpbmRl
eCAzYWI2ZjExOGM1MDguLmRmOGQ4OWQ2YmRjOSAxMDA2NDQNCj4+Pj4gLS0tIGEvZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYw0KPj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+
Pj4+IEBAIC0xNTE2LDcgKzE1MTYsNyBAQCBzdGF0aWMgaW50IF9fZHdjM19nYWRnZXRfZXBfcXVl
dWUoc3RydWN0IGR3YzNfZXAgKmRlcCwgc3RydWN0IGR3YzNfcmVxdWVzdCAqcmVxKQ0KPj4+PiAg
ew0KPj4+PiAgCXN0cnVjdCBkd2MzCQkqZHdjID0gZGVwLT5kd2M7DQo+Pj4+ICANCj4+Pj4gLQlp
ZiAoIWRlcC0+ZW5kcG9pbnQuZGVzYykgew0KPj4+PiArCWlmICghZGVwLT5lbmRwb2ludC5kZXNj
IHx8ICFkd2MtPnB1bGx1cHNfY29ubmVjdGVkKSB7DQo+Pj4+ICAJCWRldl9lcnIoZHdjLT5kZXYs
ICIlczogY2FuJ3QgcXVldWUgdG8gZGlzYWJsZWQgZW5kcG9pbnRcbiIsDQo+Pj4+ICAJCQkJZGVw
LT5uYW1lKTsNCj4+Pj4gIAkJcmV0dXJuIC1FU0hVVERPV047DQo+Pj4+IEBAIC0xOTI2LDYgKzE5
MjYsMjQgQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9zZXRfc2VsZnBvd2VyZWQoc3RydWN0IHVz
Yl9nYWRnZXQgKmcsDQo+Pj4+ICAJcmV0dXJuIDA7DQo+Pj4+ICB9DQo+Pj4+ICANCj4+Pj4gK3N0
YXRpYyB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXJzKHN0cnVjdCBkd2MzICpkd2MpDQo+
Pj4+ICt7DQo+Pj4+ICsJdTMyIGVwbnVtOw0KPj4+PiArDQo+Pj4+ICsJZm9yIChlcG51bSA9IDI7
IGVwbnVtIDwgRFdDM19FTkRQT0lOVFNfTlVNOyBlcG51bSsrKSB7DQo+Pj4+ICsJCXN0cnVjdCBk
d2MzX2VwICpkZXA7DQo+Pj4+ICsNCj4+Pj4gKwkJZGVwID0gZHdjLT5lcHNbZXBudW1dOw0KPj4+
PiArCQlpZiAoIWRlcCkNCj4+Pj4gKwkJCWNvbnRpbnVlOw0KPj4+PiArDQo+Pj4+ICsJCWlmICgh
KGRlcC0+ZmxhZ3MgJiBEV0MzX0VQX0VOQUJMRUQpKQ0KPj4+PiArCQkJY29udGludWU7DQo+Pj4g
RG9uJ3QgZG8gdGhlIGVuYWJsZWQgY2hlY2sgaGVyZS4gTGV0IHRoZSBkd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVyKCkgZG8NCj4+PiB0aGF0IGNoZWNraW5nLg0KPj4+DQo+PiBIaSBUaGluaCwNCj4+
DQo+PiBUaGFua3MgZm9yIHRoZSBkZXRhaWxlZCByZXZpZXcsIGFzIGFsd2F5cy4gIEdvdCBpdCwg
d2UgY2FuIGFsbG93IHRoYXQgdG8NCj4+IGNhdGNoIGl0IGJhc2VkIG9mZiB0aGUgRFdDM19FUF9U
UkFOU0ZFUl9TVEFSVEVELg0KPj4NCj4+Pj4gKw0KPj4+PiArCQlkd2MzX3JlbW92ZV9yZXF1ZXN0
cyhkd2MsIGRlcCk7DQo+Pj4+ICsJfQ0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICBzdGF0aWMgaW50
IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2MsIGludCBpc19vbiwgaW50IHN1
c3BlbmQpDQo+Pj4+ICB7DQo+Pj4+ICAJdTMyCQkJcmVnOw0KPj4+PiBAQCAtMTk5NCw5ICsyMDEy
LDM5IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpn
LCBpbnQgaXNfb24pDQo+Pj4+ICAJCX0NCj4+Pj4gIAl9DQo+Pj4+ICANCj4+Pj4gKwkvKg0KPj4+
PiArCSAqIFN5bmNocm9uaXplIGFuZCBkaXNhYmxlIGFueSBmdXJ0aGVyIGV2ZW50IGhhbmRsaW5n
IHdoaWxlIGNvbnRyb2xsZXINCj4+Pj4gKwkgKiBpcyBiZWluZyBlbmFibGVkL2Rpc2FibGVkLg0K
Pj4+PiArCSAqLw0KPj4+PiArCWRpc2FibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+Pj4gSSB0
aGluayBpdCdzIGJldHRlciB0byBkbyBkd2MzX2dhZGdldF9kaXNhYmxlX2lycSgpLiBUaGlzIG9u
bHkgc3RvcHMNCj4+PiBoYW5kbGluZyBldmVudHMuIEFsdGhvdWdoIGl0J3MgdW5saWtlbHksIHRo
ZSBjb250cm9sbGVyIG1heSBzdGlsbA0KPj4+IGdlbmVyYXRlIGV2ZW50cyBiZWZvcmUgaXQncyBo
YWx0ZWQuDQo+Pj4NCj4+IEkgdGhpbmsgaXRzIGJldHRlciBpZiB3ZSBjYW4gZG8gYm90aC4gIEF0
IGxlYXN0IHdpdGggdGhlIGRpc2FibGVfaXJxKCkNCj4+IGNhbGwgcHJlc2VudCwgd2UgY2FuIGVu
c3VyZSB0aGUgaXJxIGhhbmRsZXJzIGFyZSBjb21wbGV0ZSwgb3Igd2UgY2FuIGRvDQo+PiBhcyBG
ZWxpcGUgc3VnZ2VzdGVkLCBhbmQgZmlyc3QgZGlzYWJsZSB0aGUgY29udHJvbGxlciBldmVudHMg
KHVzaW5nDQo+PiBkd2MzX2dhZGdldF9kaXNhYmxlX2lycSgpKSBhbmQgdGhlbiBjYWxsaW5nIHN5
bmNocm9uaXplX2lycSgpLg0KPj4NCj4+IFRoZSBjb25jZXJuIEkgaGFkIGlzIHRoZSBwdWxsdXAo
KSBBUEkgdXBkYXRpbmcgdGhlIGxwb3MsIGFuZCB0aGUgaGFyZGlycQ0KPj4gaGFuZGxlciByZWZl
cmVuY2luZyBpdCB0byB1cGRhdGUgdGhlIGV2dCBidWYgY2FjaGUgYW5kIHdha2luZyB1cCB0aGUN
Cj4+IHRocmVhZGVkIGlycSBoYW5kbGVyLiAoc2luY2Ugd2UgZG9uJ3QgY2xlYXIgdGhlIGV2dC0+
Y291bnQgZXhwbGljaXRseSwNCj4+IGl0IG1heSByZWZlcmVuY2UgZW1wdHkvc3RhbGUgZXZlbnRz
KQ0KDQpJIHNlZSwgdGhlbiB3ZSBzaG91bGQgZG8gYm90aC4NCg0KPj4NCj4+Pj4gIAlzcGluX2xv
Y2tfaXJxc2F2ZSgmZHdjLT5sb2NrLCBmbGFncyk7DQo+Pj4+ICsNCj4+Pj4gKwkvKiBDb250cm9s
bGVyIGlzIG5vdCBoYWx0ZWQgdW50aWwgcGVuZGluZyBldmVudHMgYXJlIGFja25vd2xlZGdlZCAq
Lw0KPj4+PiArCWlmICghaXNfb24pIHsNCj4+Pj4gKwkJdTMyIHJlZzsNCj4+Pj4gKw0KPj4+PiAr
CQlfX2R3YzNfZ2FkZ2V0X2VwX2Rpc2FibGUoZHdjLT5lcHNbMF0pOw0KPj4+PiArCQlfX2R3YzNf
Z2FkZ2V0X2VwX2Rpc2FibGUoZHdjLT5lcHNbMV0pOw0KPj4+IFlvdSBjYW4ganVzdCBkbyBfX2R3
YzNfZ2FkZ2V0X3N0b3AoKSwgYW5kIGRvIHRoYXQgYWZ0ZXINCj4+PiBkd2MzX3N0b3BfYWN0aXZl
X3RyYW5zZmVycygpLg0KPj4+DQo+PiBHb3QgaXQuDQo+Pg0KPiBIaSBUaGluaCwNCj4NCj4gTWF5
YmUgd2UgY2FuIGlnbm9yZSBjYWxsaW5nIGR3YzNfZ2FkZ2V0X2Rpc2FibGVfaXJxKCkgc2VwYXJh
dGVseSBpZiB3ZQ0KPiBhcmUgZ29pbmcgdG8gdXNlIF9fZHdjM19nYWRnZXRfc3RvcCgpLCBzaW5j
ZSBnYWRnZXQgc3RvcCB3aWxsIGNhbGwNCj4gZHdjM19nYWRnZXRfZGlzYWJsZV9pcnEoKS4gIEFs
c28sIGl0IHdvdWxkIGJlIGV4ZWN1dGVkIGJlZm9yZSB0aGUgZXZlbnQNCj4gY291bnQgY2xlYXJp
bmcsIHNvIGlmIHRoZXJlIHdhcyBhbiBldmVudCAodW5saWtlbHkpIHRoYXQgd2FzIGdlbmVyYXRl
ZCwNCj4gd2Ugd291bGQgZGlzY2FyZCBpdC4NCg0KVGhhdCB3YXMgbXkgaW50ZW50aW9uLiBKdXN0
IG1ha2Ugc3VyZSB0byByZS1lbmFibGUgdGhlIGV2ZW50cyBvbiBwdWxsX3VwKG9uKQ0KDQo+DQo+
IFNvbWV0aGluZyBsaWtlOg0KPg0KPiAJZGlzYWJsZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4g
CXNwaW5fbG9ja19pcnFzYXZlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4NCj4gCWlmICghaXNfb24p
IHsNCj4gCQl1MzIgY291bnQ7DQo+DQo+IAkJZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoZHdj
KTsNCj4gCQlfX2R3YzNfZ2FkZ2V0X3N0b3AoZHdjKTsNCj4NCj4gCQljb3VudCA9IGR3YzNfcmVh
ZGwoZHdjLT5yZWdzLCBEV0MzX0dFVk5UQ09VTlQoMCkpOw0KPiAJCWNvdW50ICY9IERXQzNfR0VW
TlRDT1VOVF9NQVNLOw0KPg0KPiBUaGFua3MNCj4gV2VzbGV5DQo+DQo+DQoNClRoYW5rcywNClRo
aW5oDQo=
