Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380EDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B1A20739
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hxB2BjMi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D/Y6oxCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGGGTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:19:06 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:48624 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgGGGTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:19:05 -0400
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5498BC06E7;
        Tue,  7 Jul 2020 06:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1594102745; bh=ZebGz6GftpERu/PvkwKEw0X/h4wvM+LAMepUQzJz4E8=;
        h=From:To:CC:Subject:Date:From;
        b=hxB2BjMiiRTIZTdHcni0lmwP/XhP14KqmBt56C1uk03SN8C91TDu710E71bkh016s
         a1+3cIzcIFnk+SvcaJJQQ0A02Z+HngrbGljru/a+lkMWkx68l1ko1DUIj+Z+xhO0mX
         Ab9yLziVByF50nJVbBSJSrtKYdPCTc96kDFyqalpxNoAFFv41BeLEw9M7WzL53VyF5
         Xm4Ack62Sa5H6yHAjCuyacf4M0Huk18s49TU8tV/iEnXvaZDocCYbdPa0uLN1CPnoj
         3Xsw6fuwlRu9WMglISNNQ270YU006Bk/xiK6NFYtiu1GoFs9mqpHRSrkVhy6uDr/C5
         NVwN4MmyI3HBQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id EF0BBA0096;
        Tue,  7 Jul 2020 06:19:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id ADDC281113;
        Tue,  7 Jul 2020 06:19:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="D/Y6oxCT";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELqKZy37Oo1zUxggGoIbiB7xi/aSGcQrpH03PlRLy219c1bh+hun73+9sdPwhK5mS503IGd9iE4zKAycGdCFXBvz0cn0fI06FaSrGD/6pW8paSW8SN3V3ocbjOlnoM7nIyPSLJ2pm26v0rm4GtBYvjSwkbJ+ZbCIBmlcnGUE5WAtzDfzgFxz5gJnNZj9DBHgbgUyfWl1kRJ8clvTFL4ELgegsHngO/YhlY37Rct9FWibf+MublRSgOFw7ft1mdXH4NZ5N+Jc72xpsm9CKu93IToxvcUb1xYHg4ta6NN58xWxRwHLs+tbODftM/gUQIAf/S+f5j6HdNCacEXkL88TMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZebGz6GftpERu/PvkwKEw0X/h4wvM+LAMepUQzJz4E8=;
 b=Ec+5ZKek+hTGKTg9Wy+xxH5tPiQcE6LVd8yGtxqhsy7Y3W7PI/lF2oGg4q2Unlwoce6b8iOmnFCiBrv8j+r8y0O59yMJI4Ce6VAbK0RlLgd/9youwz/uGXgWTCDG6HNpc1PVwjozjGD8+sKwqzIW9VsNboc+vI7O4ZAtlGTQ4cV4o2DyFgfrL7T0DXw8D7esuKeubJ8HaGD5Xkz0ezx6oR9TeG00EGtsY2MOGE7POGFkatG+SHtys4sZjgMFN73CrlTTG244muzRzYXRDYIlxQmTeudzSe0cYPvpgSnG5Lqor0Jy/OHrx5O+DqblP6ckArnOX4zhtq8MGY1t4cbujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZebGz6GftpERu/PvkwKEw0X/h4wvM+LAMepUQzJz4E8=;
 b=D/Y6oxCTHcIYeOeuhUoHGqjDJ6yKybrHOA8Tpo1voY18Di8JnUPk0AINfWPDmKmcBH8VfAE/FzxfRaNkHKEPzTb2hBjR6xX7TCcdYA1uTh2AwlJR8Osp7p9z4aOBS76HVXxgF3tUYXvfFLHmFpj/LVw7uWMoFZpFdTQtl0+PHw0=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB2711.namprd12.prod.outlook.com (2603:10b6:a03:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Tue, 7 Jul
 2020 06:18:57 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:18:57 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.8-rc5
Thread-Topic: [GIT PULL] ARC updates for 5.8-rc5
Thread-Index: AQHWVCZ/k4RVpwcvkEWm69xGWcjetQ==
Date:   Tue, 7 Jul 2020 06:18:57 +0000
Message-ID: <41052a3e-c51d-a0d8-06ea-af1e30fb097a@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [2601:641:c100:83a0:fee2:8ed0:e900:96d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32234454-a250-4c9f-97a0-08d8223da1ec
x-ms-traffictypediagnostic: BYAPR12MB2711:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB27112E3D1B10BF17EFC73276B6660@BYAPR12MB2711.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:422;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ccBsa58fh+nS3Epg7Ylk3WwrtuULQv7UzFUIE6rgGFomYhxb4SWDwz0hN/c3bnbNsj13L047W/IGY04O3+03mrd5T1aHtdu0gufKLutcs8sszvwUZomgKGK95KU1vBMAIL6NR/OjyUZ5iISVumu46efZMsAe9pxRxlM+0Im6jZ/03cteH3DNuQVXnaPd9GZ9s4mfEoRqNRD50/qp5ZbUufGVCMxpkTg00RUTgk5o1T61LHcCcrRC1k75l4mqwaVAcQiwupJVVdUV+LoRJ9eOk5cqu0mr1GgbgDL9Au1ZqoRVWISKRJ42K3bc6gdNYGLy2eEPVru0jVDRFFNbOZBmy8q7JPUwDnm0r0OTzZ9fjzY7fQtPtI0X4/Ck2gjELmJY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(136003)(366004)(396003)(376002)(4326008)(6512007)(83380400001)(54906003)(107886003)(31696002)(8936002)(2616005)(2906002)(316002)(6486002)(86362001)(8676002)(5660300002)(15650500001)(186003)(478600001)(76116006)(66446008)(6506007)(6916009)(71200400001)(66946007)(36756003)(64756008)(66476007)(66556008)(31686004)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ses8fXS2Gak5sPSrK4Bpf4gM0u9vXDs8BkyUMQLdnH74d0xCzSLrywgdwhRfOR3Gn62cwd4NdPbOIKn3KNGSc00iDUBZPivA6IIMMVLD2fDqlyIZ1LvGNvm6HDc8yXQd1KaVm7nw7huuZ9unrzvcHQ3YFnvpTmJYEKPcmmqQ/hptqWMJVn6J8B9QrifoMshMFMVpzIV1EhV1XrhkHeMoR4OLvKp3vVYJFBs63OcaqIXQpGaSWUixqdBbTFo7YH9YptjO/HDgA11K9JoGuP1T+MZ+rZvho2p2zolJMlJ8VISBjW1esPv7oufVug9x/KCyw8gpIlvrma3E3aTSujh3C593EUbJZUV/KYjEilL43sIKGg8NSBbejM+8wVNcosZx7bt9AHuhpNh+bx0OYSKxScidOKbVa5d3/mLDKxhFiiodisuUc0dEi1HaU5vTtzzMHd3k9p/2D1buwcHLJ7MuyHp1jTSpQkfg7sx81ikdcQQDoNjo89SadqdaEGKerHtp2NArOXyv6X6a7YItptkCpXB8FsOeGiV/kpCP52q2UsXhkk4HJ0Twjie915XX0Z2S
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F9C4726F4119E40BFB0FF61879CAFB2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32234454-a250-4c9f-97a0-08d8223da1ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:18:57.6632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6dkFkiQlZklRgMAoMwGBbCRRzH3iUrfnqvRmJtZIlDZlv/al1uhPjc64+f4Jv3ZsuGhfiRMdqZbuXmMAMrdlDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2711
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsIEFSQyBmaXhlcy8gZm9yIDUuOC1yYzUuDQoNClRoeCwN
Ci1WaW5lZXQNCg0KLS0tLS0tLS0tLS0tLS0tLT4NClRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5j
ZSBjb21taXQgYjNhOWUzYjk2MjJhZTEwMDY0ODI2ZGNjYjRmN2E1MmJkODhjNzQwNzoNCg0KICBM
aW51eCA1LjgtcmMxICgyMDIwLTA2LTE0IDEyOjQ1OjA0IC0wNzAwKQ0KDQphcmUgYXZhaWxhYmxl
IGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIHRhZ3MvYXJjLTUuOC1yYzUNCg0K
Zm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDEwMDExZjdkOTVkZWEzMTFjMGYyYTNlYTY3
MjViNWEyZTk3MDE1YTg6DQoNCiAgQVJDdjI6IHN1cHBvcnQgbG9vcCBidWZmZXIgKExQQikgZGlz
YWJsaW5nICgyMDIwLTA2LTE4IDEzOjA3OjI0IC0wNzAwKQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpBUkMgdXBkYXRl
cyBmb3IgNS44LXJjNQ0KDQogLSBVc2VyIGJ1aWxkIHN5c3RlbXMgdG8gcGFzcyAtbWNwdQ0KDQog
LSBGaXggcG90ZW50aWFsIEVGQSBjbG9iYmVyIGluIHN5c2NhbGwgaGFuZGxlcg0KDQogLSBGaXgg
QVJDb21wYWN0IDIgbGV2ZWxzIG9mIGludGVycnVwdHMgYnVpbGQNCg0KIC0gRGV0ZWN0IG5ld2Vy
IEhTIENQVSByZWxlYXNlcw0KDQogLSBtaXNjbGwgb3RoZXIgZml4ZXMNCg0KLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KRXVn
ZW5peSBQYWx0c2V2ICgyKToNCiAgICAgIEFSQzogYnVpbGQ6IGFsbG93IHVzZXJzIHRvIHNwZWNp
ZnkgLW1jcHUNCiAgICAgIEFSQ3YyOiBzdXBwb3J0IGxvb3AgYnVmZmVyIChMUEIpIGRpc2FibGlu
Zw0KDQpWaW5lZXQgR3VwdGEgKDUpOg0KICAgICAgQVJDOiBlbnRyeTogZml4IHBvdGVudGlhbCBF
RkEgY2xvYmJlciB3aGVuIFRJRl9TWVNDQUxMX1RSQUNFDQogICAgICBBUkM6IFthcmNvbXBhY3Rd
IGZpeCBiaXRyb3Qgd2l0aCAyIGxldmVscyBvZiBpbnRlcnJ1cHQNCiAgICAgIEFSQzogZWxmOiB1
c2UgcmlnaHQgRUxGX0FSQ0gNCiAgICAgIEFSQ3YyOiBib290IGxvZzogZGV0ZWN0IG5ld2VyL3Vw
Y29uaW5nIEhTM3gvSFM0eCByZWxlYXNlcw0KICAgICAgQVJDOiBidWlsZDogcmVtb3ZlIGRlcHJl
Y2F0ZWQgdG9nZ2xlIGZvciBhcmM3MDAgYnVpbGRzDQoNCiBhcmNoL2FyYy9LY29uZmlnICAgICAg
ICAgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysNCiBhcmNoL2FyYy9NYWtlZmls
ZSAgICAgICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrLS0NCiBhcmNo
L2FyYy9pbmNsdWRlL2FzbS9lbGYuaCAgICAgICAgICAgICAgfCAgMiArLQ0KIGFyY2gvYXJjL2lu
Y2x1ZGUvYXNtL2lycWZsYWdzLWNvbXBhY3QuaCB8ICA1ICsrKystDQogYXJjaC9hcmMva2VybmVs
L2VudHJ5LlMgICAgICAgICAgICAgICAgIHwgMTYgKysrKystLS0tLS0tLS0tLQ0KIGFyY2gvYXJj
L2tlcm5lbC9oZWFkLlMgICAgICAgICAgICAgICAgICB8ICA4ICsrKysrKysrDQogYXJjaC9hcmMv
a2VybmVsL3NldHVwLmMgICAgICAgICAgICAgICAgIHwgMTkgKysrKysrKy0tLS0tLS0tLS0tLQ0K
IDcgZmlsZXMgY2hhbmdlZCwgNTkgaW5zZXJ0aW9ucygrKSwgMjcgZGVsZXRpb25zKC0pDQo=
