Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B274C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8F52075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="q03SVpgx";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="AR9C3ytx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgFHAkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:40:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25360 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728001AbgFHAku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:40:50 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0580boHW015753;
        Sun, 7 Jun 2020 17:40:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=dLulr0KYNV/HrNxsEiQPaHy0R2fJXRjjE7XJWpoD0t8=;
 b=q03SVpgxJWIgIjrj52j9DKJ2xHN2PvhrHnbfFL1lVzCSQUcOYIAui/CeqGCOxl+o8aqK
 lfcds6Q9xiahMJ+eyfuU2pTTQ6If6ox53AkwvWgBAgOQHVueZridt8nF2apkKgqTlNwO
 SQdED31P+FZ3JFDy0XPRZwLSxcTTgCA1DqU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 31g6tkcykx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 07 Jun 2020 17:40:43 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 7 Jun 2020 17:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIHCWJMDEvnNo7q08SBcrI3gKMcITdXjboGhF3d77Grg2viCEwDT3llvIwVeLJor1ATrVPHo29nMc4HHjtrMYBq0UZ947Q3WuHODjsPlhWCfpeP/nOSO/tFIKb7wLUvz9+71Safn9NLDmQgIAcYBXzpocA9wQyGlqUBZ0m4XuwbRm4t6gxX6dqVOpOrKI4RWFi6fdFa80obn7ew0hsZGZf/9ll6vAEh5T0M1b6GjHbrWDTogMLCnt8pW6V/SnVmffHdP5qql5X1Kj9ym/xRekZaDh9CDZaVDxPae0sKEBDzXVk5ELmoHakq8gzLr6AVpPNr+YY2xCrFQuZUrkpvfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLulr0KYNV/HrNxsEiQPaHy0R2fJXRjjE7XJWpoD0t8=;
 b=fn8Ko1OtKFTmkhb9wmASQ5ClbSQay//9ePHVDJUUMCwfr193D/CEW4V5Qkqgn78AmLpPwGQxFbJ63yB7c7ORguGDm0kk85KTPScv2uTI3IoUGmdSvneEyEh5hYBxl46obegCZ0mKwPBZogl4hm4m1QLS9vMBFtQooWS0kbUhIKF4K8CSK6psp9ez7Uou3eFSLIAxbOYDEl3ivkhDzh8In3+JBTEgOuh/L+oVgOsr2JYWIJWF+IrFh3jcgCdB9VNR08GG5gWS3fIglJdSBfy5QowCraVMvZGy899NHAAm4dCWHpBfzOO1WxKkK6a8LYSme2aPIZbkhyF8Cf6b9Haxug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLulr0KYNV/HrNxsEiQPaHy0R2fJXRjjE7XJWpoD0t8=;
 b=AR9C3ytxdUQM8kFeK2LtmMz5L/fYsPe+ztX4gHwb7vTt0DbJ3C8bnSNY2N5JhJZ8PUGuFV9MBLUEG+EYQ2wUmYJyMFDUVsiYoUqnBqOwKT3uMLecPxVByfdRF2WWMJhhrD6QtRml3VWc9af98bm7n3kWOnlLzHFhNMDvWjBgucY=
