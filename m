Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F94EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F47621473
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="dmErD5N3";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JOeRYx4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgFZK5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:57:33 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64451 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbgFZK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593169051; x=1624705051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/8rl3HYosR/nMLnPjNZAZzwxA5kChItBZg1Uq0K1FUA=;
  b=dmErD5N3sX075woikfbmF9lJXRCDoxw7hlvPHIS43JKzQFqTCo9Qzvef
   +bEynkkPmaev8wKmhUw6Ytv2S6ubk9uYY3SWn+bWShe2tNmB/PAq1BRut
   hOqimWZC7sDaAjX/5Oha6elw2tybGqL0aWrQf5LHejRM3d5qUjdnCIvSv
   xGfliGyFfg62tqWeJ/jhInDOPWqYFBAevRvSnuQZszuPwMcdCbKuXGqPM
   mQoi+qsBAB8xDK+xjkdg8olGhoRweo6RKtn1hWa8XBnkzBAyCOcGccVVA
   AIRYE4u6M8JoL83iynXPGR+EYDMKFrmKLICKe042lxb4Z+JZvtyCU+o8g
   w==;
IronPort-SDR: XfaJdA0tyEzUF/6aNi6b0rURpduEMBFMkPl/NGpVrxoDjxFskE/LEItW9n2z43OBnkSOTTWzEh
 6wWsUPJcWWiWsfftfEEB6SsRodNdep3jwapRIWl/kVfpggrMxzhe3U4m/ba/+uq+3+fU7c99i6
 rdNty4groSt/7pvhQZUx+aTwVDBv53DltUHwWmENW+dUQgCMlWP0xjpQMYvKbjo/cWpV9FcEok
 aW+NdOdNr9vUTXUuzqq6xEEVxT615cIvAelUFUGsWo2nvyXQvlLtavEJNZ1W2NCeCnAIpNhPYE
 lYo=
