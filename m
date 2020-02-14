Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B5EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A58206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="IIv7Lnv3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Hc9s3Bwp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388976AbgBNTzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:55:17 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20186 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388605AbgBNTzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:55:17 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01EJsfh4015018;
        Fri, 14 Feb 2020 11:55:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=ncg7qV4wQuam1EV/AF/S8Z66ysHhaQPKbbGcBdAnv+c=;
 b=IIv7Lnv3NzBJ3zBjF5eQP9YB0FOQxhevPPG3Z60VbpQO/jQwMEpxYyPQwAYsavnWGr+6
 rwqqtwRaF2EeYPSlNZ/AnM1tkqs2Euq5QEEK+bNHDEFSeP2IFC10iixiBNK2Q4qg8Bsp
 Nxe0w+GceC0VUji1JaCHUYzio8WTEgeizEdjWlsm0KAFXi81hXu9HitOhnobKmBgCOPY
 cb+aGyYLEk2S34i4lfsv8UyE+FMwKSuqVOi73tEJRdKu/aJogIoLxg9w+00qFbak7YyV
 PuwRuvs7Qyncv6SO8fAFPOVXSoHzNJF7VpljzzXTOEYuCM2YOFcfGVj9bSQ9pd2RbL5b 4g== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2y1u181025-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Feb 2020 11:55:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGsjNzSwvwHhPA82VwCQjRfqeBbs2+w+54rp1VsiF6K95/J2mCndECeCOezKXrQjUr9HEPaTmHeSyYhk2uvjx2Wh3eXTAJBODRYq9MrNZwKKcCY4BCUDFYa1vp1ocg1WiNpRwQISXL/UHUzQJk847p6zM6C308dh4Of54r6hRO0PZjYbpXfFnxAneK/IcTKhaY9UVRjKVsctu+WNB0537SsTj5Rp6fIFHcIaKL/D8xLoSJrjc8AV64VMiUXyiUNxltIZnLjo5LXfYCQ1qZTEEFFjSDO8Dbbvdv/n0bc5VKfO3H/bNWLm5boHesNUyv+DPobyJMBoUZMrba9nVbDCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncg7qV4wQuam1EV/AF/S8Z66ysHhaQPKbbGcBdAnv+c=;
 b=bo5ckWXB15qg0lZVGjE1YYnr50zzOtgAAzb5/7dCjUeSFzYTGCEBugM3L4fSsH3oawBtKeKVDMjZ1yADA6jHhobmMM8HSPuP1NshQslbWNr5tEGPzZfhYW2+DPMQkIIuytsJqtSpqg6iuGC7mH/R/GwbrnPqeql603X0w747bnoQK42xF5BxWAOHEJv17GSk8JzobDb0XjZJk87VDf6zn7aLD05sV5BdDlCaTPClnJg28ojkapR1XbkwZs4SdBdaL1s5Ibsfdk8NiW6v18ZCzIDDKQ1iKSTB4lxpGmyCUqwM++puHT3TVRfJpM1JwFIloPn418mW7hPXVdOxbaNhZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncg7qV4wQuam1EV/AF/S8Z66ysHhaQPKbbGcBdAnv+c=;
 b=Hc9s3BwpUpk2eYgg8MCC3WiASIyrRW7GQcy9i/TRcZLN2GKN6dNzcqWT9Hiimm7kIWze8C7+4yRybE1rXM7Yq/0YbZHOiKFLpgNcg4XaCYcEn9lM147NRxaKIpzHgLUKiAND1OQZj+JOSy/ZrXbzkLeF0qt4y+4muEssa4YRMX8=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB6263.namprd07.prod.outlook.com (20.179.89.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 14 Feb 2020 19:55:03 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d9f8:fb5c:51c6:12]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::d9f8:fb5c:51c6:12%5]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 19:55:02 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>
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
Thread-Index: AQHV4Y32UrsTfqs+oUajZ8/oG8wA+agaDcsAgAALDsCAAP1SAIAABCbg
Date:   Fri, 14 Feb 2020 19:55:02 +0000
Message-ID: <BYAPR07MB47093444129A8EEB734F4F2EDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
 <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
 <BYAPR07MB47098648C28E5E4BB9B78DCADD150@BYAPR07MB4709.namprd07.prod.outlook.com>
 <7ef4b9c5-8694-4d8e-2866-95ec11546bec@synopsys.com>
