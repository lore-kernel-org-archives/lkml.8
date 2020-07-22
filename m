Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51A0C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FBFD207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LjJDC/if";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="fj5FTlN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgGVRDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:03:37 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:48488 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVRDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1595437415; x=1626973415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B7CAeF1WEBbFoztntOaniu2dd+J1CmpwQ7M9cxbhOb8=;
  b=LjJDC/ifOrF7D/fdvG+hzW9IribBCoj+Z7aNXyxzSYJreWr7mB12YvtX
   hSFzI4WdGbya9TV3YIcahN4iygk6uNO+1UD/tki6Gc5eqc9bhjwLeCKuR
   xm1+AaOFT/QJ371KqFYwzxG61NMtqS9YgTsFsPl9plbqRhNfYIG4zRas+
   v7ZLhP2+tgRPdfEe6hAVyRPYLv4g77gfNCZzfExwXAeEB1H676c5ymCu8
   hDxLiADx1X4BK2mwFmlANE7c9iH8w20U6sYOKJkMmgeL5IYG7PdkzIWun
   vnMdnAPqGQx7lTtsU8bhqvQLxOiwWcFXaEIcb/P+UT16X6pi8WrSGCg3V
   A==;
IronPort-SDR: 2lyGhiPUosLt5urtgZxV0B16aIDuX88zTM2tWxLVjiwuZqNJQSu+AywD1OkmZggx9n548UFOOJ
 BJ0t1sZdATxZLdHCsWmi2iEW3yBHoD4bfD2g6JbgtH6ya7FQpctWqo3nCqEw11BgksyAwYBPYm
 HCWFWCpuepMB+5ytfhVZ7RNs1NL+n36dcUlITfXaSHDliqiKfFjfL3106hCEwoydtuRDfDPEdo
 fTXerz3V3okoqiVh8BZGMVon5yY+Xqdgst4npt69tgt997gmt89NZ/OWn8+MM2FAfLHp6zyGeh
 49A=
X-IronPort-AV: E=Sophos;i="5.75,383,1589266800"; 
   d="scan'208";a="80930555"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jul 2020 10:03:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 22 Jul 2020 10:03:33 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 22 Jul 2020 10:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ+yJpUPYJ97+FK/ox8lLHNJFBD9UoeHM4D28MHt6UO2ZQFC+o8H4nutFn4o22FZXmOWKF4vllnO6vTOypZZW83LiLt4Fk1ftZdzRI7QRqIVriY45FVCt8zNwQlLrx0H4H6jOA20G9/LCkYIEYc+vfU0iSr40fFjSxguOsxVrd3tzvpT9u57Aqgkt2SXoKh7mtRFmgiHZTZUn75pTejKdKZ6pCJzJwww8ZahHbqYK7tXnSIf21S8Mm47CQsSeMeUe7bUCTNIZMTAO5rIJsUMH95fhGpcBujzAPqfwgeiQKkvcc08aB4zP7PL0WIVgVmcKvJ+lYzMTflIODWIdVG/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7CAeF1WEBbFoztntOaniu2dd+J1CmpwQ7M9cxbhOb8=;
 b=B+2Monr4plgR9ZoNBqSvSFHvXIplspu0AM4u53l/kRwVr5WxV/4Ka1ImrcaiMgS1Z8xO++/joNmhj1fyKiU09OK1FVdVqkKrgkQU8DNu80qDUG0cHznMPNj/3DrzfbJWT71Tjb9+qCMWBdJdrOe6XK+K44Z2L6AEYhKVB4UaQ2dWiyWn3Ys/Qg/FH5Kh1zhJGyAoNyEQfCxdnLxPRIZlBL0g9wzCiIBb4/bCGhX6Vo14/zlz+PFx4sCeOMYVO0NhdfkJ+DPETThCLGqBI7ALX9JDK7CebX+fc+lFCNtxWfvFwO3xSdlYJ7LWB63mUP/0D7zpflK+OlayI9GYz18blw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7CAeF1WEBbFoztntOaniu2dd+J1CmpwQ7M9cxbhOb8=;
 b=fj5FTlN0O02sVdgEn+LTyvbVV/Ft3Zxkz+8b7HrKm0FPyg7elW4TXrngb4bueYthd3/K4dpZdkzCuQpcMx7c22NO1iBYluEwGXDgJPAChiqAmwZSHLnmMs5IludUbbaZcSgrUNJf6kHBQAx2CN2I8oP06PwzC0f0jmeZbRElYso=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB2741.namprd11.prod.outlook.com (2603:10b6:a02:bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Wed, 22 Jul
 2020 17:03:32 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::7424:cb9d:3c63:5181%7]) with mapi id 15.20.3216.022; Wed, 22 Jul 2020
 17:03:32 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <alexander.sverdlin@nokia.com>, <luisalberto@google.com>