Received: from BY5PR15MB3697.namprd15.prod.outlook.com (2603:10b6:a03:1b3::32)
 by BY5PR15MB3683.namprd15.prod.outlook.com (2603:10b6:a03:1b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 00:40:26 +0000
Received: from BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::7972:45aa:234f:723e]) by BY5PR15MB3697.namprd15.prod.outlook.com
 ([fe80::7972:45aa:234f:723e%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 00:40:26 +0000
From:   Yann Collet <cyan@fb.com>
To:     Vasily Averin <vvs@virtuozzo.com>, Gao Xiang <hsiangkao@aol.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
Thread-Topic: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
Thread-Index: AQHWPBV4OwGdykNppkSCX6Z2FqRR66jNbUiA
Date:   Mon, 8 Jun 2020 00:40:26 +0000
Message-ID: <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
 <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
In-Reply-To: <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.37.20051002
authentication-results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2601:641:500:c800:8f8:c5b9:7f45:4cf3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41673dce-4fe6-4fce-9c5f-08d80b4489a3
x-ms-traffictypediagnostic: BY5PR15MB3683:
x-microsoft-antispam-prvs: <BY5PR15MB3683385BF9599137538029F7A4850@BY5PR15MB3683.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bOS1GR3o1cI63ul4OFf/KV+OxYy8SXluqjf8WBobpKbksf+YnLNbUL8GFK5tnRF5Qk+36lEkPp9FaTkEBaTZNEOjZIrtA7dUGKUCKyOP6AEopRemoxUz3wZLjIp6GaMtYgw7VddZTrnrvQ3Zx/GY2M3KQBUNp9Ffx6p/MczU0rC9PLq7sdiuQUzRqIBacFyyyGWMtTfzpiePM2L+Ewp2YMusrtgH58Jj2sFlzMmCls9OhMz5CY2GRNi8qvwmDPiwrWhIh7x1LsFya9CDb7ufDGpH/4IUS5hgnvIUhCJ5ErsB4RadJSNLlXrz2QkDI/sAHzGUpzLKpP9P6Mn0TZe9GLyfp3+we5vCPT5OS7onzkF9HBzuAfCjiwn02g15p085Ldkqb1lbVl/O2Ixic0jEjC6ukRodR6VSl+cbn9lFy6mUHWgDVXhSGEpa6dG2GefMT1xniXiDf8FTbJYcTEmOiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3697.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(76116006)(186003)(36756003)(6506007)(64756008)(53546011)(66556008)(966005)(66446008)(66946007)(54906003)(66476007)(6512007)(6486002)(71200400001)(83380400001)(478600001)(4326008)(5660300002)(110136005)(8676002)(33656002)(86362001)(316002)(8936002)(2616005)(2906002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ImDH1zQdr0RD0u6qp4w4YKKPYQxmyt8Ya6xqQgYYSim8twzCtjEiMIjQ0fq8nVQYkXxU+vJzHDlmIpzm1VKUF/K2AJTHv7tlONSi+GuMWqQsif8psmflQCFj6kfk22kGlOrfbVkAVHWmJ0x9bZ5iHz0TdtZ2PiS9wP5L02xeqQ7Vm9QanzQMns5xZHqmVBP1m5++p6EuGls6v9MSpkhyriROPjx3RlFJ+FXJyCmBCsN//Hn9w3Pr2Vf25LFdeAHG6LXlcv6BO1CgJ+ZdZSG00DCj4/qAVlvtrstzehXiYal/NpZByjrRsooEqJLv//g8L4V+p9k7aBGoU013k41BxtfW+K0OOPm8gQIx6JQhcEC1vPTfDBz8yQA4F2T/9hbpUvPY000O0KQBbq/lTSIrPzXp1Mq10pGA++Ju9oc2g4nBzEfJrIyq0xapGssh0adfIzgtEDphWV5MaJYew9wVmpmoPX/B3g9Qb3MMq9SVLE7JdUJxZUCI8KKBdIg2OeSSczKWBLp0nA2f7+g8Q1TpjkO99NwQOMuxuMsqSjBet3s=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D26ED0AE03E449478E2CCDDCEE395BA7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 41673dce-4fe6-4fce-9c5f-08d80b4489a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 00:40:26.6168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xI8l0vPs+IBh/60zwiGCbfqSS6ep7833c/oeVe2BmrtPSRmJThFD5Z0uhfvMthY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3683
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-07_13:2020-06-04,2020-06-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1011 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006080002
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmFzaWx5DQoNCg0KSWYgSSBkbyB1bmRlcnN0YW5kIHRoZSBkaXNjdXNzaW9uLCB0aGUgcXVl
c3Rpb24gaXMgYWJvdXQgdXNhZ2Ugb2YgYCZgIGluc3RlYWQgb2YgYCYmYCwNCmFuZCB0aGUgc3Bl
Y3VsYXRpb24gdGhhdCBpdCBtaWdodCBiZSBhbiBlcnJvci4NCg0KSXQncyBub3QgYW4gZXJyb3Iu
IFVuZm9ydHVuYXRlbHksIGV4cGxhaW5pbmcgdGhlIHJlYXNvbmluZyBiZWhpbmQgdGhpcyBkZWNp
c2lvbiBpcyBhIGJpdCBsb25nLg0KDQpGaXJzdCwgaW4gdGVybSBvZiBvdXRjb21lLCBJIGJlbGll
dmUgaXQgc2hvdWxkIGJlIGNsZWFyIHRoYXQgOiANCihlbmRPbklucHV0ID8gaXAgPCBzaG9ydGll
bmQgOiAxKSAmJiAob3AgPD0gc2hvcnRvZW5kKQ0KaXMgY29tcGxldGVseSBlcXVpdmFsZW50IHRv
IDogDQooZW5kT25JbnB1dCA/IGlwIDwgc2hvcnRpZW5kIDogMSkgJiAob3AgPD0gc2hvcnRvZW5k
KQ0KDQpOb3RlIHRoYXQgb25lIGNhbm5vdCBqdXN0IG1pbmRsZXNzbHkgcmVwbGFjZSAmJiBieSAm
IGFueXdoZXJlIGFuZCBleHBlY3QgaXQgdG8gd29yayB0aGUgc2FtZSwNCkluIHRoZSBnZW5lcmFs
IGNhc2Ugb2YgaW50IEEsQjsgIEEgJiYgQiBpcyBkaWZmZXJlbnQgZnJvbSBBICYgQi4NCkJ1dCAo
QT4wKSAmJiAoQj4wKSBpcyBlcXVpdmFsZW50IHRvIChBPjApICYgKEI+MCksIGJlY2F1c2UgZWFj
aCBzaWRlIG9mIHRoZSB0ZXN0IGlzIG5vdyBhIHN0cmljdCAwLzEgdmFsdWUuDQpUaGlzIGNvbmRp
dGlvbiBpcyByZXNwZWN0ZWQgYWJvdmUuDQoNCk5vdyB3aHkgc2VsZWN0aW5nIG9uZSByYXRoZXIg
dGhhbiB0aGUgb3RoZXIgPw0KSXQgaGFzIHNvbWV0aGluZyB0byBkbyB3aXRoIEMgbGFuZ3VhZ2Ug
c2VxdWVudGlhbCBndWFyYW50ZWVzIGFuZCB0aGUgcGlwZWxpbmUgb2YgbW9kZXJuIGNwdXMuDQoN
CldoZW4gc3BlbGxpbmc6IGlmIChmKEEpICYmIGYoQikpDQp0aGUgcHJvZ3JhbSBtdXN0IGRvIGYo
QSkgZmlyc3QsIGFuZCB0aGVuLCBpZiBpdCdzIHRydWUsIG1vdmUgb24gdG8gZihCKS4NClRoaXMg
aW50cm9kdWNlcyBhIHNlcmlhbCBkZXBlbmRlbmN5IGFuZCBhbiBhZGRpdGlvbmFsIGludGVybWVk
aWF0ZSBicmFuY2guDQoNCldoZXJlYXMgaW46IGlmIChmKEEpICYgZihCKSkNCmYoQSkgYW5kIGYo
QikgY2FuIGJlIGV4ZWN1dGVkIGluIHBhcmFsbGVsLA0KdGhlbiBjb21iaW5lZCB3aXRoIGEgc2lt
cGxlIEFORCBvcGVyYXRpb24sDQphbmQgdGhlcmUgaXMgb25seSBvbmUgYnJhbmNoLCBhdCB0aGUg
ZW5kLg0KDQpPbmNlIGFnYWluLCB0aGlzIHNob3VsZCBub3QgYmUgZG9uZSBtaW5kbGVzc2x5IDoN
CnN1Y2ggY29uc3RydWN0aW9uIGlzIG9ubHkgdmFsaWQgaWYgZihCKSBpcyB0cnVseSBjb21wbGV0
ZWx5IGluZGVwZW5kZW50IGZyb20gZihBKS4NCkZvciBleGFtcGxlLCBpbiA6IChvcCAhPSBOVUxM
KSAmJiAoKm9wPUspLCBvbmUgbXVzdCB1c2UgJiYsIG90aGVyd2lzZSBpdCdzIFVCLCBiZWNhdXNl
IHRoZSBzZWNvbmQgdGVzdCBpcyBvbmx5IHZhbGlkIGFmdGVyIHRoZSBmaXJzdCBvbmUgaXMgdmVy
aWZpZWQuDQoNCkJ1dCBmb3IgdGhlIGV4YW1wbGUgYXQgc3Rha2UgOiANCihlbmRPbklucHV0ID8g
aXAgPCBzaG9ydGllbmQgOiAxKSAmIChvcCA8PSBzaG9ydG9lbmQpDQpvbmUgY2FuIHNlZSB0aGF0
IGVhY2ggdGVzdCBpcyBmdWxseSBpbmRlcGVuZGVudCwNCihvcDw9c2hvcnRvZW5kKSBkb2Vzbid0
IGRlcGVuZCBvbiBhbnl0aGluZyBmcm9tIHRoZSBsZWZ0IHNpZGUuDQoNCg0KT0ssIG5vdywgZG9l
cyBpdCBtYWtlIGEgZGlmZmVyZW5jZSA/DQpXZWxsLCBhcyB1c3VhbCwgaXQgZGVwZW5kcy4NCklm
IGl0IHdhcyBhIGJyYW5jaCBhbnl3aGVyZSBpbiB0aGUgY29kZSBiYXNlLCBpdCBwcm9iYWJseSBk
b2Vzbid0Lg0KT25lIG5lZWRzIGEgdmVyeSBob3QgY29kZSBzZWN0aW9uIGZvciBzdWNoIGEgZGlm
ZmVyZW5jZSB0byBiZWNvbWUgbm90aWNlYWJsZS4NCkJ1dCBpdCBoYXBwZW5zIHRoYXQgaW4gbHo0
LCB3ZSBkbyBoYXZlIHN1Y2ggaG90IHNlY3Rpb25zLg0KDQpUaGVyZSBpcyBhbm90aGVyIGlzc3Vl
IGF0IHN0YWtlLCBhbG1vc3QgaW52aXNpYmxlIDoNCmlmIHlvdSBrbm93IHRoZSBhcmNoaXRlY3R1
cmUgb2YgbW9kZXJuIGludGVsIGNwdSwNCnlvdSBtaWdodCBrbm93IHRoYXQgdGhleSBoYXZlIGEg
bWljcm8tb3AgY2FjaGUuDQpUaGUgd2F5IHRoaXMgbWljcm8tb3AgY2FjaGUgaXMgc3RydWN0dXJl
ZCBpcyBhIGJpdCBjb21wbGV4LCBhbmQgbW9yZSBpbXBvcnRhbnRseSwgcG9vcmx5IGRvY3VtZW50
ZWQsIGFuZCBjaGFuZ2VzIHdpdGggZWFjaCBjaGlwIGdlbmVyYXRpb24uDQpCdXQgd2VsbCwgYW1v
bmcgdGhlIG5vdGFibGUgZWxlbWVudHMsIHRoZSBjb25jZW50cmF0aW9uIG9mIGJyYW5jaGVzIG1h
dHRlciA6DQppZiB0aGVyZSBhcmUgdG9vIG1hbnkgYnJhbmNoZXMgZGVuc2VseSBwYWNrZWQsIHRo
ZSBtaWNyby1vcCBjYWNoZSBjYW5ub3QgZG8gaXRzIGpvYiwgDQp0aGVyZWZvcmUsIGV2ZXJ5IHRp
bWUgdGhlIGluc3RydWN0aW9uIHNlZ21lbnQgbXVzdCBiZSBwbGF5ZWQsIGl0IGhhcyB0byBiZSBk
ZWNvZGVkIGFnYWluLCBjb3N0aW5nIHNpZ25pZmljYW50IHBlcmZvcm1hbmNlLg0KDQpBbHNvLCB0
aGUgYnJhbmNoIHByZWRpY3RvciBoYXMgYSBsaW1pdGVkIGhpc3RvcnksIGFuZCBhIGRlbnNlciBw
YWNrIG9mIGJyYW5jaGVzIGVuZHMgdXAgYmVpbmcgbW9yZSBkaWZmaWN1bHQgdG8gdHJhY2sgaGVu
Y2UgdG8gcHJlZGljdA0KKGhlcmUgYWxzbywgZGV0YWlscyBhcmUgbm90IGVzcGVjaWFsbHkgd2Vs
bCBkb2N1bWVudGVkLCBhbmQgY2hhbmdlIGFsbCB0aGUgdGltZS4gVGhlIG9ubHkgImdlbmVyaWMg
cnVsZSIgaXMgdGhhdCBsZXNzIGJyYW5jaGVzIHRlbmRzIHRvIGJlIGVhc2llciB0aGFuIG1vcmUg
YnJhbmNoZXMpLg0KDQpTbywgYXMgb25lIGNhbiBzZWUsIGl0J3MgX2dlbmVyYWxseV8gYmV0dGVy
IHRvIHJlcGxhY2UgYSAmJiBicmFuY2ggYnkgYW4gJiBBTkQgb3BlcmF0aW9uLCB3aGVuIGNvbmRp
dGlvbnMgYXJlIGZ1bGZpbGxlZCwNCmJ1dCBpdCBvbmx5IG1hdHRlcnMgd2l0aGluIHZlcnkgaG90
IGNvZGUgc2VnbWVudHMuDQoNClRvIG1ha2UgbWF0dGVycyBldmVuIG1vcmUgZGlmZmljdWx0LCBz
b21ldGltZXMsIGNsZXZlciBjb21waWxlcnMgY2FuIG1ha2UgdGhlIHNhbWUgY2hvaWNlIGF1dG9t
YXRpY2FsbHksDQpyZWFsaXppbmcgdGhhdCBpbiBhIGNvZGUgbGlrZSBmKEEpICYmIGYoQiksIHRo
ZXJlIG1heSBhY3R1YWxseSBiZSBhIHdheSB0byBleGVjdXRlIGJvdGggc2lkZXMgYW5kIHJlcGxh
Y2UgdGhlIGludGVybWVkaWF0ZSBicmFuY2ggYnkgYSBtYXNrLg0KVGhlIHByb2JsZW0gaXMsIHRo
YXQncyB0cnVlIHNvbWV0aW1lcy4gTm90IGFsd2F5cy4NCk90aGVyIGNvbXBpbGVycyB3aWxsIHJl
YWN0IGRpZmZlcmVudGx5IGFuZCBtYXkgbWlzcyB0aGlzIG9wcG9ydHVuaXR5Lg0KVGhhdCdzIGlt
cG9ydGFudCBmb3IgY29kZXMgZGVzaWduZWQgdG8gYmUgaGlnaGx5IHBvcnRhYmxlLCBhcyAiaXQg
d29ya3MgZmluZSBvbiBteSBtYWNoaW5lIiBpc24ndCBlbm91Z2ggdG8ganVzdGlmeSBhIG1vZGlm
aWNhdGlvbiB0aGF0IG1heSBhZmZlY3Qgb3RoZXIgc3lzdGVtcy4NCg0KDQpBbnl3YXksIEkgaG9w
ZSBpdCBhbnN3ZXJzIHlvdXIgcXVlc3Rpb24gOiANCi0gYm90aCBleHByZXNzaW9ucyBhcmUgZXF1
aXZhbGVudCwgdGhvdWdoIHRoYXQncyBvbmx5IGJlY2F1c2Ugc29tZSBjb25kaXRpb25zIGFyZSBj
YXJlZnVsbHkgcmVzcGVjdGVkLg0KLSAmJiBpcyBiZXR0ZXIgZnJvbSBhIHN0eWxlIHBlcnNwZWN0
aXZlLCBhbmQgaXMgbXkgZmlyc3QgY2hvaWNlIGZvciAibm9ybWFsIiBjb2RlDQotIGhvdCBjb2Rl
IHNlZ21lbnRzIHZhbHVlIHNwZWVkLCBpbiB3aGljaCBjYXNlLCAmIGNhbiBiZSBhIG1vcmUgZWZm
aWNpZW50IGFsdGVybmF0aXZlDQoNCg0KUmVnYXJkcw0KDQpZYW5uDQoNCu+7v09uIDYvNi8yMCwg
MDg6MTYsICJWYXNpbHkgQXZlcmluIiA8dnZzQHZpcnR1b3p6by5jb20+IHdyb3RlOg0KDQogICAg
RGVhciBZYW5uLA0KICAgIGNvdWxkIHlvdSBwbGVhc2UgY29uc3VsdCB1cyBhYm91dCB5b3VyIGx6
NCBwYWN0aA0KICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L2NvbW1pdC8xYTE5MWIzZjhk
MjZiNTBhN2MxZDQxNTkwYjUyOWVjMzA4ZDc2OGNkDQoNCiAgICBQbGVhc2Ugc2VlIGRldGFpbHMg
YmVsb3cuDQoNCiAgICBUaGFuayB5b3UsDQogICAgCVZhc2lseSBBdmVyaW4NCg0KICAgIE9uIDYv
Ni8yMCA1OjM2IFBNLCBHYW8gWGlhbmcgd3JvdGU6DQogICAgPiBPbiBTYXQsIEp1biAwNiwgMjAy
MCBhdCAwNDoyODowMlBNICswMzAwLCBWYXNpbHkgQXZlcmluIHdyb3RlOg0KICAgID4+IEZvdW5k
IGJ5IHNtYXRjaDoNCiAgICA+PiBsaWIvbHo0L2x6NF9kZWNvbXByZXNzLmM6MTUwIExaNF9kZWNv
bXByZXNzX2dlbmVyaWMoKSB3YXJuOiBtYXliZSB1c2UgJiYgaW5zdGVhZCBvZiAmDQogICAgPj4g
SXQgd2FzIHJlYWx5IGluY29ycmVjdGx5IGNvcGllZCBmcm9tDQogICAgPj4gaHR0cHM6Ly9naXRo
dWIuY29tL2x6NC9sejQvY29tbWl0LzQ1Zjg2MDNhYWUzODlkMzRjNjg5ZDNmZjc0MjdiMzE0MDcx
Y2NkMmMNCiAgICA+PiBsaW5lIDE0MzENCiAgICA+IA0KICAgID4gU2ltcGx5IG5vLg0KICAgID4g
DQogICAgPj4NCiAgICA+PiBGaXhlczogMjIwOWZkYTMyM2UyICgibGliL2x6NDogdXBkYXRlIExa
NCBkZWNvbXByZXNzb3IgbW9kdWxlIikNCiAgICA+PiBTaWduZWQtb2ZmLWJ5OiBWYXNpbHkgQXZl
cmluIDx2dnNAdmlydHVvenpvLmNvbT4NCiAgICA+PiAtLS0NCiAgICA+PiAgbGliL2x6NC9sejRf
ZGVjb21wcmVzcy5jIHwgMiArLQ0KICAgID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCiAgICA+Y29tbWl0IDFhMTkxYjNmOGQyNmI1MGE3YzFkNDE1OTBi
NTI5ZWMzMDhkNzY4Y2QNCiAgICBBdXRob3I6IFlhbm4gQ29sbGV0IDxjeWFuQGZiLmNvbT4NCiAg
ICBEYXRlOiAgIFdlZCBNYXkgMiAxMDozMzoxMiAyMDE4IC0wNzAwDQoNCiAgICAgICAgc2ltcGxp
Znkgc2hvcnRjdXQNCg0KICAgIGRpZmYgLS1naXQgYS9saWIvbHo0LmMgYi9saWIvbHo0LmMNCiAg
ICBpbmRleCBjNmYwNDI2Li5iNDY5MTBmIDEwMDY0NA0KICAgIC0tLSBhL2xpYi9sejQuYw0KICAg
ICsrKyBiL2xpYi9sejQuYw0KICAgIEBAIC0xNDI5LDYyICsxNDI5LDI5IEBAIExaNF9GT1JDRV9J
TkxJTkUgaW50IExaNF9kZWNvbXByZXNzX2dlbmVyaWMoDQogICAgICAgICAgICAgICovDQogICAg
ICAgICAgICAgaWYgKChlbmRPbklucHV0ID8gbGVuZ3RoICE9IFJVTl9NQVNLIDogbGVuZ3RoIDw9
IDgpICYmDQogICAgICAgICAgICAgICAgIC8qIHN0cmljdGx5ICJsZXNzIHRoYW4iIG9uIGlucHV0
LCB0byByZS1lbnRlciB0aGUgbG9vcCB3aXRoIGF0IGxlYXN0IG9uZSBieXRlICovDQogICAgLSAg
ICAgICAgICAgIGxpa2VseSgoZW5kT25JbnB1dCA/IGlwIDwgc2hvcnRpZW5kIDogMSkgJiYgKG9w
IDw9IHNob3J0b2VuZCkpKQ0KICAgICsgICAgICAgICAgICBsaWtlbHkoKGVuZE9uSW5wdXQgPyBp
cCA8IHNob3J0aWVuZCA6IDEpICYgKG9wIDw9IHNob3J0b2VuZCkpKQ0KICAgID4NCiAgICA+PiBk
aWZmIC0tZ2l0IGEvbGliL2x6NC9sejRfZGVjb21wcmVzcy5jIGIvbGliL2x6NC9sejRfZGVjb21w
cmVzcy5jDQogICAgPj4gaW5kZXggMGM5ZDNhZC4uZjdmN2RjYSAxMDA2NDQNCiAgICA+PiAtLS0g
YS9saWIvbHo0L2x6NF9kZWNvbXByZXNzLmMNCiAgICA+PiArKysgYi9saWIvbHo0L2x6NF9kZWNv
bXByZXNzLmMNCiAgICA+PiBAQCAtMTQ3LDcgKzE0Nyw3IEBAIHN0YXRpYyBGT1JDRV9JTkxJTkUg
aW50IExaNF9kZWNvbXByZXNzX2dlbmVyaWMoDQogICAgPj4gIAkJICAgICogc3RyaWN0bHkgImxl
c3MgdGhhbiIgb24gaW5wdXQsIHRvIHJlLWVudGVyDQogICAgPj4gIAkJICAgICogdGhlIGxvb3Ag
d2l0aCBhdCBsZWFzdCBvbmUgYnl0ZQ0KICAgID4+ICAJCSAgICAqLw0KICAgID4+IC0JCSAgICYm
IGxpa2VseSgoZW5kT25JbnB1dCA/IGlwIDwgc2hvcnRpZW5kIDogMSkgJg0KICAgID4+ICsJCSAg
ICYmIGxpa2VseSgoZW5kT25JbnB1dCA/IGlwIDwgc2hvcnRpZW5kIDogMSkgJiYNCiAgICA+IA0K
ICAgID4gSSdkIGxpa2UgdG8gc2F5LCB0aGlzIGlzIG5vdCBteSBtaXN0YWtlIChldmVuIG5vdCBh
biBpc3N1ZSkuDQogICAgPiBJZiB5b3Ugbm90aWNlIHRoZSBsYXRlc3QgTFo0IHVwc3RyZWFtDQog
ICAgPiBodHRwczovL2dpdGh1Yi5jb20vbHo0L2x6NC9ibG9iL2Rldi9saWIvbHo0LmMjTDE4NjUN
CiAgICA+IA0KICAgID4gT3Igc29tZSByZWxhdGVkIGNoYW5nZSwgdGhlIGx6NCBhdXRob3IgQ3lh
biBkaWQgaXQgb24gcHVycG9zZS4NCiAgICA+IGh0dHBzOi8vZ2l0aHViLmNvbS9sejQvbHo0L2Nv
bW1pdC8xYTE5MWIzZjhkMjZiNTBhN2MxZDQxNTkwYjUyOWVjMzA4ZDc2OGNkDQoNCiAgICBGb3Ig
bWUgaXQgbG9va3MgbGlrZSB0eXBvIGluIHBhdGNoLA0KICAgIGxldHMgYXNrIGF1dGhvciBvZiB0
aGlzIGNvbW1pdC4NCg0KICAgID4gSSB0aGluayB3ZSBjb3VsZCBmb2xsb3cgdGhlIGxhdGVzdCBM
WjQgdXBzdHJlYW0gaW4gb3JkZXIgdG8NCiAgICA+IGF2b2lkIGZ1cnRoZXIgbWFpbnRhaW5lbmNl
IG92ZXJoZWFkLiBUaGF0J3MgbXkgb3duIHRob3VnaHQNCiAgICA+IGFueXdheS4NCiAgICA+IA0K
ICAgID4gVGhhbmtzLA0KICAgID4gR2FvIFhpYW5nDQogICAgPiANCg0K
