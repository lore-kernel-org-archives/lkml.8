Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED11C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EFD20714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dUKNDDVq";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kQINBcfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgGWQdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:33:45 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:51464 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729861AbgGWQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595522023; x=1627058023;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=5qB7qgIcehbKkap0TnVcUbFE2hTteprM0BudQxmA210=;
  b=dUKNDDVqNUNoNr1pdo+w34iU9x5b3K8VNbrl60b6+Cx7UzkLlCrA92yy
   Qf/d6zU2+C88bpOT0UrHYakJNcjMk+3c+LoB1qnTpnnFnN2896ULi+kRM
   8epFacPZupTuLinfroAOkHbnBobguZ//1NPretVQxI80zgxBwD94QXL4D
   /X+6coIuXUKn4tDXuI8YVbDlrsWTGquMjfQvJe37C6w5xKhLKd/3VQNsx
   GhfEmCFhXF96O9jYnnV57TOMeA5QQocE4iMfQvR683NQBx07bSDQ8tSMS
   KN8W02igVni0XU+w/4smIz6SqTzZlOaUFawjUuYU5u8Uuoq56LME/4BPs
   g==;
IronPort-SDR: i9sxXX6/ynzYPzkYONUKfYlAJtKjfYOXMe/li4oKS8ZwTM9Y+/LSR3a8zO3sx7ynhoPQIvdo7r
 b3H/3H2FXsHGHg1gM8ULwYvJi65FKgMv+i33n0NSEqNWQW4BPb5Kqehd9mxSKloaZgJScdKd9s
 ZoOjWLKhdoOt+1fdW9G439CE1sQizFUxbe6oF/vFtNElija2wSED1UPoHyWFAgG3SydpGfTJp6
 7LvVluJlnBzgP0LOjy6P3fNsvDfYnFmFOIoc+ghtU8N7xIQh1mK3Gr1Csym1IEyefznlUMmX/p
 oTY=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83022006"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 09:33:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 09:32:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 09:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffTdyrLCLu5zkWDFmmUFED89cRhhEaCJXYR/HS0ZLfCPSVYD+mVJa04fS3QM5EbFQKkBc9pvhNh/oNfUu29/BfXUsqhVioOnQQpN1PSVkKDhwwvquJ12le2G2b1voc7lXFt4YMRcO/JbjZVv3C9BMWz/J5dybaQK75F4no0Ryc11xnhyiTwM/GypJEt6OlOdLuiZZ50UwieeQOlyJLltKZrw0QWidXQ26M5ScHrBJ8qzQENdwN7ZLq5oWUafQqhTAMSWzeIqhB+zbYTwP96YNgjz1DCvkoOP7p+tRAEp/5GgH5Im5G4J5o/W5yGMNvmjNVSenhwW0GLGwmmfL4eutQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qB7qgIcehbKkap0TnVcUbFE2hTteprM0BudQxmA210=;
 b=g+MJ6+xrJpvGPymK3fTv8QplK1HayUZDpweWXw0s3sXL0ZTRW13jtYMOBQWp6tO/qx3PJRIkQVbWPhMWjQBYSWUKYdzpQ+trRa0T2lx1IGbMJtnp0pdxEoez6fyw41mxRrvgbEgk3nvlxOI0YHk3910hV1yU+UMSEpRU4BvJ8+t+jlXJ/ihqXjV/q2hqXu+6xklJGPqsD4sirPmM5v4Njz6iBQB6lIAKL065N+WV/ONXBYbmZjjkFlL84guWQFkVcNgT1ao+I0c7awUxb7e2ifMbuctopyTYQNO8BvgGUPSbJdaUoipy0PELOuE9NK1gE+5+22+msC2HRWrukR9ZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qB7qgIcehbKkap0TnVcUbFE2hTteprM0BudQxmA210=;
 b=kQINBcfX0cLwqNA1cjz0tXhJqJi0Vh5qY3nOk7XEoMhJG4uloN+fh+/RSeAboH2emwYxc6wiO7315lS79c56iJetQmyj2Vw6IL8L3gNrG6cyRL+OqOZQeUkaWJx8OSgLbXZdGZIDc6wv/cr8h+7QZhXCSRQSbN0Cn0mLL8KS/lg=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (2603:10b6:5:6b::19) by
 DM6PR11MB2569.namprd11.prod.outlook.com (2603:10b6:5:c6::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.24; Thu, 23 Jul 2020 16:33:22 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::4462:2b61:e6e8:3f47]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::4462:2b61:e6e8:3f47%5]) with mapi id 15.20.3195.024; Thu, 23 Jul 2020
 16:33:22 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/6] usb: gadget: udc: atmel: use
 of_find_matching_node_and_match
