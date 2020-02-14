Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF43AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C8217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bgmsp2OR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="XQXSLv0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbgBNT0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:26:35 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:52860 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387576AbgBNT0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:26:35 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 876CF42AC9;
        Fri, 14 Feb 2020 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1581708393; bh=xyaaYPjZLors06QU6i64Nifnmc7t8f9/3Fdnwe6AmLI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Bgmsp2ORUWD1Fd41MVpld6VsngaUv3AbLtxH9OnOZ3Z+g5VylVxcfbRiyi4B0lbD7
         iAHVFpefKqB5AhOKmymwA83Syt6P/gMIW8EFbc54BcRw60fhkQpQfjP7LNtbbOdaWC
         0TNA3bJL4ggn0Jm98rsyjGipU+x2RTnUb5pW6TKdhA1L/5U5Hz1nImx+zyjpoH1kfP
         LUkCbKJmW8cGXtvhFT+xZZMs2jwO03CimJmXv3AgSyYxylEmhp03SIGfNa1qFX30xi
         KTjuTo3M2PLSdMa8yTkiTuqUbQ9PxR2FJHzgQOXAa0w0bnoYfEbQ4s8mzZjGMEV5O2
         EdW3EPqnyOfMQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 91EF1A006A;
        Fri, 14 Feb 2020 19:26:32 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 14 Feb 2020 11:26:25 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 14 Feb 2020 11:26:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hm0mTRUGG7pXQCmAIpARkYzeBkTuyeXhQWyqlEZ1yCQz5rOB333B04t0P1B086TwVv9C5DFUYwnDzWCCOVx7RTI5przPW/aSiiVddAZcMozgCcOKx9e5UR+iYjGfg3FAGShHkuqnleO7bXx8sHCbQIIku9vOHYAaamTW0jm/ociLdOwFGfI7YnheqbNsYeWf9HPngdFjdxMahZsdULEl6YJ79LDEAbqYDJGfsAK5mdbImedUNDnibJiGn0nyDCCDRoqYAvxvrH6I92lexLzVCfFhFuhN2GpUL12oLstfXTI3gSgXgY47aO0KU75cLnmbv6hJ5/ImepkxRaGsX9unDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyaaYPjZLors06QU6i64Nifnmc7t8f9/3Fdnwe6AmLI=;
 b=EqtkmVY7VOh9Ycwpd/Ry3wx+upFJyt451LbsWGVevCKAhNXN9rL//oSAysV41VrhBEtjXNzQRRk4jnIT9Bj4O2uskku8t3c6Xc+ey0RTdagJwaKVZNnjKfQVIhhqexU0ya6abCaUZLUuQSr+J8Ci6KwCMT2WRE4u8WKCONm2U3HufzivQmT5J1Ux065QTk3NJ6mmf1+ZFhjR5eFAZxgyMkIR+I7bPzS2+/zDHLEq2cOtbqfm5nlUij8y4z1NA6F7U4WCg+wW1KTx8+C11LaQwgzLxU1M1R4YHneug5L+GtCrqjfcRSEn8YySpgDxgaTCS7ktEF43OqhkzOR68VgJbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyaaYPjZLors06QU6i64Nifnmc7t8f9/3Fdnwe6AmLI=;
 b=XQXSLv0HME7roykh7CURMCyl5y7mMgUEvC9h+3PEmaj84ZqkMnKzB5tY2VhEvQv2QIXzTHpAHZIuDLOMPGxsyeZC4+oIN1IhXFthHEv2ympAAIaSqI29xExvMuA4DoVqDp7CiYj3k1mouMOd16s82gXbTdSOc1Ax3lcFLn2Gi2U=
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (52.135.103.22) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 19:26:23 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35b7:65bf:63e:aad0]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::35b7:65bf:63e:aad0%7]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 19:26:23 +0000
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Pawel Laszczak <pawell@cadence.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        "Rahul Kumar" <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: Re: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Topic: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Index: AQHV4Y5FV9MeiX15OUylR8jx9wgmF6gaDcsAgAANDYCAAPtSAA==
Date:   Fri, 14 Feb 2020 19:26:22 +0000
Message-ID: <7ef4b9c5-8694-4d8e-2866-95ec11546bec@synopsys.com>
References: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
 <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
 <BYAPR07MB47098648C28E5E4BB9B78DCADD150@BYAPR07MB4709.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB47098648C28E5E4BB9B78DCADD150@BYAPR07MB4709.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=thinhn@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf515be6-94e5-4270-3dea-08d7b183c70b
