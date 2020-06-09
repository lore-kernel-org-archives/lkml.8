Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A341DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD68207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="J3UaL9Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgFIA04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:26:56 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:38986 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728140AbgFIA0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:26:51 -0400
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0590F0Kd019534;
        Mon, 8 Jun 2020 20:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=XVGbFrqO+4wKhVMCqql/3iST8DZZYeupgv0BCbt5RBg=;
 b=J3UaL9CpVGCh68LkP+n+eYxM/oQiKDLEczwt/AsInKb9LR5NZ9MZ4mePKTwEtnB8ZoGZ
 FERvBkakuxDFy069SIrLEJPzR76/7kmusa7/+FqQ1qkhB6n64gtjQa3ZjaL7nLSesi5g
 TEMC4BP7RVTU0NKiPChMzG+7b113c0dK0jXmyNbhlkFfRPFFaRDBt0JsgIxvl0TBP9Em
 nMWlXTOKbSupqR/+9kx4+HNwBZPGaeVuA6w7LXmfCKI5R/yt3bd4hm/ac1nWixdxnJth
 D6OxY7Eb52aaA+R8JMaxb6fUwpywgD8rjHHVDGN7RXe5r7GIcpmtKHY/rvDU6FvVtQ3T 4w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31g5q5pr2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 20:26:49 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0590En5V171725;
        Mon, 8 Jun 2020 20:26:48 -0400
Received: from ausxippc110.us.dell.com (AUSXIPPC110.us.dell.com [143.166.85.200])
        by mx0a-00154901.pphosted.com with ESMTP id 31gb7864js-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 20:26:48 -0400
X-LoopCount0: from 10.166.132.127
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="951288285"
From:   <Mario.Limonciello@dell.com>
To:     <pali@kernel.org>, <y.linux@paritcher.com>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type 0x0012
Thread-Topic: [PATCH v2 2/3] platform/x86: dell-wmi: add new keymap type
 0x0012
Thread-Index: AQHWPels4NQdm2zLIUyaNqWd/TH4jKjPsk2A//+4ULA=
Date:   Tue, 9 Jun 2020 00:26:45 +0000
Message-ID: <295ad85ecc464a57bffd5b783d4170a1@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <cover.1591656154.git.y.linux@paritcher.com>
 <74fdb288757cf5970a558f920f531b3bd1c51b47.1591656154.git.y.linux@paritcher.com>
 <20200608233303.57ubv4rxo4tnaaxa@pali>
