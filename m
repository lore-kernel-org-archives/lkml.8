Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECBAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD7C206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KVfQkolV";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="pVnJiqmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbgF2TCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:02:19 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:10069 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730487AbgF2TCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:02:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593457333; x=1624993333;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=k5/mTpV8mqqbD032ShqsXWdbTmkf7e+9W83qiEoYNfg=;
  b=KVfQkolVhoqYMdd/l1T9uYzvpIUgevyisRbeCl/5R5vZMqwy2gXjjdE0
   xUosM++Q1cIGzbTNicKit2KCejTvi1opbQ041oV3yqkhZNMPcW2Kojcx8
   X0vo6zCgi35RhjBIbe0N7neD9fYPlz4xdAtI35hKI4M7dAyYj0FtHRm04
   IDfj5XXDN/jEN9H+FsWkSUMwQ13jZFzGeJyMo5Do1JHmlJHRplEf6H9po
   u6gdZqLDJIo+XV8+L20LL/CZokMcZrVD7ZjM5MS8JD5/OnUFuzToyKFtK
   LFtHlJT2CVlCLgNsvSxdeu38l5dtILW8kUGJ90OSzk0TXl+gWkV8CIKx8
   Q==;
IronPort-SDR: AGKdxt9FV/e6mDEdYSaPGMeZYC4Mc0fMPKUuDcu3yj7s1vOLTmxKUGhsBiAXxGqyB763CX149p
 bk5yfS4N0Ruq9ztdAooSSM+V4rqgpnodFwS/4HL3qDHqgJcH1JaxP2tCBoyeJL3c5tK7S5KgDj
 nxE0vFzebblmw+ruDk2xNmbwS9N7hzUPGevXcMlXBXD16Tnd7EeNjW0T5XZB+ZYTSX+sM0ZxV+
 Zs3kZ4HQx+kR6mwubdF2UOcFH6ilMhxBMU5FpGHIg4nFgC5IdrKWS7kBhEHvwvOk2w6INFTyCI
 +C4=
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="85533574"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2020 12:01:57 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 12:01:54 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Mon, 29 Jun 2020 12:01:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7WVAxEoaaWcVelEQBi68ZNxTa0RSEwO2rTqtbaOCxXtNI5PuC2bBjOrHBuWeghnQZ18dc8yFQ1TKvSGnBlylIPZhE24GmO6uOckQ62LGIuCx/OfmiFDBqf95h0oAXW/mFYJsW7zFkUl+5fG39QiLXX1kpi/cP6C4zX89vkyfU2x7a+YHa67WObI8cT251Sbv2Z8GGvkn0UGmUJVv0SKT/UhgaFzbtzieNFOexTV2V1tCkphfnEkvZwoByExNQaAD35KvGCL+QdFaMlUYx3JyYGedaclCl2JGeRk6svrcv5GiTEKo/kw/uiFFT0gsFwBqh+V+bBN1WsfMJOXrNTy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5/mTpV8mqqbD032ShqsXWdbTmkf7e+9W83qiEoYNfg=;
 b=hs1WVuZJFyjijI+JPH8YNrJJYhjbMU1YA7IATMVGzLvs8hQDpzPGrrz/oH9veNn7tnqrD45IHUfXP2HdCrmRXoYyO8RhEQ8X2syew+q9Gx5ueI7ffF6/U0Gm2gDuFcVOp6Wd73vQJ3PgaQkjERPVahBM6gF6CKoAgVhBNpsBWRLGzmo3hfSC/tsth5DhvjmW7hwSRfWNgcjP7NbSAJmX0F0MCtVLG7e8Jk5UEHTqsp2leQBzrmfIPrZQYuHRwwF6by/Gk0uW5L5eRibgGgZs9yVcYX4YRg6lqh0GPr6tJVDbYqRUUVRAm4Pu4NjSJ+VjFkaDQqn1FpmfaVTsMYgRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5/mTpV8mqqbD032ShqsXWdbTmkf7e+9W83qiEoYNfg=;
 b=pVnJiqmZNmAJB478wPoUEK1KwVJRbNvgsUv9xTJqiYf0+I75cYIgBCv1174J5OqnONVMXQ/LjmCY2cQYT0kR3ecktgSSzniopcs63quQMi8H0kj9xda3Ipi/enqq3Mggyy6Ug5p0CYJR5JR3S3jtRasNZhwymCBmkOSPlKlJ2bk=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BY5PR11MB4054.namprd11.prod.outlook.com (2603:10b6:a03:189::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Mon, 29 Jun
 2020 19:01:51 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 19:01:51 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <thesven73@gmail.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi
 flash
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi
 flash
Thread-Index: AQHWThPSolCxrzN8IU2HXo+YK1EHpg==
Date:   Mon, 29 Jun 2020 19:01:51 +0000
Message-ID: <f3859642-1830-15a9-0773-0a8a2a77dfb6@microchip.com>
References: <20200613235331.24678-1-TheSven73@gmail.com>
 <4b0f2a2d-66be-4cdd-8384-a80f6b729d74@microchip.com>
 <CAGngYiUFh8XexBZK1U2bHcsvHS2LFAXONgLG7HhY7CDQ=LayWg@mail.gmail.com>
In-Reply-To: <CAGngYiUFh8XexBZK1U2bHcsvHS2LFAXONgLG7HhY7CDQ=LayWg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c726b767-114a-482a-23ef-08d81c5ee1e2
x-ms-traffictypediagnostic: BY5PR11MB4054:
x-microsoft-antispam-prvs: <BY5PR11MB4054B09090E316D200F450C9F06E0@BY5PR11MB4054.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HaM3+BnqB0UkWQSlCY8Z4hkPqFEnto01F44t2Q7xTodw40vAhwQTsZ+qpXXpiLsYOwYeXZ0vXHKJE26zBiz4sjXlm5Dbpb7zYitmkaj0sGNYEpApGCjr2IeM2cno1sYje3avC9TsY1NFGqCS/vOVW3/q7kZxRofIhMXkdBdg6lIDO8V0AoRK7ALf5QFpZLtrXuQ2dCWxctgsIJb+WNui8IXIrU5sCY1ZETkGGaiqJ1BSn040IQsLAeVbC4ABgXmrVb/jARJP5lrv9fDbBP2IITxPDy08UVaGzASoCYUaF4wu0rftJu5wPOIpnQv4V0zduK4SBuDzEzneY0EXdY8Bnxpgx0j4kRGdO/dC6tHWYKKvrCskM2qFEB7EDNcuAcsiXwCVtFHDXWTiZ2yDWZTAO8055koZoYrN3tPc4Iw3j6UuHYqif+VeanHdJ1+aacRCF9qJn9bU0c3220+uJhXtHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(478600001)(8676002)(31686004)(6486002)(2616005)(5660300002)(36756003)(186003)(53546011)(966005)(26005)(6506007)(8936002)(316002)(2906002)(66946007)(76116006)(71200400001)(91956017)(31696002)(66556008)(4326008)(66476007)(83380400001)(66446008)(6512007)(86362001)(64756008)(54906003)(6916009)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Th14CAK57r6T4RBUwencSAiyGaDSzUxSvXdpzkZ+h1oZVcXTdafbfsBhR++0urzZIBCB7plScHpoief6tQRRo8YeuxyxBzb6Pi8hoHA/82tmPK1HSjKNtuVDAbIhn/9C9i3fycisjvHUVhLnS55fN+NURE1F1EITsqKoOTiclLMJNxD86FUw2FCxVZgTFjqCpDLgzKVs8s/U8qdLWlfmM+0VgqkGWJPqbZZ6Y3llsGxBuRqvIxAWGy2xqqqpmMRiTULkDx1e5D/B2JSO+9o0AaZkz2Z7f5W7j74nZ7zVF9fsSBXm3maxwLBorEdqCq9LrxpcnTiKV0SDJc+tm7cgGbsNgX1lV1Uj2TL8sV3sMGBYLfTXAsJXQRGbuxsojItj1ae/ZoydEs+J8tR/qkuES+XWxKjz9ToJ+50BOyhSUmQoLagKMIytylkljL0SITMeBLyELTfVgg4CM0XuTwAZY18flG1VBDARQzRF8ZoB+LI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C05CA36435E134D92168DEDBF077CE0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c726b767-114a-482a-23ef-08d81c5ee1e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 19:01:51.4143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTQ9PUnjoPLd2Fl6cC8aldNn7c9DgoblRVOZsEjLzK2sPygyaazzNPEw7lDwUxekYwRSZdlae7dCw4gxQ07iLVZOBb/IvWQ9bSxpvNu8kuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8yOS8yMCA1OjUzIFBNLCBTdmVuIFZhbiBBc2Jyb2VjayB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCj4gDQo+IE9uIE1vbiwg
SnVuIDI5LCAyMDIwIGF0IDg6NTAgQU0gPFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbT4gd3Jv
dGU6DQo+Pg0KPj4gSSdtIHJlYWRpbmcgdGhlIGZvbGxvd2luZyBkYXRhc2hlZXQ6DQo+PiBodHRw
czovL3d3dy53aW5ib25kLmNvbS9yZXNvdXJjZS1maWxlcy93MjVxNjRqdiUyMHJldmolMjAwMzI3
MjAxOCUyMHBsdXMucGRmDQo+Pg0KPj4gdzI1cTY0anZtICgweGVmNzAxNykgY29tZXMgd2l0aCBR
RSBiaXQgc2V0IHRvIGEgMCBzdGF0ZSwgYnV0IGNhbiBiZQ0KPj4gc2V0IHRvIDEsIHNvIFF1YWQg
bW9kZSBjYW4gYmUgc3VwcG9ydGVkLiBXb3VsZCB5b3UgcGxlYXNlIHNldCBTUElfTk9SX0RVQUxf
UkVBRA0KPj4gYW5kIFNQSV9OT1JfUVVBRF9SRUFEIGZsYWdzIGFuZCB0ZXN0IGFuZCBzZWUgaWYg
UXVhZCB3b3Jrcz8gSWYgYWxsIGdvb2QsDQo+PiBwbGVhc2Ugc3BlY2lmeSBpbiB0aGUgY29tbWl0
IG1lc3NhZ2Ugd2l0aCB3aGljaCBjb250cm9sbGVyIHlvdSBkaWQgdGhlIHRlc3RzLg0KPj4NCj4g
DQo+IEdvb2QgcG9pbnQgIQ0KPiANCj4gVW5mb3J0dW5hdGVseSBJJ20gdXNpbmcgdGhlIHNwaSBj
b250cm9sbGVyIG9uIGFuIGlteDYgKCJmc2wsaW14NTEtZWNzcGkiKSB3aGljaA0KPiBkb2VzIG5v
dCBzdXBwb3J0IGR1YWwgb3IgcXVhZCBtb2RlLiBTbyBJIGNhbm5vdCBwb3NzaWJseSB0ZXN0IHRo
aXMgOikNCj4gDQo+IEhvdyB3b3VsZCB5b3UgbGlrZSB0byBwcm9jZWVkPyBTaG91bGQgSSBrZWVw
IHRoaXMgYXMgYSBwcml2YXRlIHBhdGNoLCBhbmQNCj4gd2FpdCB1bnRpbCBzb21lb25lIGNvbWVz
IGFsb25nIHdobyBjYW4gdGVzdCB0aGlzIG9uIG1vcmUgY2FwYWJsZQ0KPiBjb250cm9sbGVyIGgv
dyA/DQo+IA0KPiBPciBzaG91bGQgSSByZS1zcGluIHRoZSBwYXRjaCB3aXRob3V0IHRoZSBmbGFn
cz8NCj4gDQoNClJlLXNwaW4gdGhlIHBhdGNoIHdpdGhvdXQgdGhlIGZsYWdzLiBXZSBjYW4gYWRk
IHRoZW0gbGF0ZXIgb24sIHdoZW4gc29tZW9uZSBjYW4NCnRlc3QgdGhlbS4NCg0KQ2hlZXJzLA0K
dGENCg0K
