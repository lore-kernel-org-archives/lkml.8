Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B23C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5732A20665
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="oenl3ghZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="qtfDiOxF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgICOb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:31:27 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:30518 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729057AbgICO1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:27:48 -0400
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083EOIO1006770;
        Thu, 3 Sep 2020 10:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=FqoAHFB9NlnUp4IovHJYiE5FRgBAiUyLyKN8lBUqkII=;
 b=oenl3ghZQehYn8fkdGkVIID3XZlTvmhiBpHSy28X0ejBGaE8u4TxFu5FrMWC+sHtOd6t
 kaRIlWPqUzwvvxHoDii6KS/x9Ifv0HlNccTbGCe0xQuCNmQV3srtFpW8YWFCNzr1RTv7
 qM4BCkGs4Zkp2HOAEPW7/VyqVF96WtT4YyCMAjhg9LWx7AjVfledfVimFCJwhKhzQnST
 s7BKq+I2TWLn/Kk4FGj7Djdd4dRWXcH1FGGWDFt2XhSk6Q9JT2p2uyPAsvG+J9PYr7XA
 H42F+l9/txQTfp3P7eSBgaZL6zrm53L9XlGYgG+PFjRUuE19wxXdw+KwwiWz7OAoyRVV yw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 337j8aa2m3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 10:27:12 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083EPDmp053739;
        Thu, 3 Sep 2020 10:27:12 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00154901.pphosted.com with ESMTP id 33b27sr1gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 10:27:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcgpkUc3iLuGN7IwCzQxnFAtqtKZkQxmb/+dbktH0tMs9Qxzeh4ERcfVb8539bZQtES3KqfVMKjerzR1hvxbbBPuUMXX6uEl4O4gS9pEufB/uCS7wyNJydfoBw1u5EO044BlqhKKGKoF1O3cZ/AcDcmu+H0YnG6+L8x0pUU6dM+A4wspSqOYPeCnLzB0e1AUAYXQTRtr6AYT+N6pLCwe/hCA5T/V1fJDQArmih3HT4LBw914YMIF/QJrRx2RTd90dV2r0W3WyaCGwwurxkduBeg77yneI2tys6/aPvnoMqFwdTCBvP+XRc7tfa5DceUUDEo7InIpMNXT+0ICOuTclQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqoAHFB9NlnUp4IovHJYiE5FRgBAiUyLyKN8lBUqkII=;
 b=IRJoG+rZ6RqrMWTxED82rjRojD/OTqGKXhEt02GogJ1jC/Y7gY7xEI7R97kZ2EvLA6UPxhjM3u3kp5OsaL+N+PdvriUQtkwrcd1g9wJp04IehsjFY1sK73KJIEyo99feRur/4+RFBYnatZwlr+1qEgmfhr0l+TJYv5Yoi4XxWp1CyrOHvoVJWwlHC2nFBpKVqa8EPWQafhFxGsP0L7HD/lXjrkhYsgFXFUSKqQugPWm0AI38mKwjPW19ZQznCT5i5H4nmtaVcFeMvpq13ea7rPfZLvaS4sW+BEmdzf77IhgSaxFNDr0RALvUeuyx/fosPPBawKFlurFG/cuApR8izA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqoAHFB9NlnUp4IovHJYiE5FRgBAiUyLyKN8lBUqkII=;
 b=qtfDiOxFjg8mZz3gAP4xJFyRHBiJeH6ew22baPeqY31xbZAPj8wVFDyYvpZqTjhR6uP7d1Ub6bn5vEYcw9N8gpNbv0DrYSfHtCE8AuWtdAo85Rs2PjYLZawapD8gGJijI5JCLRYvBm0vQdM/LCq9DtzoBb/sU8JjhtkZeleL+RE=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (2603:10b6:5:15f::15)
 by DM5PR19MB1482.namprd19.prod.outlook.com (2603:10b6:3:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 14:27:10 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 14:27:10 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Divya Bharathi <divya27392@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Topic: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalT3MeAgAFVu4CAAfxhsA==
Date:   Thu, 3 Sep 2020 14:27:10 +0000
Message-ID: <DM6PR19MB2636225813D7359A210D8DCCFA2C0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <9b0e8473-1582-eb02-70f4-0f25d09c720c@redhat.com>
 <CAHp75Vfxgf4ttL931M08WqiWVELtZQotHvikDbmrTGkOyd=ZtQ@mail.gmail.com>
In-Reply-To: <CAHp75Vfxgf4ttL931M08WqiWVELtZQotHvikDbmrTGkOyd=ZtQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-03T14:27:08.5815747Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=98ccd2cd-0f93-4f59-8e45-badcde4dc706;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b40cb9af-888b-4aad-41b9-08d8501571bb
x-ms-traffictypediagnostic: DM5PR19MB1482:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB14823D1BCF6BC267EA14B2B5FA2C0@DM5PR19MB1482.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Nd8PH2MR09D1ZZMI/Jz/0vX3XE/suMj1quPjVBjwIv/WsqO1cUdVIRFxKtJtwKcBOzV/lTCbJC9+XhyKxzayFLQ0hnUkCyjMSABhkA/ls15fVCmSEh1Cl39tzsxbGOpe9llisP9LuhGP+cZ2PpXTtUp/BmRrzkF833Bbzk0oPJZDFNWN19tu23Z1Au8CjoI9JNqm/Ae6EUiuqArjOleeWPY6dWqAQRlV4h5kWCb0/zGQwdXP4QZOsBaI2ovcNhtVGqLjsQ5A0w1mbY9IhC0ftQ7Cbi0tXpLoKOgUecCgYzlzJlZvHVzCZjkbTGwx1hQ/L2C4G9ZyfY79ZAAGsOlTvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(376002)(396003)(346002)(136003)(366004)(26005)(6506007)(186003)(33656002)(316002)(786003)(110136005)(54906003)(7696005)(4326008)(478600001)(83380400001)(2906002)(86362001)(52536014)(8676002)(66946007)(5660300002)(71200400001)(107886003)(9686003)(55016002)(66556008)(66476007)(8936002)(64756008)(66446008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /RcVGUiPNOCdFXQvz3y4paLTXVsa+cYWDojo5nz1Ez8WHFLf89KqV+U0GcM8QNhsmpQqrJqNFvaiR4AZrTXgBYtNNqiLJvvc0IaC9oP1bl5t0s24rpNyKlQ5Aq7bIH2AYf+OXZJTsY5xGlxhNJi9o3NRSQNxkQWuXZjYxiyITwVzIT4l9xmk8uJbqL3ZEKFhyRqP9MKzPA4UR0pXZjFfPSrNbRbY1uKrP6UqI0QB7XlUJMJMzSHasw4Qv6SargY3g+KZQEsaYagMO7saTJMf8y1CJ71g7nwulyBPLiigs/N/5qOPIK1ZXYx2teWn2R81o1BJbYHFSzOi03Gv6JPVASo/THDqwsytHaiszfWLFDkhLjFXX0XO4zKeeEyHBtRwh1JD/tp+CVTmKfwtkJahKxsfe6+BAzbQEM19aCNJqXI8tJutvCU2wRKvMaT8LOtBAWlKP8f/zD4ekZP1op517ESPayCr/Nb8GkJXGQbHIt5gOLvKyIJzWvZHoHy+LXxc8tUPlbQC8VMgbWWtpk04xfSLlLIK6fVSIc5oTS7HVhe/chLwzDgUxiA4YGG2RM2rRM43/drwK9zLwPj8D6ZF0e0xBrlyYxihZNRwIE5dQWzBWnRpPdnICR61tMPEcpacwvZ4n+DbcUNW12bESsZx9Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40cb9af-888b-4aad-41b9-08d8501571bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 14:27:10.4358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QhBmnVSIkm6rqoDU/GjQlf5BURWyiXMknjzV5bt2zinC+/6k0yTjAr2gNp4piLoa9DxTPUXGd3uKHdEnQXwRYG3BtVjoWLlu0ZHVr74Q5yA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB1482
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_06:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030133
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KPiANCj4gPiA+ICtib29sIGdldF9w
ZW5kaW5nX2NoYW5nZXModm9pZCkNCj4gPiA+ICt7DQo+ID4gPiArICAgICBzdHJ1Y3Qgd21pX2lu
dGVyZmFjZV9wcml2ICpwcml2Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcHJpdiA9IGdldF9maXJz
dF9pbnRlcmZhY2VfcHJpdigpOw0KPiA+ID4gKyAgICAgaWYgKHByaXYpDQo+ID4gPiArICAgICAg
ICAgICAgIHJldHVybiBwcml2LT5wZW5kaW5nX2NoYW5nZXM7DQo+IA0KPiA+ID4gKyAgICAgcmV0
dXJuIDA7DQo+IA0KPiAwIGlzIG5vdCBib29sZWFuLg0KDQoNCkFjaw0KDQo+IA0KPiA+ID4gK30N
Cj4gDQo+IC4uLg0KPiANCj4gPiA+ICtpbnQgc2V0X2F0dHJpYnV0ZShjb25zdCBjaGFyICphX25h
bWUsIGNvbnN0IGNoYXIgKmFfdmFsdWUpDQo+ID4gPiArew0KPiANCj4gPiA+ICsgICAgIGludCBy
ZXQgPSAtMTsNCj4gPiA+ICsgICAgIGludCBpOw0KPiA+ID4gKyAgICAgdTggKm5hbWVfbGVuLCAq
dmFsdWVfbGVuOw0KPiA+ID4gKyAgICAgY2hhciAqY3VycmVudF9wYXNzd29yZCwgKmF0dHJpYnV0
ZV9uYW1lLCAqYXR0cmlidXRlX3ZhbHVlOw0KPiA+ID4gKyAgICAgc2l6ZV90IHNlY3VyaXR5X2Fy
ZWFfc2l6ZTsNCj4gPiA+ICsgICAgIHNpemVfdCBzdHJpbmdfYXJlYV9zaXplOw0KPiA+ID4gKyAg
ICAgc2l6ZV90IGJ1ZmZlcl9zaXplOw0KPiA+ID4gKyAgICAgc3RydWN0IHdtaV9pbnRlcmZhY2Vf
cHJpdiAqcHJpdjsNCj4gPiA+ICsgICAgIGNoYXIgKmJ1ZmZlcjsNCj4gDQo+IENvbnNpZGVyIHRv
IHVzZSByZXZlcnNlZCB4bWFzIHRyZWUgb3JkZXIuIEFuZCB3aGF0IC0xIG1lYW5zPw0KDQpBY2sN
Cg0KPiANCj4gPiA+ICsgICAgIC8qIGxvb2sgdXAgaWYgdXNlciBzZXQgYSBwYXNzd29yZCBmb3Ig
dGhlIHJlcXVlc3RzICovDQo+ID4gPiArICAgICBjdXJyZW50X3Bhc3N3b3JkID0gZ2V0X2N1cnJl
bnRfcGFzc3dvcmQoIkFkbWluIik7DQo+ID4gPiArICAgICBpZiAoIWN1cnJlbnRfcGFzc3dvcmQp
DQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPiA+DQo+ID4gQ2FuIHdlIGlu
c3RlYWQgb2YgcGFzc2luZyAiQWRtaW4iIGFuZCAiU3lzdGVtIiB0byB0aGlzIGZ1bmN0aW9uDQo+
ID4ganVzdCBoYXZlIDIgc2VwYXJhdGUgZ2V0X2N1cnJlbnRfYWRtaW5fcGFzc3dvcmQgYW5kDQo+
IGdldF9jdXJyZW50X3N5c3RlbV9wYXNzd29yZA0KPiA+IGhlbHBlcnMgYW5kIHRoZW4gZHJvcCB0
aGUgZXJyb3IgaGFuZGxpbmcgPw0KDQpUaGUgZXJyb3IgaGFuZGxpbmcgZm9yIC1FTk9ERVYgaXMg
YWN0dWFsbHkgaW1wb3J0YW50IGluIGNhc2UgYSBXTUkgZHJpdmVyDQp3YXMgdW5ib3VuZC4NCg0K
PiA+DQo+ID4gPiArDQo+ID4gPiArICAgICAvKiBwYXNzd29yZCBpcyBzZXQgKi8NCj4gPiA+ICsg
ICAgIGlmIChzdHJsZW4oY3VycmVudF9wYXNzd29yZCkgPiAwKQ0KPiA+ID4gKyAgICAgICAgICAg
ICBzZWN1cml0eV9hcmVhX3NpemUgPSAoc2l6ZW9mKHUzMikgKiAyKSArDQo+IHN0cmxlbihjdXJy
ZW50X3Bhc3N3b3JkKSArDQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHN0cmxlbihjdXJyZW50X3Bhc3N3b3JkKSAlIDI7DQo+ID4gPiArICAgICAvKiBwYXNzd29y
ZCBub3Qgc2V0ICovDQo+ID4gPiArICAgICBlbHNlDQo+ID4gPiArICAgICAgICAgICAgIHNlY3Vy
aXR5X2FyZWFfc2l6ZSA9IHNpemVvZih1MzIpICogMjsNCj4gPg0KPiA+IFNpbmNlIHlvdSBhcmUg
dXNpbmcgbW9yZSB0aGVuIDEgbGluZSBoZXJlIHBsZWFzZSB1c2Uge30gYXJvdW5kIHRoZSBzdGF0
ZS0NCj4gbWVudHMsDQo+ID4gYWxzbyBwbGVhc2UgcHV0IHRoZSAvKiBwYXNzd29yZCBub3Qgc2V0
ICovIGFmdGVyIHRoZSBlbHNlOg0KPiA+DQo+ID4gICAgICAgICAgICAgICAgIC4uLg0KPiA+ICAg
ICAgICAgfSBlbHNlIHsgLyogcGFzc3dvcmQgbm90IHNldCAqLw0KPiA+ICAgICAgICAgICAgICAg
ICAuLi4NCj4gPg0KPiA+ID4gKyAgICAgc3RyaW5nX2FyZWFfc2l6ZSA9IChzdHJsZW4oYV9uYW1l
KSArIHN0cmxlbihhX3ZhbHVlKSkqMjsNCj4gPiA+ICsgICAgIGJ1ZmZlcl9zaXplID0gc2VjdXJp
dHlfYXJlYV9zaXplICsgc3RyaW5nX2FyZWFfc2l6ZSArIHNpemVvZih1MTYpICoNCj4gMjsNCj4g
PiA+ICsNCj4gPiA+ICsgICAgIGJ1ZmZlciA9IGt6YWxsb2MoYnVmZmVyX3NpemUsIEdGUF9LRVJO
RUwpOw0KPiANCj4gQWN0dWFsbHkgYWJvdmUgbG9va3MgbGlrZSBob21lIGdyb3duIGthc3ByaW50
ZigpIGltcGxlbWVudGF0aW9uLg0KDQpJIGRvbid0IHRoaW5rIHNvLCBzcHJpbnRmIGlzbid0IHVz
ZWQgYXQgYWxsIGhlcmUuICBJdCdzIGEgY2FsY3VsYXRpb24gdG8gZGV0ZXJtaW5lDQp0aGUgc2l6
ZSBvZiB0aGUgYnVmZmVyIHRvIHVzZS4NCg0KPiANCj4gPiA+ICsgICAgIGlmICghYnVmZmVyKQ0K
PiA+ID4gKyAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gPiA+ICsNCj4gPiA+ICsgICAg
IC8qIGJ1aWxkIHNlY3VyaXR5IGFyZWEgKi8NCj4gPiA+ICsgICAgIGlmIChzdHJsZW4oY3VycmVu
dF9wYXNzd29yZCkgPiAwKQ0KPiA+ID4gKyAgICAgICAgICAgICBwb3B1bGF0ZV9zZWN1cml0eV9i
dWZmZXIoYnVmZmVyLCBjdXJyZW50X3Bhc3N3b3JkKTsNCj4gDQo+ID4gPiArICAgICBuYW1lX2xl
biA9IGJ1ZmZlciArIHNlY3VyaXR5X2FyZWFfc2l6ZTsNCj4gPiA+ICsgICAgIGF0dHJpYnV0ZV9u
YW1lID0gbmFtZV9sZW4gKyBzaXplb2YodTE2KTsNCj4gPiA+ICsgICAgIHZhbHVlX2xlbiA9IGF0
dHJpYnV0ZV9uYW1lICsgc3RybGVuKGFfbmFtZSkqMjsNCj4gPiA+ICsgICAgIGF0dHJpYnV0ZV92
YWx1ZSA9IHZhbHVlX2xlbiArIHNpemVvZih1MTYpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgLyog
dHVybiBpbnRvIFVURjE2IHN0cmluZ3MsIG5vIE5VTEwgdGVybWluYXRvciAqLw0KPiA+ID4gKyAg
ICAgKm5hbWVfbGVuID0gc3RybGVuKGFfbmFtZSkqMjsNCj4gPiA+ICsgICAgICp2YWx1ZV9sZW4g
PSBzdHJsZW4oYV92YWx1ZSkqMjsNCj4gPiA+ICsgICAgIGZvciAoaSA9IDA7IGkgPCBzdHJsZW4o
YV9uYW1lKTsgaSsrKQ0KPiA+ID4gKyAgICAgICAgICAgICBhdHRyaWJ1dGVfbmFtZVtpKjJdID0g
YV9uYW1lW2ldOw0KPiA+ID4gKyAgICAgZm9yIChpID0gMDsgaSA8IHN0cmxlbihhX3ZhbHVlKTsg
aSsrKQ0KPiA+ID4gKyAgICAgICAgICAgICBhdHRyaWJ1dGVfdmFsdWVbaSoyXSA9IGFfdmFsdWVb
aV07DQo+ID4NCj4gPiBUaGlzIGFzc3VtZXMgdGhlIGluY29taW5nIHN0cmluZyBpcyBBU0NJSSBv
bmx5IGFuZCB3b24ndA0KPiA+IHdvcmsgd2hlbiB0aGUgaW5jb21pbmcgc3RyaW5nIGlzIFVURi04
LiBJdCBpcyBwcm9iYWJseQ0KPiA+IGJldHRlciB0byB1c2UgdGhlIHV0ZjhzX3RvX3V0ZjE2cygp
IGhlbHBlciBmcm9tIHRoZSBubHMNCj4gPiBjb2RlLCB0aGlzIHdpbGwgbWVhbiBhZGRpbmcgYSBk
ZXBlbmRlbmN5IG9uIENPTkZJR19OTFMNCj4gPiB3aGljaCB0eXBpY2FsbHkgaXMgdXNlZCBmb3Ig
ZmlsZXN5c3RlbSBjb2RlLCBidXQgSSB0aGluaw0KPiA+IHRoYXQgdGhhdCB3aWxsIGJlIGZpbmUu
DQo+IA0KPiArMS4gQWxzbyBteSB0aG91Z2h0Lg0KDQpBY2sNCg0KPiANCj4gPiA+ICsgICAgIG11
dGV4X2xvY2soJmNhbGxfbXV0ZXgpOw0KPiA+ID4gKyAgICAgcHJpdiA9IGdldF9maXJzdF9pbnRl
cmZhY2VfcHJpdigpOw0KPiA+ID4gKyAgICAgaWYgKCFwcml2KSB7DQo+ID4gPiArICAgICAgICAg
ICAgIHJldCA9IC1FTk9ERVY7DQo+IA0KPiA+ID4gKyAgICAgICAgICAgICBwcl9lcnIoRFJJVkVS
X05BTUUgIjogbm8gV01JIGJhY2tlbmQgYm91bmQiKTsNCj4gDQo+IElmIHlvdSB3aXNoLCBkZWZp
bmUgcHJfZm10KCkgcmF0aGVyIHRoYW4gcHV0dGluZyB0aGlzIERSSVZFUl9OQU1FIHRvDQo+IGVh
Y2ggb2YgdGhlIHByXyooKSBjYWxsLg0KDQpBY2ssIHdlJ2xsIGFkZCBwcl9mbXQuDQoNCj4gDQo+
ID4gPiArICAgICAgICAgICAgIGdvdG8gb3V0X3NldF9hdHRyaWJ1dGU7DQo+ID4gPiArICAgICB9
DQo+ID4gPiArDQo+ID4gPiArICAgICByZXQgPSBjYWxsX2Jpb3NhdHRyaWJ1dGVzX2ludGVyZmFj
ZShwcml2LT53ZGV2LCBidWZmZXIsIGJ1ZmZlcl9zaXplLA0KPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNFVEFUVFJJQlVURV9NRVRIT0RfSUQpOw0K
PiA+ID4gKyAgICAgaWYgKHJldCA9PSAtRU9QTk9UU1VQUCkNCj4gPiA+ICsgICAgICAgICAgICAg
ZGV2X2VycigmcHJpdi0+d2Rldi0+ZGV2LCAiYWRtaW4gcGFzc3dvcmQgbXVzdCBiZQ0KPiBjb25m
aWd1cmVkIik7DQo+ID4gPiArICAgICBlbHNlIGlmIChyZXQgPT0gLUVBQ0NFUykNCj4gPiA+ICsg
ICAgICAgICAgICAgZGV2X2VycigmcHJpdi0+d2Rldi0+ZGV2LCAiaW52YWxpZCBwYXNzd29yZCIp
Ow0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcHJpdi0+cGVuZGluZ19jaGFuZ2VzID0gMTsNCj4gPiA+
ICtvdXRfc2V0X2F0dHJpYnV0ZToNCj4gPiA+ICsgICAgIGtmcmVlKGJ1ZmZlcik7DQo+ID4gPiAr
ICAgICBtdXRleF91bmxvY2soJmNhbGxfbXV0ZXgpOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmV0
dXJuIHJldDsNCj4gPiA+ICt9DQo+IA0KPiBBYm92ZSBjb21tZW50cywgYXMgYSBydWxlIG9mIHRo
dW1iLCBzaG91bGQgYmUgY29uc2lkZXJlZCBhZ2FpbnN0DQo+IGVudGlyZSBjb2RlICh3aGVyZSBh
cHByb3ByaWF0ZSBhbmQgYXBwbGljYWJsZSkuDQoNClRoYW5rcywgdGhlIHRlYW0gd2lsbCBhZGp1
c3QgYWdhaW5zdCBhbGwgdGhlIGNvZGUgZm9yIHRoZSBuZXh0IHBhdGNoLg0KDQo=
