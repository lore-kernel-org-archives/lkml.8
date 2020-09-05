Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6956C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B21520578
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="VGsWHbYl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XMP0j6Y/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIEBJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:09:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44026 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgIEBJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:09:06 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25ADC407CE;
        Sat,  5 Sep 2020 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599268146; bh=tAhiQLjKbj7leVrjYmKWpjwcsxMlPjE+ajKcF4f4qyo=;
        h=From:To:CC:Subject:Date:From;
        b=VGsWHbYl/tFUvaVa953ycQiUAPf1n67jNPtxZOx4jsYZX6+zI5OO7KXKe2NT6FWpl
         J0JT5dJFh0PmpKblqLaq8ziikzVsLym1fovP0tUvfnCRY1Zk2jjluglwBimo6+6FgS
         MXO4VU8+WvosYz0TXS991FXFs6aSmMdZQb4AFHoBU6A2zHnFY6OYWbCtDz5+0Anf6T
         wH7zRKSbj+3x1bQT631yySHbDq8uQ604uCBjHKEdXsb67/Xn3VdwWbzfAiKqBjbRt7
         wZqXyeGmBRbPJ5rTGxQLFR8Yw/xVWga10bJ1vHrc5W6e50vtQpbr2O0vi/LZ37Yzaz
         DHUWGo/6nvuRQ==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A40ACA006E;
        Sat,  5 Sep 2020 01:09:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id E9E3A80F76;
        Sat,  5 Sep 2020 01:09:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XMP0j6Y/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1+gBWRWLECi6gpFf733ZW27pxL1y3ZaSXJq5HRxD6gaIY74SzZM1+bIs+GRFqUBe1fFNl2ePDuO5OvaLcQyTz7J7280AjQbBOTVFnrVTeeQj3++zCBm4AVZWllxAQS1XFpvtaOhj+cg/NwXJaWG4co7vScctQPpmhpLZXYxYenLeSlBbZt7nM1QOXNNzquQqz6Is6YnJLAMx/Gl+P775gYQyyV+1ku2EJGszLCQ6c7A1YxnDWSU9E4ZfLKzxzdH6GQgQwwYhuMTaFfSzQFMTDgWYiM+QiMr279MYvDd61aDMbDshqtOksvu5dP/DwqUCM7dUgnVJDpbp4n/Tr9Y6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAhiQLjKbj7leVrjYmKWpjwcsxMlPjE+ajKcF4f4qyo=;
 b=U8QEGm0M9xkkfJhtFAkHe/tFUguHHfEOP1EIo97ushFV9HKpGcUom/KJqZuFtqdK/F2NbR587ayX5yMAY1D5/4AGHSm+WZGmCvO+yBqRJS644v49jXZ95vcsB/k7B3wGg+TBTgq7IV1OZ18aOxia3txK5an0sg73yc8tg88KwI3MCzXWpFbynBsk+jFu7ZwEYstr0HIu2aLOkgAXF7WbxL2OzPw4dO3qq3wOvfYmg5C+6kmApyLCkOWEyYxtfJRW6zd6p7Ed+dHmOH/KZMA3Bu4m6RD6KdeVNxloKsbXvoKWqPOtheht6MNa0zfX9yxgM7Os9Lo1kUZSQscET3Sdqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tAhiQLjKbj7leVrjYmKWpjwcsxMlPjE+ajKcF4f4qyo=;
 b=XMP0j6Y/21poenub5jbqlM/M2H65DarzJ6s21d4t7Lp2NUrx19oL4YsDfA5D8LzO/FgXBLpEiMiQrm+3GxenofTS2hXPbj+z4DATB7F4uh8PL9+Hp/4avbD6wivhQtpNjGphkFy6mP21ipUWMgTw0U1f7z9kMYUodq/kRr/dhIA=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Sat, 5 Sep
 2020 01:08:56 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::19e1:33b2:5f25:5c5e%5]) with mapi id 15.20.3348.016; Sat, 5 Sep 2020
 01:08:56 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Evgeniy Didin <Evgeniy.Didin@synopsys.com>
