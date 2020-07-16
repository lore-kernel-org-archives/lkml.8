Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36856C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4692065E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kKpwhl7z";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lrJh82VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgGPQjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:39:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48618 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729334AbgGPQjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594917558; x=1626453558;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OcT87+KFhM8Fpo0DLDw7uMuG9bFsqRUrpQF9g4gDOFY=;
  b=kKpwhl7z/k5jfMVkzuXqfseVHXuJasUhBcVSPGkdCMn3h9Rzi7Qe5D1Z
   rhl8IY+c8SGGqLWnrYQ16anWyzkD3OsPddu+5f9qTupxyyiWl3H24FWla
   kgjNbU8sfeIXjx5hmnZMWEWocMRIVWKf3HMNA493HEEtXstq0nAsD4P2S
   U9aEemm/CFXS0YasMKCBSPbH0NJc7JNuz8jTAEjdoR147exz/hdRTTE8C
   M3OuADPHqGoYRVcCnDxfqUSXLq8bV6yHb91MkzSGag/SvgJjPmcLIBzsD
   XkWsazIxKOBy6oV6cBQpPdneTIdMP9ESunOieuQZc+GNTx/fJ4LcxHuFB
   Q==;
IronPort-SDR: 689afsba7GCAuecGE+bExElv38LYDx0WkMt1pTjM3EiIwSOm8A06FfZjCuSbwB8+ehQHRAYt3C
 93S6V1iSATwlSG9pClnT6550yeW/BUEy/tQL4RRU9DkrmhN2x3mjZ94NHcKQbi+AQE4zkSIuy1
 tsgeYfnzrdwhO/pFU+rs+ItQ8HgereZEu7NpcZ/G3jYDyZfX4P7tSDeWGkpf4D3KEH1ng0Dp4n
 hO1GOt+F0+TAfK6BT8NIq4rzE/IJfW/26Y7g3DlTLqpjbfFXhcPl2mq0YNiA8qPYMGwT4GgabX
 sTc=
X-IronPort-AV: E=Sophos;i="5.75,360,1589212800"; 
   d="scan'208";a="146930596"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 00:39:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sy3GrUfZ0PLXr9B6isP3faha/2qv/t5U/5JaSNT+Tq5gOm5tYADV1Q+P2TZDwJQq3xDiI7hA0EltdwGAge9XPRfFGSr8510pYrsompWj78eh8gZxpxZSGwpGv0raA2kwnHaVC25VdAxrCv6LI4NLae+V3PY1u3T77MMam0r8cIXTCrrfH/8eO6Tn9gcE51PW+ojaRPwj96IOb1aOMmSf7q68c4XSh7kiyTQunG8xF4fag1hccUn21JKB0h8F0yfKwAAPpIgwVmnr9OlrJAp5DwWCcYG6sIrZ1ecB34bVw1ieXR0s+2mypm45h8cpC5VNFGQYudoiacW1rFj6jd6ipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcT87+KFhM8Fpo0DLDw7uMuG9bFsqRUrpQF9g4gDOFY=;
 b=gsZf0KPwbx4bEeObpxPdbXQrCOZs7YfJqeHWkrs+RlqQAMHfnh7JjP7qyk+E4tBaCmK6Erwcd9q1tjCTFtpSt6m40sF5s6K3YGugu7t7XxZtKPGn71j4pdtVBT6P4/miT5lLk/YkQWPZQ4ft9M9HvVpYtMlLxLEb2dVOnaQIPUizaZ9vadZmlAxmkf8XS/gpqNTzmc+z4XVg+qSJoE0FNDfG2JaAHU1fq7WTD6m1COaJQ0zDsa1OuezzaCdql/LhSFW7ckKxJsimBOthv3MOMhABeUsk9u9GYW4Lr1cu9OHSWn3JhvOHIJxIZNvhYqvGZ3uUtJjC4ELF4NAQD05HVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcT87+KFhM8Fpo0DLDw7uMuG9bFsqRUrpQF9g4gDOFY=;
 b=lrJh82VUBKaJ12ilYBR9m3P0yU1CCdqy9Jw1ZMuMjp8Chhe0h9t+1nmBsAGVM1WHFm6lKvOLrspklu/CR3qHHjxR4QcYR7gTt/Kid7vUBWOB8bcFeu4kWiNpgz+9jNCXHErJK4zoBdGAnrX3wOzc9IdBy2Pq4GMMcIWxCHErjoY=