X-IronPort-AV: E=Sophos;i="5.75,283,1589266800"; 
   d="scan'208";a="77929145"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2020 03:57:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Jun 2020 03:57:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 26 Jun 2020 03:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZb4CP6d9W4TIx4+ppQUrhBmc7WRcH/tD0Us7iqzc58a3QU/VkSusm0dz+5gntj3/YsikAdyAz55BrWsi+cZFKcoxthnbGhGtbY9UU4r3ZqrRr/+t5+XmYJHRo8geklFnigzCmpDqct67eEzdUEKPecPcB+RhmhdiAaFMfQMhEcdzDlR+EM0xvQLie7lb7uY2Xo4D+pYszdXHmjwJ9iBNB/AWhcYDxD8Q/QTJRs81T71aM6xfdOa5b2WWPJsS/VkQUX+n9KC3gkkf8ouRoLU5lBQd028FAy83Qzty5GNVvBDxJU9r4R6Q/nfjI9biYaAaeCEB8ELazMcD3xB25eFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8rl3HYosR/nMLnPjNZAZzwxA5kChItBZg1Uq0K1FUA=;
 b=TNguGQw04W7n9W96ip4dtONYkIIY6f7R97Y+vhpBw+orgQDISBhv2qugSX1ZoGEQv6rFh/pbaHC1D7sfLH5iFVUf7XCvUW/rCkx1jS+9STbHZ8rAJZ1UO6DGlU7Mb4uH6RAb/KsVXBLmA16tR8BWiB6ID//jV2wbKul7UmGUtD0xiLpq+AhxAel5FQAPNQ5cQKQaWEt2Eo+aJ0nMfchmFUBcb29I15cqSpH58/gr5haczEIhHvWZkim/ishuU5iak9+nAhadKfRjmFArO+FM4Vtie4qq76PAUW91VBGgJrevCu+HEAr+3yw0eEvD37w/bRDs12JOyJoI0ML8ZXfrTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/8rl3HYosR/nMLnPjNZAZzwxA5kChItBZg1Uq0K1FUA=;
 b=JOeRYx4R987Ju7rhzM5Vl7Yr0NI9jm+fMJCfok4+m4juULJYMM1Jb/gp1155dL5Vbzo8FQQZKi0HhVepPLvtyrMnDJmYnxDI2B5TYM9Zkui5zG/w+CNob0N6loYBqa6ZFS5RUqeyzVUY59/LicJaQiQkVdlfjbn8pZKp2FpCKt0=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3461.namprd11.prod.outlook.com (2603:10b6:a03:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 10:57:27 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 10:57:27 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <luisalberto@google.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <mika.westerberg@linux.intel.com>, <jethro@fortanix.com>,
        <bbrezillon@kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Topic: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Index: AQHWS6iUCAqTB2Up30yP+LHzC/Sy+w==
Date:   Fri, 26 Jun 2020 10:57:26 +0000
Message-ID: <e5f8203c-bf0a-3aee-a067-980592eab9e6@microchip.com>
References: <20200610224652.64336-1-luisalberto@google.com>
In-Reply-To: <20200610224652.64336-1-luisalberto@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1874aa67-0591-4319-c8aa-08d819bfb6e9
x-ms-traffictypediagnostic: BYAPR11MB3461:
x-microsoft-antispam-prvs: <BYAPR11MB34612F679F70589B9A9EBA55F0930@BYAPR11MB3461.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GyElf74I3j4Q0tntrwyIUat5/6++fFLdq8FIHHG7ZabAaArp6xI4Tt60ctkJ0oX6pdhxN5RlqbiXa1cxY8RqZDS9aIfvPs4lqlDNk78Re9djVROF2mjpdjnPdJJ8sMfWpgZi5MQPPoVklYbHzr0qmcEzHmKHlzS9MEUcvtep74jLUxyR9AYmJX0GNAKfSFKwhEw1XT94yqsgLda/0iOYtxH72hTAVIoplZHuX2jsT88fMrmnxCpSk+/IqB7gB1ue7jlkBwBsy//2ZMGqbgsaY07JYeg+N03W5Z+SB22Qkva4ZoRd3YUWb3IbZrmp4iyzUDi03JJv/OqDScu/TIaSHIiqDFV5mkX5ZjgIAenIxgcpB9Bs33tdW0vYf3U6g1P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(346002)(39860400002)(136003)(366004)(5660300002)(64756008)(31696002)(66446008)(86362001)(36756003)(66556008)(54906003)(6916009)(8676002)(478600001)(6486002)(76116006)(83380400001)(66946007)(66476007)(316002)(53546011)(8936002)(6512007)(6506007)(91956017)(71200400001)(26005)(2616005)(186003)(2906002)(31686004)(4326008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 1Zi6FesVMXBl3bcS6fhw4R+nURIFAAxU9i4zdZ5fNK2wGg7giaOcOs55LyupJb0Ku0QWpWJXKTxZz7ixm89vYaAvhN5J371TmqSBlPSAEVHZpU3wvbDWmx8SLYm+HML3aiDcEyMF14vZkJEjAfsfzn5TaTXSFGrnZqkJOLpizc7RyKCVdf7TKeW8kTFO/C/xwkW/kh3HUoaQqnkZxsK9Q8UqPBpuVkv+9yYZp3yFO3SxzOkHedGelOupIair/U0rlxQ++aZ/fLmTV7JyjRy7YZ3sEt4ll5o0oQ07q28bLLmFbKjKUv6YjWEWWn67Cc3TjH4/SMtbKsoQ+fbj8cFxev/2SuxTrAY9z14kIOSlZWcWIpVmo7rkkQiTuPyz6Arisi8QGRw0jccmrgLi8rkt+kNvpsnMPFJiBAi84j9ri1/Xw+To7gDJsj0y1esQ7N83St/NxPiKpTUZ6l52b48Y8vZlgSY3u7UdKajsJD/NfEs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E57C6A9BB55824C8122813DE858586E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1874aa67-0591-4319-c8aa-08d819bfb6e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 10:57:26.9318
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTKeLRnhELbGcyGpqhfrSRdXisOhOgjCfbVWOwz4y5ED9OYaTzsrfB6lwdbaifYvtjJHVuJU85uj6OYxKwBSxu5ZnDzk5vsam66k+6EWNzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8xMS8yMCAxOjQ2IEFNLCBMdWlzIEFsYmVydG8gSGVycmVyYSB3cm90ZToNCj4gVGhpcyBj
aGFuZ2UgcmV2ZXJ0cyBhYmEzYTg4MmExNzg6ICJtdGQ6IHNwaS1ub3I6IGludGVsOiBwcm92aWRl
IGEgcmFuZ2UNCj4gZm9yIHBvbGxfdGltb3V0Ii4gVGhhdCBjaGFuZ2UgaW50cm9kdWNlcyBhIHBl
cmZvcm1hbmNlIHJlZ3Jlc3Npb24gd2hlbg0KPiByZWFkaW5nIHNlcXVlbnRpYWxseSBmcm9tIGZs
YXNoLiBMb2dnaW5nIGNhbGxzIHRvIGludGVsX3NwaV9yZWFkIHdpdGhvdXQNCj4gdGhpcyBjaGFu
Z2Ugd2UgZ2V0Og0KPiANCj4gU3RhcnQgTVREIHJlYWQNCj4gWyAgIDIwLjA0NTUyN10gaW50ZWxf
c3BpX3JlYWQoZnJvbT0xODAwMDAwLCBsZW49NDAwMDAwKQ0KPiBbICAgMjAuMDQ1NTI3XSBpbnRl
bF9zcGlfcmVhZChmcm9tPTE4MDAwMDAsIGxlbj00MDAwMDApDQo+IFsgIDI4Mi4xOTkyNzRdIGlu
dGVsX3NwaV9yZWFkKGZyb209MWMwMDAwMCwgbGVuPTQwMDAwMCkNCj4gWyAgMjgyLjE5OTI3NF0g
aW50ZWxfc3BpX3JlYWQoZnJvbT0xYzAwMDAwLCBsZW49NDAwMDAwKQ0KPiBbICA1NDQuMzUxNTI4
XSBpbnRlbF9zcGlfcmVhZChmcm9tPTIwMDAwMDAsIGxlbj00MDAwMDApDQo+IFsgIDU0NC4zNTE1
MjhdIGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVuPTQwMDAwMCkNCj4gRW5kIE1URCBy
ZWFkDQo+IA0KPiBXaXRoIHRoaXMgY2hhbmdlOg0KPiANCj4gU3RhcnQgTVREIHJlYWQNCj4gWyAg
IDIxLjk0MjkyMl0gaW50ZWxfc3BpX3JlYWQoZnJvbT0xYzAwMDAwLCBsZW49NDAwMDAwKQ0KPiBb
ICAgMjEuOTQyOTIyXSBpbnRlbF9zcGlfcmVhZChmcm9tPTFjMDAwMDAsIGxlbj00MDAwMDApDQo+
IFsgICAyMy43ODQwNThdIGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVuPTQwMDAwMCkN
Cj4gWyAgIDIzLjc4NDA1OF0gaW50ZWxfc3BpX3JlYWQoZnJvbT0yMDAwMDAwLCBsZW49NDAwMDAw
KQ0KPiBbICAgMjUuNjI1MDA2XSBpbnRlbF9zcGlfcmVhZChmcm9tPTI0MDAwMDAsIGxlbj00MDAw
MDApDQo+IFsgICAyNS42MjUwMDZdIGludGVsX3NwaV9yZWFkKGZyb209MjQwMDAwMCwgbGVuPTQw
MDAwMCkNCj4gRW5kIE1URCByZWFkDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBMdWlzIEFsYmVydG8g
SGVycmVyYSA8bHVpc2FsYmVydG9AZ29vZ2xlLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9z
cGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5jIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5jDQo+IGluZGV4IDYxZDJhMGFkMjEzMS4uMmI4
OTM2MWEwZDNhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJz
L2ludGVsLXNwaS5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50
ZWwtc3BpLmMNCj4gQEAgLTI5Miw3ICsyOTIsNyBAQCBzdGF0aWMgaW50IGludGVsX3NwaV93YWl0
X2h3X2J1c3koc3RydWN0IGludGVsX3NwaSAqaXNwaSkNCj4gICAgICAgICB1MzIgdmFsOw0KPiAN
Cj4gICAgICAgICByZXR1cm4gcmVhZGxfcG9sbF90aW1lb3V0KGlzcGktPmJhc2UgKyBIU0ZTVFNf
Q1RMLCB2YWwsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhKHZhbCAmIEhT
RlNUU19DVExfU0NJUCksIDQwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ISh2YWwgJiBIU0ZTVFNfQ1RMX1NDSVApLCAwLA0KDQpXb3VsZCAxMCB1cyBrZWVwIHRoZSBwZXJm
b3JtYW5jZSBhcyBpdCB3YXMgYmVmb3JlPw0KDQpDaGVlcnMsDQp0YQ0K
