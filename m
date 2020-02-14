Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9AFC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E4D2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 04:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XesXGEQv";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ko/rkeFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgBNE1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 23:27:07 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:41296 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728369AbgBNE1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 23:27:06 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01E4Q9SQ014791;
        Thu, 13 Feb 2020 20:26:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=FihNh9ZqPWicxJRxOn9Lr+59Z43RuyTiw82Zzhs1C+U=;
 b=XesXGEQv5/zr/LSUrUMMsi5Ct/9VoHlU0Y90jgQWvwdSVVXFQMq+tRKLv65M+8HXeKGl
 c2Y+5RZx9zEqi/lMPMTJgVdtYu3yHAMMWIMbLdwqksHc+RRqjH6or8q3gluF+eh0UlB6
 oBLGj1tiwJZx04pmGL74vuvkhIpRrOT4w3REfgsZUyTQ/F60AdcEczUo08DDlCCVqxiT
 JKQEHJ0hHJXd6HmNV8FA+PHLwMXHPuS3VNqJKxR65rhm/1As+4DkbCz7Yg7zL7KaMWhq
 PRY8xI74U3bwOuZzoKgbOD/sUI3qKFjVOjdc+Jw5MAkEYpOD1FtlREXJ349GW8vPW94/ AA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2y1u17x3g5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Feb 2020 20:26:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzhcAaQq2UzUuVDpFRrzSt3VSUT4VbU+0pUYmFlzhJRuVzQhHpPc8+qRY46M5URlbef3EWMACe8bOkarTwUkvvnJKZ5sxGKEpM/ynXSI/gGhpCsGPY530HMdJqVZMJaeDBHW3mOmOpTbc1XHztlRP41zRo2MGfgy0NrW9IkTvPWjOUakzXN1IJMEaP+xRt0hra8YlX7LCBHCyqGj/kK6hdSwyY+1TfzXW0El/V0qQEWLIBjZElk3WDsEwFRCF+vc6o6tYRDIm+qE4At0iIav+ZbNDIY5xeFUX9973kOBjr7sfe7PqIo5u4YPQqpbEH4Sw8EUL42bHBodEr1O/OYtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FihNh9ZqPWicxJRxOn9Lr+59Z43RuyTiw82Zzhs1C+U=;
 b=bwITL61k7n7KyoVFQajG1QsmTab6aDIkdUUYueoeUl5NI1Yb+DFEQwkRC5PqdffsdZ1pQKyCz5+GbN4IR2ZKXRiLbiS35G6t7k0HTv+09/TaLUMLjxUaNtuGEsghn/ijwIkmvBv58d5C/OM+tTF1Wb2e4MKIxWSdeloyJFiSFHxKdFWDcEC05qVjGPq4zW7vtcC+agQ58EFEinVX/dUrNv02w/5DyzqiN9fMpzjEjFuqr1lStDbPM+aa9C9H6oytOxTKqJ/dUngX6BXS6hKHRW4rL0QWwlNPo+saJw4uUIYIO9PBVs3P0Hp75rLd4pSi8IFJ4TqvV+jWeATv5vbDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FihNh9ZqPWicxJRxOn9Lr+59Z43RuyTiw82Zzhs1C+U=;
 b=Ko/rkeFHkE0UEAnSbJUpL5sZf6hQ+oXfZRWsC7xWPl5SPRW+P2Ojl6gNZmzRwV9IPIKbQnud+YJieO/hjm4eOD06HY6TRX6V22eMWotXG8NbTmYpdtf9o2e7h/EgQn5abVYyRzsAd6MKMLJnCmWSJFzIEcc5jv6GOPHFboRrRIY=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6359.namprd07.prod.outlook.com (20.179.88.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 04:26:51 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d9f8:fb5c:51c6:12]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d9f8:fb5c:51c6:12%5]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 04:26:51 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
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
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
Subject: RE: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Topic: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
Thread-Index: AQHV4Y32UrsTfqs+oUajZ8/oG8wA+agaDcsAgAALDsA=
Date:   Fri, 14 Feb 2020 04:26:51 +0000
Message-ID: <BYAPR07MB47098648C28E5E4BB9B78DCADD150@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
 <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
