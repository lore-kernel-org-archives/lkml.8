Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176FFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33102076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="C5MA4kGy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgFHWAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:00:47 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:28594 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726723AbgFHWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:00:45 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058LdOh9029790;
        Mon, 8 Jun 2020 18:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=IGmRu8xNo3dGrX/Gt/g8i0qkBSm8CF+dxDZ2EFvKQ+Q=;
 b=C5MA4kGy/6zDc602+zxHF+fSuwX/LkytGk0zqFKGVUR8ltVXKUKsaACIzmuG5edzpujm
 s0cPWRXZ9W3vpnMB9PkiaMtFmWw1d/mgSsIp4UBL3uSslqOZN2XPwSAi58uTPbw4t6eM
 CtFA29SDKUY6n+xcUwOJBca/jbrR8Nss0hddIxjxYUfW+JkZ21fbN/wkD4w6ohxwFqzO
 2cF4NzWBnDclCHwlj7+oltmqHJst8Sa2r0R7Ny+MTUo8NKepL1pnPb1Dpnat78SZM4as
 4KfFlXWR/sAERxc4Z6oWX9zD8IEmV4Qnq4VHcWB10Lj7IowBe7MOKleDer7TtOPEOhTE dg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 31g6c86csf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 18:00:44 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058LhqDQ070993;
        Mon, 8 Jun 2020 18:00:43 -0400
Received: from ausxipps310.us.dell.com (AUSXIPPS310.us.dell.com [143.166.148.211])
        by mx0a-00154901.pphosted.com with ESMTP id 31hsukb4a5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 18:00:42 -0400
X-LoopCount0: from 10.166.132.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="509496153"
From:   <Mario.Limonciello@dell.com>
To:     <y.linux@paritcher.com>, <hdegoede@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>,
        <pali@kernel.org>
Subject: RE: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Topic: [PATCH 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Index: AQHWPUx5kZ6BCWcrZkepA13uOwTuTKjO2RsQgACifgD//7DjgIAAXSCA//+7RnA=
Date:   Mon, 8 Jun 2020 22:00:37 +0000
Message-ID: <6cfba0ce42a74b39b5b80e9c621e2601@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <0dc191a3d16f0e114f6a8976433e248018e10c43.1591584631.git.y.linux@paritcher.com>
 <83fe431cacbc4708962767668ac8f06f@AUSX13MPC105.AMER.DELL.COM>
 <79bd59ee-dd37-bdc5-f6b4-00f2c33fdcff@paritcher.com>
 <7f9f0410696141cfabb0237d33b7b529@AUSX13MPC105.AMER.DELL.COM>
 <01169d6e-1bb1-6fc5-0690-0e8f44941cce@paritcher.com>
In-Reply-To: <01169d6e-1bb1-6fc5-0690-0e8f44941cce@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T22:00:34.4451358Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=ad1ac4c1-ae92-4357-9d65-57e26e184c16;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 cotscore=-2147483648 mlxlogscore=884 adultscore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080150
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=977 mlxscore=0 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gdGhpcyBpcyB0aGUgV01JIGV2ZW50IGZyb20gcHJlc3NpbmcgdGhlIEZuIGxvY2sga2V5
Lg0KPiB0aGlzIGluZGljYXRlcyB3aGljaCBtb2RlIGl0IGlzIHN3aXRjaGluZyB0by4NCj4gDQo+
IHRoaXMgY2hhbmdlcyBpZiB0aGUgZGVmYXVsdCBmb3IgcHJlc3NpbmcgdGhlIEZbMS0xMl0gc2hv
dWxkIGJlIEZ1bmN0aW9uIG9yDQo+IG1lZGlhLg0KPiB0aGUgc2NhbmNvZGVzIG9mIHRoZSBGbiBr
ZXlzIGFyZSBwcm9wZXJseSB0cmFuc21pdHRlZCwgdGhpcyBqdXN0IGludmVydHMNCj4gd2hpY2gN
Cj4gb25lcyBhcmUgc2VudCBieSBkZWZhdWx0IGFuZCB3aGljaCBhcmUgc2VudCB3aGVuIHByZXNz
aW5nIHRoZSBGbitGWzEtMTJdDQo+IA0KPiBJbiBvdGhlciB3b3JkcywgdGhlcmUgYXJlIDI0IHNj
YW5jb2RlIHRoZSBvbmx5IGRpZmZlcmVuY2UgaXMgd2hpY2ggMTIgYXJlDQo+IGRlZmF1bHQNCj4g
YW5kIHdoaWNoIDEyIGFyZSB3aGVuIHByZXNzaW5nIHdpdGggdGhlIEZuIGtleQ0KPiA+Pg0KPiA+
PiBUaGVyZWZvcmUgaSBhZ3JlZSB0aGlzIHNob3VsZCBoYXZlIGl0J3Mgb3duIGNhc2UgaW4NCg0K
VG8gbWUgdGhpcyBzb3VuZHMgbGlrZSBpdCBtYWtlcyBtb3N0IHNlbnNlIHRvIGVpdGhlciBiZSBh
biBldmRldiBzd2l0Y2ggd2hpY2ggaW5kaWNhdGVzDQp3aGljaCBtb2RlIHRoZSBmbiBrZXkgaXMg
c2V0IHRvIHdoZW4gYW4gZXZlbnQgY29tZXMgaW4uICBZb3UgY2FuIHBvcHVsYXRlIHRoZSBzdGFy
dGluZw0KbW9kZSBieSBsb29raW5nIHVwIGZyb20gYSB0b2tlbi4NCmh0dHBzOi8vZ2l0aHViLmNv
bS9kZWxsL2xpYnNtYmlvcy9ibG9iL21hc3Rlci9kb2MvdG9rZW5fbGlzdC5jc3YjTDk4Nw0KDQpB
bnkgb3RoZXIgdGhvdWdodHMgZnJvbSBvdGhlcnM/DQo=