Subject: [GIT PULL] ARC updates for 5.9-rc4
Thread-Topic: [GIT PULL] ARC updates for 5.9-rc4
Thread-Index: AQHWgyEgQk4ef6lCzUO46l9cpBqINA==
Date:   Sat, 5 Sep 2020 01:08:56 +0000
Message-ID: <0724a4d3-7f69-040e-2a76-67ceefe9e745@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [107.3.145.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c710f20a-70f3-44ab-5609-08d85138437f
x-ms-traffictypediagnostic: BY5PR12MB4178:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB41786768A5B785E7AF5DEEAAB62A0@BY5PR12MB4178.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZnzHIpF+vmiXC5SjVkq+/j3cx2jMhBZCsfyCN86LpJagSkEC1TjaZ8dKgtb1XCDIT6AH0mVx5fGf+iKKrGKpC7lc8dDa1oVQaJxobDutYDX3mBWbkhZlb7IQ0DZ/S3hqFVVCYVRuYLgbwuO765Swx4fOVJw1KlpDP6Ea4BP45EaIXkheEuzQWe7tHM6OEvbXxOkKUEGvyB4A3IsxVCAoFlkjD4pYjhZo0N+cnL8XAqOLFzlJmPHTQa9J0iswB0b1zKyey7BgkyPvHBdXHTs2OeAP9Vi9mNn1XNu+8yasaohVcRAK8ApVrUyfAP8/3GqJvD9CHJbrb0Mu5Cfp3nMMbMWjmUQFz7eF0wRYvfXTelNKFdAMCh3dioOBX0jdqEHk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(346002)(366004)(39860400002)(71200400001)(4326008)(8676002)(66476007)(66946007)(66446008)(66556008)(64756008)(83380400001)(76116006)(6506007)(26005)(86362001)(107886003)(31696002)(15650500001)(5660300002)(8936002)(6486002)(54906003)(2906002)(36756003)(31686004)(316002)(186003)(6916009)(6512007)(2616005)(478600001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OieM4mMO5K3wAQqmwquJEXYlo4WQHIKRs4yxXxGxQIxoXPbTgX9iNQuO1JiMOWUDCwNa+2L2Kff5n/MrDokfnXBYE3nTPpMzEDnudq0bIXhW+W7hDOu62YD4Q8TVjYdJspjIwpSsbclG9RIPFhFEwppq9udET5PEtvQ00jMEZp4EqmA7qRTP1NtziJR/99IwcpB3yN5JYt0MMd5Aa809S71Tbs2oMv57ad9EyBqcTRAa25NXLTP4vbMM3cndRASPk1NAfXL6y3Z/N/oxW1xfQql/kto6h8E77+fu0cuG/g+fOstNLjF5z2UmB4bCNLNoOtmS8E2zVINojvIPuwkXInRmodm6wCAR7makV9FbmsngW3PtpXQbScOaevkZW28YzUtwQJt+fQgPOFD0w+2NH0vKtOjUCMMCmV/SETJre1tPOh25Dxh4GHdYN2WK0pLW55BvhXW/OwVdFxUwn+ito/ic5MpwvyZ2Xi4ICCTiCzZlTTGh7KlZFDgqAYqJ9/hx6d6/JGELcX0SEZdf175D5ooCeZq/HlMkrnIzM7EhqfweYt7ccxHOOwAT0JGBgf6U5hHCOXRneBmpdx03CqPdwJ0KSRKRhQbDsFIdFxQcZtd0kgj/WCpVqw8DTR/8jLxLjc6hbXzrIWQaKMwDXhfzAA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E08F6F5C938D4146B369465926922C93@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c710f20a-70f3-44ab-5609-08d85138437f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2020 01:08:56.4222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5P92lZjEqjit3JJwNDc/Tucf3Jps2IY+J8qyANdiHx61l02EuY32Dug0j4iEiPzH39ajtPTFKiLYJljXM+McAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsLg0KDQpUaHgsDQotVmluZWV0DQotLS0tLS0tLS0tLS0t
LS0tLS0tPg0KVGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCA5MTIzZTNhNzRlYzdi
OTM0YTRhMDk5ZTk4YWY2YTYxYzJmODBiYmY1Og0KDQogIExpbnV4IDUuOS1yYzEgKDIwMjAtMDgt
MTYgMTM6MDQ6NTcgLTA3MDApDQoNCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5
IGF0Og0KDQogIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC92
Z3VwdGEvYXJjLmdpdC8gdGFncy9hcmMtNS45LXJjNA0KDQpmb3IgeW91IHRvIGZldGNoIGNoYW5n
ZXMgdXAgdG8gMjY5MDdlYjYwNWZiYzNiYTlkYmY4ODhmMjFkOWQ4ZDA0NDcxMjcxZDoNCg0KICBB
UkM6IFtwbGF0LWhzZGtdOiBTd2l0Y2ggZXRoZXJuZXQgcGh5LW1vZGUgdG8gcmdtaWktaWQgKDIw
MjAtMDktMDEgMTE6NTk6MDQgLTA3MDApDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkFSQyBmaXhlcyBmb3IgNS45LXJj
NA0KDQogLSBIU0RLLTR4ZCBEZXYgc3lzdGVtOiBwZXJmIGRyaXZlciB1cGRhdGVzIGZvciBzYW1w
bGluZyBpbnRlcnJ1cHQNCg0KIC0gSFNESyogRGV2IFN5c3RlbSA6IEV0aGVybmV0IGJyb2tlbglb
RXZnZW5peSBEaWRpbl0NCg0KIC0gSElHSE1FTSBicm9rZW4gKDIgbWVtb3J5IGJhbmtzKQlbTWlr
ZSBSYXBvcG9ydF0NCg0KIC0gc2hvd19yZWdzKCkgcmV3cml0ZSBvbmNlIGFuZCBmb3IgYWxsDQoN
CiAtIE90aGVyIG1pbm9yIGZpeGVzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkV2Z2VuaXkgRGlkaW4gKDEpOg0KICAg
ICAgQVJDOiBbcGxhdC1oc2RrXTogU3dpdGNoIGV0aGVybmV0IHBoeS1tb2RlIHRvIHJnbWlpLWlk
DQoNCk1pa2UgUmFwb3BvcnQgKDEpOg0KICAgICAgYXJjOiBmaXggbWVtb3J5IGluaXRpYWxpemF0
aW9uIGZvciBzeXN0ZW1zIHdpdGggdHdvIG1lbW9yeSBiYW5rcw0KDQpSYW5keSBEdW5sYXAgKDEp
Og0KICAgICAgQVJDOiBwZ2FsbG9jLmg6IGRlbGV0ZSBhIGR1cGxpY2F0ZWQgd29yZCArIG90aGVy
IGZpeGVzDQoNClZpbmVldCBHdXB0YSAoNCk6DQogICAgICBBUkM6IHBlcmY6IGRvbid0IGJhaWwg
c2V0dXAgaWYgcGN0IGlycSBtaXNzaW5nIGluIGRldmljZS10cmVlDQogICAgICBBUkM6IEhTREs6
IHdpcmV1cCBwZXJmIGlycQ0KICAgICAgQVJDOiBzaG93X3JlZ3M6IGZpeCByMTIgcHJpbnRpbmcg
YW5kIHNpbXBsaWZ5DQogICAgICBpcnFjaGlwL2V6bnBzOiBGaXggYnVpbGQgZXJyb3IgZm9yICFB
UkM3MDAgYnVpbGRzDQoNCiBhcmNoL2FyYy9ib290L2R0cy9oc2RrLmR0cyAgICAgICAgICAgICAg
fCAgNiArKy0NCiBhcmNoL2FyYy9pbmNsdWRlL2FzbS9wZ2FsbG9jLmggICAgICAgICAgfCAgNCAr
LQ0KIGFyY2gvYXJjL2tlcm5lbC9wZXJmX2V2ZW50LmMgICAgICAgICAgICB8IDE0ICsrLS0tLQ0K
IGFyY2gvYXJjL2tlcm5lbC90cm91Ymxlc2hvb3QuYyAgICAgICAgICB8IDc3ICsrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGFyY2gvYXJjL21tL2luaXQuYyAgICAgICAgICAgICAg
ICAgICAgICB8IDI3ICsrKysrKystLS0tLQ0KIGFyY2gvYXJjL3BsYXQtZXpucHMvaW5jbHVkZS9w
bGF0L2N0b3AuaCB8ICAxIC0NCiBpbmNsdWRlL3NvYy9ucHMvY29tbW9uLmggICAgICAgICAgICAg
ICAgfCAgNiArKysNCiA3IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKyksIDczIGRlbGV0
aW9ucygtKQ0K
