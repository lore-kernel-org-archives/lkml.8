Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FEAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8023D207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fev8tGOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgE2Ss4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:48:56 -0400
Received: from mail-eopbgr700137.outbound.protection.outlook.com ([40.107.70.137]:64480
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725865AbgE2Ssz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:48:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDRjmv1w14aqA5cdIW1CIotXs/QlqlySDUfhX+PgQYnpUCqmn4cHt6dmu0R+Zsp39LvB2GvknXsCIiHnJtkSwvdJNJLkzjMvYLYf60/aDU44Q2J/Ev56UN57FlYBNiawcjVEpwZ3uKfGQgbNlpm1QcW0BD23rt5qqI+oDzvsMyR3J3nGgzT7radiFP2zrXUVtXcA8PLkfqhjYF1mnHvOgJSDPN1XV35Xao7U1Cu6EW1fTtt+1INLe0NdiIj7Xb/CyY0jdAdXTctpYNGT4uHJc2sUa8kNB8O5R/aT2tJnPpR9+c47YqdYOkJTVRFvmvMi2y9yeCOZ6qBD8b3LoeU5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX5HA6Mdzp7mNR1YivT+Oe19qqh8rBpZ8AlJVsT/w+0=;
 b=QZt/Dn7jmw0ZrVN6bZXhpem05ux8FY6FBQyDqUd99Bzyv0lypx2wljYMdRr18SIADiBwmZwrXSXmbbVVQIaxj2CKdWlhXxxR+F3zwVMHY3a34cIbgLPor5hOXOOwK2EFbJCQQ72RXtdqpPjPiNCjYUcy4m9Pky5gT7Yu3IYG5SCLK7ILQqucflJ5ctuvTpvReqXjtCStuw38yDYFu0wvY0i6acvpEjfT6nNMpqP3W6B8lJ9yc8fBlYMa8i/GiScM1fsV40ItrMRjCl4B7T/wnzREY+LSb4xTiq6Pl1zoG9Vqq4bcTm6sBosmR47CwwhwfdbJQwxscz5E4HXna3d/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX5HA6Mdzp7mNR1YivT+Oe19qqh8rBpZ8AlJVsT/w+0=;
 b=Fev8tGOtHAxJ1AV0CTF/B5BvpLdxGxouFt62nWM7QpEziHW6YzmcuOT8F8kT+iA1rFvCRqPVZwq0TLg72YyZHLYv+xfVG17wuurXQ/TKJJkAOzyGo6qrp6+wF7le323KYGqF9ENEHJE6WtVERY6bJf509ram9f0Jtgn52tfBFe8=
Received: from MN2PR21MB1518.namprd21.prod.outlook.com (2603:10b6:208:20e::24)
 by MN2PR21MB1471.namprd21.prod.outlook.com (2603:10b6:208:206::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.3; Fri, 29 May
 2020 18:48:52 +0000
Received: from MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88]) by MN2PR21MB1518.namprd21.prod.outlook.com
 ([fe80::115a:8a52:79d6:6d88%8]) with mapi id 15.20.3066.007; Fri, 29 May 2020
 18:48:51 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Ian Rogers <irogers@google.com>
CC:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Topic: [EXTERNAL] Re: [PATCH v4] perf inject --jit: Remove //anon mmap
 events
Thread-Index: AQHWM8mKGkvgLkOO8Em0Algb20rYzKi8SrMAgAACEUCAAB83gIAA0mCAgAIkP9A=
Date:   Fri, 29 May 2020 18:48:51 +0000
Message-ID: <MN2PR21MB1518D07AD29D0E744E2D4EA2F78F0@MN2PR21MB1518.namprd21.prod.outlook.com>
References: <1590544271-125795-1-git-send-email-steve.maclean@linux.microsoft.com>
 <CAP-5=fXGXqkTbSwKv7eq9UkPvVqRJXDm3E-XNxD8+5fmQk3bpg@mail.gmail.com>
 <MN2PR21MB15185419971A29EF52B8138FF7B10@MN2PR21MB1518.namprd21.prod.outlook.com>
 <CAP-5=fVHo262Lo_Re31wM8Bt0soJ-m51J7MEnwvdTg5P8J6e6A@mail.gmail.com>
 <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
