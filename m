Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F16DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3020767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Cj+8qDTm";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=Dell.onmicrosoft.com header.i=@Dell.onmicrosoft.com header.b="mSfKUcz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgIAOdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:33:12 -0400
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:2644 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728258AbgIAOWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:22:51 -0400
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081ELiCG014279;
        Tue, 1 Sep 2020 10:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=Gt9Mr6ywhiaz3E3I4w6AvljDD19HAqQmbXOlYPK0cf0=;
 b=Cj+8qDTmZQHN9yuxP9iz9qvaTxwLA4W1rBGl3vQw5Sct28G6ppIp7yYP1X/p46K/nMc5
 IJIGtbe4YXYHPxOVv+uwSu6fvO8dF1cwW9tN5PA5Sk1wddXmD/BnG6QEcAyBiI4htiHL
 jxseEH64OuVMLlUt6hVh4YK1pDUTH2oO0b+orxVgoPRkCWgQMAvvAbv8Za24eKtQxiCH
 F1WRfi/cczj5RHKKJ1/y/tzd4JHVvk82NiavnWxHORlJcPtkUvQZ9arcjQjweRFJecSc
 dSMgY7Hs77QsiMaDtdjqN79l8uTTB4eG9eefQbM1fNnyCFmyRpE8K79KxSdixOozSBGl 3g== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 337ygy8ab0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Sep 2020 10:22:46 -0400
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 081EFFJW083686;
        Tue, 1 Sep 2020 10:22:45 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00154901.pphosted.com with ESMTP id 339qjaghwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Sep 2020 10:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hn5shP4qiW+8velA9ECLTdu8wSFg9f+KjDizGfigQVoa/+mQr3lTQgv6wlkGL/kWcUBBGWF0kcH3+dp+Jt/7hBjY+kR8PHI0YMsbDjXysVFzZETW1LoOFNpam4hwgILPalKpJdFsIWqoMhaft1QDiZcZaYexi21lExkZFBpOj/ToXTDYY+1SvU/j7/ZCsTLltQzx5QTjIvnp2ZFdt9gOOxBGI1lrvIPHh46p8GLPmyQPbUUA8cvy1mj/KVhEr4N1/uRbux1nrRfR1xjJKKLwMf+wuDweGd8PVI895whXc+LSJzWWunC8HkQaQANb/h+m763FeQtammUz9t5V/ip3SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt9Mr6ywhiaz3E3I4w6AvljDD19HAqQmbXOlYPK0cf0=;
 b=RWHPTBfH49bXMG79oTAn7+OgQUUfoWn/MbLOMr2IPqhP1yUVAiC5owRSJrp175rN/QJ9wKbFLq30cDqG0oBxuMvAGLV778g2iof+MHawbumwBtcwoCt1+bBkZ1BzaUmXBV+ONStqTqsHkADbpXvv0FKGbxmKBMJ3Rg/ULJZtIvAkjok8UQ/P4+UwXsfseE501bE3uUR6cUiX/uzRP+D1YbkmU55LJ1uC00t66LemKe2/x2AEpRuB2yXvvGpYk/LEuOwZjumCVyjOCuOhICiWDmxKAWPZrMc7k30K8CJFi9CtbFBpk8Mvcou4rsM1+SoDYWdGBNQxm7Op9WMG/8c9zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Dell.onmicrosoft.com;
 s=selector1-Dell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt9Mr6ywhiaz3E3I4w6AvljDD19HAqQmbXOlYPK0cf0=;
 b=mSfKUcz2r1EZb7XuFKZMWyAqSDlQYrEwzH9tePwPSYFy4uEkzarprLkVDdlXWibeWWGoEnbkBFoOo5UGfsPfHr0wUoUsJwk0hSfREOxbr41WO1wCAAtcGsJzpFIjWSiG07LfG9uDA1uglKT7KlkThzqzgLZi0tl1tpJyTWDM2QE=
