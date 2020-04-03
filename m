Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB712C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436262076E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Wrbb1xnI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nslz07Cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgDCV5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:57:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:51080 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbgDCV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:57:39 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 90C3640181;
        Fri,  3 Apr 2020 21:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585951058; bh=mZz5DMhdyWeVDDxbA3heHO79uySoR8Tx5QWQ87SyKXQ=;
        h=From:To:CC:Subject:Date:From;
        b=Wrbb1xnI7MzQJQdWG5L0PCRHHtIUVMOiirrdNch3HB5xex0yx6qGRYTkK6uYFToQ0
         R/0+m3aQHI2WCFVEEAczNF9PA0cF36tO9xNbUj/i6k0lHtNdwlem5nGqe2RPFUStG6
         T6boiwLDg5VtQQu4jRR7qEpVDmt+bOHnGTZ6/tAmV/r3B0hL6iEsTb5zdVMWhPHAxG
         dOZO+XiM0n4O5Jb4jh6wlId6BsUMvFD1zN82oOkkOi4/F5Drb8laayjg9GlDoGNNKi
         ESay4uVZZzvzLG1V4XHB2FS9i7M8B+zPP1+PCwXx2M/vuxIWEQd7WmFYvRCOt93q2f
         oxeeU4CUomeow==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B2F39A007F;
        Fri,  3 Apr 2020 21:57:35 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Apr 2020 14:57:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 3 Apr 2020 14:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJAzdsDu4CiHgByYir3hnIq6U9Jn3OT2h4bNOuvaGuvVyHO2awgOpQjyvbM7yB2ySr+cnw6vTNffrIj6wn4GVu0fD+ZNqkqOXHVbbk2Ef2r1AWbyqGEQADrM7sVtXM5+lTbuKlQdEVFZy0WOoogxrZOSBqWqkwV5LMof/Zih/ffgXJEL9WhH200Bq9feyvA1kVgPDKyx/ZhE7wSkfcMpT0mEXxHWB3OyAL6rK0DLu+VleOpq5CWCMuBHdmCVlJROn+Tq8KDBFceZYfcv0yBwpcqAkYcryjNXwTAVuybLrQLfNi/yX0JpIMd0ukbY8Sfz/vvvDt+2iLD7JNmLSeonyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZz5DMhdyWeVDDxbA3heHO79uySoR8Tx5QWQ87SyKXQ=;
 b=kd+r4qv80JlYtMdCLcdlkbRHS+MiuhEZbwnwlEQ07RgueayIzWC+uzh8N04Z/6Xgn+19ikryoElpxEK57VWQEEKLOjBoXpk4fpGkT2WNBG0COLq7KB5IaR/beGYU4ZqE+gdmxDMRsiUhxW8Y1jcfhvfve2GmlejRTiakqEl6fsNLH+RD60wo02DtGCfWcUn72VRCuA8tUdHNDJ4j6JqVVbZQHXbK35NtXs47s4k0hmPJmSkn+4k+Ev6RUqgch1LY4hh+EWUudQG4pFf0SuQvZrDAxdyre2+UlASL6nyGoCOrhATI185kcb9/uvzjDn4uAFmmYw8a+CCHyAnLYBOrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZz5DMhdyWeVDDxbA3heHO79uySoR8Tx5QWQ87SyKXQ=;
 b=nslz07CjFcct1qwC/I1VZ1hjO/m00gO3V+jjN2FNU/EQ0/y6Wq8qUIY2hmzZI+737VUv7LVGdLG9QKDQ0sCFxrtKcFhEgRhMhlO3SMGklA7A77/6kvHUOzCMphb+oltsbcBHK+bEZm04NyxVLbpi6iv38sgUXtU/czJU4ZpcFtg=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3576.namprd12.prod.outlook.com (2603:10b6:a03:d8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Fri, 3 Apr
 2020 21:57:33 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 21:57:33 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.7-rc1
Thread-Topic: [GIT PULL] ARC updates for 5.7-rc1
Thread-Index: AQHWCgLgHkpNzQFO/U+zax1BcaOPDQ==
Date:   Fri, 3 Apr 2020 21:57:33 +0000
Message-ID: <5b7afdcd-48dc-dc90-d7c0-53559a3ca3b8@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [24.7.46.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2203a204-afa8-4862-922d-08d7d81a0366
x-ms-traffictypediagnostic: BYAPR12MB3576:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB35766C9F4F6C3EFC7F52C96BB6C70@BYAPR12MB3576.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:568;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(396003)(346002)(366004)(39860400002)(136003)(31686004)(478600001)(107886003)(2906002)(186003)(4326008)(6512007)(6916009)(26005)(31696002)(15650500001)(81156014)(76116006)(66946007)(2616005)(86362001)(66476007)(36756003)(6486002)(8936002)(66556008)(8676002)(64756008)(6506007)(5660300002)(71200400001)(66446008)(81166006)(316002)(54906003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GztRLQ0mqlvqbLdIR78KlaKXiM87IOa6f3vpDFclZJKmRFDsxVjJ7use35kuMzWDoRGn0BxUxpIK4iTi0StpeU0wB2yPsibvAkmN4GccLQUur0jtMyC+dw9ZheTX8R+FAp4rVxlcpcLt6XbTUxs4iMxuHCWXUFdKxKgQAlXefYme+ejJvV/EFC/uL1a8t0Bq43/b400wi/MLOFdAnbeaSA/lc+r/mJ7u48ASXw332aydUSZGhDWDQlNR6LJnxQ7NqIOXVMj/XJLE4v+wrBpjAp55C/mvuv0tdaZ7R1kSQ1VvcmRBsyaRxhbGBWEnfOgAal1Cz1DJQ6px6M05NQl3CXC1nswCbNsl8eKm0cJREpaF/rzh/lWLZhxYVNgcbYA41e9FCPjEn2zDkgHU5WtCgzFk6AiRX0kBGX/bZN1JG6DitiJtp6ZmfQPz8Mkn8VVH
x-ms-exchange-antispam-messagedata: vKEz9XjD9ZIpbWifBPmmEIeQ/hD8rK2JaNmsz5mSVxrI1X0VfTAIxzCl614lUdio2BFRRPkOpKrVq3EzmaNkigmABjFLpkmsnNUzUIMvBIICEVutyl/NsCuYlHgy2QWOQWfg6RPGhtX/w/3L9DmlbQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <86A6FDD40B623648BE264499F9BF3F9A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2203a204-afa8-4862-922d-08d7d81a0366
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 21:57:33.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: de57jJfrExG4ppybhKo450p7DWVDPIth18IdijN4QBz6wMimHecltXzxLF84d51O9CdvOF5hNBUBnyh9uvaX6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3576
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsLg0KDQpUaHgsDQotVmluZWV0DQotLS0tLS0tLS0tLS0t
LS0tLS0+DQpUaGUgZm9sbG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IGZiMzNjNjUxMGQ1NTk1
MTQ0ZDU4NWFhMTk0ZDM3N2NmNzRkMzE5MTE6DQoNCiAgTGludXggNS42LXJjNiAoMjAyMC0wMy0x
NSAxNTowMToyMyAtMDcwMCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkg
YXQ6DQoNCiAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zn
dXB0YS9hcmMuZ2l0LyB0YWdzL2FyYy01LjctcmMxDQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdl
cyB1cCB0byBmMDlkMzE3NGYwMDJlZTJjZjE1NjIzZDVhMGY2OGY3MzkzNTM2Y2U3Og0KDQogIEFS
QzogYWxsb3cgdXNlcnNwYWNlIERTUCBhcHBsaWNhdGlvbnMgdG8gdXNlIEFHVSBleHRlbnNpb25z
ICgyMDIwLTAzLTE2IDEwOjMwOjQ5DQotMDcwMCkNCg0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KQVJDIHVwZGF0ZXMgZm9y
IDUuNy1yYzENCg0KIC0gU3VwcG9ydCBmb3IgRFNQIGVuYWJsZWQgdXNlcnNwYWNlIChzYXZlL3Jl
c3RvcmUgcmVncykNCg0KIC0gTWlzY2xsIG90aGVyIHBsYXRmb3JtIGZpeGVzDQoNCi0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CkV1Z2VuaXkgUGFsdHNldiAoNSk6DQogICAgICBBUkM6IFtwbGF0LWF4czEweF06IFBHVTogcmVt
b3ZlIHVudXNlZCBlbmNvZGVyLXNsYXZlIHByb3BlcnR5DQogICAgICBBUkM6IGFkZCBoZWxwZXJz
IHRvIHNhbml0aXplIGNvbmZpZyBvcHRpb25zDQogICAgICBBUkM6IGhhbmRsZSBEU1AgcHJlc2Vu
Y2UgaW4gSFcNCiAgICAgIEFSQzogYWRkIHN1cHBvcnQgZm9yIERTUC1lbmFibGVkIHVzZXJzcGFj
ZSBhcHBsaWNhdGlvbnMNCiAgICAgIEFSQzogYWxsb3cgdXNlcnNwYWNlIERTUCBhcHBsaWNhdGlv
bnMgdG8gdXNlIEFHVSBleHRlbnNpb25zDQoNCiBhcmNoL2FyYy9LY29uZmlnICAgICAgICAgICAg
ICAgICAgIHwgIDUwICsrKysrKysrKysrKy0NCiBhcmNoL2FyYy9ib290L2R0cy9heHMxMHhfbWIu
ZHRzaSAgIHwgICAxIC0NCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9hcmNyZWdzLmggICAgIHwgIDI2
ICsrKysrKysNCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9hc3NlcnRzLmggICAgIHwgIDM0ICsrKysr
KysrKw0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmggICAgfCAxNTAgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC5o
ICAgICAgICAgfCAgMjkgKysrKysrKw0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2VudHJ5LWFyY3Yy
LmggfCAgIDYgKysNCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaCAgIHwgICA0ICsN
CiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wdHJhY2UuaCAgICAgIHwgICAzICsNCiBhcmNoL2FyYy9p
bmNsdWRlL2FzbS9zd2l0Y2hfdG8uaCAgIHwgICAyICsNCiBhcmNoL2FyYy9rZXJuZWwvYXNtLW9m
ZnNldHMuYyAgICAgIHwgICA0ICsNCiBhcmNoL2FyYy9rZXJuZWwvaGVhZC5TICAgICAgICAgICAg
IHwgICA0ICsNCiBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgIHwgIDM0ICsrKysr
LS0tLQ0KIDEzIGZpbGVzIGNoYW5nZWQsIDMzMiBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMo
LSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMvaW5jbHVkZS9hc20vYXNzZXJ0cy5oDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmgNCiBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcmMvaW5jbHVkZS9hc20vZHNwLmgNCg==