Received: from BY5PR04MB6882.namprd04.prod.outlook.com (2603:10b6:a03:21b::19)
 by BYAPR04MB4711.namprd04.prod.outlook.com (2603:10b6:a03:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 16:39:15 +0000
Received: from BY5PR04MB6882.namprd04.prod.outlook.com
 ([fe80::5d51:59b1:8272:23fa]) by BY5PR04MB6882.namprd04.prod.outlook.com
 ([fe80::5d51:59b1:8272:23fa%7]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 16:39:15 +0000
From:   Alistair Francis <Alistair.Francis@wdc.com>
To:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "bmeng.cn@gmail.com" <bmeng.cn@gmail.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "bin.meng@windriver.com" <bin.meng@windriver.com>
Subject: Re: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
Thread-Topic: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
Thread-Index: AQHWWys+Ht+QHg1RAUqvDfDsT6qM+qkKZkIA
Date:   Thu, 16 Jul 2020 16:39:15 +0000
Message-ID: <edca7c9e9a8934fc66d09c7056e92a6aa7f0d645.camel@wdc.com>
References: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com>
In-Reply-To: <1594874393-23620-1-git-send-email-bmeng.cn@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: sifive.com; dkim=none (message not signed)
 header.d=none;sifive.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2601:646:8e00:37b2:f615:7f83:6835:448a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3fa6677a-abe0-48f6-2025-08d829a6c72f
x-ms-traffictypediagnostic: BYAPR04MB4711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB471105F46F1AE49B43440C4F907F0@BYAPR04MB4711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkz7kSjcArtS1ZgztJRgfArI8a6zLyfClAUjiR+kK/5rIRAy07O7MkkQdPxzDETfvK/ZgRa+TZqkDaNAaXI60aW/T+jO1SR5v5LTY9LsVWNuRePxjQVXypCl/YEL4n4xSL4AAaDGseo8E4qeEo59zWw+67gMTYXIyi1AtSDUIVflzPZjlmZ4FSq4TpCFdq1Hq+oBdx85VeegRjNUMla1wFLQftP9qoF06IWjFIFEgaU58aoXlpyRm32ChtspvGrPryWQtE2/+bCgWW15sWRJrZeRkfCInBUIU+19gg4STMG541J8yTiD839QaKKv0Wtpg/R6Bs+Cta3/E/nrG64xIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6882.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(6029001)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(8936002)(8676002)(186003)(316002)(4326008)(6486002)(6512007)(83380400001)(110136005)(36756003)(71200400001)(66946007)(2906002)(86362001)(66556008)(64756008)(5660300002)(478600001)(6506007)(66476007)(66446008)(2616005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3qhO+oE9JbO4/fzvqGFlDc2HHmKz77hGchRpzwy6CFf7hcLIEAY19bgoIgsaMMSVGPcmU7TVpmEVDA3A1blLbLFZfWIXn5W8xY8aK8k4Mp9fUEDeexa/ta5QEOtz9EgZzJ6mSSapXeD6xUbpOVWuur/AlTdsLQiGuQJrI1gdMc18JIh21WtO1UEEOnuMYXyfC2dX9hdsXIysNogeN6T2ShblDWe6sQxzCAqwrih4WFn93UTpZCe/ndt6Js8lYerd3KUuBYUeBCSBzNb4vNQpA/pumtVHkUlw+dTbEQ1UjPIlp9VZX6hqoXxLm4WUw1NDVlCOIHGZJQMUFkI21TuMvlMT+WQRNlfNrbfHhlR5N5wu74JAf03DIMkhl8WZ4vrwjemnPFkVpjiPYNQBHsI+ofaP2uh6IAYM+rE75CPWW6n+m904VvHrnN2+Vg2QYjVbtDGtkHdboB4n8sbQ+qQHDgWbw1PWZqQN69/9pqXjad2gi2doL2m7oTbGkcxAFq/IVR5ukcxL641X/QxakgOssLzyiwXVRDrqwyLH3ZW6ZtRfL1Mw6m1UcsHunFnZQcLR
Content-Type: text/plain; charset="utf-8"
Content-ID: <075FE95E888DA74D9D31303055259EF9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6882.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fa6677a-abe0-48f6-2025-08d829a6c72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 16:39:15.4506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyBRyXIkQTaRmZW/PkxEGq8+VV8Y+DZv1UfLtpTU67hUMbNJf7H49oICAcMEaoyTq6j5RBe9KXlPRmRlLyV4GrKqnDQlN1FsiA8d+TAAD+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIwLTA3LTE1IGF0IDIxOjM5IC0wNzAwLCBCaW4gTWVuZyB3cm90ZToNCj4gRnJv
bTogQmluIE1lbmcgPGJpbi5tZW5nQHdpbmRyaXZlci5jb20+DQo+IA0KPiBUaGlzIGFkZHMgU2lG
aXZlIGRyaXZlcnMgdG8gcnYzMl9kZWZjb25maWcsIHRvIGtlZXAgaW4gc3luYyB3aXRoIHRoZQ0K
PiA2NC1iaXQgY29uZmlnLiBUaGlzIGlzIHVzZWZ1bCB3aGVuIHRlc3RpbmcgMzItYml0IGtlcm5l
bCB3aXRoIFFFTVUNCj4gJ3NpZml2ZV91JyAzMi1iaXQgbWFjaGluZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEJpbiBNZW5nIDxiaW4ubWVuZ0B3aW5kcml2ZXIuY29tPg0KDQpSZXZpZXdlZC1ieTog
QWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0K
DQo+IC0tLQ0KPiANCj4gIGFyY2gvcmlzY3YvY29uZmlncy9ydjMyX2RlZmNvbmZpZyB8IDUgKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9hcmNoL3Jpc2N2L2NvbmZpZ3MvcnYzMl9kZWZjb25maWcNCj4gYi9hcmNoL3Jpc2N2L2NvbmZp
Z3MvcnYzMl9kZWZjb25maWcNCj4gaW5kZXggMDViYmY1Mi4uODc1OTUwMSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9yaXNjdi9jb25maWdzL3J2MzJfZGVmY29uZmlnDQo+ICsrKyBiL2FyY2gvcmlzY3Yv
Y29uZmlncy9ydjMyX2RlZmNvbmZpZw0KPiBAQCAtMTQsNiArMTQsNyBAQCBDT05GSUdfQ0hFQ0tQ
T0lOVF9SRVNUT1JFPXkNCj4gIENPTkZJR19CTEtfREVWX0lOSVRSRD15DQo+ICBDT05GSUdfRVhQ
RVJUPXkNCj4gIENPTkZJR19CUEZfU1lTQ0FMTD15DQo+ICtDT05GSUdfU09DX1NJRklWRT15DQo+
ICBDT05GSUdfU09DX1ZJUlQ9eQ0KPiAgQ09ORklHX0FSQ0hfUlYzMkk9eQ0KPiAgQ09ORklHX1NN
UD15DQo+IEBAIC02MSw2ICs2Miw4IEBAIENPTkZJR19IVkNfUklTQ1ZfU0JJPXkNCj4gIENPTkZJ
R19WSVJUSU9fQ09OU09MRT15DQo+ICBDT05GSUdfSFdfUkFORE9NPXkNCj4gIENPTkZJR19IV19S
QU5ET01fVklSVElPPXkNCj4gK0NPTkZJR19TUEk9eQ0KPiArQ09ORklHX1NQSV9TSUZJVkU9eQ0K
PiAgIyBDT05GSUdfUFRQXzE1ODhfQ0xPQ0sgaXMgbm90IHNldA0KPiAgQ09ORklHX1BPV0VSX1JF
U0VUPXkNCj4gIENPTkZJR19EUk09eQ0KPiBAQCAtNzYsNiArNzksOCBAQCBDT05GSUdfVVNCX09I
Q0lfSENEPXkNCj4gIENPTkZJR19VU0JfT0hDSV9IQ0RfUExBVEZPUk09eQ0KPiAgQ09ORklHX1VT
Ql9TVE9SQUdFPXkNCj4gIENPTkZJR19VU0JfVUFTPXkNCj4gK0NPTkZJR19NTUM9eQ0KPiArQ09O
RklHX01NQ19TUEk9eQ0KPiAgQ09ORklHX1JUQ19DTEFTUz15DQo+ICBDT05GSUdfVklSVElPX1BD
ST15DQo+ICBDT05GSUdfVklSVElPX0JBTExPT049eQ0K
