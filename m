Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C290C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17F3B206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="U18V/9KH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgFHUOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:14:21 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:51822 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgFHUOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 16:14:20 -0400
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058K9Ex3028476;
        Mon, 8 Jun 2020 16:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=eAUrs514kS7wCWNhhoyPEYBgnK9pQkyYJj7M7Jj8tDU=;
 b=U18V/9KHKePWBFHVHJhL07ZIt1FMcgaNXRQriwCnaluXzi2WbaA1567K+UKp3THoK0L0
 /3cIuzY7y+cyyamY/4vjxLLScKT479nWeLyL5TW1Pab/J9KXzypwJOwxeWPL+SEx/1zM
 N1ZaPunDliysRV2Qf3BxPfBw1VUTaZO4K8l5jSQKytXoALhj0cVsXYBT4ijFRyFeiOtT
 nSCJHN1c6DEM7IXFeIBm4+FmHtHMGmu5UGwItw3CKUi+4Lt8k8x9YS0mc10FrAktrri9
 JDzD64NqxbW4g5cfRuK7xC5pEqBzEoN4OkM0XIXJlApuuLmx1N87bpowvdjpu9vgXZzd Ag== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 31g6yxx2yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Jun 2020 16:14:19 -0400
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 058KAlG7118792;
        Mon, 8 Jun 2020 16:14:18 -0400
Received: from ausxipps301.us.dell.com (ausxipps301.us.dell.com [143.166.148.223])
        by mx0a-00154901.pphosted.com with ESMTP id 31gb783f3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Jun 2020 16:14:18 -0400
X-LoopCount0: from 10.166.132.128
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,349,1549951200"; 
   d="scan'208";a="497423135"
From:   <Mario.Limonciello@dell.com>
To:     <y.linux@paritcher.com>, <pali@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>, <mjg59@srcf.ucam.org>
Subject: RE: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Topic: [PATCH 1/3] platform/x86: dell-wmi: add new backlight events
Thread-Index: AQHWPUx85gyioMYN202l2/4aacfOb6jOuKGAgAAgDRCAAKKfgP//rIcQ
Date:   Mon, 8 Jun 2020 20:14:15 +0000
Message-ID: <14b9e7d3a3e842e991e4e5e271b447e7@AUSX13MPC105.AMER.DELL.COM>
References: <cover.1591584631.git.y.linux@paritcher.com>
 <7dbe4e9e5ed64e4704b1c4ae13ac84df644ccc13.1591584631.git.y.linux@paritcher.com>
 <20200608083503.l5g5iq52ezxkobvv@pali>
 <3e0d394545954ed79b8f883e1ac93338@AUSX13MPC105.AMER.DELL.COM>
 <e91bb21e-98fa-f469-cc24-abc9ae200e4d@paritcher.com>