In-Reply-To: <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZmY1MTcyYWEtNGVlMS0xMWVhLTg3NTQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGZmNTE3MmFjLTRlZTEtMTFlYS04NzU0LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNDc0MiIgdD0iMTMyMjYxMjc5MTU2NTU1NTg2IiBoPSJjVVZTNVFQNWFMRTc2Rzc0RmM4K3lLWVhlVlk9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4add9654-58fc-4041-d774-08d7b1061d1e
x-ms-traffictypediagnostic: BYAPR07MB6359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB6359C86CB8E4244652AE77A6DD150@BYAPR07MB6359.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(189003)(199004)(36092001)(110136005)(71200400001)(54906003)(498600001)(8676002)(107886003)(52536014)(5660300002)(33656002)(81166006)(81156014)(55016002)(9686003)(4326008)(7416002)(66946007)(8936002)(26005)(76116006)(66476007)(2906002)(186003)(64756008)(6506007)(66446008)(66556008)(7696005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6359;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X1OCwMkTDiEXW1H/gWXN6kPiVWMYWfoum5yimjYYiR7UUOKoEzrUMb8pPHj7fqCjMwjHUHQbSfTZsUS6TyIp1TKOkhTTT29fITBHIvF9fQtN+a9Bpsn4fTKsONLqf2NIGp6sD1XKmUYTucy5GWZws5OpMQc6Hh5/T5n9GQCUilZSLrwLNi3w/AezJpNBGFp+H4ZM82Q8NcZfgLhTSh2vszVlIs08/NeeyYcNJ4Dw2l8vtFbdIRd0kctMaXMd6YxDhOSKV0V1cH0th2TukSV1S5tnkmM1VTmK+G3Gf+gigKhfJQel/Qfvn1jv97SzK+ZRcppX/mCwzVhuzcHTsVRih4G/r1sPKNU/YzGFHEndBQym2m6Ha8q41nr2ohMP3cX2UUVfZ+NZ7hpSrS5hH8JeS/9z76+nY22ZjjoGTqEu8WytayPYvt8baNyDqil2rvF2GvXqSLml6MxlUhGEvG+pdYXRLqNggQzfEvTURtCsDDjoFxGvlmkZ17Dhu+v7j3VB
x-ms-exchange-antispam-messagedata: fhgw8woltKvyDcfUwfnZVXYmM6eZGdPVsS+2U3do3b2EK9p95Sox4zJNbBGsh6V/lWKkWLZGhhcr4upGB9wcwf5Iw3I9TaVa9eSK62GHbrOP1RRPYYfgspAgLmpSyAYxoz24xxJI41RNtgvNW8lp6Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4add9654-58fc-4041-d774-08d7b1061d1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 04:26:51.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zWpSqFOwTAzZv5DP5lQAENR4KHPar1a+xRn7W5GGTgaSpSWqXvLHG52U9sp3GHuSBRAX6lGFyCxSQ08Ie/m8WvmQXdq4LfKaJZ1qAS8Cmxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6359
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_10:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=861 clxscore=1011 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002140034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCj5IaSwNCj4NCj5KYXlzaHJpIFBhd2FyIHdyb3RlOg0KPj4gVGhpcyBwYXRjaCBhZGRz
IGFkZGl0aW9uYWwgcGFyYW1ldGVyIGFsdCB0byBjb25maWdfZXBfYnlfc3BlZWQgZnVuY3Rpb24u
DQo+PiBUaGlzIGFkZGl0aW9uYWwgcGFyYW1ldGVyIGFsbG93cyB0byBpbXByb3ZlIHRoaXMgZnVu
Y3Rpb24gYW5kDQo+PiBmaW5kIHByb3BlciB1c2Jfc3NfZXBfY29tcF9kZXNjcmlwdG9yLg0KPj4N
Cj4+IFByb2JsZW0gaGFzIGFwcGVhcmVkIGR1cmluZyB0ZXN0aW5nIGZfdGNtIChCT1QvVUFTKSBk
cml2ZXIgZnVuY3Rpb24uDQo+Pg0KPj4gZl90Y20gZnVuY3Rpb24gZm9yIFNTIHVzZSBhcnJheSBv
ZiBoZWFkZXJzIGZvciBib3RoICBCT1QvVUFTIGFsdGVybmF0ZQ0KPj4gc2V0dGluZzoNCj4+DQo+
PiBzdGF0aWMgc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqdWFzcF9zc19mdW5jdGlvbl9k
ZXNjW10gPSB7DQo+PiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAm
Ym90X2ludGZfZGVzYywNCj4+ICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVy
ICopICZib3RfdWFzcF9zc19iaV9kZXNjLA0KPj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3Jp
cHRvcl9oZWFkZXIgKikgJmJvdF9iaV9lcF9jb21wX2Rlc2MsDQo+PiAgICAgICAgICAoc3RydWN0
IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmYm90X3Vhc3Bfc3NfYm9fZGVzYywNCj4+ICAgICAg
ICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZib3RfYm9fZXBfY29tcF9kZXNj
LA0KPj4NCj4+ICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNw
X2ludGZfZGVzYywNCj4+ICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICop
ICZib3RfdWFzcF9zc19iaV9kZXNjLA0KPj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRv
cl9oZWFkZXIgKikgJnVhc3BfYmlfZXBfY29tcF9kZXNjLA0KPj4gICAgICAgICAgKHN0cnVjdCB1
c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfYmlfcGlwZV9kZXNjLA0KPj4gICAgICAgICAg
KHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF91YXNwX3NzX2JvX2Rlc2MsDQo+
PiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9ib19lcF9j
b21wX2Rlc2MsDQo+PiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAm
dWFzcF9ib19waXBlX2Rlc2MsDQo+PiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hl
YWRlciAqKSAmdWFzcF9zc19zdGF0dXNfZGVzYywNCj4+ICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rl
c2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX3N0YXR1c19pbl9lcF9jb21wX2Rlc2MsDQo+PiAgICAg
ICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9zdGF0dXNfcGlwZV9k
ZXNjLA0KPj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJnVhc3Bf
c3NfY21kX2Rlc2MsDQo+PiAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAq
KSAmdWFzcF9jbWRfY29tcF9kZXNjLA0KPj4gICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRv
cl9oZWFkZXIgKikgJnVhc3BfY21kX3BpcGVfZGVzYywNCj4+ICAgICAgICAgIE5VTEwsDQo+PiB9
Ow0KPj4NCj4+IFRoZSBmaXJzdCA1IGRlc2NyaXB0b3JzIGFyZSBhc3NvY2lhdGVkIHdpdGggQk9U
IGFsdGVybmF0ZSBzZXR0aW5nLA0KPj4gYW5kIG90aGVycyBhcmUgYXNzb2NpYXRlZCAgd2l0aCBV
QVMuDQo+Pg0KPj4gRHVyaW5nIGhhbmRsaW5nIFVBUyBhbHRlcm5hdGUgc2V0dGluZyBmX3RjbSBk
cml2ciBpbnZva2VzDQo+PiBjb25maWdfZXBfYnlfc3BlZWQgYW5kIHRoaXMgZnVuY3Rpb24gc2V0
cyBpbmNvcnJlY3QgY29tcGFuaW9uIGVuZHBvaW50DQo+PiBkZXNjcmlwdG9yIGluIHVzYl9lcCBv
YmplY3QuDQo+Pg0KPj4gSW5zdGVhZCBzZXR0aW5nIGVwLT5jb21wX2Rlc2MgdG8gdWFzcF9iaV9l
cF9jb21wX2Rlc2MgZnVuY3Rpb24gaW4gdGhpcw0KPj4gY2FzZSBzZXQgZXAtPmNvbXBfZGVzYyB0
byBib3RfdWFzcF9zc19iaV9kZXNjLg0KPj4NCj4+IFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRo
YXQgaXQgc2VhcmNoIGVuZHBvaW50IGJhc2VkIG9uIGVuZHBvaW50DQo+PiBhZGRyZXNzOg0KPj4N
Cj4+ICAgICAgICAgIGZvcl9lYWNoX2VwX2Rlc2Moc3BlZWRfZGVzYywgZF9zcGQpIHsNCj4+ICAg
ICAgICAgICAgICAgICAgY2hvc2VuX2Rlc2MgPSAoc3RydWN0IHVzYl9lbmRwb2ludF9kZXNjcmlw
dG9yICopKmRfc3BkOw0KPj4gICAgICAgICAgICAgICAgICBpZiAoY2hvc2VuX2Rlc2MtPmJFbmRw
b2l0QWRkcmVzcyA9PSBfZXAtPmFkZHJlc3MpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBlcF9mb3VuZDsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiBBbmQgaW4gcmVzdWx0IGl0IHVz
ZXMgdGhlIGRlc2NyaXB0b3IgZnJvbSBCT1QgYWx0ZXJuYXRlIHNldHRpbmcNCj4+IGluc3RlYWQg
VUFTLg0KPj4NCj4+IEZpbmFsbHksIGl0IGNhdXNlcyB0aGF0IGNvbnRyb2xsZXIgZHJpdmVyIGR1
cmluZyBlbmFibGluZyBlbmRwb2ludHMNCj4+IGRldGVjdCB0aGF0IGp1c3QgZW5hYmxlZCBlbmRw
b2ludCBmb3IgYm90Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpheXNocmkgUGF3YXIgPGpwYXdh
ckBjYWRlbmNlLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFBhd2VsIExhc3pjemFrIDxwYXdlbGxA
Y2FkZW5jZS5jb20+DQo+PiAtLS0NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2NvbXBvc2l0ZS5j
ICAgICAgICAgICAgICAgfCA0NiArKysrKysrKysrKysrKy0tLS0tLQ0KPj4gICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl9hY20uYyAgICAgICAgICB8ICA3ICstLQ0KPj4gICBkcml2ZXJz
L3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lY20uYyAgICAgICAgICB8ICA3ICstLQ0KPj4gICBkcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9lZW0uYyAgICAgICAgICB8ICA0ICstDQo+PiAgIGRy
aXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX2ZzLmMgICAgICAgICAgIHwgIDMgKy0NCj4+ICAg
ZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfaGlkLmMgICAgICAgICAgfCAgNCArLQ0KPj4g
ICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9sb29wYmFjay5jICAgICB8ICAyICstDQo+
PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX21hc3Nfc3RvcmFnZS5jIHwgIDUgKyst
DQo+PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX21pZGkuYyAgICAgICAgIHwgIDIg
Ky0NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfbmNtLmMgICAgICAgICAgfCAg
NyArLS0NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zfb2JleC5jICAgICAgICAg
fCAgNCArLQ0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9waG9uZXQuYyAgICAg
ICB8ICA0ICstDQo+PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3JuZGlzLmMgICAg
ICAgIHwgIDcgKy0tDQo+PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3NlcmlhbC5j
ICAgICAgIHwgIDQgKy0NCj4+ICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2Zfc291cmNl
c2luay5jICAgfCAxMSArKystLQ0KPj4gICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9z
dWJzZXQuYyAgICAgICB8ICA0ICstDQo+PiAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9m
X3RjbS5jICAgICAgICAgIHwgMzYgKysrKysrKy0tLS0tLS0tDQo+PiAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9mdW5jdGlvbi9mX3VhYzFfbGVnYWN5LmMgIHwgIDIgKy0NCj4+ICAgZHJpdmVycy91c2Iv
Z2FkZ2V0L2Z1bmN0aW9uL2ZfdXZjLmMgICAgICAgICAgfCAgNSArKy0NCj4+ICAgZHJpdmVycy91
c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfYXVkaW8uYyAgICAgICAgfCAgNCArLQ0KPj4gICBpbmNsdWRl
L2xpbnV4L3VzYi9jb21wb3NpdGUuaCAgICAgICAgICAgICAgICB8ICAyICstDQo+PiAgIDIxIGZp
bGVzIGNoYW5nZWQsIDk5IGluc2VydGlvbnMoKyksIDcxIGRlbGV0aW9ucygtKQ0KPj4NCj4NCj5J
IHRoaW5rIHdlIHNob3VsZCBjcmVhdGUgYSBuZXcgZnVuY3Rpb24gYW5kIGtlZXAgdGhlIG9sZA0K
PmNvbmZpZ19lcF9ieV9zcGVlZCgpIGZvciBkZWZhdWx0IGFsdC1zZXR0aW5nIChlLmkuIGhhdmUN
Cj5jb25maWdfZXBfYnlfc3BlZWQgY2FsbHMgdGhlIG5ldyBmdW5jdGlvbiB3aXRoIGRlZmF1bHQg
YWx0LXNldHRpbmcgMCkuDQo+VGhpcyB3YXksIHdlIGNhbiBrZWVwIGNvbXBhdGliaWxpdHkgd2l0
aCBvbGQgZnVuY3Rpb24gZHJpdmVycyBhbmQNCj5taW5pbWl6ZSBjaGFuZ2VzLiBBdCBsZWFzdCB0
aGF0J3Mgd2hhdCB3ZSBkaWQuDQo+DQoNCkkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGUgc2VwYXJh
dGUgZnVuY3Rpb24uIA0KSWYgd2Ugc2V0IGxhc3QgcGFyYW1ldGVyIGFsdD0wIHRoZW4gdGhpcyBm
dW5jdGlvbiB3aWxsIHdvcmsgaW4gdGhlIHNhbWUgd2F5IGFzIG9sZCBvbmUuDQoNClJlZ2FyZHMs
DQpQYXdlbA0KDQo+QlIsDQo+VGhpbmgNCg==