x-ms-traffictypediagnostic: SN6PR12MB2749:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR12MB2749F1B2A315C6ABC2903596AA150@SN6PR12MB2749.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(39860400002)(376002)(396003)(199004)(189003)(66946007)(4326008)(2616005)(86362001)(8676002)(66556008)(81156014)(81166006)(31696002)(66476007)(8936002)(2906002)(64756008)(6506007)(31686004)(36756003)(54906003)(478600001)(5660300002)(316002)(110136005)(6486002)(6512007)(26005)(7416002)(186003)(76116006)(66446008)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2718.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ErnABUhV15Dkej97rGUWhNicOrVDBtrkYzPI5UAlaGAb+B7YC8LFGLgFDiPLRsO37kkDdJ5sGUoJyItSh2zPoRUy8zRtlAhObkpNJXpj/RcB2xBnJ9p7hGj/VGCCo1xilvaGxTXEzlza5sjZnj85rcoaQHsNHyxWB/1FadeYt8dShJAfuDlaBbghsbyOBB4tk6S3ol4GtL7GndKUx5nsvWbhPw5lSy5cbQ39u+6oT/0UYeKATXy8Qx/BUId2f+nfRfDLJKav7ulBQsZWpf9TW1XyIezmCUzQUsbh0Z+BYb2p7oQHZbZRh5AIB3rKK5gR6vKLztd09hK5deH46W8CrqlIWDXvbhoodo3dh7QnriF91wJ0gRI6cx4amiWdvmHCGlmy6lLQ2fwPq5J/u812rmOKwmc5Io3IbO60lBZTgWRW9IugoPttQwoeJeuBkAr
x-ms-exchange-antispam-messagedata: rWzIqdogNoRum2s5+Zyhq2o7Qk9lzLC2iNYts6xQSfmhCm6g49c0AmRCUZwUYOfcfgoJnqa3vkeke3G60vjZsxTz5PqsvVWA9s3W/ThwpLy9pzntrOQoH8mn89TbM/Xz8pv+GiN5WRLMJqa/xD22LQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABEFD228888F0A49BEEA4D7F42E7BB6A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cf515be6-94e5-4270-3dea-08d7b183c70b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 19:26:22.8872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYbNR2daBYwDtSMmQtnclHNaDkH9nqLXF5X3WaswKv8FbSBbnaJAnJ7XhQKELrKhD3ZOShOTE0/DiO7kknIB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGF3ZWwgTGFzemN6YWsgd3JvdGU6DQo+IEhpLA0KPg0KPj4gSGksDQo+Pg0KPj4gSmF5c2hyaSBQ
YXdhciB3cm90ZToNCj4+PiBUaGlzIHBhdGNoIGFkZHMgYWRkaXRpb25hbCBwYXJhbWV0ZXIgYWx0
IHRvIGNvbmZpZ19lcF9ieV9zcGVlZCBmdW5jdGlvbi4NCj4+PiBUaGlzIGFkZGl0aW9uYWwgcGFy
YW1ldGVyIGFsbG93cyB0byBpbXByb3ZlIHRoaXMgZnVuY3Rpb24gYW5kDQo+Pj4gZmluZCBwcm9w
ZXIgdXNiX3NzX2VwX2NvbXBfZGVzY3JpcHRvci4NCj4+Pg0KPj4+IFByb2JsZW0gaGFzIGFwcGVh
cmVkIGR1cmluZyB0ZXN0aW5nIGZfdGNtIChCT1QvVUFTKSBkcml2ZXIgZnVuY3Rpb24uDQo+Pj4N
Cj4+PiBmX3RjbSBmdW5jdGlvbiBmb3IgU1MgdXNlIGFycmF5IG9mIGhlYWRlcnMgZm9yIGJvdGgg
IEJPVC9VQVMgYWx0ZXJuYXRlDQo+Pj4gc2V0dGluZzoNCj4+Pg0KPj4+IHN0YXRpYyBzdHJ1Y3Qg
dXNiX2Rlc2NyaXB0b3JfaGVhZGVyICp1YXNwX3NzX2Z1bmN0aW9uX2Rlc2NbXSA9IHsNCj4+PiAg
ICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF9pbnRmX2Rlc2Ms
DQo+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZib3RfdWFz
cF9zc19iaV9kZXNjLA0KPj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRl
ciAqKSAmYm90X2JpX2VwX2NvbXBfZGVzYywNCj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2JfZGVz
Y3JpcHRvcl9oZWFkZXIgKikgJmJvdF91YXNwX3NzX2JvX2Rlc2MsDQo+Pj4gICAgICAgICAgIChz
dHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZib3RfYm9fZXBfY29tcF9kZXNjLA0KPj4+
DQo+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX2lu
dGZfZGVzYywNCj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikg
JmJvdF91YXNwX3NzX2JpX2Rlc2MsDQo+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0
b3JfaGVhZGVyICopICZ1YXNwX2JpX2VwX2NvbXBfZGVzYywNCj4+PiAgICAgICAgICAgKHN0cnVj
dCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfYmlfcGlwZV9kZXNjLA0KPj4+ICAgICAg
ICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmYm90X3Vhc3Bfc3NfYm9fZGVz
YywNCj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3Bf
Ym9fZXBfY29tcF9kZXNjLA0KPj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hl
YWRlciAqKSAmdWFzcF9ib19waXBlX2Rlc2MsDQo+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rl
c2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX3NzX3N0YXR1c19kZXNjLA0KPj4+ICAgICAgICAgICAo
c3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9zdGF0dXNfaW5fZXBfY29tcF9k
ZXNjLA0KPj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFz
cF9zdGF0dXNfcGlwZV9kZXNjLA0KPj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9y
X2hlYWRlciAqKSAmdWFzcF9zc19jbWRfZGVzYywNCj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2Jf
ZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfY21kX2NvbXBfZGVzYywNCj4+PiAgICAgICAgICAg
KHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfY21kX3BpcGVfZGVzYywNCj4+
PiAgICAgICAgICAgTlVMTCwNCj4+PiB9Ow0KPj4+DQo+Pj4gVGhlIGZpcnN0IDUgZGVzY3JpcHRv
cnMgYXJlIGFzc29jaWF0ZWQgd2l0aCBCT1QgYWx0ZXJuYXRlIHNldHRpbmcsDQo+Pj4gYW5kIG90
aGVycyBhcmUgYXNzb2NpYXRlZCAgd2l0aCBVQVMuDQo+Pj4NCj4+PiBEdXJpbmcgaGFuZGxpbmcg
VUFTIGFsdGVybmF0ZSBzZXR0aW5nIGZfdGNtIGRyaXZyIGludm9rZXMNCj4+PiBjb25maWdfZXBf
Ynlfc3BlZWQgYW5kIHRoaXMgZnVuY3Rpb24gc2V0cyBpbmNvcnJlY3QgY29tcGFuaW9uIGVuZHBv
aW50DQo+Pj4gZGVzY3JpcHRvciBpbiB1c2JfZXAgb2JqZWN0Lg0KPj4+DQo+Pj4gSW5zdGVhZCBz
ZXR0aW5nIGVwLT5jb21wX2Rlc2MgdG8gdWFzcF9iaV9lcF9jb21wX2Rlc2MgZnVuY3Rpb24gaW4g
dGhpcw0KPj4+IGNhc2Ugc2V0IGVwLT5jb21wX2Rlc2MgdG8gYm90X3Vhc3Bfc3NfYmlfZGVzYy4N
Cj4+Pg0KPj4+IFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRoYXQgaXQgc2VhcmNoIGVuZHBvaW50
IGJhc2VkIG9uIGVuZHBvaW50DQo+Pj4gYWRkcmVzczoNCj4+Pg0KPj4+ICAgICAgICAgICBmb3Jf
ZWFjaF9lcF9kZXNjKHNwZWVkX2Rlc2MsIGRfc3BkKSB7DQo+Pj4gICAgICAgICAgICAgICAgICAg
Y2hvc2VuX2Rlc2MgPSAoc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlwdG9yICopKmRfc3BkOw0K
Pj4+ICAgICAgICAgICAgICAgICAgIGlmIChjaG9zZW5fZGVzYy0+YkVuZHBvaXRBZGRyZXNzID09
IF9lcC0+YWRkcmVzcykNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXBfZm91
bmQ7DQo+Pj4gICAgICAgICAgIH0NCj4+Pg0KPj4+IEFuZCBpbiByZXN1bHQgaXQgdXNlcyB0aGUg
ZGVzY3JpcHRvciBmcm9tIEJPVCBhbHRlcm5hdGUgc2V0dGluZw0KPj4+IGluc3RlYWQgVUFTLg0K
Pj4+DQo+Pj4gRmluYWxseSwgaXQgY2F1c2VzIHRoYXQgY29udHJvbGxlciBkcml2ZXIgZHVyaW5n
IGVuYWJsaW5nIGVuZHBvaW50cw0KPj4+IGRldGVjdCB0aGF0IGp1c3QgZW5hYmxlZCBlbmRwb2lu
dCBmb3IgYm90Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSmF5c2hyaSBQYXdhciA8anBhd2Fy
QGNhZGVuY2UuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxA
Y2FkZW5jZS5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0
ZS5jICAgICAgICAgICAgICAgfCA0NiArKysrKysrKysrKysrKy0tLS0tLQ0KPj4+ICAgIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2FjbS5jICAgICAgICAgIHwgIDcgKy0tDQo+Pj4gICAg
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgICAgICAgICAgfCAgNyArLS0NCj4+
PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lZW0uYyAgICAgICAgICB8ICA0ICst
DQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZnMuYyAgICAgICAgICAgfCAg
MyArLQ0KPj4+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2hpZC5jICAgICAgICAg
IHwgIDQgKy0NCj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9sb29wYmFjay5j
ICAgICB8ICAyICstDQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfbWFzc19z
dG9yYWdlLmMgfCAgNSArKy0NCj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9t
aWRpLmMgICAgICAgICB8ICAyICstDQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfbmNtLmMgICAgICAgICAgfCAgNyArLS0NCj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl9vYmV4LmMgICAgICAgICB8ICA0ICstDQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0
L2Z1bmN0aW9uL2ZfcGhvbmV0LmMgICAgICAgfCAgNCArLQ0KPj4+ICAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX3JuZGlzLmMgICAgICAgIHwgIDcgKy0tDQo+Pj4gICAgZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zfc2VyaWFsLmMgICAgICAgfCAgNCArLQ0KPj4+ICAgIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3NvdXJjZXNpbmsuYyAgIHwgMTEgKysrLS0NCj4+PiAg
ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9zdWJzZXQuYyAgICAgICB8ICA0ICstDQo+
Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfdGNtLmMgICAgICAgICAgfCAzNiAr
KysrKysrLS0tLS0tLS0NCj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91YWMx
X2xlZ2FjeS5jICB8ICAyICstDQo+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zf
dXZjLmMgICAgICAgICAgfCAgNSArKy0NCj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9hdWRpby5jICAgICAgICB8ICA0ICstDQo+Pj4gICAgaW5jbHVkZS9saW51eC91c2IvY29t
cG9zaXRlLmggICAgICAgICAgICAgICAgfCAgMiArLQ0KPj4+ICAgIDIxIGZpbGVzIGNoYW5nZWQs
IDk5IGluc2VydGlvbnMoKyksIDcxIGRlbGV0aW9ucygtKQ0KPj4+DQo+PiBJIHRoaW5rIHdlIHNo
b3VsZCBjcmVhdGUgYSBuZXcgZnVuY3Rpb24gYW5kIGtlZXAgdGhlIG9sZA0KPj4gY29uZmlnX2Vw
X2J5X3NwZWVkKCkgZm9yIGRlZmF1bHQgYWx0LXNldHRpbmcgKGUuaS4gaGF2ZQ0KPj4gY29uZmln
X2VwX2J5X3NwZWVkIGNhbGxzIHRoZSBuZXcgZnVuY3Rpb24gd2l0aCBkZWZhdWx0IGFsdC1zZXR0
aW5nIDApLg0KPj4gVGhpcyB3YXksIHdlIGNhbiBrZWVwIGNvbXBhdGliaWxpdHkgd2l0aCBvbGQg
ZnVuY3Rpb24gZHJpdmVycyBhbmQNCj4+IG1pbmltaXplIGNoYW5nZXMuIEF0IGxlYXN0IHRoYXQn
cyB3aGF0IHdlIGRpZC4NCj4+DQo+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGUgc2VwYXJhdGUg
ZnVuY3Rpb24uDQo+IElmIHdlIHNldCBsYXN0IHBhcmFtZXRlciBhbHQ9MCB0aGVuIHRoaXMgZnVu
Y3Rpb24gd2lsbCB3b3JrIGluIHRoZSBzYW1lIHdheSBhcyBvbGQgb25lLg0KPg0KDQpJIHdhc24n
dCB0YWxraW5nIGFib3V0IHRoYXQuIFRoaXMgcGF0Y2ggbW9kaWZpZXMgdGhlIA0KY29uZmlnX2Vw
X2J5X3NwZWVkKCkgcGFyYW1ldGVycywgd2hpY2ggcmVxdWlyZXMgdG8gbWFrZSBhIGNoYW5nZSB0
byANCmV2ZXJ5IGZ1bmN0aW9uIGRyaXZlciBvZiB0aGUga2VybmVsLCBhbmQgYWxsIGluIGEgc2lu
Z2xlIHBhdGNoLiBUaGlzIA0KbWFrZXMgaXQgZGlmZmljdWx0IHRvIGJhY2twb3J0IHRoaXMgZml4
LiBUaGUgb25seSBmdW5jdGlvbiBkcml2ZXIgdGhhdCANCnlvdSByZWFsbHkgbmVlZCB0aGlzIGZp
eCBmb3IgaXMgZl90Y20gYmVjYXVzZSBvZiB0aGUgc3RyZWFtIGVwcyByaWdodD8NCg0KWW91IGNv
dWxkIGp1c3QgYWRkIGEgZnVuY3Rpb24gbGlrZQ0KDQogICAgaW50IGNvbmZpZ19lcF9ieV9zcGVl
ZF9hbmRfYWx0KHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBzdHJ1Y3QNCiAgICB1c2JfZnVuY3Rpb24g
KmYsIHVuc2lnbmVkIGludCBhbHQsIHN0cnVjdCB1c2JfZXAgKl9lcCk7DQoNCg0KVGhlbiByZWRl
ZmluZSBjb25maWdfZXBfYnlfc3BlZWQoKSB0byB1c2UgaXQNCg0KICAgIGludCBjb25maWdfZXBf
Ynlfc3BlZWQoc3RydWN0IHVzYl9nYWRnZXQgKmcsDQogICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLA0KICAgICDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHVzYl9lcCAqX2Vw
KQ0KICAgIHsNCiAgICAgwqDCoMKgwqDCoMKgIHJldHVybiBjb25maWdfZXBfYnlfc3BlZWRfYW5k
X2FsdChnLCBmLCAwLCBfZXApOw0KICAgIH0NCg0KVGhpcyB3YXksIDEpIHlvdSBjYW4gc3BsaXQg
dGhpcyBwYXRjaCwgMikgeW91IG9ubHkgbmVlZCB0byBtYWtlIGEgZml4IHRvIA0KZl90Y20sIDMp
IHRoaXMgZml4IGNhbiBiZSBiYWNrcG9ydGVkIG11Y2ggZWFzaWVyLg0KDQpBbnl3YXlzLCB0aGlz
IGlzIGp1c3QgYSBzdWdnZXN0aW9uLiBJdCdzIHVwIHRvIHRoZSBtYWludGFpbmVycyB0byBkZWNp
ZGUuDQoNCkJSLA0KVGhpbmgNCg0K