In-Reply-To: <20200608233303.57ubv4rxo4tnaaxa@pali>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-09T00:26:44.4179432Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=d289b344-7bda-44c2-ad5c-c8b80da7b348;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_18:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090000
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYWxpIFJvaMOhciA8cGFsaUBr
ZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyMCA2OjMzIFBNDQo+IFRvOiBZ
IFBhcml0Y2hlcg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0t
ZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7DQo+IE1hdHRoZXcgR2FycmV0dDsgTGltb25jaWVs
bG8sIE1hcmlvDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBwbGF0Zm9ybS94ODY6IGRl
bGwtd21pOiBhZGQgbmV3IGtleW1hcCB0eXBlDQo+IDB4MDAxMg0KPiANCj4gDQo+IFtFWFRFUk5B
TCBFTUFJTF0NCj4gDQo+IE9uIE1vbmRheSAwOCBKdW5lIDIwMjAgMTk6MDU6MjkgWSBQYXJpdGNo
ZXIgd3JvdGU6DQo+ID4gVGhlc2UgYXJlIGV2ZW50cyB3aXRoIGV4dGVuZGVkIGRhdGEuIFRoZSBl
eHRlbmRlZCBkYXRhIGlzDQo+ID4gY3VycmVudGx5IGlnbm9yZWQgYXMgdXNlcnNwYWNlIGRvZXMg
bm90IGhhdmUgYSB3YXkgdG8gZGVhbA0KPiA+IGl0Lg0KPiA+DQo+ID4gSWdub3JlIGV2ZW50IHdp
dGggYSB0eXBlIG9mIDB4MDAxMiBhbmQgYSBjb2RlIG9mIDB4ZTAzNSwgYXMNCj4gPiB0aGUga2V5
Ym9hcmQgY29udHJvbGxlciB0YWtlcyBjYXJlIG9mIEZuIGxvY2sgZXZlbnRzIGJ5IGl0c2VsZi4N
Cj4gDQo+IE5pY2UhIFRoaXMgaXMgaW5mb3JtYXRpb24gd2hpY2ggaXMgcmVhbGx5IGltcG9ydGFu
dCBhbmQgbmVlZCB0byBoYXZlIGl0DQo+IGRvY3VtZW50ZWQuDQo+IA0KPiA+IFRoaXMgc2lsZW5j
ZXMgdGhlIGZvbGxvd2luZyBtZXNzYWdlcyBiZWluZyBsb2dnZWQgd2hlbg0KPiA+IHByZXNzaW5n
IHRoZSBGbi1sb2NrIGtleSBvbiBhIERlbGwgSW5zcGlyb24gNTU5MzoNCj4gPg0KPiA+IGRlbGxf
d21pOiBVbmtub3duIFdNSSBldmVudCB0eXBlIDB4MTINCj4gPiBkZWxsX3dtaTogVW5rbm93biBr
ZXkgd2l0aCB0eXBlIDB4MDAxMiBhbmQgY29kZSAweGUwMzUgcHJlc3NlZA0KPiA+DQo+ID4gVGhp
cyBpcyBjb25zaXN0ZW50IHdpdGggdGhlIGJlaGF2aW9yIGZvciB0aGUgRm4tbG9jayBrZXkNCj4g
PiBlbHNld2hlcmUgaW4gdGhpcyBmaWxlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWSBQYXJp
dGNoZXIgPHkubGludXhAcGFyaXRjaGVyLmNvbT4NCj4gDQo+IEknbSBmaW5lIHdpdGggdGhpcyBw
YXRjaCBub3cuDQo+IA0KPiBSZXZpZXdlZC1ieTogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9y
Zz4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMgfCAy
MCArKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZv
cm0veDg2L2RlbGwtd21pLmMgYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9kZWxsLQ0KPiB3bWkuYw0K
PiA+IGluZGV4IDBiMmVkZmUyNzY3ZC4uNmI1MTBmODQzMWEzIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMNCj4gPiArKysgYi9kcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9kZWxsLXdtaS5jDQo+ID4gQEAgLTMzNCw2ICszMzQsMTUgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBrZXlfZW50cnkNCj4gZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAxMVtdID0gew0KPiA+ICAJ
eyBLRV9JR05PUkUsIEtCRF9MRURfQVVUT18xMDBfVE9LRU4sIHsgS0VZX1JFU0VSVkVEIH0gfSwN
Cj4gPiAgfTsNCj4gPg0KPiA+ICsvKg0KPiA+ICsgKiBLZXltYXAgZm9yIFdNSSBldmVudHMgb2Yg
dHlwZSAweDAwMTINCj4gPiArICogVGhleSBhcmUgZXZlbnRzIHdpdGggZXh0ZW5kZWQgZGF0YQ0K
PiA+ICsgKi8NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBrZXlfZW50cnkgZGVsbF93bWlfa2V5
bWFwX3R5cGVfMDAxMltdID0gew0KPiA+ICsJLyogRm4tbG9jayBidXR0b24gcHJlc3NlZCAqLw0K
PiA+ICsJeyBLRV9JR05PUkUsIDB4ZTAzNSwgeyBLRVlfUkVTRVJWRUQgfSB9LA0KPiA+ICt9Ow0K
PiA+ICsNCj4gPiAgc3RhdGljIHZvaWQgZGVsbF93bWlfcHJvY2Vzc19rZXkoc3RydWN0IHdtaV9k
ZXZpY2UgKndkZXYsIGludCB0eXBlLCBpbnQNCj4gY29kZSkNCj4gPiAgew0KPiA+ICAJc3RydWN0
IGRlbGxfd21pX3ByaXYgKnByaXYgPSBkZXZfZ2V0X2RydmRhdGEoJndkZXYtPmRldik7DQo+ID4g
QEAgLTQxOCwxMCArNDI3LDExIEBAIHN0YXRpYyB2b2lkIGRlbGxfd21pX25vdGlmeShzdHJ1Y3Qg
d21pX2RldmljZQ0KPiAqd2RldiwNCj4gPg0KPiA+ICAJCXN3aXRjaCAoYnVmZmVyX2VudHJ5WzFd
KSB7DQo+ID4gIAkJY2FzZSAweDAwMDA6IC8qIE9uZSBrZXkgcHJlc3NlZCBvciBldmVudCBvY2N1
cnJlZCAqLw0KPiA+ICsJCWNhc2UgMHgwMDEyOiAvKiBFdmVudCB3aXRoIGV4dGVuZGVkIGRhdGEg
b2NjdXJyZWQgKi8NCg0KSSBkb24ndCByZWFsbHkgbGlrZSB0aGlzIGJlaW5nIGhhbmRsZWQgYXMg
YSBrZXkgYXMgaXQncyBqdXN0IGRpc2NhcmRpbmcgYWxsDQp0aGF0IGV4dGVuZGVkIGRhdGEuDQoN
Cj4gDQo+IE1hcmlvLCBhcmUgeW91IGFibGUgdG8gZ2V0IHNvbWUgb2ZmaWNpYWwgZG9jdW1lbnRh
dGlvbiBmb3IgdGhlc2UgMHgwMDEyDQo+IGV2ZW50IHR5cGVzPyBJIHRoaW5rIGl0IGNvdWxkIGJl
IHJlYWxseSB1c2VmdWwgZm9yIGNvbW11bml0eSBzbyB0aGV5IGNhbg0KPiB1bmRlcnN0YW5kIGFu
ZCBhZGQgZWFzaWx5IG5ldyB0eXBlIG9mIGNvZGUgYW5kIGV2ZW50cy4gQmVjYXVzZSBjdXJyZW50
bHkNCj4gd2UgYXJlIGp1c3QgZ3Vlc3Npbmcgd2hhdCBpdCBjb3VsZCBiZS4gKEl0IGlzIHNlcXVl
bmNlPyBPciBzaW5nbGUgZXZlbnQ/DQo+IE9yIHNpbmdsZSBldmVudCB3aXRoIGV4dGVuZGVkIGRh
dGE/IEl0IGlzIGdlbmVyaWMgZXZlbnQ/IE9yIGl0IGlzIHJlYWwNCj4ga2V5cHJlc3M/IGV0Yy4u
LikNCg0KSXQncyBhIHNpbmdsZSBldmVudCB3aXRoIG1vcmUgZGF0YSBpbiB0aGUgc3Vic2VxdWVu
dCB3b3Jkcy4gIEl0IGlzIGRlZmluaXRlbHkNCm5vdCBhIHJlYWwga2V5cHJlc3MuICBJdCdzIHN1
cHBvc2VkIHRvIGJlIGRhdGEgdGhhdCBhIHVzZXIgYXBwbGljYXRpb24gd291bGQgc2hvdy4NCg0K
UmVtZW1iZXIgdGhlIHdheSBXTUkgd29ya3Mgb24gTGludXggYW5kIFdpbmRvd3MgaXMgZGlmZmVy
ZW50LiAgT24gV2luZG93cw0KdXNlcmxhbmQgYXBwbGljYXRpb25zIGdldCB0aGUgZXZlbnRzIGRp
cmVjdGx5LiAgT24gTGludXgga2VybmVsIGRyaXZlcnMgZ2V0IHRoZQ0KZXZlbnRzIGFuZCBlaXRo
ZXIgdXNlIGl0IGludGVybmFsbHksIHBhc3MgdG8gYW5vdGhlciBrZXJuZWwgZHJpdmVyIG9yIHBh
c3MgdG8NCnVzZXJsYW5kIGluIHRoZSBmb3JtIG9mIGEgdHJhbnNsYXRlZCBldmVudC4NCg0KU28g
b24gV2luZG93cyB0aGUgd2hvbGUgYnVmZmVyIGdldHMgbG9va2VkIGF0IGRpcmVjdGx5IGJ5IHRo
ZSBhcHBsaWNhdGlvbiBhbmQgdGhlDQphcHBsaWNhdGlvbiB3aWxsIGRlY29kZSBpdCB0byBzaG93
IGEgdHJhbnNsYXRlZCBzdHJpbmcuDQoNCkkgY2FuIGNlcnRhaW5seSBkaXNjdXNzIGludGVybmFs
bHkgYWJvdXQgb3VyIHRlYW0gcmVsZWFzaW5nIGEgcGF0Y2ggdG8gZXhwb3J0DQphbGwgdGhlc2Ug
b3RoZXIgZXZlbnRzLiAgSSB3b3VsZCBsaWtlIHRvIGtub3cgd2hhdCBpbnRlcmZhY2UgdG8gcmVj
b21tZW5kIGl0IHBhc3MNCnRvIHVzZXJzcGFjZSB0aG91Z2gsIGJlY2F1c2UgYXMgSSBzYWlkIHRo
aXMgaXMgbW9yZSB0aGFuIGp1c3QgYSBrZXljb2RlIHRoYXQNCmNvbWVzIHRocm91Z2ggaW4gdGhl
IGV2ZW50LiAgSXQncyBub3QgdXNlZnVsIHRvIGp1c3QgZG8gZGV2X2luZm8sIGl0IHJlYWxseSBz
aG91bGQNCmJlIHNvbWV0aGluZyB0aGF0IHVzZXJzcGFjZSBjYW4gYWN0IG9uIGFuZCBzaG93IGEg
dHJhbnNsYXRlZCBtZXNzYWdlLg0KSSBkb24ndCB0aGluayB3ZSB3YW50IHRvIGFkZCBhbm90aGVy
IDE1IERlbGwgc3BlY2lmaWMga2V5Y29kZXMgdG8gdGhlIGtlcm5lbCBmb3IgdGhlDQp2YXJpb3Vz
IGV2ZW50cyBhbmQgYWRkIGFub3RoZXIgNCBtb3JlIHdoZW4gYSBsYXB0b3AgaW50cm9kdWNlcyBh
bm90aGVyIHNldCBvZiBrZXlzLg0KDQo+IA0KPiA+ICAJCQlpZiAobGVuID4gMikNCj4gPiAgCQkJ
CWRlbGxfd21pX3Byb2Nlc3Nfa2V5KHdkZXYsIDB4MDAwMCwNCj4gPiAgCQkJCQkJICAgICBidWZm
ZXJfZW50cnlbMl0pOw0KPiA+IC0JCQkvKiBPdGhlciBlbnRyaWVzIGNvdWxkIGNvbnRhaW4gYWRk
aXRpb25hbCBpbmZvcm1hdGlvbiAqLw0KPiA+ICsJCQkvKiBFeHRlbmRlZCBkYXRhIGlzIGN1cnJl
bnRseSBpZ25vcmVkICovDQo+ID4gIAkJCWJyZWFrOw0KPiA+ICAJCWNhc2UgMHgwMDEwOiAvKiBT
ZXF1ZW5jZSBvZiBrZXlzIHByZXNzZWQgKi8NCj4gPiAgCQljYXNlIDB4MDAxMTogLyogU2VxdWVu
Y2Ugb2YgZXZlbnRzIG9jY3VycmVkICovDQo+ID4gQEAgLTU1Niw2ICs1NjYsNyBAQCBzdGF0aWMg
aW50IGRlbGxfd21pX2lucHV0X3NldHVwKHN0cnVjdCB3bWlfZGV2aWNlDQo+ICp3ZGV2KQ0KPiA+
ICAJCQkgQVJSQVlfU0laRShkZWxsX3dtaV9rZXltYXBfdHlwZV8wMDAwKSArDQo+ID4gIAkJCSBB
UlJBWV9TSVpFKGRlbGxfd21pX2tleW1hcF90eXBlXzAwMTApICsNCj4gPiAgCQkJIEFSUkFZX1NJ
WkUoZGVsbF93bWlfa2V5bWFwX3R5cGVfMDAxMSkgKw0KPiA+ICsJCQkgQVJSQVlfU0laRShkZWxs
X3dtaV9rZXltYXBfdHlwZV8wMDEyKSArDQo+ID4gIAkJCSAxLA0KPiA+ICAJCQkgc2l6ZW9mKHN0
cnVjdCBrZXlfZW50cnkpLCBHRlBfS0VSTkVMKTsNCj4gPiAgCWlmICgha2V5bWFwKSB7DQo+ID4g
QEAgLTYwMCw2ICs2MTEsMTMgQEAgc3RhdGljIGludCBkZWxsX3dtaV9pbnB1dF9zZXR1cChzdHJ1
Y3Qgd21pX2RldmljZQ0KPiAqd2RldikNCj4gPiAgCQlwb3MrKzsNCj4gPiAgCX0NCj4gPg0KPiA+
ICsJLyogQXBwZW5kIHRhYmxlIHdpdGggZXZlbnRzIG9mIHR5cGUgMHgwMDEyICovDQo+ID4gKwlm
b3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShkZWxsX3dtaV9rZXltYXBfdHlwZV8wMDEyKTsgaSsr
KSB7DQo+ID4gKwkJa2V5bWFwW3Bvc10gPSBkZWxsX3dtaV9rZXltYXBfdHlwZV8wMDEyW2ldOw0K
PiA+ICsJCWtleW1hcFtwb3NdLmNvZGUgfD0gKDB4MDAxMiA8PCAxNik7DQo+ID4gKwkJcG9zKys7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJLyoNCj4gPiAgCSAqIE5vdyBhcHBlbmQgYWxzbyB0YWJs
ZSB3aXRoICJsZWdhY3kiIGV2ZW50cyBvZiB0eXBlIDB4MDAwMC4gU29tZSBvZg0KPiA+ICAJICog
dGhlbSBhcmUgcmVwb3J0ZWQgYWxzbyBvbiBsYXB0b3BzIHdoaWNoIGhhdmUgc2NhbmNvZGVzIGlu
IERNSS4NCj4gPiAtLQ0KPiA+IDIuMjcuMA0KPiA+DQo=
