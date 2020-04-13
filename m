Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DB4C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:35:02 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA9420735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 05:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kQ5BzJPf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="tlM0iV9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA9420735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDMFe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 01:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbgDMFe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 01:34:57 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66F9C00860C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 22:34:56 -0700 (PDT)
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CB782C00AC;
        Mon, 13 Apr 2020 05:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586756096; bh=NCuFAP20Ca3+D5CTq3bBIVHwuZz7lPZ4LSyqoGHQRJg=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=kQ5BzJPfml6BsNoJE7GQPz/XPuSIZJ3odrAPMPQpEBDUmLdBEt38QrbTPfuziUUpZ
         qBRKMQ69Tx4XhJoZE3hYrhmWaiLZujORVT7L0DIwPKZhgeaZjSGZoLLUU/2YjvcXob
         3VSsmLUR4V6+LG1SYagPYUCENxa396KBB05v56E9P+G0vBHUwh3q66V/BXY9XzYCtj
         /ok0hPKoIAxzqMdH+MbgeQnwo0upg5GjmYggI7DMVDgB6qc3D/sf+Tbjs7MLDWDrRE
         H2A74sv/m3X6TdGM3Z7l/OAOu0Tj3ERokeYeS68i4XpiJ8qHgsAhmwY1Stg+2RbxPg
         GjnRTvq2E5UlQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id DE509A00CA;
        Mon, 13 Apr 2020 05:34:42 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sun, 12 Apr 2020 22:34:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Sun, 12 Apr 2020 22:34:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0wLiLJOa6OEXN9ukowJWKaXgb7kU5HUmFgztjqFTM4d8fB5HjYMJmssz9EH8njnvmXdG9bueFc4fmNsusx97vqHebYGmIcm/YtYp51f1zylzOMbyi+5SHQ9ipDdBlC+DsNuhsst4v+rj9+dD5GWelqsw9Kb/kB94Uo8h1JeIgw8r2lJ4VaSkzl7SvdtkT9EcIfSWMzI+Cg6y556OsQzttBMAktPndS27wn4R0J9Uha3qO6mWi16R2me0mEiQiP+jRFBwMxGGTwqiO4uf/ojxHuwxaTn412czvxSzOMrihPlhFuICId4fOmbOKAaUZjdWpn9MYsZCQkKsuTO4VwkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCuFAP20Ca3+D5CTq3bBIVHwuZz7lPZ4LSyqoGHQRJg=;
 b=Espe7FVZ4yCV1DBBx7xutDKrmmCU8clUE8XeErvHzUldTfJoJgFZGSHIsGZ0ObIrTM5GV4rZgNBiQ6HGqP5eIzFIzIo2plfiaibxAM6B42c7zLKBcVqYidBREhCnB8odJkrzfccsoVAzRV1aNcLDPiDDlrgBjJdg3d5Q22Pz6+rxTQ21DniYURapppY+L9muq3f9EI1uZdpMtNjaYC2w47DJQKe1Uo6IYyZH8tLaStuOGLsdquFZEsWS4Th8bEtQWVhTDOYF3PoM/Yy+e1AGO7XtjMhaZ3va7AwAO6rECZAFQqiPPz4Znka9x7OgtDE2OA3m7U9vsAxHlQqSRMaorg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCuFAP20Ca3+D5CTq3bBIVHwuZz7lPZ4LSyqoGHQRJg=;
 b=tlM0iV9Mfy9a5jKY+i7DKhdc/qStyMhjnwfgTwJfDfj/2YomXh3vvnHr12z97ZWpysvuWya8utcXtnjjD0cB1P8vHVokM9M1cOQItOrKbb6oUUhg9FRjlm7GtfCdMQu3kH71Atr/tJ2tacS4K+rjg3VmpjL/1CjVumT5IY8Gb7o=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB2760.namprd12.prod.outlook.com (2603:10b6:a03:72::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 05:34:40 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 05:34:40 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Enrico Weigelt <info@metux.net>, Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Allison Randal <allison@lohutok.net>
Subject: Re: [PATCH] arc: ptrace: hard-code "arc" instead of UTS_MACHINE
Thread-Topic: [PATCH] arc: ptrace: hard-code "arc" instead of UTS_MACHINE
Thread-Index: AQHWETOabgGABChFBEufQWoztbTnFqh2iAuA
Date:   Mon, 13 Apr 2020 05:34:40 +0000
Message-ID: <c0fa4fec-b0f9-2440-01b6-481a202742cd@synopsys.com>
References: <20200413013240.8659-1-masahiroy@kernel.org>
In-Reply-To: <20200413013240.8659-1-masahiroy@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [2601:641:c100:83a0:7c06:2fd:ae14:dd9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dac6d31-6854-47bb-85f7-08d7df6c5cf8
x-ms-traffictypediagnostic: BYAPR12MB2760:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB276094813EA50AFF66AB621BB6DD0@BYAPR12MB2760.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 037291602B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(346002)(39850400004)(136003)(396003)(366004)(8936002)(478600001)(186003)(6506007)(4744005)(2616005)(8676002)(81156014)(5660300002)(53546011)(110136005)(54906003)(4326008)(66476007)(86362001)(76116006)(64756008)(66446008)(316002)(31696002)(66556008)(6486002)(71200400001)(31686004)(36756003)(6512007)(2906002)(66946007);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ZOiTLx6KN5G7CqTFee858UkCT8fAIYgbnHq1v6y4++zBxd+4RmMJUxStp0AHrHZ8Fq12zFK4HSedj5RupXM/MKe52Q//YrwWiPfnG/Ojao7d4gEK+mtFo0Fk09ft95vmJ0XVKkRptlbvQoqDtdBk2QOlIw+YVVuBiHSDrJomTuD+6DgKUunDiXnyLVPPKetBSZrCOwjdnlOyjje/zwX3gX3KLM2SFH4Yija5aTo6mn7IYC80W8g7G58gkB0VQ3cOuXesMS5ob9zOSyfbwNV1oIBobMXm+138/Z39E4lTAWX0UeGankfw8itZ7C4Ssoxeb3eZ5GnRlbGLBf23xY72eZzM40vwv3mPMc3y3P153d68m+4DF+oEd3OytVI2PoGNU5qYhd23yF6lV8fA7TOLZ+cQBgcXATTYUOM661L4A5cCk/PnE1dRq/TocpsFrkk
x-ms-exchange-antispam-messagedata: dmcd2EZwB86Va+I+X0crMslYJ7LPgZlSG+Fb3UXg/2dMCggLOqvtsuktTHIgZKEzu3C52qoViJOyUF3hdewKCkiaXVpLT9kbZ2rEAjkMCBX/UO5SmPDmwY0sVg0SK5s2ivmz/FexocHg/G68+QjOwpNn+Z1DNQGVrUjbIHhuPeBT/nC+v4inGwQVd38VwssyaV/97OMXAvJP2ZTbqs+DAg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3CAFADE7317C043A6FE97CB98981DC7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dac6d31-6854-47bb-85f7-08d7df6c5cf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2020 05:34:40.3248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zYVNJjqKGS/jRy6lha4ypWQgHVdDTUxEbAlBkL/yqET4tjYTE2+56XYFVH+DTopQwuIL77bHRlBqcSx9L2uMog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2760
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWFzYWhpcm8gU2FuLA0KDQpPbiA0LzEyLzIwIDY6MzIgUE0sIE1hc2FoaXJvIFlhbWFkYSB3
cm90ZToNCj4gQVJDIHVzZXMgdGhlIFVUU19NQUNISU5FIGRlZmluZWQgaW4gdGhlIHRvcCBNYWtl
ZmlsZSBhcyBmb2xsb3dzOg0KPiANCj4gICBVVFNfTUFDSElORSAgICAgOj0gJChBUkNIKQ0KPiAN
Cj4gV2Uga25vdyBpdCBpcyAiYXJjIiB3aGVuIHdlIGFyZSBidWlsZGluZyB0aGUga2VybmVsIGZv
ciBBUkMuDQo+IEhhcmQtY29kZSB1c2VyX3JlZ3NldF92aWV3OjpuYW1lLCBsaWtlIG1hbnkgb3Ro
ZXIgYXJjaGl0ZWN0dXJlcyBkby4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hc2FoaXJvIFlhbWFk
YSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+DQoNClRoeCBmb3IgdGhpcy4gQXBwbGllZCB0byBmb3It
Y3Vyci4NCg0KLVZpbmVldA0K
