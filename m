Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E2FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DB01206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="JDKPC9jD";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="JIOJqRcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgGWQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:29:00 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:50894 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQ27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595521738; x=1627057738;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=3gMoUouwlk3fJwcByBAmiWdDWHPIZLt5eiuvmdzxTBc=;
  b=JDKPC9jDpT2/JwfqR8vr9zNqbeWsGmNcq9leK+YCh2oX4gKml4KjELp5
   EotMyEx8MYXiC/P8WNpJl5BdtGzreZLkN8O9EnDVbtq91koEMXGYFXfCC
   lg8MFCaPx8IARV+8pVrju9e3RMet/ZMb8RP8/ozJ2xeRChcYY3z2RY9ST
   nIMS9izR08EOPw3sooYa1MzgPiTvzXn/oQ7OFKd8WFJYobvS4UobNs+GQ
   aqKjcIVBIYQUz0iTctcimwmqfWFurs9sBLN9sr4PT0awWB2qQIIS9mBbQ
   0/wsZx5C/smcjcYl5PQ7UQ9uafdt9NcT/eeRmiFOH6guwhkdgZIvBbfCH
   g==;
IronPort-SDR: /G2oarO1AeG0A0QzndN1JpK5x0PGHCYv+A1fneWW0IytOXTSi3cbiDlpYpSksvzQcUxupEZQDp
 OmTcOdgkSDXavcIQS0PUepOeOqSHRd5T+pWzSTUyxWmTLS1eTQSYOWMQVFelotTygS3e2FGJ/n
 9rx5Fqzq4RjyLM0hrLJK4cQ/+mdwy06qdB34gUAfqpsUJDbUaOGWpL0/WZxy9XvUl723l7dOkn
 gyvGG5xlgie61AWw/NpStGerj06u3X4cL3ciGfAb4f7hwo3lyUxK2CAGEEAPlqLa+fc3v3fkRv
 7sg=
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="83018926"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jul 2020 09:28:58 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 23 Jul 2020 09:28:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 23 Jul 2020 09:28:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq+kfKR2R2HMQZajb7t/1tSDTq2UuM/PMKe9r9l80dwsvNo3rwVD3jJh2SWb7JK9kwQfOAVhA+FxIly2DfXGEnnuHyDIFFVDY6RAqMircgPebsCrpZayeNOM7c/mSksqWqe21Fk3c4JQkHrcA2qShekENrJfAMkU0qHrLGk0bluwk+mYGQZw4Kq1BzRS/olEVgUpM8O+CWndNoOUDMuNml2zlk7jmP9LwGjjOasLUxCDOE5ckmmcXT9NGv8mnuxnEFyMVtFYGtPlxWMCLPo/to4eSL7s67YwQmatomPsQgkrnDjyt9yV2FnZAJJAUv8WQFjkjWOGoTzZQNSDhtH3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gMoUouwlk3fJwcByBAmiWdDWHPIZLt5eiuvmdzxTBc=;
 b=Z3XiIJr13ktGwu5WIPMw5b1TO9/TA8G6fJCf8dzgX77bV06DsaOQxMOgvJYy3kg8hqi5MQkSy+v4H58LEBfhMjBZ//oy8Orkn+/G0o79WGX/IEhiln+OCt1a7xz/HmRtgv4/ocYkTuLay3LuWVY1OrUGLqj70E8auFbCB68XBfwZ8K78WkvDCbyEZ+ucC2zT7Hc5D3ri172lRw+kZelYjOu7dFZP1fOMZLh1jmnIm4ZC7btkUav5XMNkUUJB4Gkf/NLkMFUkdrfu3iBSF7oMMx+S1fC7sdpdej5fA6aT1MgwC9xJOE4SU1NfrhLthdKSxmP2bTQzSvlco6HU1tfDyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gMoUouwlk3fJwcByBAmiWdDWHPIZLt5eiuvmdzxTBc=;
 b=JIOJqRcwQ8489dAt8KJ1agbt7t1Z5BPe2P6+19q0rVdLQ93vTIAUfYqJn7jvD4qGjy5o670/2kWiAfcq9PqaU3mYtefmiGmfgr+r64/yZ2CIQdPrbrA/tk7bp7kyTLlYDDYsbVdzktfE31XLFa3f11CrYoATWiFYSQe/OpFAjnc=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3193.namprd11.prod.outlook.com (2603:10b6:5:57::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.23; Thu, 23 Jul 2020 16:28:53 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3216.024; Thu, 23 Jul 2020
 16:28:53 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Cristian.Birsan@microchip.com>, <balbi@kernel.org>,
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
Thread-Index: AQHWYDZ7vQs+wibSwkmzkBgy4Ym1sakVXEWA
Date:   Thu, 23 Jul 2020 16:28:53 +0000
Message-ID: <b9c051ce-fba2-297e-e6ec-63acfcc47afc@microchip.com>
References: <20200722134421.190741-1-cristian.birsan@microchip.com>
 <20200722134421.190741-2-cristian.birsan@microchip.com>
 <9cf8e546-09ce-d902-6dca-e2490fd8c4ae@microchip.com>
In-Reply-To: <9cf8e546-09ce-d902-6dca-e2490fd8c4ae@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: microchip.com; dkim=none (message not signed)
 header.d=none;microchip.com; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [213.233.110.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90b832b2-2bb5-43ed-3338-08d82f257d4b
x-ms-traffictypediagnostic: DM6PR11MB3193:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3193CF28614F29BE6814808187760@DM6PR11MB3193.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MJXTwNxDPvrMQdaXR/OSJZpeQxsmfhMAxEKIn7tHJSpxjEZ4LFf+PbwR1IHY77ZT8nb8e5ZJHIl9mf257L95Ip/JqPSIAdegtKk1Iznt6dfmTfpB+7DxSCgzk+goZ9990T512ExGoM00w+paffJ7+myHMhnOlzw5dfK70BImEjGmAi1bzzqx7Eq/EtHUNa6VImxaGbSWEeezfo3bpMKvLtcuRmndBO7/+KriHZmGMXx2VnLScFFcLv3aq9v1/kfUisqr06b8LPWK6A2rk+k1oJ+4xPR3jM14OjsZa4pB0nqmnOntjGyr6eo459+bMiajeM62vgGwdUIHR9eIazx0eH83qFMG5icQbQzIZMqwoq7fj4w+K9WBQb629SU14HyZtzaOTR6NUSOJYflMXXhCsZZmM1RRT8aESIJY0rxqCAu4ow8MKlkcQlO5kcbxCcuHCIx4cNsLBFJi9PyZITo4V/UNK1r0Nkebtd80Kgli9qw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(39860400002)(376002)(136003)(83380400001)(186003)(71200400001)(26005)(5660300002)(31686004)(8676002)(6486002)(66446008)(36756003)(66556008)(2616005)(966005)(31696002)(6506007)(86362001)(110136005)(66476007)(91956017)(2906002)(8936002)(53546011)(6512007)(478600001)(316002)(76116006)(64756008)(66946007)(921003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: TtNTQ1oo8rvXhFyaDUZfe/3wreGtPOym5N+KUrh6wDJhrZfAHZ8rxCJYeFAsERNTd3BxpudxNLYAgcFGDP6oY3vLbT6TRrOKQm22LhKYFPE5eb/gCo6VtLREBKx5IdAbaA5jrjN4cc9ocxQzJNHkp6NnbdPLgIIx+2mUAWzR7E+DhI1gBgFkp36WIfI0eiLwv9/8tcdKxp/k7kk69gq4+QkaNR53zKqeDKsYT3W8WH6SdgIPUy0OYZSS5vQ3+UHOmCPfhbZLZ/EPOEidH+0WDKrWfgzXXXe0L/1AIyEFF8mVaDU0YukrShJ7FbPIAWaCp9JboRoNERSQ2K4Tkp8Ry1rb7fTNVYNIQrAmOtJdkFUc6RD3Jq08l4n8/hZhEAoumqjyxUzz5d+V6ivsJwWDRfkQUFBt59DfEE4pm8mnLzzlECIiOIHGXVhEWKvkPCxaObzk/81x5d80Qt4l5wAMJIwKoWPCAJTk7mVDh5aJSzfEM8XQRWnJ5/3vB6sOmAVL
Content-Type: text/plain; charset="utf-8"
Content-ID: <47DDA43FD86B73409BAEC4EFE15D26FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b832b2-2bb5-43ed-3338-08d82f257d4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2020 16:28:53.4711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHZJXIvyQK6/Yid+IK9m071+CxLn1/fpDcLiCLRgjsuAp/xeN+EUggFyHKJcx+9cIpilnxJofpOQFf7DC4kJvV2u9OZdudnZcggo2XgRf28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3193
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIyLjA3LjIwMjAgMTc6NDMsIENsYXVkaXUuQmV6bmVhQG1pY3JvY2hpcC5jb20gd3Jv
dGU6DQo+IA0KPiANCj4gT24gMjIuMDcuMjAyMCAxNjo0NCwgY3Jpc3RpYW4uYmlyc2FuQG1pY3Jv
Y2hpcC5jb20gd3JvdGU6DQo+PiBGcm9tOiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFA
bWljcm9jaGlwLmNvbT4NCj4+DQo+PiBJbnN0ZWFkIG9mIHRyeWluZyB0byBtYXRjaCBldmVyeSBw
b3NzaWJsZSBjb21wYXRpYmxlIHVzZQ0KPj4gb2ZfZmluZF9tYXRjaGluZ19ub2RlX2FuZF9tYXRj
aCgpIGFuZCBwYXNzIHRoZSBjb21wYXRpYmxlIGFycmF5Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KPj4gLS0tDQo+
PiAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jIHwgMjUgKysrKysrKysr
KysrKysrKysrLS0tLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQvdWRj
L2F0bWVsX3VzYmFfdWRjLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRj
LmMNCj4+IGluZGV4IGM1MTI4YzIyOWM1Mi4uZWUyYjU1MGFhNDAwIDEwMDY0NA0KPj4gLS0tIGEv
ZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jDQo+PiArKysgYi9kcml2ZXJz
L3VzYi9nYWRnZXQvdWRjL2F0bWVsX3VzYmFfdWRjLmMNCj4+IEBAIC0yMTEyLDYgKzIxMTIsMTMg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgYXRtZWxfdWRjX2R0X2lkc1tdID0g
ew0KPj4gIA0KPj4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGF0bWVsX3VkY19kdF9pZHMpOw0K
Pj4gIA0KPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGF0bWVsX3BtY19kdF9p
ZHNbXSA9IHsNCj4+ICsJeyAuY29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOWc0NS1wbWMiIH0s
DQo+PiArCXsgLmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTlybC1wbWMiIH0sDQo+PiArCXsg
LmNvbXBhdGlibGUgPSAiYXRtZWwsYXQ5MXNhbTl4NS1wbWMiIH0sDQo+PiArCXsgLyogc2VudGlu
ZWwgKi8gfQ0KPj4gK307DQo+PiArDQo+PiAgc3RhdGljIHN0cnVjdCB1c2JhX2VwICogYXRtZWxf
dWRjX29mX2luaXQoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCj4+ICAJCQkJCQkgICAg
c3RydWN0IHVzYmFfdWRjICp1ZGMpDQo+PiAgew0KPj4gQEAgLTIxMjgsMTMgKzIxMzUsMTcgQEAg
c3RhdGljIHN0cnVjdCB1c2JhX2VwICogYXRtZWxfdWRjX29mX2luaXQoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwNCj4+ICANCj4+ICAJdWRjX2NvbmZpZyA9IG1hdGNoLT5kYXRhOw0KPj4g
IAl1ZGMtPmVycmF0YSA9IHVkY19jb25maWctPmVycmF0YTsNCj4+IC0JdWRjLT5wbWMgPSBzeXNj
b25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJhdG1lbCxhdDkxc2FtOWc0NS1wbWMiKTsN
Cj4+IC0JaWYgKElTX0VSUih1ZGMtPnBtYykpDQo+PiAtCQl1ZGMtPnBtYyA9IHN5c2Nvbl9yZWdt
YXBfbG9va3VwX2J5X2NvbXBhdGlibGUoImF0bWVsLGF0OTFzYW05cmwtcG1jIik7DQo+PiAtCWlm
IChJU19FUlIodWRjLT5wbWMpKQ0KPj4gLQkJdWRjLT5wbWMgPSBzeXNjb25fcmVnbWFwX2xvb2t1
cF9ieV9jb21wYXRpYmxlKCJhdG1lbCxhdDkxc2FtOXg1LXBtYyIpOw0KPj4gLQlpZiAodWRjLT5l
cnJhdGEgJiYgSVNfRVJSKHVkYy0+cG1jKSkNCj4+IC0JCXJldHVybiBFUlJfQ0FTVCh1ZGMtPnBt
Yyk7DQo+PiArCWlmICh1ZGMtPmVycmF0YSkgew0KPj4gKwkJcHAgPSBvZl9maW5kX21hdGNoaW5n
X25vZGVfYW5kX21hdGNoKE5VTEwsIGF0bWVsX3BtY19kdF9pZHMsDQo+PiArCQkJCQkJICAgICBO
VUxMKTsNCj4+ICsJCWlmICghcHApDQo+PiArCQkJcmV0dXJuIEVSUl9QVFIoLUVOT0RFVik7DQo+
PiArDQo+PiArCQl1ZGMtPnBtYyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChwcCk7DQo+PiArCQlv
Zl9ub2RlX3B1dChwcCk7DQo+PiArCQlpZiAoSVNfRVJSKHVkYy0+cG1jKSkNCj4+ICsJCQlyZXR1
cm4gRVJSX0NBU1QodWRjLT5wbWMpOw0KPj4gKwl9DQo+IA0KPiBUaGlzIHNlZW1zIGEgYml0IG5v
dCBzaW1pbGFyLiBJIG1heSBoYWQgYmVlbiB3cm9uZyBhdCB0aGUgbW9tZW50IEkgd3JvdGUNCj4g
dGhpcyBwYXRjaC4gUHJvYmFibHkgdGhlIGJlc3Qgd291bGQgYmU6DQo+IA0KPiArCXVkYy0+cG1j
ID0gRVJSX1BUUigtRU5PREVWKTsNCj4gKwlwcCA9IG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRf
bWF0Y2goTlVMTCwgYXRtZWxfcG1jX2R0X2lkcywNCj4gKwkJCQkJICAgICBOVUxMKTsNCj4gKwlp
ZiAocHApIHsNCj4gKwkJdWRjLT5wbWMgPSBzeXNjb25fbm9kZV90b19yZWdtYXAocHApOw0KPiAr
CQlvZl9ub2RlX3B1dChwcCk7DQo+ICsJfQ0KPiArDQo+ICsJaWYgKCghcHAgfHwgSVNfRVJSKHVk
Yy0+cG1jKSkgJiYgdWRjLT5lcnJhdGEpDQo+ICsJCXJldHVybiBFUlJfQ0FTVCh1ZGMtPnBtYyk7
DQoNCkFjdHVhbGx5LCB0aGUgaW5pdGlhbCBwYXRjaCBzaG91bGQgYmUgZ29vZCBhbmQgc2ltcGxl
ciB0aGFuIHdoYXQgSSBwcm9wb3NlZA0KaW4gcHJldmlvdXMgZW1haWwuIFBsZWFzZSBpZ25vcmUg
aXQuDQoNClNvcnJ5IGZvciB0aGUgbm9pc2UhDQoNCj4gDQo+IFRoYW5rIHlvdSwNCj4gQ2xhdWRp
dSBCZXpuZWENCj4gDQo+PiAgDQo+PiAgCXVkYy0+bnVtX2VwID0gMDsNCj4+ICANCj4+DQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IGxpbnV4LWFy
bS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwNCj4g