CC:     <vigneshr@ti.com>, <bbrezillon@kernel.org>, <richard@nod.at>,
        <jethro@fortanix.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <miquel.raynal@bootlin.com>,
        <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Topic: [PATCH] mtd: revert "spi-nor: intel: provide a range for
 poll_timout"
Thread-Index: AQHWYEoGCAqTB2Up30yP+LHzC/Sy+w==
Date:   Wed, 22 Jul 2020 17:03:32 +0000
Message-ID: <df774dcb-edd1-ae7a-0e26-2e7c324406ff@microchip.com>
References: <20200610224652.64336-1-luisalberto@google.com>
 <40ef3da0-56f4-3c78-f875-a750afaf2ec5@nokia.com>
In-Reply-To: <40ef3da0-56f4-3c78-f875-a750afaf2ec5@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: nokia.com; dkim=none (message not signed)
 header.d=none;nokia.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [79.115.63.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971a7bdb-1fdd-44d3-6842-08d82e6129e2
x-ms-traffictypediagnostic: BYAPR11MB2741:
x-microsoft-antispam-prvs: <BYAPR11MB274109645EC69F3AFABD534CF0790@BYAPR11MB2741.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kr/UyWc2hDxS9afRSjiM4wciwepAYogq7bd+AJ+uLpZH6skRraJ7FKFkgo+PLp5X/f+NNv8YeHj/8H8XXaU/i/r84OVS5iHuX0G4yG8UWjkfADXsUa1IzHuLY5bZG+lkfs2X9rZFTL1IR1GPcblEgHoN3BE9ZwiuLYro09vnthHmV83exa5IRNriG5/UXChytKnL2bhu3pgeCVCwNGroMt8iAvk3CkVp5Hf96WiDHSSL4LQLj2/dWFcs8/ij94/5pk23KAj71GPiPLX972LKXoIYtSs0Zg1KGBr2ZGdxAlqLo+RMr6okMrID4yR6L7CBIhhEQccTmPCC/tT00vJzivfabnySqbwhjN1HTVDgHlWa2CmpLPdp6GZphE4P4GxiRjwlzE8oAdmP2cZtlVhbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(110136005)(71200400001)(31696002)(8936002)(316002)(8676002)(4326008)(6512007)(296002)(2906002)(54906003)(6486002)(7416002)(186003)(86362001)(6506007)(53546011)(26005)(31686004)(478600001)(83380400001)(64756008)(66556008)(66476007)(76116006)(66946007)(91956017)(5660300002)(66446008)(2616005)(36756003)(21314003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fAyQZvCHPleIUEErzQz/ZQt69oYOfKJkW0mjJuZHl6RCwTDXwfchs2t0ghXQNvSRTfhoL573pqsPxvzh5RpY++m7b6J+JbCW9hyo8SPABagtCK+MKaab0fPqAhRGaS/uD8Jnque7gaUb9UOzz6PQf/AB7t0xj2aLcNNIL7hawLwOlzLMCMkw3iAn5isvhiOUAsDTBqAOokN9DAqUwtmnSKEYPH5Q8mGEqSceO2I+swUi2COqJkz2I+dwLxlOf//SUS3o4X7uWTVtBU+gj/TL8h493WkhdXtPZDEVdbsdtPjNFn7AV8S8Tj915898v2q//pJftKMVOBCpJC1rY1B1xeohHVBRHLyaQxyyEA06tDYX060OEroGlKnFvMVVoQm7Fvik9lf5A1gOP+g6YXRCtTvpGm/KNJl3Rzo5y2pEpvXfqLKcxG55qMr089ZhrjICNOmrnRmIilmG+gkMak8c2acOekafnBqNcvR6YHxneXQ4yyA2ZFCSSLthjZYPZ1Bk
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C3580F987ED9B42A9AB149179A1CCB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971a7bdb-1fdd-44d3-6842-08d82e6129e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 17:03:32.1164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmaJFo4UnVyhvzbcqq2Bqu0Q2yxt+ced3mJqBTns4cqTnmeEh420kSxIMRLYnG1nbfMGyQP7y0UgvgnSK+bQxVWPpr71ChTxfI5rwfSx/s4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2741
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEFsZXhhbmRlciwNCg0KT24gNy8yMi8yMCA3OjM3IFBNLCBBbGV4YW5kZXIgU3ZlcmRsaW4g
d3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGVsbG8g
THVpcywNCj4gDQo+IHRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoIQ0KPiANCj4gT24gMTEvMDYvMjAy
MCAwMDo0NiwgTHVpcyBBbGJlcnRvIEhlcnJlcmEgd3JvdGU6DQo+PiBUaGlzIGNoYW5nZSByZXZl
cnRzIGFiYTNhODgyYTE3ODogIm10ZDogc3BpLW5vcjogaW50ZWw6IHByb3ZpZGUgYSByYW5nZQ0K
Pj4gZm9yIHBvbGxfdGltb3V0Ii4gVGhhdCBjaGFuZ2UgaW50cm9kdWNlcyBhIHBlcmZvcm1hbmNl
IHJlZ3Jlc3Npb24gd2hlbg0KPj4gcmVhZGluZyBzZXF1ZW50aWFsbHkgZnJvbSBmbGFzaC4gTG9n
Z2luZyBjYWxscyB0byBpbnRlbF9zcGlfcmVhZCB3aXRob3V0DQo+PiB0aGlzIGNoYW5nZSB3ZSBn
ZXQ6DQo+Pg0KPj4gU3RhcnQgTVREIHJlYWQNCj4+IFsgICAyMC4wNDU1MjddIGludGVsX3NwaV9y
ZWFkKGZyb209MTgwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IFsgICAyMC4wNDU1MjddIGludGVsX3Nw
aV9yZWFkKGZyb209MTgwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IFsgIDI4Mi4xOTkyNzRdIGludGVs
X3NwaV9yZWFkKGZyb209MWMwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IFsgIDI4Mi4xOTkyNzRdIGlu
dGVsX3NwaV9yZWFkKGZyb209MWMwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IFsgIDU0NC4zNTE1Mjhd
IGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IFsgIDU0NC4zNTE1
MjhdIGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVuPTQwMDAwMCkNCj4+IEVuZCBNVEQg
cmVhZA0KPj4NCj4+IFdpdGggdGhpcyBjaGFuZ2U6DQo+Pg0KPj4gU3RhcnQgTVREIHJlYWQNCj4+
IFsgICAyMS45NDI5MjJdIGludGVsX3NwaV9yZWFkKGZyb209MWMwMDAwMCwgbGVuPTQwMDAwMCkN
Cj4+IFsgICAyMS45NDI5MjJdIGludGVsX3NwaV9yZWFkKGZyb209MWMwMDAwMCwgbGVuPTQwMDAw
MCkNCj4+IFsgICAyMy43ODQwNThdIGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVuPTQw
MDAwMCkNCj4+IFsgICAyMy43ODQwNThdIGludGVsX3NwaV9yZWFkKGZyb209MjAwMDAwMCwgbGVu
PTQwMDAwMCkNCj4+IFsgICAyNS42MjUwMDZdIGludGVsX3NwaV9yZWFkKGZyb209MjQwMDAwMCwg
bGVuPTQwMDAwMCkNCj4+IFsgICAyNS42MjUwMDZdIGludGVsX3NwaV9yZWFkKGZyb209MjQwMDAw
MCwgbGVuPTQwMDAwMCkNCj4+IEVuZCBNVEQgcmVhZA0KPiANCj4gSSd2ZSBwZXJmb3JtZWQgbXkg
dGVzdGluZyBhcyB3ZWxsIGFuZCBnb3QgdGhlIGZvbGxvd2luZyByZXN1bHRzOg0KPiANCj4gVmFu
aWxsYSBMaW51eCA0LjkgKGkuZS4gYmVmb3JlIHRoZSBpbnRyb2R1Y3Rpb24gb2YgdGhlIG9mZmVu
ZGluZw0KPiBwYXRjaCk6DQo+IA0KPiBkZCBpZj0vZGV2L2ZsYXNoL2J5LW5hbWUvWFhYIG9mPS9k
ZXYvbnVsbCBicz00aw0KPiAxMjgwKzAgcmVjb3JkcyBpbg0KPiAxMjgwKzAgcmVjb3JkcyBvdXQN
Cj4gNTI0Mjg4MCBieXRlcyAoNS4yIE1CLCA1LjAgTWlCKSBjb3BpZWQsIDMuOTE5ODEgcywgMS4z
IE1CL3MNCj4gDQo+IFZhbmlsbGEgNC4xOSAoaS5lLiB3aXRoIG9mZmVuZGluZyBwYXRjaCk6DQo+
IA0KPiBkZCBpZj0vZGV2L2ZsYXNoL2J5LW5hbWUvWFhYIG9mPS9kZXYvbnVsbCBicz00aw0KPiAx
MjgwKzAgcmVjb3JkcyBpbg0KPiAxMjgwKzAgcmVjb3JkcyBvdXQNCj4gNTI0Mjg4MCBieXRlcyAo
NS4yIE1CLCA1LjAgTWlCKSBjb3BpZWQsIDYuNzA4OTEgcywgNzgxIGtCL3MNCj4gDQo+IDQuMTkg
KyByZXZlcnQ6DQo+IA0KPiBkZCBpZj0vZGV2L2ZsYXNoL2J5LW5hbWUvWFhYIG9mPS9kZXYvbnVs
bCBicz00aw0KPiAxMjgwKzAgcmVjb3JkcyBpbg0KPiAxMjgwKzAgcmVjb3JkcyBvdXQNCj4gNTI0
Mjg4MCBieXRlcyAoNS4yIE1CLCA1LjAgTWlCKSBjb3BpZWQsIDMuOTA1MDMgcywgMS4zIE1CL3MN
Cj4gDQo+IFRoZXJlZm9yZSBpdCBsb29rcyBnb29kIGZyb20gbXkgUG9WOg0KPiANCj4gVGVzdGVk
LWJ5OiBBbGV4YW5kZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBnbWFpbC5jb20+DQo+
IA0KPj4gU2lnbmVkLW9mZi1ieTogTHVpcyBBbGJlcnRvIEhlcnJlcmEgPGx1aXNhbGJlcnRvQGdv
b2dsZS5jb20+DQo+PiBBY2tlZC1ieTogTWlrYSBXZXN0ZXJiZXJnIDxtaWthLndlc3RlcmJlcmdA
bGludXguaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb250cm9s
bGVycy9pbnRlbC1zcGkuYyB8IDQgKystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRy
b2xsZXJzL2ludGVsLXNwaS5jDQo+PiBpbmRleCA2MWQyYTBhZDIxMzEuLjJiODkzNjFhMGQzYSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3Bp
LmMNCj4+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMN
Cj4+IEBAIC0yOTIsNyArMjkyLDcgQEAgc3RhdGljIGludCBpbnRlbF9zcGlfd2FpdF9od19idXN5
KHN0cnVjdCBpbnRlbF9zcGkgKmlzcGkpDQo+PiAgICAgICB1MzIgdmFsOw0KPj4NCj4+ICAgICAg
IHJldHVybiByZWFkbF9wb2xsX3RpbWVvdXQoaXNwaS0+YmFzZSArIEhTRlNUU19DVEwsIHZhbCwN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgISh2YWwgJiBIU0ZTVFNfQ1RMX1ND
SVApLCA0MCw+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEodmFsICYgSFNGU1RT
X0NUTF9TQ0lQKSwgMCwNCg0Kd291bGQgeW91IHB1dCAxMCB1cyBoZXJlDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIElOVEVMX1NQSV9USU1FT1VUICogMTAwMCk7DQo+PiAgfQ0K
Pj4NCj4+IEBAIC0zMDEsNyArMzAxLDcgQEAgc3RhdGljIGludCBpbnRlbF9zcGlfd2FpdF9zd19i
dXN5KHN0cnVjdCBpbnRlbF9zcGkgKmlzcGkpDQo+PiAgICAgICB1MzIgdmFsOw0KPj4NCj4+ICAg
ICAgIHJldHVybiByZWFkbF9wb2xsX3RpbWVvdXQoaXNwaS0+c3JlZ3MgKyBTU0ZTVFNfQ1RMLCB2
YWwsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEodmFsICYgU1NGU1RTX0NU
TF9TQ0lQKSwgNDAsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICEodmFsICYg
U1NGU1RTX0NUTF9TQ0lQKSwgMCwNCg0KYWxzbyBoZXJlLCBhbmQgcmUtZG8gYSB0ZXN0PyBJJ20g
Y3VyaW9zIGlmIHRoZSBwZXJmb3JtYW5jZSB3aWxsIGJlDQphcyBpdCB3YXMgYmVmb3JlLg0KDQpU
aGFua3MhDQoNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU5URUxfU1BJX1RJ
TUVPVVQgKiAxMDAwKTsNCj4+ICB9DQo+Pg0KPj4NCj4gDQo+IC0tDQo+IEJlc3QgcmVnYXJkcywN
Cj4gQWxleGFuZGVyIFN2ZXJkbGluLg0KPiANCg0K