In-Reply-To: <7ef4b9c5-8694-4d8e-2866-95ec11546bec@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctZTA4MDEzYTktNGY2My0xMWVhLTg3NTQtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XGUwODAxM2FhLTRmNjMtMTFlYS04NzU0LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iNjQ5NSIgdD0iMTMyMjYxODM2OTg1NTU2NzY4IiBoPSJPdTgxaG9JYTdqODM2eTlPdFhqYk9ENkllWGM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b7d4872-7fc4-4039-4a93-08d7b187c7df
x-ms-traffictypediagnostic: BYAPR07MB6263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR07MB6263D2590717D8E401D2E38ADD150@BYAPR07MB6263.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(36092001)(199004)(189003)(4326008)(54906003)(55016002)(186003)(33656002)(110136005)(316002)(478600001)(81156014)(9686003)(8676002)(7696005)(86362001)(107886003)(8936002)(81166006)(76116006)(6506007)(52536014)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(7416002)(5660300002)(2906002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6263;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1rGndUURula5mao4sS0o0+AoACoIP9MLUccLXIRwQRSJiuQ9IbneVXZmlKQ2fHr4eaxTBdlLG/wHyW3Ho8UHXoj2F/M1LSoy1WGz5nVkpu/JHYa16bJRToK5qtMjE/zMVgSfCH3546myOWFG3l0uLDvChlFAIdfAy/XiN4pFS2SzMuTLAQE2gMBCkHFjEFU97r/I2nBJLbWOtL9cYYOB9F2cpIcz54FIqfgp5bt4/ZhdsvWNiZ+9ljTITFsQ+Jkcd7twJ2Z5zVHbYOokaWTw1bfQ1uW5+bSmFYYnsbnxRJwtTXpofDxaQzfqPgeF2L7qsk5GKOItpG/mY7Crw7QpCliEUX1LDu2gbo0jLZU9P9BpBYrplUZxeZzsJxXCkRYrzPNnHK/Fbf4FxnjctWCXBDOdKVjkn1xaHW1NnNXMBqVYXx9/QP137QQkoJ2WFoRlfe7cZjIb3Tp6uL749VUdieTviER0oILna5L57KiCjydAge3aYtD3CdP93uUXHdZ
x-ms-exchange-antispam-messagedata: 98Vz/z7olBw1zgjaGcL6WlXC3x7yp5BDELrvsZ2I6NlF3KN0QhBymvEim9Q5RU3vb1O6lMB/I/7TQAHPUonCFI9fquVU8p/5v1XqiDpAYYf5LO51A+ZPSAJkkFDJfSF6lffNfUaRN3GAJUMI1Pmjgw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7d4872-7fc4-4039-4a93-08d7b187c7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 19:55:02.5696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hc9xpiCbVjwAQQ4Zxvhn99PIXxcIHuGwAdsiF0DBGH2p1U6iI03wG5XR1udYTwre+0Db1xwWQfv5fv13PKUuaLxq3m6GxJ4S28f1jF7g0XE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6263
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-14_07:2020-02-14,2020-02-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002140144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPlBhd2VsIExhc3pjemFrIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4+IEhpLA0KPj4+DQo+Pj4g
SmF5c2hyaSBQYXdhciB3cm90ZToNCj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGFkZGl0aW9uYWwgcGFy
YW1ldGVyIGFsdCB0byBjb25maWdfZXBfYnlfc3BlZWQgZnVuY3Rpb24uDQo+Pj4+IFRoaXMgYWRk
aXRpb25hbCBwYXJhbWV0ZXIgYWxsb3dzIHRvIGltcHJvdmUgdGhpcyBmdW5jdGlvbiBhbmQNCj4+
Pj4gZmluZCBwcm9wZXIgdXNiX3NzX2VwX2NvbXBfZGVzY3JpcHRvci4NCj4+Pj4NCj4+Pj4gUHJv
YmxlbSBoYXMgYXBwZWFyZWQgZHVyaW5nIHRlc3RpbmcgZl90Y20gKEJPVC9VQVMpIGRyaXZlciBm
dW5jdGlvbi4NCj4+Pj4NCj4+Pj4gZl90Y20gZnVuY3Rpb24gZm9yIFNTIHVzZSBhcnJheSBvZiBo
ZWFkZXJzIGZvciBib3RoICBCT1QvVUFTIGFsdGVybmF0ZQ0KPj4+PiBzZXR0aW5nOg0KPj4+Pg0K
Pj4+PiBzdGF0aWMgc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqdWFzcF9zc19mdW5jdGlv
bl9kZXNjW10gPSB7DQo+Pj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRl
ciAqKSAmYm90X2ludGZfZGVzYywNCj4+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0
b3JfaGVhZGVyICopICZib3RfdWFzcF9zc19iaV9kZXNjLA0KPj4+PiAgICAgICAgICAgKHN0cnVj
dCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF9iaV9lcF9jb21wX2Rlc2MsDQo+Pj4+ICAg
ICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmYm90X3Vhc3Bfc3NfYm9f
ZGVzYywNCj4+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZi
b3RfYm9fZXBfY29tcF9kZXNjLA0KPj4+Pg0KPj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2JfZGVz
Y3JpcHRvcl9oZWFkZXIgKikgJnVhc3BfaW50Zl9kZXNjLA0KPj4+PiAgICAgICAgICAgKHN0cnVj
dCB1c2JfZGVzY3JpcHRvcl9oZWFkZXIgKikgJmJvdF91YXNwX3NzX2JpX2Rlc2MsDQo+Pj4+ICAg
ICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9iaV9lcF9jb21w
X2Rlc2MsDQo+Pj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAm
dWFzcF9iaV9waXBlX2Rlc2MsDQo+Pj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9y
X2hlYWRlciAqKSAmYm90X3Vhc3Bfc3NfYm9fZGVzYywNCj4+Pj4gICAgICAgICAgIChzdHJ1Y3Qg
dXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX2JvX2VwX2NvbXBfZGVzYywNCj4+Pj4gICAg
ICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX2JvX3BpcGVfZGVz
YywNCj4+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNw
X3NzX3N0YXR1c19kZXNjLA0KPj4+PiAgICAgICAgICAgKHN0cnVjdCB1c2JfZGVzY3JpcHRvcl9o
ZWFkZXIgKikgJnVhc3Bfc3RhdHVzX2luX2VwX2NvbXBfZGVzYywNCj4+Pj4gICAgICAgICAgIChz
dHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICopICZ1YXNwX3N0YXR1c19waXBlX2Rlc2MsDQo+
Pj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlwdG9yX2hlYWRlciAqKSAmdWFzcF9zc19j
bWRfZGVzYywNCj4+Pj4gICAgICAgICAgIChzdHJ1Y3QgdXNiX2Rlc2NyaXB0b3JfaGVhZGVyICop
ICZ1YXNwX2NtZF9jb21wX2Rlc2MsDQo+Pj4+ICAgICAgICAgICAoc3RydWN0IHVzYl9kZXNjcmlw
dG9yX2hlYWRlciAqKSAmdWFzcF9jbWRfcGlwZV9kZXNjLA0KPj4+PiAgICAgICAgICAgTlVMTCwN
Cj4+Pj4gfTsNCj4+Pj4NCj4+Pj4gVGhlIGZpcnN0IDUgZGVzY3JpcHRvcnMgYXJlIGFzc29jaWF0
ZWQgd2l0aCBCT1QgYWx0ZXJuYXRlIHNldHRpbmcsDQo+Pj4+IGFuZCBvdGhlcnMgYXJlIGFzc29j
aWF0ZWQgIHdpdGggVUFTLg0KPj4+Pg0KPj4+PiBEdXJpbmcgaGFuZGxpbmcgVUFTIGFsdGVybmF0
ZSBzZXR0aW5nIGZfdGNtIGRyaXZyIGludm9rZXMNCj4+Pj4gY29uZmlnX2VwX2J5X3NwZWVkIGFu
ZCB0aGlzIGZ1bmN0aW9uIHNldHMgaW5jb3JyZWN0IGNvbXBhbmlvbiBlbmRwb2ludA0KPj4+PiBk
ZXNjcmlwdG9yIGluIHVzYl9lcCBvYmplY3QuDQo+Pj4+DQo+Pj4+IEluc3RlYWQgc2V0dGluZyBl
cC0+Y29tcF9kZXNjIHRvIHVhc3BfYmlfZXBfY29tcF9kZXNjIGZ1bmN0aW9uIGluIHRoaXMNCj4+
Pj4gY2FzZSBzZXQgZXAtPmNvbXBfZGVzYyB0byBib3RfdWFzcF9zc19iaV9kZXNjLg0KPj4+Pg0K
Pj4+PiBUaGlzIGlzIGR1ZSB0byB0aGUgZmFjdCB0aGF0IGl0IHNlYXJjaCBlbmRwb2ludCBiYXNl
ZCBvbiBlbmRwb2ludA0KPj4+PiBhZGRyZXNzOg0KPj4+Pg0KPj4+PiAgICAgICAgICAgZm9yX2Vh
Y2hfZXBfZGVzYyhzcGVlZF9kZXNjLCBkX3NwZCkgew0KPj4+PiAgICAgICAgICAgICAgICAgICBj
aG9zZW5fZGVzYyA9IChzdHJ1Y3QgdXNiX2VuZHBvaW50X2Rlc2NyaXB0b3IgKikqZF9zcGQ7DQo+
Pj4+ICAgICAgICAgICAgICAgICAgIGlmIChjaG9zZW5fZGVzYy0+YkVuZHBvaXRBZGRyZXNzID09
IF9lcC0+YWRkcmVzcykNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVwX2Zv
dW5kOw0KPj4+PiAgICAgICAgICAgfQ0KPj4+Pg0KPj4+PiBBbmQgaW4gcmVzdWx0IGl0IHVzZXMg
dGhlIGRlc2NyaXB0b3IgZnJvbSBCT1QgYWx0ZXJuYXRlIHNldHRpbmcNCj4+Pj4gaW5zdGVhZCBV
QVMuDQo+Pj4+DQo+Pj4+IEZpbmFsbHksIGl0IGNhdXNlcyB0aGF0IGNvbnRyb2xsZXIgZHJpdmVy
IGR1cmluZyBlbmFibGluZyBlbmRwb2ludHMNCj4+Pj4gZGV0ZWN0IHRoYXQganVzdCBlbmFibGVk
IGVuZHBvaW50IGZvciBib3QuDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEpheXNocmkgUGF3
YXIgPGpwYXdhckBjYWRlbmNlLmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6
YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGRyaXZlcnMvdXNiL2dh
ZGdldC9jb21wb3NpdGUuYyAgICAgICAgICAgICAgIHwgNDYgKysrKysrKysrKysrKystLS0tLS0N
Cj4+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfYWNtLmMgICAgICAgICAgfCAg
NyArLS0NCj4+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWNtLmMgICAgICAg
ICAgfCAgNyArLS0NCj4+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfZWVtLmMg
ICAgICAgICAgfCAgNCArLQ0KPj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9m
cy5jICAgICAgICAgICB8ICAzICstDQo+Pj4+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlv
bi9mX2hpZC5jICAgICAgICAgIHwgIDQgKy0NCj4+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1
bmN0aW9uL2ZfbG9vcGJhY2suYyAgICAgfCAgMiArLQ0KPj4+PiAgICBkcml2ZXJzL3VzYi9nYWRn
ZXQvZnVuY3Rpb24vZl9tYXNzX3N0b3JhZ2UuYyB8ICA1ICsrLQ0KPj4+PiAgICBkcml2ZXJzL3Vz
Yi9nYWRnZXQvZnVuY3Rpb24vZl9taWRpLmMgICAgICAgICB8ICAyICstDQo+Pj4+ICAgIGRyaXZl
cnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX25jbS5jICAgICAgICAgIHwgIDcgKy0tDQo+Pj4+ICAg
IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX29iZXguYyAgICAgICAgIHwgIDQgKy0NCj4+
Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL2ZfcGhvbmV0LmMgICAgICAgfCAgNCAr
LQ0KPj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9ybmRpcy5jICAgICAgICB8
ICA3ICstLQ0KPj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl9zZXJpYWwuYyAg
ICAgICB8ICA0ICstDQo+Pj4+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3NvdXJj
ZXNpbmsuYyAgIHwgMTEgKysrLS0NCj4+Pj4gICAgZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2Zfc3Vic2V0LmMgICAgICAgfCAgNCArLQ0KPj4+PiAgICBkcml2ZXJzL3VzYi9nYWRnZXQvZnVu
Y3Rpb24vZl90Y20uYyAgICAgICAgICB8IDM2ICsrKysrKystLS0tLS0tLQ0KPj4+PiAgICBkcml2
ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91YWMxX2xlZ2FjeS5jICB8ICAyICstDQo+Pj4+ICAg
IGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jICAgICAgICAgIHwgIDUgKystDQo+
Pj4+ICAgIGRyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2F1ZGlvLmMgICAgICAgIHwgIDQg
Ky0NCj4+Pj4gICAgaW5jbHVkZS9saW51eC91c2IvY29tcG9zaXRlLmggICAgICAgICAgICAgICAg
fCAgMiArLQ0KPj4+PiAgICAyMSBmaWxlcyBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspLCA3MSBk
ZWxldGlvbnMoLSkNCj4+Pj4NCj4+PiBJIHRoaW5rIHdlIHNob3VsZCBjcmVhdGUgYSBuZXcgZnVu
Y3Rpb24gYW5kIGtlZXAgdGhlIG9sZA0KPj4+IGNvbmZpZ19lcF9ieV9zcGVlZCgpIGZvciBkZWZh
dWx0IGFsdC1zZXR0aW5nIChlLmkuIGhhdmUNCj4+PiBjb25maWdfZXBfYnlfc3BlZWQgY2FsbHMg
dGhlIG5ldyBmdW5jdGlvbiB3aXRoIGRlZmF1bHQgYWx0LXNldHRpbmcgMCkuDQo+Pj4gVGhpcyB3
YXksIHdlIGNhbiBrZWVwIGNvbXBhdGliaWxpdHkgd2l0aCBvbGQgZnVuY3Rpb24gZHJpdmVycyBh
bmQNCj4+PiBtaW5pbWl6ZSBjaGFuZ2VzLiBBdCBsZWFzdCB0aGF0J3Mgd2hhdCB3ZSBkaWQuDQo+
Pj4NCj4+IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCB0aGUgc2VwYXJhdGUgZnVuY3Rpb24uDQo+PiBJ
ZiB3ZSBzZXQgbGFzdCBwYXJhbWV0ZXIgYWx0PTAgdGhlbiB0aGlzIGZ1bmN0aW9uIHdpbGwgd29y
ayBpbiB0aGUgc2FtZSB3YXkgYXMgb2xkIG9uZS4NCj4+DQo+DQo+SSB3YXNuJ3QgdGFsa2luZyBh
Ym91dCB0aGF0LiBUaGlzIHBhdGNoIG1vZGlmaWVzIHRoZQ0KPmNvbmZpZ19lcF9ieV9zcGVlZCgp
IHBhcmFtZXRlcnMsIHdoaWNoIHJlcXVpcmVzIHRvIG1ha2UgYSBjaGFuZ2UgdG8NCj5ldmVyeSBm
dW5jdGlvbiBkcml2ZXIgb2YgdGhlIGtlcm5lbCwgYW5kIGFsbCBpbiBhIHNpbmdsZSBwYXRjaC4g
VGhpcw0KPm1ha2VzIGl0IGRpZmZpY3VsdCB0byBiYWNrcG9ydCB0aGlzIGZpeC4gVGhlIG9ubHkg
ZnVuY3Rpb24gZHJpdmVyIHRoYXQNCj55b3UgcmVhbGx5IG5lZWQgdGhpcyBmaXggZm9yIGlzIGZf
dGNtIGJlY2F1c2Ugb2YgdGhlIHN0cmVhbSBlcHMgcmlnaHQ/DQo+DQo+WW91IGNvdWxkIGp1c3Qg
YWRkIGEgZnVuY3Rpb24gbGlrZQ0KPg0KPiAgICBpbnQgY29uZmlnX2VwX2J5X3NwZWVkX2FuZF9h
bHQoc3RydWN0IHVzYl9nYWRnZXQgKmcsIHN0cnVjdA0KPiAgICB1c2JfZnVuY3Rpb24gKmYsIHVu
c2lnbmVkIGludCBhbHQsIHN0cnVjdCB1c2JfZXAgKl9lcCk7DQo+DQo+DQo+VGhlbiByZWRlZmlu
ZSBjb25maWdfZXBfYnlfc3BlZWQoKSB0byB1c2UgaXQNCj4NCj4gICAgaW50IGNvbmZpZ19lcF9i
eV9zcGVlZChzdHJ1Y3QgdXNiX2dhZGdldCAqZywNCj4gICAgIMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdXNiX2Z1bmN0aW9uICpmLA0KPiAgICAgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB1c2JfZXAgKl9l
cCkNCj4gICAgew0KPiAgICAgwqDCoMKgwqDCoMKgIHJldHVybiBjb25maWdfZXBfYnlfc3BlZWRf
YW5kX2FsdChnLCBmLCAwLCBfZXApOw0KPiAgICB9DQo+DQo+VGhpcyB3YXksIDEpIHlvdSBjYW4g
c3BsaXQgdGhpcyBwYXRjaCwgMikgeW91IG9ubHkgbmVlZCB0byBtYWtlIGEgZml4IHRvDQo+Zl90
Y20sIDMpIHRoaXMgZml4IGNhbiBiZSBiYWNrcG9ydGVkIG11Y2ggZWFzaWVyLg0KPg0KPkFueXdh
eXMsIHRoaXMgaXMganVzdCBhIHN1Z2dlc3Rpb24uIEl0J3MgdXAgdG8gdGhlIG1haW50YWluZXJz
IHRvIGRlY2lkZS4NCg0KVGhhbmtzIGZvciBjbGFyaWZpY2F0aW9uLCBub3cgSSBnb3QgaXQuIElu
IG15IG9waW5pb24sIGJvdGggc29sdXRpb24gaGFzIHByb3MgYW5kIGNvbnMNCjEuIE9yaWdpbmFs
IHBhdGNoLiANCmNvbnM6IGludHJvZHVjZSBtYW55IGNoYW5nZSBpbiBtYW55IGZpbGVzDQpwcm9z
OiAgd2UgaGF2ZSBvbmx5IHNpbmdsZSBBUEkgZnVuY3Rpb24gLSBzaW1wbGVyIEdhZGdldCBTdWJz
eXN0ZW0gQVBJIA0KDQoyLiB1c2luZyBjb25maWdfZXBfYnlfc3BlZWRfYW5kX2FsdA0KY29uczog
bWluaW1hbCBpbXBhY3QgdG8gb3RoZXIgZmlsZXMuIA0KcHJvczogaW50cm9kdWNlIHRoZSBuZXcg
QVBJIGZ1bmN0aW9uIHdoaWNoIGluIGZhY3QgY291bGQgYmUgIG9taXR0ZWQuIA0KDQpJdCdzIG9u
bHkgbXkgcGVyc29uYWwgb3BpbmlvbiA6KSAuIA0KDQpGZWxpcGUgYW5kIEdyZWcgd2hhdCBpcyB5
b3Ugb3BpbmlvbiA/DQoNCkJlc3QgUmVnYXJkcywNClBhd2VsDQoNCj4NCj5CUiwNCj5UaGluaA0K
DQo=
