Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BC2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 670D820838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="CfJ+XwhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLO7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:59:44 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:21226 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgFLO7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:59:43 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CEvLT5020933;
        Fri, 12 Jun 2020 10:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=HdF98p29Q7CNEkv51WtLm3X1tX8y+8fRalE+qCj//kQ=;
 b=CfJ+XwhUERFBqXUOKY08IL0IHfabBYdeG5/v26NKkVvvzuF3Znw9meSg0a9YvewUMbN+
 JRWqSl84tV69NTLy19qeIzdpn6GHWrYctWX6ZiardiKDzCWAzFQo8X1q9xJ+GUgWXSnt
 jwifvb8kiZZ81va5IDykxJ5Q+C4OoviBFiwV2gdGbNE/Bfj7cklkQw4d5FDhmmxl5VJk
 NKxAYIeyqcTX458WP1AUZCdtaMxhQbG36smXhl7Sj0GVJzrsO0QOYusGkTKMFi5uhDWc
 d9IgDp5CNG3jDbvGPSa9qpUhqKSD2cnHFuRoJBFeXP44iMhSUq0mxyDvWAC/QMdSwoov Ew== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 31jjr6b5tr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 10:59:42 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CEsMK8186782;
        Fri, 12 Jun 2020 10:59:42 -0400
Received: from ausxippc106.us.dell.com (AUSXIPPC106.us.dell.com [143.166.85.156])
        by mx0a-00154901.pphosted.com with ESMTP id 31kxw8a56j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 10:59:42 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="558293660"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>
CC:     <rdunlap@infradead.org>, <y.linux@paritcher.com>,
        <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Topic: [PATCH v2 3/3] platform/x86: dell-wmi: add new dmi keys to
 bios_to_linux_keycode
Thread-Index: AQHWPelqfgxdvjwP/0a7+jtlxWF6SqjPsKgAgAAH0ACAAPg6kIABPt2A///ajtCAA5VdAP//sP+Q
Date:   Fri, 12 Jun 2020 14:59:39 +0000
Message-ID: <a8b5465e4c834f1c98c8499acb0cacb7@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <d585d2a0f01a6b9480352530b571dec2d1afd79f.1591656154.git.y.linux@paritcher.com>
 <8053252a-83ad-bcaa-2830-ccfbca1b4152@infradead.org>
 <20200608235508.wthtgilgmifwfgz2@pali>
 <ced5832cfe984c68b27a577cac0f02f1@AUSX13MPC105.AMER.DELL.COM>
 <20200610094449.xltvs2y6kp7driyh@pali>
 <a7b5dd31dd32461aad51e08d38777edf@AUSX13MPC105.AMER.DELL.COM>
 <20200612141410.7sp7brcmgcel3bfc@pali>
