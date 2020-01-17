Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7C6C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C320728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="fmtRpFL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAQSdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:33:18 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:36510 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727573AbgAQSdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:33:17 -0500
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HIUNuO017820
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=gYYhrZJCgbqRHjjG9WGfvThIkFBKVsDM/jSmTOJvDlI=;
 b=fmtRpFL1GUByQnp+gCvADMY/3NKoJl/6HKckRqCtkJKeIawPYKJKJdW3N8c+/YFFFpSp
 +6qks+KE3auNzPqAETyyP2qZa9/CEfMANnScRapllG5IHHX6AwRCt9AyV0QuTBPj9X5c
 N5FKYFoJy+gGQ+3oRRCjc7U6qs1/pGL3m74yrr2IUwPUqsOkIui7M/ZJu3sgsM7GKrbS
 7Eg903JpkVlUCI8L22aAXtNH8DLrBMBrO7hnGMve9Rymi2OfNu6bjWvnjuwrPkJtmGIr
 +STolngXy16vRZrJKruKWlRYjMdLOeu8pDR+rWrS/8PWtNqqfFjADqfbOLDieKQZni53 AQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0b-00154904.pphosted.com with ESMTP id 2xk0s4mddj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:33:16 -0500
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00HIScQV086270
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:33:15 -0500
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 2xkht2gg66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:33:15 -0500
X-LoopCount0: from 10.166.132.131
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.60,346,1549951200"; 
   d="scan'208";a="1348425647"
From:   <Mario.Limonciello@dell.com>
To:     <pmenzel@molgen.mpg.de>, <mathias.nyman@linux.intel.com>,
        <mika.westerberg@linux.intel.com>
CC:     <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <YehezkelShB@gmail.com>, <ck@xatom.net>,
        <linux-kernel@vger.kernel.org>, <anthony.wong@canonical.com>
Subject: RE: USB devices on Dell TB16 dock stop working after resuming
Thread-Topic: USB devices on Dell TB16 dock stop working after resuming
Thread-Index: AQHVkxGi4f0HmqPYOkmPAZlfRfFMhqd7dbiAgAAFewCAABDQAP//m/tggABrZQCAAALDgIAXnKiAgAEsYACAAyR+AIAABDKAgAAGv4CAAAE5AIAAAhEAgASPp4CAAbeOgIAAE+eAgCXUBQCABGcYAIAnTzqAgAApv5A=
Date:   Fri, 17 Jan 2020 18:33:12 +0000
Message-ID: <789c7db3bafa4bf9a9348123492196b0@AUSX13MPC105.AMER.DELL.COM>
References: <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <20191122105012.GD11621@lahna.fi.intel.com>
 <edfe1e3c-779b-61e4-8551-f2e13d46d733@molgen.mpg.de>
 <20191122112921.GF11621@lahna.fi.intel.com>
 <ae67c377-4763-4648-a91c-b9351e3b1cf1@molgen.mpg.de>
 <20191122114108.GG11621@lahna.fi.intel.com>
 <cf4140c8-5b92-f1e5-c9e4-e362ab06d6f8@linux.intel.com>
 <e5e3df06-4ddd-aadb-f1ad-6dd24fa2a5c2@molgen.mpg.de>
 <4b25e707-d2b5-11d1-4b16-48122828fde7@linux.intel.com>
 <a9e12353-6f88-edeb-0d78-15c1ac75666b@molgen.mpg.de>
 <87670037-8af5-c209-cbf8-70042e0a8fc5@linux.intel.com>
 <44d8eb12-9af5-7b9a-fa24-be8e8ec3cd48@molgen.mpg.de>
In-Reply-To: <44d8eb12-9af5-7b9a-fa24-be8e8ec3cd48@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-01-17T18:33:10.8705013Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual;
 aiplabel=External Public
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=996 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-2001170143
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001170143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IEkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoIGFuIGV4dGVybmFsIEhT
IGh1YiBhcyB3ZWxsLCBzb8KgIHRoaXMgaXNzdWUNCj4gPiBhcHBlYXJzIHRvIGJlIG1vcmUgcmVs
YXRlZCB0byBBU01lZGlhIGhvc3QgdGhhbiB0aGUgYnVpbHQgaW4gSFMgaHViIGluIFRCMTYNCj4g
DQo+IEkgY29udGFjdGVkIHRoZSAoR2VybWFuKSBEZWxsIHN1cHBvcnQsIGFuZCB0aGV5IGFza2Vk
IG1lIHRvIHVwZGF0ZSB0aGUgbGFwdG9wDQo+IGZpcm13YXJlIHRvIDEuOS4xIGNsYWltaW5nIHRo
YXQgdGhlc2UgaXNzdWVzIG1pZ2h0IGJlIGZpeGVkIHRoZXJlIChkZXNwaXRlIHRoZQ0KPiBjaGFu
Z2UtbG9nIG5vdCBjb250YWluaW5nIHRoYXQpLiBBbnl3YXksIGFmdGVyIHRoZSB1cGRhdGUsIHRo
ZSB1c2VyIGlzIHN0aWxsDQo+IGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZS4NCj4gDQo+IE1h
cmlvLCB3aGF0IGNhbiBJIGRvLCBzbyB0aGUgaXNzdWUgaXMgZXNjYWxhdGVkIHRvIHlvdXIgdGVh
bSwgc28geW91IGNhbiB3b3JrDQo+IHdpdGggQVNNZWRpYSB0byBzb2x2ZSB0aGlzPw0KPiANCj4g
DQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg0KRnJvbSB0aGlzIHRocmVhZCBpdCBkb2Vz
IHNvdW5kIHRvIG1lIGxpa2UgYW4gQVNNZWRpYSBmaXJtd2FyZSBwcm9ibGVtLA0Kbm90IGEgTGlu
dXgga2VybmVsIHByb2JsZW0uDQoNCkkgZG8ga25vdyB0aGVyZSBpcyBhbiB1cGRhdGVkIEFTTWVk
aWEgZmlybXdhcmUgYmluYXJ5IGF2YWlsYWJsZS4gIFJpZ2h0IG5vdw0KaG93ZXZlciB0aGVyZSBp
cyB1bmZvcnR1bmF0ZWx5IG5vdCBhIHdheSB0byB1cGRhdGUgQVNNZWRpYSBodWIgZmlybXdhcmUg
dXNpbmcNCmZyZWUgc29mdHdhcmUuICBJZiBwb3NzaWJsZSwgSSB3b3VsZCByZWNvbW1lbmQgdGhh
dCB5b3UgdHJ5IHRvIHVwZGF0ZSB0aGUNCmZpcm13YXJlIHVzaW5nIGEgV2luZG93cyBtYWNoaW5l
IGFuZCBzZWUgaWYgaXQgaGVscHMgdGhlIHByb2JsZW0uDQoNCkknbSBzb3JyeSBhbmQgSSBkb24n
dCBpbnRlbmQgdG8gInBhc3MgdGhlIGJ1Y2siIGJ1dCBpZiB0aGF0IGRvZXNuJ3QgaGVscCB0aGlz
IG5lZWRzDQp0byBiZSBwcmlvcml0aXplZCBhbmQgZXNjYWxhdGVkIHdpdGggRGVsbCBzdXBwb3J0
Lg0KDQpUaGV5IHdpbGwgdGhlbiB3b3JrIHdpdGggdGhlIGFwcHJvcHJpYXRlIGVuZ2luZWVyaW5n
IHRlYW0gd2hvIG93bnMgdGhlIHJlbGF0aW9uc2hpcA0KdG8gQVNNZWRpYSB0byByZXNvbHZlIGl0
Lg0K
