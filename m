Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071DD2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=designlinxhs.onmicrosoft.com header.i=@designlinxhs.onmicrosoft.com header.b="drT8tqoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgHTVRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:17:52 -0400
Received: from mail-dm6nam10on2094.outbound.protection.outlook.com ([40.107.93.94]:26535
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726781AbgHTVRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:17:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8uPmNXfKbB13E6yD9JawgdvfzGMgs/moQSN0J9VKHS8piDUS/i3uYr+FtsvvhQmy6ybdnQnmpDyqdLsFOQKai5WfY8D6BsUiZyYrPmZT9KV1q0Pa4OX76CRnvURAq9E3jEfon8jlfJqxRqp5Gdebq60Gf2nbMqSagcQL1pyrQizCc4yKz9f/geErBio+xormRvowdgxoF8ef2lrS9yRHPcTUSoh93mscBCJCPYy+uwE2JKdMpdzf2XYJp6Y8YdQw6p+Go3SE1M4FboikUPkneg1hXTSOxTm8vCQICP27M+y2ClgrgYo7517nzfuTOzbcBu0oZ7ZMkMWHEwqrZkkZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqN+mbbQipXMazByDPmrBQ/Z+uxRLOMU5aLZtrjLgLE=;
 b=UpSZbt77Q8by/5Q+dpCR0JfZqRqf9RxyXVs8xAOMiSfu2fsCGLhfl3HZYwYSWoEKLPd1taVAMdH8Se0b0SxphvwR/xryCxK3AtnRPGt5xMxUU1XNJshHHq9HV0T9uz+S3z3nETQclS5biJYcEsA2F0fg59KPANXz50KZ2uQ3pOP2PoPd1CUAw4AX5TcUE3FbGPSu6XJa8LJyCdna2w0w3bxxhq6gFKoYDOk9dhkC7BtHjrhmng5VV04o6FV62RgikhbEut3fb4yoL3v9w6tC2UfgnJV3eFcAlKiVmC67jiTqgwnq3UbuF8pKIM2nyvCFO7u47MhBb9ca5YjvY8GpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=designlinxhs.com; dmarc=pass action=none
 header.from=designlinxhs.com; dkim=pass header.d=designlinxhs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=designlinxhs.onmicrosoft.com; s=selector2-designlinxhs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqN+mbbQipXMazByDPmrBQ/Z+uxRLOMU5aLZtrjLgLE=;
 b=drT8tqoRiOVb2Opov73n1oGubNHtZl8QakyN6/YU6Q955FQGr3+gaU6sckFeSId5P88V37XpfEJ2SCVe3SYzhXxLM98Wbs2MbiWvFxCAlIfwINVtqu/oKUdFHzAbZ8qiPgPBoj7rFJq2Eaj6W9JoLFn04vmXnEChh0o+/DmF/lE=
Received: from BN8PR17MB3025.namprd17.prod.outlook.com (2603:10b6:408:5c::32)
 by BN8PR17MB3010.namprd17.prod.outlook.com (2603:10b6:408:52::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 21:17:46 +0000
Received: from BN8PR17MB3025.namprd17.prod.outlook.com
 ([fe80::3097:62c1:5903:f3f]) by BN8PR17MB3025.namprd17.prod.outlook.com
 ([fe80::3097:62c1:5903:f3f%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 21:17:46 +0000
From:   Kenneth Sloat <ksloat@designlinxhs.com>
To:     "hyun.kwon@xilinx.com" <hyun.kwon@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: dt-bindings: display: xlnx: mixer: Inconsistent pixel format
 terminology in dt docs
Thread-Topic: dt-bindings: display: xlnx: mixer: Inconsistent pixel format
 terminology in dt docs
Thread-Index: AQHWdzdZDHMJ4RCJPEqeVWmACT1c3Q==
Date:   Thu, 20 Aug 2020 21:17:46 +0000
Message-ID: <1ac0eeed-7455-b0a3-a3e4-4501ae3129df@designlinxhs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none
 header.from=designlinxhs.com;
x-originating-ip: [47.196.189.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fe832e4-f9fd-4dd0-7530-08d8454e7c22
x-ms-traffictypediagnostic: BN8PR17MB3010:
x-microsoft-antispam-prvs: <BN8PR17MB30106F0BEE167800F391B40CA15A0@BN8PR17MB3010.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cD5eZmLkjRe7hO+ex9b8FsFdRw3DRTprbpjfwSxc7hfh0MgnhsS8ZDUPlkHsqm8qk38srV1taFOPcM5tvB4n+VMsmdNCMSdQv0/5yA+DmDxQRwhueni4kHTsDpI4TJrt82twumzNcnb1N4WkGezkZUyaI65qUFxIKnpILdmzAy2zVm46ckVCytP2NjpVcwlJUkqRCJSh8bCVyxHPNoEu/fQx+yLA1/GScfpyLiCLjiDkOOw7QiO8FyEFddKaRrnWGfGcKp2QJmWfZVUmM7qFLkx3PAF2AyJAJ1CKhG/FjVTBGiiOwncZoycrK9/T9RkVN2OFuqwo84tGYpRLgE+8cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR17MB3025.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39830400003)(136003)(346002)(396003)(316002)(6506007)(110136005)(5660300002)(91956017)(76116006)(83380400001)(2906002)(86362001)(6486002)(6512007)(2616005)(54906003)(4326008)(478600001)(66946007)(8936002)(66476007)(31696002)(64756008)(36756003)(66556008)(31686004)(8676002)(71200400001)(186003)(26005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 09xG/wpQ8sA4lJLmrdTBrro3YsgHNL67lL41EUKJzk49dwfk51GWdWrhpxqw3qhvJjKw+0iTvtrS+ANurMxsnGPBP66hQkAoBjTwzuQwCRwScNt64t5KcI1hcz6EgqABr/oa3TlyDd9aMwAgkEA/xBQOuSiOG1a2c1RPWT5xSe+PyGQM2zj7Td9ZwRLrlPsCtMrLldWB4EtdKNgZpgSFgqAVJ+6Y/+xgCxwO2uBzc6BtLEJgKEeAQk8j79yUId3BPUBZHVr55O1RoBOBVoL37C42tUHZiSZ9XeyFyyOmpX1Mv+kH2PzZxnn0mGyc29w2uU+x7JpRBXDKZhjj6P8xnAJo6NdBdZBhv66gBxooaYCB8Dq4aJwQfg7Bw6ZUQZQtYRGD8P0Ce/W9DIIsioS7mhdqQkQady9DaWEr8vX+3pyunyS5udlWFbmbUC4vVIaaCdVEkTUVppOb8Mh8zX+nFB5QX8cy8rxI7TSre3WAnYpkKmRERcRet40HdSZ69WTyrN+qWAMjygJrtkeOYGs7cBKf3l17WGsE42o5fL0t1hsHrz2o+BKS3YrViJXsarJoZBVoUWMqJ4iglze0WIIcNHMXHwqHNe+rL3Hjj3VF2U+c+526NgB18Bk1GDZ3DPBTJra8y12B7p96xyypb0E3YQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABC86728DF772D41AA24E46B429ED2FE@namprd17.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: designlinxhs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR17MB3025.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe832e4-f9fd-4dd0-7530-08d8454e7c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 21:17:46.3524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 21db78a4-85a8-43a2-9030-593b170ddfa9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVbzI+sdn38FD60FKXWMXE3YP61hPT3jiJvQ7dPmvpHspm0GpnZJSM947eogK7c+DtRgoy7z0cw/jPJIIGmtIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR17MB3010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQoNClRoZSBYaWxpbnggVmlkZW8gbWl4ZXIgSVAgdXNlcyB0aGUgRFJNIGZvdXJjYyBz
dHJpbmcgYXMgYSBkZXZpY2UgdHJlZSBiaW5kaW5nIGluIG9yZGVyIHRvIGRlc2NyaWJlIHRoZSBm
b3JtYXQgZm9yIGEgc3BlY2lmaWMgRFJNIGxheWVyL3BsYW5lLiBDdXJyZW50bHksIGluIHRoZSBk
ZXZpY2UgdHJlZSBkb2MgaW4gIkRvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kbWEv
eGlsaW54L3hpbGlueF9mcm1idWYudHh0IiB0aGVyZSBpcyBhIGxpc3QgY2FsbGVkICJWSURFTyBG
T1JNQVRTIiB3aXRoIGEgdGFibGUgY29udGFpbmluZyAiTWl4ZXIgSVAgRm9ybWF0IiBhbmQgYXNz
b2NpYXRlZCAiRHJpdmVyIHN1cHBvcnRlZCBGb3JtYXQgU3RyaW5nIiAoZm91cmNjKS4gSW4gZ2Vu
ZXJhbCwgdGhpcyB0YWJsZSBpcyBub3QgaGVscGZ1bCwgYmVjYXVzZSAiTWl4ZXIgSVAgRm9ybWF0
IiBkb2VzIG5vdCBtYXRjaCB0aGUgWGlsaW54IElQIGRhdGFzaGVldCB0ZXJtaW5vbG9neSBmb3Ig
Zm9ybWF0cyBidXQgcmF0aGVyIHNvbWUgb3RoZXIgY29tbW9ubHkgdXNlZCBub21lbmNsYXR1cmUu
IFRoaXMgaXMgYWxzbyBpbmNvbnNpc3RlbnQgZnJvbSBvdGhlciBYaWxpbnggZHRzIGJpbmRpbmcg
ZG9jcyB3aGljaCBzcGVjaWZ5IHRoZSBhY3R1YWwgY29ycmVjdCBJUCBuYW1lIGFuZCBhdCB0aW1l
cyBsaXN0IG90aGVyIGZvcm1hdCBub21lbmNsYXR1cmUgd2hlcmUgaGVscGZ1bCAoaS5lLiB4aWxp
bnhfZnJtYnVmLnR4dCkNCg0KTXkgc3VnZ2VzdGlvbiBpcyB0byByZW1vdmUgdGhlIGN1cnJlbnQg
Ik1peGVyIElQIEZvcm1hdCIgc3RyaW5ncyBpbiB0aGUgZG9jIGFuZCByZXBsYWNlIHRoZW0gd2l0
aCB0aGUgYWN0dWFsIElQIG5hbWVzIGluIHRoZSBkYXRhc2hlZXQgKHdoaWNoIGFsc28gbWF0Y2gg
dGhvc2UgdXNlZCBpbiBYaWxpbngncyBWaXZhZG8gRlBHQSB0b29sKS4gT3RoZXJ3aXNlLCB0aGUg
cHJvZ3JhbW1lciBtdXN0IGNyb3NzIHJlZmVyZW5jZSBvdGhlciBkdHMgZG9jdW1lbnRhdGlvbiBv
ciB0aGUgY29kZSBpbiBvcmRlciB0byBmaWd1cmUgdGhlc2Ugb3V0LiBJIGFtIGhhcHB5IHRvIHBy
b3ZpZGUgYSBwYXRjaCBmb3IgdGhpcyBidXQgd2FudGVkIHRvIHRocm93IG91dCB0aGUgc3VnZ2Vz
dGlvbiBmaXJzdC4NCg0KVGhhbmtzDQoNClNpbmNlcmVseSwNCktlbiBTbG9hdA0KDQo=
