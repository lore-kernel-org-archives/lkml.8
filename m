Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD0BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 477DD207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:49:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marvell.com header.i=@marvell.com header.b="ra9B3spO";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="phcI1iZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgFDEth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:49:37 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:35128 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgFDEth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:49:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0544e5Vl023383;
        Wed, 3 Jun 2020 21:49:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=sQJQE/wqPRwvZycQcX5kzWGnHQPAj5uf35xFfvXcBkw=;
 b=ra9B3spOPDctuYcE94G+K9Ec7UpllKDyTERZdd1qlXSNu+0kzsyX2U/QoOZ3DYv0Ck91
 0VpQKW5Qh9UI0n4NLc+jKoLRGQ/IvVspis9Ju1k6i7exAoKfYv1iXF30Xg3RciBH44G7
 mrtp1cOFVXnskPg8gtXsMsIkjDXxOLyYp/OiO8Ai9IBTKs+91snU8gK9iWc+iLEvB/hU
 3YOc0bNnY88TQZ9b/VT5gadDwmcTYuUSJfGoiK03QvgXwcTH9Q8Q+c5N9QKY6L7SO0Wh
 VANTNnqPovFne8po2tVoTJH9VbLRa7uQNEFxoiSA7cb3HmDQHvRPiIOWZBCxLwfIOCmM Yg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 31bmuq305x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 21:49:11 -0700
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 3 Jun
 2020 21:49:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 3 Jun 2020 21:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYxmb03+M+3BAwF2i35mY6ORwH2wOCW+WbqXh8FYlWEmUSP0hp9H7YuGd41N2eHM2MZdOE4OhtuU4KPuw8018/0VQSnvcZQ51r3mOp6BcjuYrdYW3/LdcNZU6IDbSKJHuIq2g5QJBIX/4S7ObcNuwxvtO/GR0TSqE+0/Tbe9ZAGkBIvFVhTjhv5EiHmPdft+0wpc2+zDQkZe2bISTH6GT2AFHT+Bt8VRwpf44P8aJ47zqaXteu8WZCqCs8PvjUtSAJjPwQ67N89NKicTIEe0TNv0TYqgr8oXtIIiFoSgAAoILawpSsY1ohoqIx4md/qX8VjVoinWEaSBtJ8UIkXoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQJQE/wqPRwvZycQcX5kzWGnHQPAj5uf35xFfvXcBkw=;
 b=Z/yBMIT1XedCiFoN1RFXNXezwb7yR5ouG6cpglq3NjeS1XUTKLe3Ne/Wgv8qQ42/C9jE+k//kNuHLRwgJ8qOBLSo0IbrRUl+Mm+SrI43aBS6NN0n5TqOLP9djb0RCxFFSMjfu7Xg7CXeZ9A1hqJC9X96DC5Q3r3bcaqp2EdflErBHrC/f4Ffa1QzTmgtCp/Hjd7RzUmucjcnEf9YSjElHh87jxp4y7yZsYavViOineYJp9EDYnAV1ROcS3Ek2e/zO6160zUIWpf5fWKfYB8WjuvwZHrWwgTgKjVZ/q7Iiv/gSaz0xjISayD+NS93sRPvoFdcc+hmksT7qXnhEFJY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQJQE/wqPRwvZycQcX5kzWGnHQPAj5uf35xFfvXcBkw=;
 b=phcI1iZdm+iXBI8GsKLH0YHcgtytikAucCrOEYIjjJHoTbvriBGNXtQSMSufjTGuh0CdretKfSHNCQxzSxi2iMlDpZ6r+SxrHwlcCpeF9G2aCIcssOQlEWhxFbyGGpiI4wJciB7mCsajZhXXZD/28549W9Ll2UQRCy/yu5uwsis=