In-Reply-To: <e91bb21e-98fa-f469-cc24-abc9ae200e4d@paritcher.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-06-08T20:14:12.1758629Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=1a93c58a-7ddd-4b7c-bee7-b7be10d9e8af;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [143.166.24.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-08_17:2020-06-08,2020-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080141
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006080141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBZIFBhcml0Y2hlciA8eS5saW51
eEBwYXJpdGNoZXIuY29tPg0KPiBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyMCAzOjEyIFBNDQo+
IFRvOiBMaW1vbmNpZWxsbywgTWFyaW87IHBhbGlAa2VybmVsLm9yZw0KPiBDYzogbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgcGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7
DQo+IG1qZzU5QHNyY2YudWNhbS5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIHBsYXRm
b3JtL3g4NjogZGVsbC13bWk6IGFkZCBuZXcgYmFja2xpZ2h0IGV2ZW50cw0KPiANCj4gDQo+IFtF
WFRFUk5BTCBFTUFJTF0NCj4gDQo+IE9uIDYvOC8yMCAxMTozMCBBTSwgTWFyaW8uTGltb25jaWVs
bG9AZGVsbC5jb20gd3JvdGU6DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+
IEZyb206IHBsYXRmb3JtLWRyaXZlci14ODYtb3duZXJAdmdlci5rZXJuZWwub3JnIDxwbGF0Zm9y
bS1kcml2ZXIteDg2LQ0KPiA+PiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBQ
YWxpIFJvaMOhcg0KPiA+PiBTZW50OiBNb25kYXksIEp1bmUgOCwgMjAyMCAzOjM1IEFNDQo+ID4+
IFRvOiBZIFBhcml0Y2hlcg0KPiA+PiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsg
cGxhdGZvcm0tZHJpdmVyLXg4NkB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4+IE1hdHRoZXcgR2FycmV0
dA0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvM10gcGxhdGZvcm0veDg2OiBkZWxsLXdtaTog
YWRkIG5ldyBiYWNrbGlnaHQNCj4gZXZlbnRzDQo+ID4+DQo+ID4+DQo+ID4+IFtFWFRFUk5BTCBF
TUFJTF0NCj4gPj4NCj4gPj4gT24gTW9uZGF5IDA4IEp1bmUgMjAyMCAwMDoyMjoyNCBZIFBhcml0
Y2hlciB3cm90ZToNCj4gPj4+IElnbm9yZSBldmVudHMgd2l0aCBhIHR5cGUgb2YgMHgwMDEwIGFu
ZCBhIGNvZGUgb2YgMHg1NyAvIDB4NTgsDQo+ID4+PiB0aGlzIHNpbGVuY2VzIHRoZSBmb2xsb3dp
bmcgbWVzc2FnZXMgYmVpbmcgbG9nZ2VkIG9uIGENCj4gPj4+IERlbGwgSW5zcGlyb24gNTU5MzoN
Cj4gPj4+DQo+ID4+PiBkZWxsX3dtaTogVW5rbm93biBrZXkgd2l0aCB0eXBlIDB4MDAxMCBhbmQg
Y29kZSAweDAwNTcgcHJlc3NlZA0KPiA+Pj4gZGVsbF93bWk6IFVua25vd24ga2V5IHdpdGggdHlw
ZSAweDAwMTAgYW5kIGNvZGUgMHgwMDU4IHByZXNzZWQNCj4gPj4+DQo+ID4+PiBTaWduZWQtb2Zm
LWJ5OiBZIFBhcml0Y2hlciA8eS5saW51eEBwYXJpdGNoZXIuY29tPg0KPiA+Pj4gLS0tDQo+ID4+
PiAgZHJpdmVycy9wbGF0Zm9ybS94ODYvZGVsbC13bWkuYyB8IDQgKysrKw0KPiA+Pj4gIDEgZmls
ZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wbGF0Zm9ybS94ODYvZGVsbC13bWkuYw0KPiBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2Rl
bGwtDQo+ID4+IHdtaS5jDQo+ID4+PiBpbmRleCBjMjVhNDI4NmQ3NjYuLjBiNGY3MmY5MjNjZCAx
MDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMNCj4gPj4+
ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0veDg2L2RlbGwtd21pLmMNCj4gPj4+IEBAIC0yNTIsNiAr
MjUyLDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qga2V5X2VudHJ5DQo+ID4+IGRlbGxfd21pX2tl
eW1hcF90eXBlXzAwMTBbXSA9IHsNCj4gPj4+ICAJLyogRm4tbG9jayBzd2l0Y2hlZCB0byBtdWx0
aW1lZGlhIGtleXMgKi8NCj4gPj4+ICAJeyBLRV9JR05PUkUsIDB4MSwgeyBLRVlfUkVTRVJWRUQg
fSB9LA0KPiA+Pj4NCj4gPj4+ICsJLyogQmFja2xpZ2h0IGJyaWdodG5lc3MgbGV2ZWwgKi8NCj4g
Pj4+ICsJeyBLRV9LRVksICAgIDB4NTcsIHsgS0VZX0JSSUdIVE5FU1NET1dOIH0gfSwNCj4gPj4+
ICsJeyBLRV9LRVksICAgIDB4NTgsIHsgS0VZX0JSSUdIVE5FU1NVUCB9IH0sDQo+ID4+PiArDQo+
ID4NCj4gPiBGb3IgdGhlc2UgcGFydGljdWxhciBldmVudHMgYXJlIHRoZXkgZW1pdHRlZCBieSBh
bm90aGVyIGludGVyZmFjZSBhcyB3ZWxsDQo+IGluIHRoaXMNCj4gPiBwbGF0Zm9ybT8NCj4gPg0K
PiA+IElmIHNvIHRoZXkgc2hvdWxkIGJlIEtFX0lHTk9SRSBzbyB5b3UgZG9uJ3QgZW5kIHVwIHdp
dGggZG91YmxlDQo+IG5vdGlmaWNhdGlvbnMgdG8NCj4gPiB1c2Vyc3BhY2UuDQo+IFRoYW5rIHlv
dSBib3RoIGZvciB0aGUgcmV2aWV3LA0KPiBUaGlzIGlzIG15IGZpcnN0IHBhdGNoIHNvIGlmIGkg
YW0gZG9pbmcgc29tZXRoaW5nIHdyb25nIHBsZWFzZSBsZXQgbWUga25vdy4NCj4gDQo+IEJvdGgg
YmVmb3JlIGFuZCBhZnRlciB0aGlzIGNoYW5nZSB0aGV5IGFyZSBvbmx5IGVtaXR0ZWQgb25jZSAo
dmVyaWZpZWQgdmlhDQo+IHNob3drZXlzKQ0KPiB0aGlzIGlzIGJlY2F1c2UgYGRlbGxfd21pX3By
b2Nlc3Nfa2V5KClgIGNhbGxzDQo+IGBhY3BpX3ZpZGVvX2hhbmRsZXNfYnJpZ2h0bmVzc19rZXlf
cHJlc3NlcygpYA0KPiBmb3IgYnJpZ2h0bmVzcyBldmVudHMsIGFuZCBgYWNwaV92aWRlb19oYW5k
bGVzX2JyaWdodG5lc3Nfa2V5X3ByZXNzZXMoKWANCj4gbWFrZXMgc3VyZSBubyBkdXBsaWNhdGUg
YWNwaS12aWRlbyBldmVudHMgYXJlIHNlbnQuDQoNClRoYXQncyBnb29kIHRvIGhlYXIgdGhhdCBp
dCBhbHNvIGZpbHRlcnMgaXQsIGJ1dCBteSBvcGluaW9uIGlzIHRoYXQgZGVsbC13bWkuYw0Kc2hv
dWxkIGFsc28gZmlsdGVyIGl0LiAgU28ganVzdCBjaGFuZ2UgS0VfS0VZIHRvIEtFX0lHTk9SRSBs
aWtlIHRoZSBvdGhlciBldmVudHMuDQoNCj4gPg0KPiA+Pj4gIAkvKiBLZXlib2FyZCBiYWNrbGln
aHQgY2hhbmdlIG5vdGlmaWNhdGlvbiAqLw0KPiA+Pj4gIAl7IEtFX0lHTk9SRSwgMHgzZiwgeyBL
RVlfUkVTRVJWRUQgfSB9LA0KPiA+Pg0KPiA+PiBQbGVhc2UsIGtlZXAgY29kZXMgc29ydGVkLg0K
PiANCj4gV2lsbCBmaXgNCj4gPj4NCj4gPj4+DQo+ID4+PiAtLQ0KPiA+Pj4gMi4yNy4wDQo+ID4+
Pg0K
