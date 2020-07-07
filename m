Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73795C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5B4206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="mYLGVIHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgGGB0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:26:48 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:27996
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727079AbgGGB0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:26:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hf0j2tBH7v+rVPHLygGY0vzHpYTU+FiualdtZPHUnbkcRSb2fzAgRBe7qzl+2a/FP5QGeP+N79Rxm8C75WUO8I+mzOaJTMWpSAyRSt+fURKoFtdhVKvco7Oms88HHBe7YiHOVWVzMwJCELGnYJKw2oWpPxxhahP4HfJY3XZF1p9cJBC80zydtZRKC/esofCvYfQWPW4GqwzkYJ7eSVne5ZoXcLT3dpmd5XgfHFOQ+g1/VfQwfDKYf4BYW3PcWIwKSE51XS6EfmGLH2uolVpfvgUu1Q7BYt4V7JXIGe+OBRKvdobqnHHINW1LU3cJAKf6DurHCMDSEcLSWma1E5vCyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO0bo3pKu6aYSJT5HkhB2sawkWmgS5FPFZRIISIpRhI=;
 b=ea9WY26ZhmIeU+xJbsviszPAG7G2yHJlfjTART+pErncV3SMmJQQU/mFIO37X/0M+mXYQXL9oV2POmUgXtgQLefY1sZyha4v0v5bPb/2GMRXga+u/mK+tO4drkCyrKR0jb9QhLiGRrQSrhPHpagiOfX0FjLnxK2AeYANNH6lwALl+u8O57FMxIskhZcI7STTkbjlyasxaSASqI97BU7kVMXobbiI/gQ9HcyKDM2qlh+arf6xtfaPqcMKUdTQjXK/SWk7C45HmSW3ZwNBI5KBc9OQt8HdkatIsb7Wz/Tb/P0yTCg3yOeB/AHQKv8TzgdyiEvj49SEf+Jd60x/nuYUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO0bo3pKu6aYSJT5HkhB2sawkWmgS5FPFZRIISIpRhI=;
 b=mYLGVIHGiffBmu58JXpzb68jKljl7c2w+kxYTjg4q7R7NhOpm0Cy2hkabNqsDznT6o8WrmT5dUVq9yKkOqXlWuXATHYz4fYwD8sZJUMkRjKvSRzDcZFDf1ieSPXewC98L7Mqcj6xMXxMSgYrlYGy0trgUf5S8AhcIe52UB9jZ2w=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB3975.namprd11.prod.outlook.com (2603:10b6:a03:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 01:26:37 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 01:26:37 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Tejun Heo <tj@kernel.org>
CC:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "cl@rock-chips.com" <cl@rock-chips.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYzXSBrdGhyZWFkOiBXb3JrIGNvdWxkIG5vdCBiZSBx?=
 =?gb2312?Q?ueued_when_worker_being_destroyed?=
Thread-Topic: [PATCH v3] kthread: Work could not be queued when worker being
 destroyed
Thread-Index: AQHWU0RdRSc2HNZSQE6NBVT1UPI6TKj6paKAgACto/Q=
Date:   Tue, 7 Jul 2020 01:26:37 +0000
Message-ID: <BYAPR11MB26326F16BC261A7AB78B9D3FFF660@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200705013018.7375-1-qiang.zhang@windriver.com>,<20200706145945.GB5603@mtj.thefacebook.com>
In-Reply-To: <20200706145945.GB5603@mtj.thefacebook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6a0f1dd-f332-4322-2b1a-08d82214cb35
x-ms-traffictypediagnostic: BY5PR11MB3975:
x-microsoft-antispam-prvs: <BY5PR11MB3975DAF32382594596895AFCFF660@BY5PR11MB3975.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNbcuXCTvufpSCZIK5HTyZoNuhEKla2+nPEKhLoaZ6ByCMlyl+OFgqAX8+MHuoManzgPfgIZ4Vp4TNQ+J3rw6El3cD5cpeeL5MHzI4iGu2WxKUi9LLdiRF9r3HYEmW2pH9YBdl+Nz5vhef+z6ePKXIV5+08KN9+fr8N9kGte3VvDeKsxy5stqDtU+A+Lu5XTdQStjcNgZNGX3/5Ciq67PDZi2fhsUFbRvl4nT7pXvTy2X/cDyR2ZlHq5vxmC2Ryu2AShWHlmoJ3xkkeIXiao2X0Y82NG3AdlRWcApiIfWJjQpul0ZZxkvxo0MPpaWLF7/xOQDbExAK4Sa5Q+TmTjYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39850400004)(136003)(396003)(346002)(366004)(376002)(7696005)(26005)(186003)(52536014)(478600001)(45080400002)(2906002)(83380400001)(224303003)(4326008)(8936002)(6916009)(33656002)(316002)(6506007)(54906003)(9686003)(55016002)(76116006)(66556008)(91956017)(66476007)(71200400001)(66946007)(66446008)(64756008)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JQYgIIYSY03L21M0yp/MBOwLlvGWB1zuxK7E5TKc1de/QbrGCotqCZBNaL7szX7tWg/KhOUyXXnvLun+68ue+7kHnPM9S16gRawjvj6L0PAE7jhoIelnfvKhiqFZ36SrJJvX0bQeETolvY9OS9z1Qc23UtYOSi6Lbl+V7ryUj65YqyNQcu6fzd9z0+tz6nztlYD6k6rqDhFCdExEr56Qei7Suw04sjbpkHenz0UGnUgpyK37z8Poh4ewFXcTItxAW/UCz7SR+Ebdo18sXKhY+kHTt/RXhs/6cSXVuaDJZx6bDgNH1xH/TiKnZoxyGvQw/FG4N1EG2eOcCWPJYZf4RhyNaohIlznBbGSd/j/5LTyC0d4ofqTo/VdfoH3ohcdhmcutnq8aiOp0Qh5vXbjiWrgjNHGbr/oiwnEZWbbb/7Bz3DJPnZWzwEc5OU2kUBlWdYkyvG6ICyoGQaLD1K89jX+Km8K4d8DfXBERTSiVhFk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a0f1dd-f332-4322-2b1a-08d82214cb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 01:26:37.3316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJ8lIp5EOsSbJTZVJqUbjCJEPkKgvpdwLbNLRYjjhhP8Ctb5Bll4YZc0BR6Eg0dbwPNA5KraH9loQaHZz3Q1xKAhRHIuZxpzz4jp6S7Icb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3975
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSdtIHZlcnkgc29ycnkgdGhhdCB0aGVyZSBhcmUgc29tZSBwcm9ibGVtcyB3aXRoIG15IGNoYW5n
ZS4NCmFzIGZvbGxvd3M6DQoNClsgICAgMS4yMDMzMDBdIGxvb3A6IG1vZHVsZSBsb2FkZWQNClsg
ICAgMS4yMDQ1OTldIG1lZ2FzYXM6IDA3LjcxNC4wNC4wMC1yYzENClsgICAgMS4yMTExMjRdIHNw
aV9xdXAgNzhiNzAwMC5zcGk6IElOOmJsb2NrOjE2LCBmaWZvOjY0LCBPVVQ6YmxvY2s6MTYsIGZp
Zm86NjQNClsgICAgMS4yMTE1MDldIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0t
LQ0KWyAgICAxLjIxNzIzOF0gV0FSTklORzogQ1BVOiAwIFBJRDogMSBhdCBrZXJuZWwva3RocmVh
ZC5jOjgxOQ0Ka3RocmVhZF9xdWV1ZV93b3JrKzB4OTAvMHhhMA0KWyAgICAxLjIyMTgzMl0gTW9k
dWxlcyBsaW5rZWQgaW46DQpbICAgIDEuMjI5NTU0XSBDUFU6IDAgUElEOiAxIENvbW06IHN3YXBw
ZXIvMCBOb3QgdGFpbnRlZA0KNS44LjAtcmMzLW5leHQtMjAyMDA3MDYgIzENClsgICAgMS4yMzI2
ODNdIEhhcmR3YXJlIG5hbWU6IFF1YWxjb21tIFRlY2hub2xvZ2llcywgSW5jLiBBUFEgODAxNiBT
QkMgKERUKQ0KWyAgICAxLjI0MDIzN10gcHN0YXRlOiA0MDAwMDA4NSAoblpjdiBkYUlmIC1QQU4g
LVVBTyBCVFlQRT0tLSkNClsgICAgMS4yNDY5MThdIHBjIDoga3RocmVhZF9xdWV1ZV93b3JrKzB4
OTAvMHhhMA0KWyAgICAxLjI1MjIxMV0gbHIgOiBrdGhyZWFkX3F1ZXVlX3dvcmsrMHgyYy8weGEw
DQpbICAgIDEuMjU2NzIyXSBzcCA6IGZmZmY4MDAwMTAwMmJhNTANClsgICAgMS4yNjEwNjFdIHgy
OTogZmZmZjgwMDAxMDAyYmE1MCB4Mjg6IGZmZmYwMDAwM2I4NjgwMDANClsgICAgMS4yNjQzNjNd
IHgyNzogZmZmZjAwMDAzZmNmNjNjMCB4MjY6IGZmZmYwMDAwM2I4Njg2ODANClsgICAgMS4yNjk3
NDRdIHgyNTogZmZmZjAwMDAzYjg2ODQwMCB4MjQ6IGZmZmYwMDAwM2QxMTY4MTANClsgICAgMS4y
NzUwMzldIHgyMzogZmZmZjgwMDAxMjAyNTMwNCB4MjI6IGZmZmYwMDAwM2I4NjgzYmMNClsgICAg
MS4yODAzMzVdIHgyMTogMDAwMDAwMDAwMDAwMDAwMCB4MjA6IGZmZmYwMDAwM2I4NjgzZjgNClsg
ICAgMS4yODU2MzBdIHgxOTogZmZmZjAwMDAzYjg2ODNiOCB4MTg6IDAwMDAwMDAwMDAwMDAwMDAN
ClsgICAgMS4yOTA5MjVdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IGZmZmY4MDAwMTExNjc0
MjANClsgICAgMS4yOTYyMjBdIHgxNTogZmZmZjAwMDAwZWI5MDQ4MCB4MTQ6IDAwMDAwMDAwMDAw
MDAyNjcNClsgICAgMS4zMDE1MTVdIHgxMzogMDAwMDAwMDAwMDAwMDAwNCB4MTI6IDAwMDAwMDAw
MDAwMDAwMDANClsgICAgMS4zMDY4MTBdIHgxMTogMDAwMDAwMDAwMDAwMDAwMCB4MTA6IDAwMDAw
MDAwMDAwMDAwMDMNClsgICAgMS4zMTIxMDVdIHg5IDogZmZmZjAwMDAzZmNiYWMxMCB4OCA6IGZm
ZmYwMDAwM2ZjYmEyNDANClsgICAgMS4zMTc0MDBdIHg3IDogZmZmZjAwMDAzYmMzYzgwMCB4NiA6
IDAwMDAwMDAwMDAwMDAwMDMNClsgICAgMS4zMjI2OTZdIHg1IDogMDAwMDAwMDAwMDAwMDAwMCB4
NCA6IDAwMDAwMDAwMDAwMDAwMDANClsgICAgMS4zMjc5OTFdIHgzIDogZmZmZjAwMDAzYjg2ODNi
YyB4MiA6IDAwMDAwMDAwMDAwMDAwMDENClsgICAgMS4zMzMyODVdIHgxIDogMDAwMDAwMDAwMDAw
MDAwMCB4MCA6IDAwMDAwMDAwMDAwMDAwMDANClsgICAgMS4zMzg1ODNdIENhbGwgdHJhY2U6DQpb
ICAgIDEuMzQzODc1XSAga3RocmVhZF9xdWV1ZV93b3JrKzB4OTAvMHhhMA0KWyAgICAxLjM0NjA1
MF0gIHNwaV9zdGFydF9xdWV1ZSsweDUwLzB4NzgNClsgICAgMS4zNTAyMTNdICBzcGlfcmVnaXN0
ZXJfY29udHJvbGxlcisweDQ1OC8weDgyMA0KWyAgICAxLjM1Mzg2MF0gIGRldm1fc3BpX3JlZ2lz
dGVyX2NvbnRyb2xsZXIrMHg0NC8weGEwDQpbICAgIDEuMzU4NjM4XSAgc3BpX3F1cF9wcm9iZSsw
eDVkOC8weDYzOA0KWyAgICAxLjM2MzIzNV0gIHBsYXRmb3JtX2Rydl9wcm9iZSsweDU0LzB4YTgN
ClsgICAgMS4zNjcwNTNdICByZWFsbHlfcHJvYmUrMHhkOC8weDMyMA0KWyAgICAxLjM3MTEzM10g
IGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg1OC8weGI4DQpbICAgIDEuMzc0Nzc5XSAgZGV2aWNlX2Ry
aXZlcl9hdHRhY2grMHg3NC8weDgwDQpbICAgIDEuMzc4Njg1XSAgX19kcml2ZXJfYXR0YWNoKzB4
NTgvMHhlMA0KWyAgICAxLjM4Mjc2Nl0gIGJ1c19mb3JfZWFjaF9kZXYrMHg3MC8weGMwDQpbICAg
IDEuMzg2NTgzXSAgZHJpdmVyX2F0dGFjaCsweDI0LzB4MzANClsgICAgMS4zOTAzMTddICBidXNf
YWRkX2RyaXZlcisweDE0Yy8weDFmMA0KWyAgICAxLjM5NDEzN10gIGRyaXZlcl9yZWdpc3Rlcisw
eDY0LzB4MTIwDQpbICAgIDEuMzk3Njk2XSAgX19wbGF0Zm9ybV9kcml2ZXJfcmVnaXN0ZXIrMHg0
OC8weDU4DQpbICAgIDEuNDAxNTE5XSAgc3BpX3F1cF9kcml2ZXJfaW5pdCsweDFjLzB4MjgNClsg
ICAgMS40MDYzNzhdICBkb19vbmVfaW5pdGNhbGwrMHg1NC8weDFhMA0KWyAgICAxLjQxMDM3Ml0g
IGtlcm5lbF9pbml0X2ZyZWVhYmxlKzB4MWQ0LzB4MjU0DQpbICAgIDEuNDE0MTA2XSAga2VybmVs
X2luaXQrMHgxNC8weDExMA0KWyAgICAxLjQxODYxNl0gIHJldF9mcm9tX2ZvcmsrMHgxMC8weDM0
DQpbICAgIDEuNDIxOTE4XSAtLS1bIGVuZCB0cmFjZSA0YjU5ZjMyNzYyM2M5ZTEwIF0tLS0NClsg
ICAgMS40MjY1MjZdIHNwaV9xdXAgNzhiOTAwMC5zcGk6IElOOmJsb2NrOjE2LCBmaWZvOjY0LCBP
VVQ6YmxvY2s6MTYsIGZpZm86NjQNClsgICAgMS40MzA3MjFdIC0tLS0tLS0tLS0tLVsgY3V0IGhl
cmUgXS0tLS0tLS0tLS0tLQ0KWyAgICAxLjQzNzM3NF0gV0FSTklORzogQ1BVOiAwIFBJRDogMSBh
dCBrZXJuZWwva3RocmVhZC5jOjgxOQ0KDQp3aGVuIGluICJzcGlfaW5pdF9xdWV1ZSIgZnVuYyA6
DQoia3RocmVhZF9pbml0X3dvcmtlcigmY3Rsci0+a3dvcmtlcik7ICAgICAod29ya2VyLT50YXNr
ID0gTlVMTCkNCiBjdGxyLT5rd29ya2VyX3Rhc2sgPSBrdGhyZWFkX3J1bihrdGhyZWFkX3dvcmtl
cl9mbiwgJmN0bHItPmt3b3JrZXIsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICIlcyIsIGRldl9uYW1lKCZjdGxyLT5kZXYpKTsgIg0KDQogaW4gInNwaV9zdGFydF9x
dWV1ZSIgZnVuYzoNCiAia3RocmVhZF9xdWV1ZV93b3JrKCZjdGxyLT5rd29ya2VyLCAmY3Rsci0+
cHVtcF9tZXNzYWdlcyk7Ig0KDQogQmVjYXN1ZSB0aGUga3RocmVhZF93b3JrZXJfZm4gaXMgbm90
IGJlZ2luIHJ1bm5pbmcsICBpZiBxdWV1ZSB3b3JrIHRvIHdvcmtlciwNCiB0aGUgIiF3b3JrZXIt
PnRhc2siID0gdHJ1ZSwgdHJpZ2dlciBXQVJOLg0KDQpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fDQq3orz+yMs6IFRlanVuIEhlbyA8aHRlanVuQGdtYWlsLmNvbT4gtPqx
7SBUZWp1biBIZW8gPHRqQGtlcm5lbC5vcmc+DQq3osvNyrG85DogMjAyMMTqN9TCNsjVIDIyOjU5
DQrK1bz+yMs6IFpoYW5nLCBRaWFuZw0Ks63LzTogYmVuLmRvb2tzQGNvZGV0aGluay5jby51azsg
YmZpZWxkc0ByZWRoYXQuY29tOyBjbEByb2NrLWNoaXBzLmNvbTsgcGV0ZXJ6QGluZnJhZGVhZC5v
cmc7IHBtbGFkZWtAc3VzZS5jb207IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IG1tLWNvbW1p
dHNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrW98ziOiBS
ZTogW1BBVENIIHYzXSBrdGhyZWFkOiBXb3JrIGNvdWxkIG5vdCBiZSBxdWV1ZWQgd2hlbiB3b3Jr
ZXIgYmVpbmcgZGVzdHJveWVkDQoNCk9uIFN1biwgSnVsIDA1LCAyMDIwIGF0IDA5OjMwOjE4QU0g
KzA4MDAsIHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20gd3JvdGU6DQo+IEZyb206IFpoYW5nIFFp
YW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPg0KPg0KPiBCZWZvcmUgdGhlIHdvcmsgaXMg
cHV0IGludG8gdGhlIHF1ZXVlIG9mIHRoZSB3b3JrZXIgdGhyZWFkLA0KPiB0aGUgc3RhdGUgb2Yg
dGhlIHdvcmtlciB0aHJlYWQgbmVlZHMgdG8gYmUgZGV0ZWN0ZWQsYmVjYXVzZQ0KPiB0aGUgd29y
a2VyIHRocmVhZCBtYXkgYmUgaW4gdGhlIGRlc3RydWN0aW9uIHN0YXRlIGF0IHRoaXMgdGltZS4N
Cj4NCj4gU2lnbmVkLW9mZi1ieTogWmhhbmcgUWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5j
b20+DQo+IFN1Z2dlc3RlZC1ieTogUGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+DQo+IFJl
dmlld2VkLWJ5OiBQZXRyIE1sYWRlayA8cG1sYWRla0BzdXNlLmNvbT4NCg0KQW5kcmV3IGFscmVh
ZHkgYnJvdWdodCB0aGlzIHVwIGJ1dCBjYW4geW91IHBsZWFzZSBwcm92aWRlIHNvbWUgY29udGV4
dCBvbg0Kd2h5IHlvdSdyZSBtYWtpbmcgdGhpcyBjaGFuZ2U/DQoNClRoYW5rcy4NCg0KLS0NCnRl
anVuDQo=