In-Reply-To: <CAP-5=fV7F4u66388HC-q8btOYWKxtb1gTTi4LK_Besb-zE25Rw@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-05-29T18:48:50Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=50f66f58-96bb-42b9-8031-830503629b8a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [75.182.186.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ccf35917-77a1-4157-e787-08d80400ee6f
x-ms-traffictypediagnostic: MN2PR21MB1471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR21MB147155DA1A1F8DD3E8E76E63F78F0@MN2PR21MB1471.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0mJeaB8JocBSbou+IVnSeTEDK+uqN+z8WbHJdKjk1Kla/yy6/J/z5fDHlBMMmDZYqPKM5I1dCVAUXGXY5uK4OktORwCmwCDN0AVY+Wk548dQ+rsI9qLpqtLLWS7niL739ht75iaqFtGYKbvj4PjEYlurlgjpcuI/5D5CWC0+Owys/c/CK59ZNP4jZYSxRnKDawVal158PbzPI/KpJn2zFWs9HxKAASn6WqWYn+XKf12CIcDbxP1aPk142/r9Hq0u20jI6JnFMpGSYYmZwEAAD8+n2YXdVO+KeJOK2Ui5JoHh6JwZAIHnD++P8+Pc5tu6B3jPQUah+CLBL/QSsRUeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1518.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(8676002)(316002)(52536014)(54906003)(33656002)(55016002)(66556008)(66476007)(76116006)(64756008)(66946007)(86362001)(26005)(186003)(82950400001)(4326008)(66446008)(8936002)(478600001)(82960400001)(10290500003)(9686003)(8990500004)(7696005)(71200400001)(6506007)(5660300002)(7416002)(2906002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: lV3KPQR3MrssxhgqexTdnuGwyFpcs5iSsBi9vpehJDM/U/l/ZnyP4LGf07mriz/aqdgjROzG8WJVfJVdwVjp3F61gZahS9nVWL2DwgC7bbvmcfw8BmGXXtV72cRVvZVrp4B9WJAr43sgTnSrvtgpuBxUzv5LYwpEasDKj+KuAeejL9FYA1mzWtLirP/WpUtUoCrervqinffxZuRe3TUaRrVtrk3opl8doHIuPpPd9Hlxstoehg9oyF+oUL4Zj+FQAvzvEVJulym0Llmt7KGnvYQwfysQiBV14DA6GktO6bI1cKS/Y1iDesmD/3/q/IdGrYC9BmV/cKFksU+djWavit8c8eGHIAg1WI4424VG+7TQybry8rZ9ctWwCWRfN7OeOypbfqQ6sRA6jqDmQeSesRgAmqGSF6A5YsLXjbzbig3/gkVRSnO4Dum+FNYlu4cSyetuEB9dtCtS3+pOQ9rdPtw7ulOBYbbufCPNf8jECkqimYCR88JQJajAtZEg2Grp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf35917-77a1-4157-e787-08d80400ee6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 18:48:51.8254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrTcOHdlZhNXahZLlt5HWDJPkKM6wyeeGwuJZMf78l0eNe4+Ewaa1qfMVqP0+X+uyrN1NrLTGKapIgXntfBJyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1471
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJJ3ZlIGJlZW4gdHJ5aW5nIHZhcmlhbnRzIG9mOg0KPg0KPiBCZWZvcmU6DQo+L3RtcC9wZXJm
L3BlcmYgcmVjb3JkIC1rIDEgLWUgY3ljbGVzOnUgLW8gL3RtcC9wZXJmLmRhdGEgamF2YSAtYWdl
bnRwYXRoOi90bXAvcGVyZi9saWJwZXJmLWp2bXRpLnNvIC1YWDorUHJlc2VydmVGcmFtZVBvaW50
ZXIgLVhYOkluaXRpYWxDb2RlQ2FjaGVTaXplPTIwTSAtWFg6UmVzZXJ2ZWRDb2RlQ2FjaGVTaXpl
PTFHIC1qYXIgZGFjYXBvLTkuMTItYmFjaC5qYXIganl0aG9uIC90bXAvcGVyZi9wZXJmIGluamVj
dCAtaSAvdG1wL3BlcmYuZGF0YSAtbyAvdG1wL3BlcmYtaml0LmRhdGEgLWogL3RtcC9wZXJmL3Bl
cmYgcmVwb3J0IC1pIC90bXAvcGVyZi1qaXQuZGF0YSB8Z3JlcCBjbGFzc1wgfHdjIC1sDQo+IDU3
OA0KPiAvdG1wL3BlcmYvcGVyZiByZXBvcnQgLWkgL3RtcC9wZXJmLWppdC5kYXRhIHxncmVwIHVu
a25vd24gfHdjIC1sDQo+IDYNCj4gDQo+IEFmdGVyOg0KPiAvdG1wL3BlcmYvcGVyZiByZWNvcmQg
LWsgMSAtZSBjeWNsZXM6dSAtbyAvdG1wL3BlcmYuZGF0YSBqYXZhIC1hZ2VudHBhdGg6L3RtcC9w
ZXJmL2xpYnBlcmYtanZtdGkuc28gLVhYOitQcmVzZXJ2ZUZyYW1lUG9pbnRlciAtWFg6SW5pdGlh
bENvZGVDYWNoZVNpemU9MjBNIC1YWDpSZXNlcnZlZENvZGVDYWNoZVNpemU9MUcgLWphciBkYWNh
cG8tOS4xMi1iYWNoLmphciBqeXRob24gL3RtcC9wZXJmL3BlcmYgaW5qZWN0IC1pIC90bXAvcGVy
Zi5kYXRhIC1vIC90bXAvcGVyZi1qaXQuZGF0YSAtaiAvdG1wL3BlcmYvcGVyZiByZXBvcnQgLWkg
L3RtcC9wZXJmLWppdC5kYXRhIHxncmVwIGNsYXNzXCB8d2MgLWwNCj4gNTg5DQo+IC90bXAvcGVy
Zi9wZXJmIHJlcG9ydCAtaSAvdG1wL3BlcmYtaml0LmRhdGEgfGdyZXAgdW5rbm93biB8d2MgLWwN
Cj4gNjANCj4NCj4gU28gbWF5YmUgdGhlIGppdCBjYWNoZSBpc24ndCBiZWhhdmluZyB0aGUgd2F5
IHRoYXQgdGhlIHBhdGNoIGN1cmVzLCB0aGUgdXB0aWNrIGluIHVua25vd25zIGFwcGVhcnMgY29u
c2lzdGVudCBpbiBteSB0ZXN0aW5nIHRob3VnaC4gSSBleHBlY3QgdXNlciBlcnJvciwgaXMgdGhl
cmUgYW4gb2J2aW91cyBleHBsYW5hdGlvbiBJJ20gbWlzc2luZz8NCg0KVGhhdCBpcyBjZXJ0YWlu
bHkgZGlzdHVyYmluZy4gSSBkb24ndCBzZWUgYW4gb2J2aW91cyB1c2VyIGVycm9yLCBidXQgSSBo
YXZlbid0IHBsYXllZCB3aXRoIGphdmEgaml0ZHVtcA0KDQpDb3VwbGUgb2YgaWRlYXMgY29tZSB0
byBtaW5kLg0KDQorIFdoZW4gSSB3YXMgZHJhZnRpbmcgLk5FVCBqaXRkdW1wIHN1cHBvcnQsIEkg
bG9va2VkIGJyaWVmbHkgYXQgdGhlIGphdmEgYWdlbnQuICBNeSBpbXByZXNzaW9uIHdhcyB0aGUg
amF2YSBhZ2VudCBzdXBwb3J0IHdhc24ndCB0aHJlYWQgc2FmZS4gIFRoZSBqaXRkdW1wIGZpbGUg
Zm9ybWF0IHJlcXVpcmVzIHRoYXQgY2VydGFpbiByZWNvcmRzIGFyZSBjb2xsb2NhdGVkIHRvIHNp
bXBsaWZ5IHRoZSByZWFkZXIuICBJIHdhc24ndCBzdXJlIGhvdyB0aGF0IHdhcyBiZWluZyBhY2Nv
bXBsaXNoZWQgYnkgdGhlIHdyaXRlciBpZiBKQVZBJ3MgSklUIHdhcyBtdWx0aXRocmVhZGVkIChs
aWtlIENvcmVDTFIgSklUIGlzKS4NCg0KKyBUaGUgd2F5IEkgaW1wbGVtZW50ZWQgaml0ZHVtcCBv
biBDb3JlQ0xSIHdhcyB0byBob29rIGludG8gdGhlIGV4aXN0aW5nIHN5c3RlbSB0byB3cml0ZSBw
ZXJmLW1hcCBmaWxlcy4gIFNvIEkgYW0gcHJldHR5IGNvbmZpZGVudCB0aGVyZSBpcyBhIDE6MSBj
b3JyZXNwb25kZW5jZSBvZiBwZXJmLW1hcCByZWNvcmRzIHdpdGggaml0ZHVtcCByZWNvcmRzLiAg
SXMgaXQgcG9zc2libGUgdGhhdCBKYXZhIGNob29zZSB0byBvbmx5IGVtaXQgaW50ZXJlc3Rpbmcg
aml0ZHVtcCByZWNvcmRzPyAgUGVyaGFwcyBza2lwcGluZyB0aHVua3Mvc3R1YnMvdHJhbXBvbGlu
ZXM/ICANCg0KKyBUaGVyZSBhcmUgc3RpbGwgc29tZSBgdW5rbm93bmAgcmVjb3JkcyBpbiBDb3Jl
Q0xSLCBidXQgSSBkb24ndCBiZWxpZXZlIHRoZXJlIGlzIGFuIGluY3JlYXNlLiAgSSBhbSBwcmV0
dHkgc3VyZSBzb21lIG9mIG91ciBzdHVicyBhcmUgbm90IGJlaW5nIGdlbmVyYXRlZC4gIFRoZXkg
d2VyZSBwcmVzZW50IGluIG91ciBiZWZvcmUgY2FzZSB0b28uDQoNCisgWW91ciBtZXRob2RvbG9n
eSB3b3VsZCBiZSBtb3JlIHJlcGVhdGFibGUgaWYgeW91IHJlY29yZCBvbmNlLCBhbmQgYW5hbHl6
ZSBtdWx0aXBsZSB0aW1lcy4gIHJlY29yZCwgcmVwb3J0LCBpbmplY3QgLyByZXBvcnQsIGluamVj
dCAvIHJlcG9ydA0KDQorIEkgd2FzIGZvY3VzaW5nIG9uIGVsaW1pbmF0aW5nIGR1cGxpY2F0ZSBz
eW1ib2xzIGZvciB0aGUgc2FtZSBhZGRyZXNzLiAgU28gaGF2aW5nIHRoZSBtb2R1bGUgbmFtZSBp
biB0aGUgcmVwb3J0IGFsbG93ZWQgbWUgdG8gc2VlIGlmIHRoZSBzeW1ib2wgd2FzIGZyb20gaml0
ZHVtcCBvciBmcm9tIHBlcmYtbWFwLiAgSW4gdGhlIGJlZm9yZSBjYXNlIEkgY291bGQgc2VlIGR1
cGxpY2F0ZSBzeW1ib2xzIGZvciB0aGUgc2FtZSBhZGRyZXNzLiAgVGhpcyB3YXMgaG93IHRoZSBw
cm9ibGVtIHdhcyBmaXJzdCBvYnNlcnZlZC4NCg0KKyBJIHdvdWxkIGJlIG1vcmUgaW50ZXJlc3Rl
ZCBpbiBsb29raW5nIGF0IHRoZSBkaWZmIG9mIHRoZSByZXBvcnRzLiAgUG9zc2libHkgc29ydGVk
IGJ5IGFkZHJlc3MuICBQcm9iYWJseSB3aXRoIHplcm8gY29udGV4dC4NCg0KSWYgSSB3ZXJlIHRv
IGd1ZXNzLCBJIHdvdWxkIHRoaW5rIEphdmEgY2hvb3NlIHRvIG9wdGltaXplIGppdGR1bXAgYW5k
IG9ubHkgcmVjb3JkIGludGVyZXN0aW5nIGNvZGUuDQoNClNvIGlmIHdlIG5lZWQgdG8gc3VwcG9y
dCB0aGF0IHNjZW5hcmlvIHRoZSBhcHByb2FjaCBvZiB0aGlzIHBhdGNoIHdvdWxkbid0IHdvcmsu
DQoNCldlIHdvdWxkIG5lZWQgdG8gdXNlIGEgZGlmZmVyZW50IGFwcHJvYWNoLiAgSWRlYXMuLi4N
CisgS2VlcCBhbm9uIG1hcHBpbmdzIGZyb20gb3ZlcndyaXRpbmcgaml0ZHVtcCBtYXBwaW5ncy4g
IEludHJvZHVjZSBhIHdlYWsgYWRkIG1hcCBtZXRob2QsIHRoYXQgd291bGQgb25seSBmaWxsIGVt
cHR5L2Fub24uDQorIE1vdmUgdGhlIGFub24gbWFwcGluZyB0aW1lc3RhbXAgdG8gdGhlIGJlZ2lu
bmluZyBvZiB0aW1lLCBzbyB0aGV5IGFyZSBwcm9jZXNzZWQgZmlyc3QNCisgRml4IHRoZSBrZXJu
ZWwgcGVyZiBtYXAgZXZlbnRzDQorIEtlZXAgdGhlIGFub24gbWFwcGluZ3MgaW4gYSBzZXBhcmF0
ZSBmYWxsIGJhY2sgbWFwDQoNCkkga2luZCBvZiBsaWtlIHRoZSBhZGQgd2VhayBtYXAgYXBwcm9h
Y2guDQo=