In-Reply-To: <20200612141410.7sp7brcmgcel3bfc@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-12T14:59:36.0531058Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=3521e052-dc24-4cb0-a85a-3375346127c0;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.40]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-12_11:2020-06-12,2020-06-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006120112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+DQo+ID4gPg0KPiA+ID4gQW5kIHdoYXQgZG9lcyBtZWFuICJubyBmdW5jdGlvbiI/IEkgZG8g
bm90IGtub3cgd2hhdCBzaG91bGQgSSBpbWFnaW5lDQo+IGlmDQo+ID4gPiBJIHJlY2VpdmUga2V5
IHByZXNzIG1hcmtlZCBhcyAibm8gZnVuY3Rpb24iLg0KPiA+DQo+ID4gSXQgbWVhbnMgbm8gYWN0
aW9uIGlzIGV4cGVjdGVkIHRvIG9jY3VyLCBzaG91bGQgYmVoYXZlIGxpa2UgYSBuby1vcC4gIEkN
Cj4gdGhpbmsNCj4gPiBkaXNjYXJkaW5nIGl0IG1ha2VzIGZpbmUgc2Vuc2UuDQo+IA0KPiBUaGFu
ayB5b3UhIFRoaXMgd2FzIG1pc3NpbmcgYml0IG9mIGluZm9ybWF0aW9uLg0KPiANCj4gSnVzdCBJ
J20gY3VyaW91cywgd2h5IGZpcm13YXJlIHNlbmRzICJuby1vcCIgZXZlbnQgd2hpY2ggd2UgY291
bGQgaWdub3JlPw0KPiA6RA0KPiANCg0KSSBkb24ndCBoYXZlIGRldGFpbHMgb24gdGhpcywgYnV0
IEkgY2FuIGF0IGxlYXN0IGh5cG90aGVzaXplIGEgc2l0dWF0aW9uIHRoYXQNCnRoZXJlIHdhcyBh
IG1hbnVmYWN0dXJpbmcgZXJyb3Igd2l0aCB0aGUgd3Jvbmcga2V5Ym9hcmQgYXBwbGllZC4gIExp
a2UgdGhpbmsgaWYNCnRoZSBzeXN0ZW0gaGFzIGtleWJvYXJkIHdpdGhvdXQgYSBiYWNrbGlnaHQg
YW5kIHRoZXJlIHdhcyBhIGtleWJvYXJkIHdpdGgNCmEgc2lsa3NjcmVlbmVkIGtleSBmb3IgbW9k
aWZ5aW5nIGJhY2tsaWdodC4gIEluIHRoaXMgY2FzZSBmaXJtd2FyZSBldmVudHMNCnJlbGF0ZWQg
dG8ga2V5Ym9hcmQgYmFja2xpZ2h0IHNob3VsZG4ndCBmbG93IHRocm91Z2ggc28gZmlybXdhcmUg
Y291bGQgaW5zdGVhZA0Kc2VuZCB0aGlzIHR5cGUgb2YgZXZlbnQuDQoNCj4gSSBjYW4gaW1hZ2lu
ZSB0aGF0IHRob3NlIGV2ZW50cyAvIHNjYW4gY29kZXMgbWF5IGNvbnRhaW4gc29tZQ0KPiBpbmZv
cm1hdGlvbiB3aGljaCB3ZSBjYW4gdXNlLi4uDQoNCkkgbWVhbiBJIHN1cHBvc2UgeW91IGNhbiBj
aG9vc2UgdG8gaWdub3JlIG15IGNvbW1lbnRzLCBidXQgSSdtIHRlbGxpbmcgeW91IHRoaXMNCmV2
ZW50IGRvZXNuJ3QgY29udGFpbiBhbnl0aGluZyB1c2VmdWwuDQoNCj4gDQo+ID4gPg0KPiA+ID4g
PiA+IEUuZy4gSSByZW1lbWJlciB0aGF0IHByZXNzaW5nIEZuK1Egb3IgRm4rVyBvbiBzb21lIERl
bGwgTGF0aXR1ZGUNCj4gPiA+ID4gPiBnZW5lcmF0ZXMgY29kZSAyNTUsIHdoaWNoIGNvdWxkIHBy
b3ZlIG15IHRoZXNpcyBhYm91dCAic3BlY2lhbA0KPiBjb2RlcyINCj4gPiA+ID4gPiAod2hpY2gg
YXJlIHByb2JhYmx5IG5vdCBmb3VuZCBpbiBlLmcuIFdpbmRvd3Mgb3IgTGludXggbWFwcGluZw0K
PiB0YWJsZXMpLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ICB9Ow0KPiA+ID4gPiA+ID4gPg0K
PiA+ID4gPiA+ID4gPiAgLyoNCj4gPiA+ID4gPiA+ID4gQEAgLTUwMywxMCArNTA0LDcgQEAgc3Rh
dGljIHZvaWQgaGFuZGxlX2RtaV9lbnRyeShjb25zdCBzdHJ1Y3QNCj4gPiA+ID4gPiBkbWlfaGVh
ZGVyICpkbSwgdm9pZCAqb3BhcXVlKQ0KPiA+ID4gPiA+ID4gPiAgCQkJCQkmdGFibGUtPmtleW1h
cFtpXTsNCj4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gIAkJLyogVW5pbml0aWFsaXplZCBl
bnRyaWVzIGFyZSAwIGFrYSBLRVlfUkVTRVJWRUQuICovDQo+ID4gPiA+ID4gPiA+IC0JCXUxNiBr
ZXljb2RlID0gKGJpb3NfZW50cnktPmtleWNvZGUgPA0KPiA+ID4gPiA+ID4gPiAtCQkJICAgICAg
IEFSUkFZX1NJWkUoYmlvc190b19saW51eF9rZXljb2RlKSkgPw0KPiA+ID4gPiA+ID4gPiAtCQkJ
Ymlvc190b19saW51eF9rZXljb2RlW2Jpb3NfZW50cnktPmtleWNvZGVdIDoNCj4gPiA+ID4gPiA+
ID4gLQkJCUtFWV9SRVNFUlZFRDsNCj4gPiA+ID4gPiA+ID4gKwkJdTE2IGtleWNvZGUgPSBiaW9z
X3RvX2xpbnV4X2tleWNvZGVbYmlvc19lbnRyeS0NCj4gPmtleWNvZGVdOw0KPiA+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gPiAgCQkvKg0KPiA+ID4gPiA+ID4gPiAgCQkgKiBMb2cgaWYgd2UgZmlu
ZCBhbiBlbnRyeSBpbiB0aGUgRE1JIHRhYmxlIHRoYXQgd2UNCj4gZG9uJ3QNCj4gPiA+ID4gPiA+
ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTb21ldGhpbmcgbGlrZToNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiAJCXUxNiBrZXljb2RlOw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IAkJ
a2V5Y29kZSA9IGJpb3NfZW50cnktPmtleWNvZGUgPT0gMHhmZmZmID8gS0VZX1VOS05PV04gOg0K
PiA+ID4gPiA+ID4gCQkJKGJpb3NfZW50cnktPmtleWNvZGUgPA0KPiA+ID4gPiA+ID4gCQkJICAg
ICAgIEFSUkFZX1NJWkUoYmlvc190b19saW51eF9rZXljb2RlKSkgPw0KPiA+ID4gPiA+ID4gCQkJ
Ymlvc190b19saW51eF9rZXljb2RlW2Jpb3NfZW50cnktPmtleWNvZGVdIDoNCj4gPiA+ID4gPiA+
IAkJCUtFWV9SRVNFUlZFRDsNCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4N
Cj4gPiA+ID4gPiA+IEFsc28gcGxlYXNlIGZpeCB0aGlzOg0KPiA+ID4gPiA+ID4gKG5vIFRvLWhl
YWRlciBvbiBpbnB1dCkgPD4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IEhpbnQ6IHNwZWNpZnlpbmcg
Z2l0IHNlbmQtZW1haWwgd2l0aCAnLS10bycgYXJndW1lbnQgaW5zdGVhZCBvZiAnLS0NCj4gY2Mn
DQo+ID4gPiA+ID4gc2hvdWxkIGhlbHAuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+
ID4gPiAtLQ0KPiA+ID4gPiA+ID4gflJhbmR5DQo+ID4gPiA+ID4gPg0K