Thread-Topic: [PATCH v3 1/6] usb: gadget: udc: atmel: use
 of_find_matching_node_and_match
Thread-Index: AQHWYC7dxQxbsiH1GkaOtTfXPffBvakTrJuAgAGvvICAAAFDAA==
Date:   Thu, 23 Jul 2020 16:33:22 +0000
Message-ID: <01dedbb6-e5ec-326d-134d-179f13865e83@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
 <20200722134421.190741-2-cristian.birsan@microchip.com>
 <9cf8e546-09ce-d902-6dca-e2490fd8c4ae@microchip.com>
 <b9c051ce-fba2-297e-e6ec-63acfcc47afc@microchip.com>
In-Reply-To: <b9c051ce-fba2-297e-e6ec-63acfcc47afc@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [2a02:2f01:510e:d000:5cb3:5af8:3f67:57fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7798823b-3096-4ecb-4dfa-08d82f261d74
x-ms-traffictypediagnostic: DM6PR11MB2569:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB25690BB1A6648E2DEAD918EFEF760@DM6PR11MB2569.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ujK5JWpAgrhalL7LxtJ6oy8UbfoNHaxxr8C7GcGPvbw+NOdA639HQncT6fcjnmVYtPLwzoqGZA0tKFFMq9FifNTml9selZY5r1YhWI5IPJdB9C5IHyphoR4y1nByYYY5KxUVPltQB71t0EGHV9RytsjxPT8MKddwSFVMwAGc9oP4nZs7PN05vNqqZzyC/xRIzv8St32vOIK/bAwpITz/WUBbgHYdvhMaCe+I8YEpFDRSO86adRwVBeJsFXGQ0vPESoexddQbi9xS2O8tbkaFmHKuutZnVZs/BhpjD/tf2SGxeWx0necOmCXGFK2i7BdaQgdSlEBoS9bAs1lii2VxfU9qHON+Mq4B7u9MvmxDgWB33atr4kT847CxaHiNQW07ImxoNGku78BLrt9JlERSiNIZ8q+nmePXSFad1c9uWr8f2bdtMzXjV83Kp/6emVZ6MFWDFDtJz6XQH8cEznF4f6oJ2/Sn4OyKzr2yq3pCn+I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(31696002)(110136005)(316002)(53546011)(5660300002)(6512007)(8676002)(966005)(186003)(2906002)(6506007)(31686004)(71200400001)(83380400001)(478600001)(6486002)(8936002)(36756003)(66946007)(86362001)(76116006)(64756008)(2616005)(91956017)(66476007)(66446008)(66556008)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VADCAWMxH1RHPvxXpvMiQI0QBXhZ83MRfEicsmyzHgwiTJydYj1LlNORbFHya1aMNbnDJHTvP2rcdHb4G97eRk9NhBDtkMKXOnC4+iP55TesbmQULEHQt8LEN6YLrX65/xy1yLxwcO4aN9O4vPKCtB6+BlLj0EuwQGFLOcvSQxkRZCb5nj1Th/9KzF2M6zoDd6Cx+g2cQha6egkBtkFmSzKPq0hG5RjkSYdiDQoxViB4aO14j5r5rzfdGyuXxBBLSODhWHL1TTnSConhF0FwTsGYvKtelULZcGRwL4mMJdExxJSeBaFA4jkHRJW9St+EyoEpxIPvQ1CakKhmI5noveeeqQEFmczhNg2+eDBEvyEZ+0LsXi1ys07SCCr/dAqfybHPL8/XtkLMytEmunyOONbsrq0FfYd9rnOUOhlg4V0YWN106te+TgHRFbsqNIdCvtuDfh4KHPncdTl4cdioU/7qHqmeBC28AsMolrNHrYowwTV9E8YPZlDPty6ow3IFxNVUbETLahQUs0zydV2sYZrgdflWBuAKOKKjLaQXHCdZpTQZw8ah1WATLu8p7PHy
Content-Type: text/plain; charset="utf-8"
Content-ID: <403692573EA64040863B1D3BBF332C76@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3082.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7798823b-3096-4ecb-4dfa-08d82f261d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 16:33:22.0950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Hum3CdI+HtdKa3XAua/zjXqtVN+HV54tx6ScLykX+/GQNGH0/2osxRakzGg/IruH1te13vZPC7YthiOrEUPs2/L3/eUUDvdqi//P9oT9qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2569
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDcvMjMvMjAgNzoyOCBQTSwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+
IA0KPiANCj4gT24gMjIuMDcuMjAyMCAxNzo0MywgQ2xhdWRpdS5CZXpuZWFAbWljcm9jaGlwLmNv
bSB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMjIuMDcuMjAyMCAxNjo0NCwgY3Jpc3RpYW4uYmlyc2Fu
QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4gRnJvbTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUu
YmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+Pj4NCj4+PiBJbnN0ZWFkIG9mIHRyeWluZyB0byBtYXRj
aCBldmVyeSBwb3NzaWJsZSBjb21wYXRpYmxlIHVzZQ0KPj4+IG9mX2ZpbmRfbWF0Y2hpbmdfbm9k
ZV9hbmRfbWF0Y2goKSBhbmQgcGFzcyB0aGUgY29tcGF0aWJsZSBhcnJheS4NCj4+Pg0KPj4+IFNp
Z25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KPj4+IC0tLQ0KPj4+ICBkcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMg
fCAyNSArKysrKysrKysrKysrKysrKystLS0tLS0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC91
ZGMvYXRtZWxfdXNiYV91ZGMuYw0KPj4+IGluZGV4IGM1MTI4YzIyOWM1Mi4uZWUyYjU1MGFhNDAw
IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMu
Yw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYw0KPj4+
IEBAIC0yMTEyLDYgKzIxMTIsMTMgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQg
YXRtZWxfdWRjX2R0X2lkc1tdID0gew0KPj4+ICANCj4+PiAgTU9EVUxFX0RFVklDRV9UQUJMRShv
ZiwgYXRtZWxfdWRjX2R0X2lkcyk7DQo+Pj4gIA0KPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBhdG1lbF9wbWNfZHRfaWRzW10gPSB7DQo+Pj4gKwl7IC5jb21wYXRpYmxlID0g
ImF0bWVsLGF0OTFzYW05ZzQ1LXBtYyIgfSwNCj4+PiArCXsgLmNvbXBhdGlibGUgPSAiYXRtZWws
YXQ5MXNhbTlybC1wbWMiIH0sDQo+Pj4gKwl7IC5jb21wYXRpYmxlID0gImF0bWVsLGF0OTFzYW05
eDUtcG1jIiB9LA0KPj4+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+Pj4gK307DQo+Pj4gKw0KPj4+
ICBzdGF0aWMgc3RydWN0IHVzYmFfZXAgKiBhdG1lbF91ZGNfb2ZfaW5pdChzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2LA0KPj4+ICAJCQkJCQkgICAgc3RydWN0IHVzYmFfdWRjICp1ZGMpDQo+
Pj4gIHsNCj4+PiBAQCAtMjEyOCwxMyArMjEzNSwxNyBAQCBzdGF0aWMgc3RydWN0IHVzYmFfZXAg
KiBhdG1lbF91ZGNfb2ZfaW5pdChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPj4+ICAN
Cj4+PiAgCXVkY19jb25maWcgPSBtYXRjaC0+ZGF0YTsNCj4+PiAgCXVkYy0+ZXJyYXRhID0gdWRj
X2NvbmZpZy0+ZXJyYXRhOw0KPj4+IC0JdWRjLT5wbWMgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9i
eV9jb21wYXRpYmxlKCJhdG1lbCxhdDkxc2FtOWc0NS1wbWMiKTsNCj4+PiAtCWlmIChJU19FUlIo
dWRjLT5wbWMpKQ0KPj4+IC0JCXVkYy0+cG1jID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29t
cGF0aWJsZSgiYXRtZWwsYXQ5MXNhbTlybC1wbWMiKTsNCj4+PiAtCWlmIChJU19FUlIodWRjLT5w
bWMpKQ0KPj4+IC0JCXVkYy0+cG1jID0gc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29tcGF0aWJs
ZSgiYXRtZWwsYXQ5MXNhbTl4NS1wbWMiKTsNCj4+PiAtCWlmICh1ZGMtPmVycmF0YSAmJiBJU19F
UlIodWRjLT5wbWMpKQ0KPj4+IC0JCXJldHVybiBFUlJfQ0FTVCh1ZGMtPnBtYyk7DQo+Pj4gKwlp
ZiAodWRjLT5lcnJhdGEpIHsNCj4+PiArCQlwcCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRf
bWF0Y2goTlVMTCwgYXRtZWxfcG1jX2R0X2lkcywNCj4+PiArCQkJCQkJICAgICBOVUxMKTsNCj4+
PiArCQlpZiAoIXBwKQ0KPj4+ICsJCQlyZXR1cm4gRVJSX1BUUigtRU5PREVWKTsNCj4+PiArDQo+
Pj4gKwkJdWRjLT5wbWMgPSBzeXNjb25fbm9kZV90b19yZWdtYXAocHApOw0KPj4+ICsJCW9mX25v
ZGVfcHV0KHBwKTsNCj4+PiArCQlpZiAoSVNfRVJSKHVkYy0+cG1jKSkNCj4+PiArCQkJcmV0dXJu
IEVSUl9DQVNUKHVkYy0+cG1jKTsNCj4+PiArCX0NCj4+DQo+PiBUaGlzIHNlZW1zIGEgYml0IG5v
dCBzaW1pbGFyLiBJIG1heSBoYWQgYmVlbiB3cm9uZyBhdCB0aGUgbW9tZW50IEkgd3JvdGUNCj4+
IHRoaXMgcGF0Y2guIFByb2JhYmx5IHRoZSBiZXN0IHdvdWxkIGJlOg0KPj4NCj4+ICsJdWRjLT5w
bWMgPSBFUlJfUFRSKC1FTk9ERVYpOw0KPj4gKwlwcCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9h
bmRfbWF0Y2goTlVMTCwgYXRtZWxfcG1jX2R0X2lkcywNCj4+ICsJCQkJCSAgICAgTlVMTCk7DQo+
PiArCWlmIChwcCkgew0KPj4gKwkJdWRjLT5wbWMgPSBzeXNjb25fbm9kZV90b19yZWdtYXAocHAp
Ow0KPj4gKwkJb2Zfbm9kZV9wdXQocHApOw0KPj4gKwl9DQo+PiArDQo+PiArCWlmICgoIXBwIHx8
IElTX0VSUih1ZGMtPnBtYykpICYmIHVkYy0+ZXJyYXRhKQ0KPj4gKwkJcmV0dXJuIEVSUl9DQVNU
KHVkYy0+cG1jKTsNCj4gDQo+IEFjdHVhbGx5LCB0aGUgaW5pdGlhbCBwYXRjaCBzaG91bGQgYmUg
Z29vZCBhbmQgc2ltcGxlciB0aGFuIHdoYXQgSSBwcm9wb3NlZA0KPiBpbiBwcmV2aW91cyBlbWFp
bC4gUGxlYXNlIGlnbm9yZSBpdC4NCj4gDQo+IFNvcnJ5IGZvciB0aGUgbm9pc2UhDQoNCkkgd2ls
bCByZWJhc2UgYWdhaW4gdGhlIHBhdGNoc2V0IG9uIHRvcCBvZiB0ZXN0aW5nL25leHQgYW5kIHNl
bmQgYSBWNCB3aXRoIHlvdXIgb3JpZ2luYWwgdmVyc2lvbi4NCg0KUmVnYXJkcywNCkNyaXN0aWFu
IEJpcnNhbiANCj4gDQo+Pg0KPj4gVGhhbmsgeW91LA0KPj4gQ2xhdWRpdSBCZXpuZWENCj4+DQo+
Pj4gIA0KPj4+ICAJdWRjLT5udW1fZXAgPSAwOw0KPj4+ICANCj4+Pg0KPj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4+IGxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0DQo+PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4+
IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtl
cm5lbA0K