Received: from DM6PR19MB2636.namprd19.prod.outlook.com (20.179.71.207) by
 DM5PR19MB0092.namprd19.prod.outlook.com (10.164.154.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.22; Tue, 1 Sep 2020 14:22:44 +0000
Received: from DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2]) by DM6PR19MB2636.namprd19.prod.outlook.com
 ([fe80::a4b8:d5c9:29da:39b2%4]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 14:22:44 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Divya Bharathi <divya27392@gmail.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "Bharathi, Divya" <Divya.Bharathi@Dell.com>,
        "Ksr, Prasanth" <Prasanth.Ksr@dell.com>
Subject: RE: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Topic: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
Thread-Index: AQHWZn4rqCTeVrGp2k+MCJMiO1QTGalTwuQAgABF0HA=
Date:   Tue, 1 Sep 2020 14:22:44 +0000
Message-ID: <DM6PR19MB26362B2A2CDFE73BE167FD34FA2E0@DM6PR19MB2636.namprd19.prod.outlook.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
 <aa23d8b8-6c6b-b6f2-e916-1defff8a9b26@redhat.com>
In-Reply-To: <aa23d8b8-6c6b-b6f2-e916-1defff8a9b26@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2020-09-01T14:19:32.3197945Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=61b705c7-11db-43f5-b531-9dc61ade6054;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [172.58.99.112]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 695ab3d6-0410-4e76-1676-08d84e827e20
x-ms-traffictypediagnostic: DM5PR19MB0092:
x-ld-processed: 945c199a-83a2-4e80-9f8c-5a91be5752dd,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR19MB00924F4FA51426CE80C9C4D6FA2E0@DM5PR19MB0092.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuyTU/pmVedGTnoVMVFU8HfE/HEGixU64+hLXg4ghvimfhU4cDai1tQshxVpRF0M/sQCWGIxfpJjRXU2mr4lT0yQb+1iSK/5hnzWzB9tO0n+KWxObWXwbdI7A+JHxT5uWKyntLlLG06DAaDQMJL2VjECsRNd/+4glD0qEapP0mWRKcbBKsR37hM27O7oSxZ/HNIpmxfu0mcxd5eDldYroM13K5jSqAfTC9ZGHYClYWXxpD/zmBlLek3TIDyiNF92IzrNcKQoT7804Pwz4yHC08x4erpZoA561J/b/wc4+P0Mj0doJQ+qwD+RDC+O3JLqwyQfMfGQd4F68mbGIOvRWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR19MB2636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(396003)(366004)(136003)(66476007)(4326008)(52536014)(8676002)(66556008)(478600001)(83380400001)(71200400001)(8936002)(66946007)(786003)(316002)(64756008)(66446008)(33656002)(6506007)(2906002)(86362001)(107886003)(26005)(186003)(76116006)(54906003)(55016002)(5660300002)(7696005)(9686003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: APeTYyk5n6i7zCuemRA4YcQcmYwPITMeAVgrlgSNcdi+FNqpOCMyj8UqK5c/OEM5OKI6fnQCrgpmuMW223P/6D76d0qGrtHzrOierHcQjqcTdYhX6lpFbD9iGuTPQrN6cM8uS6keqW6r1Bipz9jtkexXD1JQFzcuQv3je6lo+XiiAV7w69ioB+B79LfxH0cWDG4eq/VAiFLtCZAMgS8Z3Ek3Zk+JRlukANtzA6YA1r+B8Ufd7rKfnOV+1UHkxbSZdQY+bDhbojlyoal4gyicHzI/Xq6FxY9aCCxenXRZQkz359MBZ92gZjtosN2sdT4KVIO2AMeAut3bTjCMmShKgXXv8N6rhhHkslUSy7XkoyD9mnz1sEu/QyixcT/J4RnReXNTOQNtnntcr3FVjI11rywFRnNl24etwLw13DAvrphQ+ZClxwJxWGjJ9H1vMOwwQOXFt+seggaEHFTpfkbyXNbQ9d8bHwxmlTgSdzSg5SXhtyesJwCENo9S9tbLa6kn3ZWjo1Z7O6BhebvVqJX6zD7MPyJsBNzCjWbsq/S8eqi04c17DJXpCcVxYy+dLFZ13Zk69VNrllICK69YZ6Qt3yM5wvKpWKVEz7DZOFJNDvRI5NfZA5BKBettd/wL4mN+DcDRg5JXp3dIWswVa/jSlw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR19MB2636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695ab3d6-0410-4e76-1676-08d84e827e20
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 14:22:44.0323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ruBRtREmZDgw2iJdxPI0ZLfv5Dsi0/tq35xLfocAVsg7yltHby8UZYQa5mWV4FB27bd+hf45RWOhD8Eg+bDdR+7fMcaSTLoSeE4HI/cxGE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR19MB0092
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-01_08:2020-09-01,2020-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009010119
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009010121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pg0KPiAiQSByZWFkLW9ubHkgYXR0cmlidXRlIGVudW1lcmF0aW5nIGlmIGEgcmVib290IGlzIHBl
bmRpbmcgb24gYW55IEJJT1MgYXR0cmlidXRlDQo+IGNoYW5nZS4iDQo+IGRvZXMgbm90IHJlYWxs
eSBzZWVtIHRvIG1ha2UgbXVjaCBzZW5zZS4gSSBndWVzcyB3aGF0IHRoaXMgaXMgdHJ5aW5nIHRv
IHNheSBpczoNCj4NCj4gIlRoaXMgcmVhZC1vbmx5IGF0dHJpYnV0ZSByZWFkcyAxIGlmIGEgcmVi
b290IGlzIG5lY2Vzc2FyeSB0byBhcHBseSBwZW5kaW5nIEJJT1MNCj4gYXR0cmlidXRlIGNoYW5n
ZXMiPw0KPg0KPiAgICAgICAgICAgICAgIDA6ICAgICAgQWxsIEJJT1MgYXR0cmlidXRlcyBzZXR0
aW5nIGFyZSBjdXJyZW50DQo+ICAgICAgICAgICAgICAgMTogICAgICBBIHJlYm9vdCBpcyBuZWNl
c3NhcnkgdG8gZ2V0IHBlbmRpbmcgcGVuZGluZyBCSU9TIGF0dHJpYnV0ZQ0KPiBjaGFuZ2VzIGFw
cGxpZWQNCj4NCj4gT3Igc29tZSBzdWNoLiBJJ20gbm90IHJlYWxseSBoYXBweSB3aXRoIG15IG93
biB0ZXh0IGVpdGhlciwgYnV0IEkgdGhpbmsgaXQNCj4gYmV0dGVyIGV4cGxhaW5zDQo+IHdoYXQg
dGhpcyBhdHRyaWJ1dGUgaXMgYWJvdXQgdGhlbiB0aGUgb3JpZ2luYWwgdGV4dCwgcmlnaHQgPw0K
DQpJIHRoaW5rIHRoYXQgdGV4dCBkb2VzIHJlYWQgYmV0dGVyLCBEaXZ5YSBhbmQgdGVhbSB3aWxs
IHJld29yZCBpdC4NCg0KPHNuaXA+DQoNCj4gPiArICAgICAgICAgICBkaXNwbGF5X25hbWVfbGFu
Z3VhZ2VfY29kZTogICAgIEEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbg0KPiA+ICsg
ICAgICAgICAgIHRoZSBsYW5ndWFnZSBjb2RlIGNvcnJlc3BvbmRpbmcgdG8gdGhlICJkaXNwbGF5
X25hbWUiIG9mIHRoZSA8YXR0cj4NCj4NCj4gVGhpcyBuZWVkcyB0byBiZSBzcGVjaWZpZWQgYmV0
dGVyLCBlLmcuIHRoaXMgbmVlZHMgdG8gc2F5IHRoYXQgdGhpcyBpcyBhbg0KPiBJU08gNjM54oCR
MSBsYW5ndWFnZSBjb2RlIChvciBzb21lIG90aGVyIGxhbmd1YWdlLWNvZGUgc3BlY2lmaWNhdGlv
bikNCg0KQWNrLg0KDQo+DQo+DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIG1vZGlmaWVyOiAgICAg
ICBBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBvYnRhaW4gYXR0cmlidXRlLWxldmVsDQo+ID4g
KyAgICAgICAgICAgZGVwZW5kZW5jeSBydWxlIHdoaWNoIGhhcyB0byBiZSBtZXQgdG8gY29uZmln
dXJlIDxhdHRyPg0KPg0KPiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdlZW4gbW9kaWZpZXIg
YW5kIHZhbHVlX21vZGlmaWVyID8gQWxzbyB0aGlzIG5lZWQgdG8NCj4gYmUgc3BlY2lmaWVkIGlu
IG1vcmUgZGV0YWlsLg0KDQpBY2suDQoNCj4NCj4gPiArDQo+ID4gKyAgICAgICAgICAgcG9zc2li
bGVfdmFsdWU6IEEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUgcG9zc2libGUN
Cj4gPiArICAgICAgICAgICB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+DQo+IFRoaXMgaXMgYW4gZW51
bSwgc28gcG9zc2libGUgdmFsdWVfc18gPyAgSSBhc3N1bWUgdGhhdCBmb3IgYSBlbnVtIHRoaXMg
d2lsbCBsaXN0DQo+IGFsbCBwb3NzaWJsZSB2YWx1ZXMsIHRoaXMgYWxzbyBuZWVkcyB0byBzcGVj
aWZ5IGhvdyB0aGUgcG9zc2libGUgdmFsdWVzIHdpbGwgYmUNCj4gc2VwYXJhdGVkIChlLmcuIHVz
aW5nIHNlbWktY29sb25zIG9yIG5ld2xpbmVzIG9yIC4uLikuDQoNClllcyBjb3JyZWN0Lg0KDQo+
DQo+DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIHZhbHVlX21vZGlmaWVyOiBBIGZpbGUgdGhhdCBj
YW4gYmUgcmVhZCB0byBvYnRhaW4gdmFsdWUtbGV2ZWwNCj4gPiArICAgICAgICAgICBkZXBlbmRl
bmN5IG9uIGEgcG9zc2libGUgdmFsdWUgd2hpY2ggaGFzIHRvIGJlIG1ldCB0byBjb25maWd1cmUN
Cj4gPGF0dHI+DQo+ID4gKw0KPiA+ICtXaGF0OiAgICAgICAgICAgICAgL3N5cy9kZXZpY2VzL3Bs
YXRmb3JtL2RlbGwtd21pLQ0KPiBzeXNtYW4vYXR0cmlidXRlcy9pbnRlZ2VyLzxhdHRyPi8NCj4g
PiArRGF0ZTogICAgICAgICAgICAgIE9jdG9iZXIgMjAyMA0KPiA+ICtLZXJuZWxWZXJzaW9uOiAg
ICAgNS45DQo+ID4gK0NvbnRhY3Q6ICAgRGl2eWEgQmhhcmF0aGkgPERpdnlhLkJoYXJhdGhpQERl
bGwuY29tPiwNCj4gPiArICAgICAgICAgICBNYXJpbyBMaW1vbmNpZWxsbyA8bWFyaW8ubGltb25j
aWVsbG9AZGVsbC5jb20+LA0KPiA+ICsgICAgICAgICAgIFByYXNhbnRoIEtTUiA8cHJhc2FudGgu
a3NyQGRlbGwuY29tPg0KPiA+ICtEZXNjcmlwdGlvbjoNCj4gPiArICAgICAgICAgICBUaGlzIGRp
cmVjdG9yeSBleHBvc2VzIGludGVyZmFjZXMgZm9yIGludGVyYWN0aW9uIHdpdGgNCj4gPiArICAg
ICAgICAgICBCSU9TIGludGVnZXIgYXR0cmlidXRlcy4NCj4gPiArDQo+ID4gKyAgICAgICAgICAg
SW50ZWdlciBhdHRyaWJ1dGVzIGFyZSBzZXR0aW5ncyB0aGF0IGFjY2VwdCBhIHJhbmdlIG9mDQo+
ID4gKyAgICAgICAgICAgbnVtZXJpY2FsIHZhbHVlcyBmb3IgaW5wdXRzLiBFYWNoIEJJT1MgaW50
ZWdlciBoYXMgYQ0KPiA+ICsgICAgICAgICAgIGxvd2VyIGJvdW5kIGFuZCBhbiB1cHBlciBib3Vu
ZCBvbiB0aGUgdmFsdWVzIHRoYXQgaXQgY2FuIHRha2UuDQo+ID4gKw0KPiA+ICsgICAgICAgICAg
IGN1cnJlbnRfdmFsdWU6ICBBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBvYnRhaW4gdGhlIGN1
cnJlbnQNCj4gPiArICAgICAgICAgICB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+ID4gKw0KPiA+ICsg
ICAgICAgICAgIFRoaXMgZmlsZSBjYW4gYWxzbyBiZSB3cml0dGVuIHRvIGluIG9yZGVyIHRvIHVw
ZGF0ZQ0KPiA+ICsgICAgICAgICAgIHRoZSB2YWx1ZSBvZiBhbiA8YXR0cj4uDQo+ID4gKw0KPiA+
ICsgICAgICAgICAgIGRlZmF1bHRfdmFsdWU6ICBBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBv
YnRhaW4gdGhlIGRlZmF1bHQNCj4gPiArICAgICAgICAgICB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+
ID4gKw0KPiA+ICsgICAgICAgICAgIGRpc3BsYXlfbmFtZTogICBBIGZpbGUgdGhhdCBjYW4gYmUg
cmVhZCB0byBvYnRhaW4gYSB1c2VyIGZyaWVuZGx5DQo+ID4gKyAgICAgICAgICAgZGVzY3JpcHRp
b24gb2YgdGhlIGF0IDxhdHRyPg0KPiA+ICsNCj4gPiArICAgICAgICAgICBkaXNwbGF5X25hbWVf
bGFuZ3VhZ2VfY29kZTogICAgIEEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbg0KPiA+
ICsgICAgICAgICAgIHRoZSBsYW5ndWFnZSBjb2RlIGNvcnJlc3BvbmRpbmcgdG8gdGhlICJkaXNw
bGF5X25hbWUiIG9mIHRoZSA8YXR0cj4NCj4gPiArDQo+ID4gKyAgICAgICAgICAgbG93ZXJfYm91
bmQ6ICAgIEEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUgbG93ZXINCj4gPiAr
ICAgICAgICAgICBib3VuZCB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+ID4gKw0KPiA+ICsgICAgICAg
ICAgIG1vZGlmaWVyOiAgICAgICBBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBvYnRhaW4gYXR0
cmlidXRlLWxldmVsDQo+ID4gKyAgICAgICAgICAgZGVwZW5kZW5jeSBydWxlIHdoaWNoIGhhcyB0
byBiZSBtZXQgdG8gY29uZmlndXJlIDxhdHRyPg0KPiA+ICsNCj4gPiArICAgICAgICAgICBzY2Fs
YXJfaW5jcmVtZW50OiAgICAgICBBIGZpbGUgdGhhdCBjYW4gYmUgcmVhZCB0byBvYnRhaW4gdGhl
DQo+ID4gKyAgICAgICAgICAgcmVzb2x1dGlvbiBvZiB0aGUgaW5jcmVtZW50YWwgdmFsdWUgdGhp
cyBhdHRyaWJ1dGUgYWNjZXB0cy4NCj4gPiArDQo+ID4gKyAgICAgICAgICAgdXBwZXJfYm91bmQ6
ICAgIEEgZmlsZSB0aGF0IGNhbiBiZSByZWFkIHRvIG9idGFpbiB0aGUgdXBwZXINCj4gPiArICAg
ICAgICAgICBib3VuZCB2YWx1ZSBvZiB0aGUgPGF0dHI+DQo+DQo+IEFyZSB0aGVzZSBpbnRlZ2Vy
cyBvciBhbHNvIHBvc3NpYmx5IGZsb2F0cz8gSSBndWVzcyBwb3NzaWJseSBhbHNvIGZsb2F0cywg
cmlnaHQ/DQo+IFRoZW4gYXQgYSBtaW5pbXVtIHRoaXMgc2hvdWxkIHNwZWNpZnkgd2hpY2ggZGVj
aW1hbC1zZXBhcmF0b3IgaXMgdXNlZCAoSSBhc3N1bWUNCj4gd2Ugd2lsbCBnbyB3aXRoIHRoZSB1
c3VhbCAnLicgYXMgZGVjaW1hbCBzZXBhcmF0b3IpLg0KDQpJbiBwcmFjdGljZSB0aGV5J3JlIGlu
dGVnZXJzLCBidXQgSSBkb24ndCBzZWUgd2h5IHRoZXkgY291bGRuJ3QgYmUgZmxvYXRzLg0KDQoN
Cg==