Received: from DM6PR18MB2425.namprd18.prod.outlook.com (2603:10b6:5:180::19)
 by DM6PR18MB2508.namprd18.prod.outlook.com (2603:10b6:5:15c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.25; Thu, 4 Jun
 2020 04:49:07 +0000
Received: from DM6PR18MB2425.namprd18.prod.outlook.com
 ([fe80::9da1:54e3:fdf6:e746]) by DM6PR18MB2425.namprd18.prod.outlook.com
 ([fe80::9da1:54e3:fdf6:e746%6]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 04:49:07 +0000
From:   Kamlakant Patel <kamlakantp@marvell.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        "bhupesh.linux@gmail.com" <bhupesh.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>
Subject: RE: [EXT] Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ in
 vmcoreinfo
Thread-Topic: [EXT] Re: [PATCH v6 2/2] arm64/crash_core: Export TCR_EL1.T1SZ
 in vmcoreinfo
Thread-Index: AQHWK50dN2j16dwzSEeEnQAXi/17t6jG1pOAgACfFwCAAIgT8A==
Date:   Thu, 4 Jun 2020 04:49:07 +0000
Message-ID: <DM6PR18MB24256DBD136BB053245AF8CED2890@DM6PR18MB2425.namprd18.prod.outlook.com>
References: <1589395957-24628-1-git-send-email-bhsharma@redhat.com>
 <1589395957-24628-3-git-send-email-bhsharma@redhat.com>
 <DM6PR18MB24258C2F2B91E4BF407421CDD2880@DM6PR18MB2425.namprd18.prod.outlook.com>
 <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
In-Reply-To: <CACi5LpOyQ+MAg9rh=cgLprBGTZ3kvtVP1ShNKG-2AV1Tu14EgQ@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [157.45.168.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ab61019-6e84-477c-087b-08d808429da5
x-ms-traffictypediagnostic: DM6PR18MB2508:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB2508101195171B448E269C4ED2890@DM6PR18MB2508.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N16gN1eNLUR2BV7cse5V7ce5eiVVeZHIG9ThzbWtjnBZEFIGucWZGKM4FBHOJz9hzkLxBBQ36lLNYNZRFsoBNCQ0rI4gg0BAnXUn9zL1GuRT7aj4t6pq8EaQ2UrqhBWVcccm/FKReLK4zg6S/F51TOQAd8ovMD0M3gKLhnqNiTJNqoO5RWI5Xy1ACTLC/zkyOXCHLefpcrXUXpOMPCEpmgxiAPQoqRf3GIvISvJovBXW1kH1H/icLLnQoBBmhZEufct9kNtprtY5tdU+yvRucRO7nT4S4BVU/q0DhNhjfEYXUbdbE4G6kPxETo7qvsOFazmGpVAnR3poC9Zx3Rij8lE1cSkQIBkhs0e1iLNVzMuqM7IHY/SBAda7Bd3W6ems5O2F5wUr6kKpVPwb6ueovw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2425.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(52536014)(107886003)(54906003)(76116006)(478600001)(6506007)(33656002)(316002)(26005)(966005)(7416002)(7696005)(186003)(53546011)(6916009)(2906002)(19627235002)(66476007)(8936002)(83380400001)(66946007)(4326008)(64756008)(66556008)(8676002)(71200400001)(66446008)(9686003)(55016002)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nJnW2j698Um0dZ2WJYVYcykgdwixO5zpy7k/A8RbgaG5RlOxxSE4Wis3A+jxDCuEjaAAojWX5Nr77S4D5rBQLILFgyO8hLD3O+mnTiAfMFmJb8+AP6i5ktmuxBfDN8pDmCntkb6RcsBY4mwAL7buSIotONP0mfGbdsM89KPH+I3RDhh91c2nFKfGWefaeE3hhIDesdUnOmg1dlESm1TZ1j5o+33363bVFUuy1w0A3dYnUts68B2xMkqxkG6TvWw0jGn0K7+n0cQXXGXK59Euqr3+3gzjDknWnr/jZpr+2M9mF6wPEGaLqdcjI2vkC/4jcwcXkvEQLkZi5X7J+EqTO280VcCJrMPIFKWKoWDnu4EJbw5xUWKYwH9pSLbxL/qkszgnDuaWB0nBJO6T45LwQFi5jtfugBo3y8MnB9TzfPJ2e6Kq2hxC03WHhydhQ/nq5caz/7j+GkxreLO5le1Ph1J5sjuNWdOzd0tKMtMwH3Y=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ab61019-6e84-477c-087b-08d808429da5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 04:49:07.7218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 64P8euEc37cas4q+JIShN52hIC3cJ6NUMpFlTSDxZDA56EaS20govTpv5c0wAuL+gprGLbruWcma1ruUILX4+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2508
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-04_01:2020-06-02,2020-06-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmh1cGVzaCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCaHVw
ZXNoIFNoYXJtYSA8YmhzaGFybWFAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUg
NCwgMjAyMCAyOjA1IEFNDQo+IFRvOiBLYW1sYWthbnQgUGF0ZWwgPGthbWxha2FudHBAbWFydmVs
bC5jb20+DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IHg4NkBr
ZXJuZWwub3JnOyBNYXJrIFJ1dGxhbmQNCj4gPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgS2F6dWhp
dG8gSGFnaW8gPGstaGFnaW9AYWIuanAubmVjLmNvbT47IFN0ZXZlDQo+IENhcHBlciA8c3RldmUu
Y2FwcGVyQGFybS5jb20+OyBDYXRhbGluIE1hcmluYXMNCj4gPGNhdGFsaW4ubWFyaW5hc0Bhcm0u
Y29tPjsgQXJkIEJpZXNoZXV2ZWwgPGFyZC5iaWVzaGV1dmVsQGxpbmFyby5vcmc+Ow0KPiBrZXhl
Y0BsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKYW1l
cyBNb3JzZQ0KPiA8amFtZXMubW9yc2VAYXJtLmNvbT47IERhdmUgQW5kZXJzb24gPGFuZGVyc29u
QHJlZGhhdC5jb20+Ow0KPiBiaHVwZXNoLmxpbnV4QGdtYWlsLmNvbTsgV2lsbCBEZWFjb24gPHdp
bGxAa2VybmVsLm9yZz47IEdhbmFwYXRyYW8gS3Vsa2FybmkNCj4gPGdrdWxrYXJuaUBtYXJ2ZWxs
LmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2NiAyLzJdIGFybTY0L2NyYXNoX2Nv
cmU6IEV4cG9ydCBUQ1JfRUwxLlQxU1ogaW4NCj4gdm1jb3JlaW5mbw0KPiANCj4gRXh0ZXJuYWwg
RW1haWwNCj4gDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gSGkgS2FtbGFrYW50LA0KPiANCj4gTWFueSB0
aGFua3MgZm9yIGhhdmluZyBhIGxvb2sgYXQgdGhlIHBhdGNoc2V0Lg0KPiANCj4gT24gV2VkLCBK
dW4gMywgMjAyMCBhdCA0OjUwIFBNIEthbWxha2FudCBQYXRlbCA8a2FtbGFrYW50cEBtYXJ2ZWxs
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBIaSBCaHVwZXNoLA0KPiA+DQo+ID4gPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbToga2V4ZWMgPGtleGVjLWJvdW5jZXNAbGlz
dHMuaW5mcmFkZWFkLm9yZz4gT24gQmVoYWxmIE9mIEJodXBlc2gNCj4gPiA+IFNoYXJtYQ0KPiA+
ID4gU2VudDogVGh1cnNkYXksIE1heSAxNCwgMjAyMCAxMjoyMyBBTQ0KPiA+ID4gVG86IGxpbnV4
LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgeDg2QGtlcm5lbC5vcmcNCj4gPiA+IENj
OiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsgS2F6dWhpdG8gSGFnaW8gPGst
DQo+ID4gPiBoYWdpb0BhYi5qcC5uZWMuY29tPjsgU3RldmUgQ2FwcGVyIDxzdGV2ZS5jYXBwZXJA
YXJtLmNvbT47IENhdGFsaW4NCj4gPiA+IE1hcmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
PjsgYmhzaGFybWFAcmVkaGF0LmNvbTsgQXJkDQo+ID4gPiBCaWVzaGV1dmVsIDxhcmQuYmllc2hl
dXZlbEBsaW5hcm8ub3JnPjsga2V4ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGxpbnV4
LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBKYW1lcyBNb3JzZSA8amFtZXMubW9yc2VAYXJtLmNv
bT47DQo+ID4gPiBEYXZlIEFuZGVyc29uIDxhbmRlcnNvbkByZWRoYXQuY29tPjsgYmh1cGVzaC5s
aW51eEBnbWFpbC5jb207IFdpbGwNCj4gPiA+IERlYWNvbiA8d2lsbEBrZXJuZWwub3JnPg0KPiA+
ID4gU3ViamVjdDogW1BBVENIIHY2IDIvMl0gYXJtNjQvY3Jhc2hfY29yZTogRXhwb3J0IFRDUl9F
TDEuVDFTWiBpbg0KPiA+ID4gdm1jb3JlaW5mbw0KPiA+ID4NCj4gPiA+IHZhYml0c19hY3R1YWwg
dmFyaWFibGUgb24gYXJtNjQgaW5kaWNhdGVzIHRoZSBhY3R1YWwgVkEgc3BhY2Ugc2l6ZSwNCj4g
PiA+IGFuZCBhbGxvd3MgYSBzaW5nbGUgYmluYXJ5IHRvIHN1cHBvcnQgYm90aCA0OC1iaXQgYW5k
IDUyLWJpdCBWQSBzcGFjZXMuDQo+ID4gPg0KPiA+ID4gSWYgdGhlIEFSTXY4LjItTFZBIG9wdGlv
bmFsIGZlYXR1cmUgaXMgcHJlc2VudCwgYW5kIHdlIGFyZSBydW5uaW5nDQo+ID4gPiB3aXRoIGEg
NjRLQiBwYWdlIHNpemU7IHRoZW4gaXQgaXMgcG9zc2libGUgdG8gdXNlIDUyLWJpdHMgb2YgYWRk
cmVzcw0KPiA+ID4gc3BhY2UgZm9yIGJvdGggdXNlcnNwYWNlIGFuZCBrZXJuZWwgYWRkcmVzc2Vz
LiBIb3dldmVyLCBhbnkga2VybmVsDQo+ID4gPiBiaW5hcnkgdGhhdCBzdXBwb3J0cyA1Mi1iaXQg
bXVzdCBhbHNvIGJlIGFibGUgdG8gZmFsbCBiYWNrIHRvIDQ4LWJpdA0KPiA+ID4gYXQgZWFybHkg
Ym9vdCB0aW1lIGlmIHRoZSBoYXJkd2FyZSBmZWF0dXJlIGlzIG5vdCBwcmVzZW50Lg0KPiA+ID4N
Cj4gPiA+IFNpbmNlIFRDUl9FTDEuVDFTWiBpbmRpY2F0ZXMgdGhlIHNpemUgb2Zmc2V0IG9mIHRo
ZSBtZW1vcnkgcmVnaW9uDQo+ID4gPiBhZGRyZXNzZWQgYnkNCj4gPiA+IFRUQlIxX0VMMSAoYW5k
IGhlbmNlIGNhbiBiZSB1c2VkIGZvciBkZXRlcm1pbmluZyB0aGUgdmFiaXRzX2FjdHVhbA0KPiA+
ID4gdmFsdWUpIGl0IG1ha2VzIG1vcmUgc2Vuc2UgdG8gZXhwb3J0IHRoZSBzYW1lIGluIHZtY29y
ZWluZm8gcmF0aGVyDQo+ID4gPiB0aGFuIHZhYml0c19hY3R1YWwgdmFyaWFibGUsIGFzIHRoZSBu
YW1lIG9mIHRoZSB2YXJpYWJsZSBjYW4gY2hhbmdlDQo+ID4gPiBpbiBmdXR1cmUga2VybmVsIHZl
cnNpb25zLCBidXQgdGhlIGFyY2hpdGVjdHVyYWwgY29uc3RydWN0cyBsaWtlDQo+ID4gPiBUQ1Jf
RUwxLlQxU1ogY2FuIGJlIHVzZWQgYmV0dGVyIHRvIGluZGljYXRlIGludGVuZGVkIHNwZWNpZmlj
IGZpZWxkcyB0byB1c2VyLQ0KPiBzcGFjZS4NCj4gPiA+DQo+ID4gPiBVc2VyLXNwYWNlIHV0aWxp
dGllcyBsaWtlIG1ha2VkdW1wZmlsZSBhbmQgY3Jhc2gtdXRpbGl0eSwgbmVlZCB0bw0KPiA+ID4g
cmVhZCB0aGlzIHZhbHVlIGZyb20gdm1jb3JlaW5mbyBmb3IgZGV0ZXJtaW5pbmcgaWYgYSB2aXJ0
dWFsIGFkZHJlc3MgbGllcyBpbiB0aGUNCj4gbGluZWFyIG1hcCByYW5nZS4NCj4gPiA+DQo+ID4g
PiBXaGlsZSBhdCBpdCBhbHNvIGFkZCBkb2N1bWVudGF0aW9uIGZvciBUQ1JfRUwxLlQxU1ogdmFy
aWFibGUgYmVpbmcNCj4gPiA+IGFkZGVkIHRvIHZtY29yZWluZm8uDQo+ID4gPg0KPiA+ID4gSXQg
aW5kaWNhdGVzIHRoZSBzaXplIG9mZnNldCBvZiB0aGUgbWVtb3J5IHJlZ2lvbiBhZGRyZXNzZWQg
YnkNCj4gPiA+IFRUQlIxX0VMMQ0KPiA+ID4NCj4gPiA+IENjOiBKYW1lcyBNb3JzZSA8amFtZXMu
bW9yc2VAYXJtLmNvbT4NCj4gPiA+IENjOiBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0u
Y29tPg0KPiA+ID4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+ID4gPiBDYzog
U3RldmUgQ2FwcGVyIDxzdGV2ZS5jYXBwZXJAYXJtLmNvbT4NCj4gPiA+IENjOiBDYXRhbGluIE1h
cmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPg0KPiA+ID4gQ2M6IEFyZCBCaWVzaGV1dmVs
IDxhcmQuYmllc2hldXZlbEBsaW5hcm8ub3JnPg0KPiA+ID4gQ2M6IERhdmUgQW5kZXJzb24gPGFu
ZGVyc29uQHJlZGhhdC5jb20+DQo+ID4gPiBDYzogS2F6dWhpdG8gSGFnaW8gPGstaGFnaW9AYWIu
anAubmVjLmNvbT4NCj4gPiA+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmcNCj4gPiA+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBDYzoga2V4
ZWNAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiA+ID4gVGVzdGVkLWJ5OiBKb2huIERvbm5lbGx5IDxq
b2huLnAuZG9ubmVsbHlAb3JhY2xlLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEJodXBlc2gg
U2hhcm1hIDxiaHNoYXJtYUByZWRoYXQuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNvcmVpbmZvLnJzdCB8IDExICsrKysrKysrKysrDQo+
ID4gPiAgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLWh3ZGVmLmggICAgICAgICB8ICAx
ICsNCj4gPiA+ICBhcmNoL2FybTY0L2tlcm5lbC9jcmFzaF9jb3JlLmMgICAgICAgICAgICAgICAg
IHwgMTAgKysrKysrKysrKw0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygr
KQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tk
dW1wL3ZtY29yZWluZm8ucnN0DQo+ID4gPiBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2R1
bXAvdm1jb3JlaW5mby5yc3QNCj4gPiA+IGluZGV4IDJhNjMyMDIwZjgwOS4uMmJhYWQwYmZiMDlk
IDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92bWNv
cmVpbmZvLnJzdA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZHVtcC92
bWNvcmVpbmZvLnJzdA0KPiA+ID4gQEAgLTQwNCw2ICs0MDQsMTcgQEAgS0VSTkVMUEFDTUFTSw0K
PiA+ID4gIFRoZSBtYXNrIHRvIGV4dHJhY3QgdGhlIFBvaW50ZXIgQXV0aGVudGljYXRpb24gQ29k
ZSBmcm9tIGEga2VybmVsDQo+ID4gPiB2aXJ0dWFsIGFkZHJlc3MuDQo+ID4gPg0KPiA+ID4gK1RD
Ul9FTDEuVDFTWg0KPiA+ID4gKy0tLS0tLS0tLS0tLQ0KPiA+ID4gKw0KPiA+ID4gK0luZGljYXRl
cyB0aGUgc2l6ZSBvZmZzZXQgb2YgdGhlIG1lbW9yeSByZWdpb24gYWRkcmVzc2VkIGJ5IFRUQlIx
X0VMMS4NCj4gPiA+ICtUaGUgcmVnaW9uIHNpemUgaXMgMl4oNjQtVDFTWikgYnl0ZXMuDQo+ID4g
PiArDQo+ID4gPiArVFRCUjFfRUwxIGlzIHRoZSB0YWJsZSBiYXNlIGFkZHJlc3MgcmVnaXN0ZXIg
c3BlY2lmaWVkIGJ5IEFSTXY4LUENCj4gPiA+ICthcmNoaXRlY3R1cmUgd2hpY2ggaXMgdXNlZCB0
byBsb29rdXAgdGhlIHBhZ2UtdGFibGVzIGZvciB0aGUNCj4gPiA+ICtWaXJ0dWFsIGFkZHJlc3Nl
cyBpbiB0aGUgaGlnaGVyIFZBIHJhbmdlIChyZWZlciB0byBBUk12OCBBUk0NCj4gPiA+ICtkb2N1
bWVudCBmb3IgbW9yZSBkZXRhaWxzKS4NCj4gPiA+ICsNCj4gPiA+ICBhcm0NCj4gPiA+ICA9PT0N
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxl
LWh3ZGVmLmgNCj4gPiA+IGIvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLWh3ZGVmLmgN
Cj4gPiA+IGluZGV4IDZiZjVlNjUwZGE3OC4uYTE4NjFhZjk3YWM5IDEwMDY0NA0KPiA+ID4gLS0t
IGEvYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9wZ3RhYmxlLWh3ZGVmLmgNCj4gPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvaW5jbHVkZS9hc20vcGd0YWJsZS1od2RlZi5oDQo+ID4gPiBAQCAtMjE2LDYgKzIx
Niw3IEBADQo+ID4gPiAgI2RlZmluZSBUQ1JfVHhTWih4KSAgICAgICAgICAoVENSX1QwU1ooeCkg
fCBUQ1JfVDFTWih4KSkNCj4gPiA+ICAjZGVmaW5lIFRDUl9UeFNaX1dJRFRIICAgICAgICAgICAg
ICAgNg0KPiA+ID4gICNkZWZpbmUgVENSX1QwU1pfTUFTSyAgICAgICAgICAgICAgICAoKChVTCgx
KSA8PCBUQ1JfVHhTWl9XSURUSCkgLSAxKSA8PA0KPiA+ID4gVENSX1QwU1pfT0ZGU0VUKQ0KPiA+
ID4gKyNkZWZpbmUgVENSX1QxU1pfTUFTSyAgICAgICAgICAgICAgICAoKChVTCgxKSA8PCBUQ1Jf
VHhTWl9XSURUSCkgLSAxKSA8PA0KPiA+ID4gVENSX1QxU1pfT0ZGU0VUKQ0KPiA+ID4NCj4gPiA+
ICAjZGVmaW5lIFRDUl9FUEQwX1NISUZUICAgICAgICAgICAgICAgNw0KPiA+ID4gICNkZWZpbmUg
VENSX0VQRDBfTUFTSyAgICAgICAgICAgICAgICAoVUwoMSkgPDwgVENSX0VQRDBfU0hJRlQpDQo+
ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwvY3Jhc2hfY29yZS5jDQo+ID4gPiBi
L2FyY2gvYXJtNjQva2VybmVsL2NyYXNoX2NvcmUuYyBpbmRleCAxZjY0NmIwN2UzZTkuLjMxNDM5
MWExNTZlZQ0KPiA+ID4gMTAwNjQ0DQo+ID4gPiAtLS0gYS9hcmNoL2FybTY0L2tlcm5lbC9jcmFz
aF9jb3JlLmMNCj4gPiA+ICsrKyBiL2FyY2gvYXJtNjQva2VybmVsL2NyYXNoX2NvcmUuYw0KPiA+
ID4gQEAgLTcsNiArNywxNCBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9jcmFzaF9jb3JlLmg+
DQo+ID4gPiAgI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+ID4gPiAgI2luY2x1ZGUgPGFz
bS9tZW1vcnkuaD4NCj4gPiA+ICsjaW5jbHVkZSA8YXNtL3BndGFibGUtaHdkZWYuaD4NCj4gPiA+
ICsNCj4gPiA+ICtzdGF0aWMgaW5saW5lIHU2NCBnZXRfdGNyX2VsMV90MXN6KHZvaWQpOw0KPiA+
ID4gKw0KPiA+ID4gK3N0YXRpYyBpbmxpbmUgdTY0IGdldF90Y3JfZWwxX3Qxc3oodm9pZCkgew0K
PiA+ID4gKyAgICAgcmV0dXJuIChyZWFkX3N5c3JlZyh0Y3JfZWwxKSAmIFRDUl9UMVNaX01BU0sp
ID4+DQo+ID4gPiArVENSX1QxU1pfT0ZGU0VUOyB9DQo+ID4gPg0KPiA+ID4gIHZvaWQgYXJjaF9j
cmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkgIHsgQEAgLTE2LDYgKzI0LDggQEAgdm9pZA0KPiA+
ID4gYXJjaF9jcmFzaF9zYXZlX3ZtY29yZWluZm8odm9pZCkNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBraW1hZ2Vfdm9mZnNldCk7DQo+ID4gPiAg
ICAgICB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihQSFlTX09GRlNFVCk9MHglbGx4XG4i
LA0KPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBI
WVNfT0ZGU0VUKTsNCj4gPiA+ICsgICAgIHZtY29yZWluZm9fYXBwZW5kX3N0cigiTlVNQkVSKFRD
Ul9FTDFfVDFTWik9MHglbGx4XG4iLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGdldF90Y3JfZWwxX3Qxc3ooKSk7DQo+ID4gSSB0ZXN0ZWQgdGhp
cyBwYXRjaCBvbiB0b3Agb2YgdXBzdHJlYW0ga2VybmVsIHY1LjcgYW5kIEkgYW0gZ2V0dGluZyAi
Y3Jhc2g6DQo+IGNhbm5vdCBkZXRlcm1pbmUgVkFfQklUU19BQ1RVQUwiIGVycm9yIHdpdGggY3Jh
c2ggdG9vbC4NCj4gPiBJIGxvb2tlZCBpbnRvIGNyYXNoLXV0aWxpdHkgc291cmNlIGFuZCBpdCBp
cyBleHBlY3RpbmcgdGNyX2VsMV90MXN6IG5vdA0KPiBUQ1JfRUwxX1QxU1ouDQo+ID4gQ291bGQg
eW91IHBsZWFzZSBjaGVjay4NCj4gDQo+IEluZGVlZC4gQXMgcGVyIEphbWVzIGNvbW1lbnRzIG9u
IHRoZSB2NSAoc2VlIFsxXSkgd2hlcmUgaGUgc3VnZ2VzdGVkDQo+IGNvbnZlcnRpbmcgdHRjcl9l
bDFfdDFzeiBpbnRvIFRDUl9FTDFfVDFTWiwgSSBtYWRlIHRoZSBjaGFuZ2UgaW4gdjYNCj4gYWNj
b3JkaW5nbHkuDQo+IA0KPiBUaGlzIHRpbWUgSSBoYXZlbid0IHNlbnQgb3V0IHRoZSB2NiB1c2Vy
c3BhY2UgY2hhbmdlcw0KPiAobWFrZWR1bXBmaWxlL2NyYXNoLXV0aWxpdHkpIHVwc3RyZWFtIGZp
cnN0LCBzaW5jZSB3ZSBhcmUgd2FpdGluZyBmb3Iga2VybmVsDQo+IGNoYW5nZXMgdG8gYmUgYWNj
ZXB0ZWQgZmlyc3QsIGFzIHdlIGhhdmUgc2VlbiBpbiB0aGUgcGFzdCB0aGF0IHdoaWxlIHRoZQ0K
PiB1c2Vyc3BhY2UgcGF0Y2hlcyBoYXZlIGJlZW4gYWNjZXB0ZWQsIHRoZSBrZXJuZWwgcGF0Y2hl
cyByZXF1aXJlZCBhIHJlc3Bpbg0KPiBjeWNsZSwgdGh1cyBsZWFkaW5nIHRvIGluY29uc2lzdGVu
Y2llcywgYXMgeW91IGFsc28gcG9pbnRlZCBvdXQgd2l0aCBjcmFzaC11dGlsaXR5Lg0KPiANCj4g
SWYgeW91IHdhbnQsIGZvciB5b3VyIGxvY2FsIHRlc3RpbmcsIEkgY2FuIHNoYXJlIG15IGdpdGh1
YiBicmFuY2ggd2hlcmUgSSBoYXZlDQo+IGtlcHQgdGhlIGNyYXNoLXV0aWxpdHkgdjYgcGF0Y2hz
ZXQgcmVhZHkuIFBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IFsxXS4gaHR0cHM6Ly91cmxkZWZl
bnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fbG9yZS5rZXJuZWwub3Jn
X2xpbnV4cHBjLTJEZGV2XzYzZDZlNjNjLTJENzIxOC0yRGQyZGQtMkQ4NzY3LQ0KPiAyRDQ0NjRi
ZTgzNjAzZi0NCj4gNDBhcm0uY29tXyZkPUR3SUJhUSZjPW5LaldlYzJiNlIwbU95UGF6N3h0ZlEm
cj1YZWNRWlFKV2hHNi0NCj4gbU44c1d4ZmZGT2dVWGc0aXJHUDNTanV5NlJ4ZGFjUSZtPWlqUjh2
RWFmR19RR1RLWVgyb0ktDQo+IFN2ZkZzWTRwUG91NnR2dHJueFJvbG9vJnM9ekptbzNxYm0yWGZu
S2JyVXFKUE5ONW82UEpxRVI5T3psdHdnUzRhVGENCj4gLWsmZT0NClRoYW5rcyBmb3IgY2xhcmlm
eWluZy4NCkkgbWFkZSB1c2Vyc3BhY2UgY2hhbmdlcyBhY2NvcmRpbmdseSBhbmQgdGVzdGVkIGFu
ZCBpdCB3b3JrcyBmaW5lLiBXZSB3aWxsIGJlIHdhaXQgZm9yIHlvdXIgdXNlcnNwYWNlIHBhdGNo
Lg0KDQpUZXN0ZWQtYnk6IEthbWxha2FudCBQYXRlbCA8a2FtbGFrYW50cEBtYXJ2ZWxsLmNvbT4N
Cg0KVGhhbmtzLA0KS2FtbGFrYW50IFBhdGVsDQo+IA0KPiBUaGFua3MsDQo+IEJodXBlc2gNCj4g
DQo+IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IEthbWxha2FudCBQYXRlbA0KPiA+ID4gICAgICAg
dm1jb3JlaW5mb19hcHBlbmRfc3RyKCJLRVJORUxPRkZTRVQ9JWx4XG4iLCBrYXNscl9vZmZzZXQo
KSk7DQo+ID4gPiAgICAgICB2bWNvcmVpbmZvX2FwcGVuZF9zdHIoIk5VTUJFUihLRVJORUxQQUNN
QVNLKT0weCVsbHhcbiIsDQo+ID4gPg0KPiA+ID4gICAgICAgc3lzdGVtX3N1cHBvcnRzX2FkZHJl
c3NfYXV0aCgpID8NCj4gPiA+IC0tDQo+ID4gPiAyLjcuNA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+ID4ga2V4
ZWMgbWFpbGluZyBsaXN0DQo+ID4gPiBrZXhlY0BsaXN0cy5pbmZyYWRlYWQub3JnDQo+ID4gPiBo
dHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cC0NCj4gPiA+IDNB
X19saXN0cy5pbmZyYWRlYWQub3JnX21haWxtYW5fbGlzdGluZm9fa2V4ZWMmZD1Ed0lDQWcmYz1u
S2pXZWMyYjZSDQo+ID4gPiAwbQ0KPiA+ID4gT3lQYXo3eHRmUSZyPVhlY1FaUUpXaEc2LQ0KPiA+
ID4NCj4gbU44c1d4ZmZGT2dVWGc0aXJHUDNTanV5NlJ4ZGFjUSZtPW9lTGRJVmFXU2NpbWRmRWM0
ZE5oUkkwdFQyNElnekcNCj4gPiA+IDdMa3BBRTVQMTFKUSZzPUxMakhwejM0OUR1RHRPUlg0eHl3
Q3h6YkdVT2Fnb3E0Slhvc1N0eWNxSTQmZT0NCj4gPg0KDQo=
