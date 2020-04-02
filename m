Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0345C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932112072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 01:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="L2xXYQ+c";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hO59BS7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbgDBBRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:17:38 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:59342 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732619AbgDBBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 21:17:38 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6751F43BA4;
        Thu,  2 Apr 2020 01:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585790257; bh=CAHC31azKPmIw9jnf4UyHUygo09Hsthpa2qx8+lj9os=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=L2xXYQ+cr6jjPWhh7e4yLQBIEA2F0IOiU8lGr/ddClclgwA6+FxfrBr4vf5TUNsgY
         ZZNTRRP2H3LRRPgZ5rJpcRQ1gX2mCvuDdPKLuxYNPJUj6BBGc4C0+g7AkbnRO8n8lu
         Er/0AYhIGw6fHRkGBuQT5oPNJuK0MO6kPuvOS+qkEjTkUeec2zp86URkSeiyqQGRK+
         TMFGR3h/kXsr41f1Ihd04zbYllKULo7lfostvXb0sTsNQz+2Wps2gGIORxYPdEuWbd
         Y0FtmT4Nu993lQuSg6DgtzjanWiDp9M7DzmRuS/0EYALMQaVD5oFLqkf0vhVuzlEnu
         54LjpkMkra4uQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 41652A007F;
        Thu,  2 Apr 2020 01:17:37 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 1 Apr 2020 18:17:05 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 1 Apr 2020 18:17:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUUsYRfB2PbLish129Fw1pg9L49mt4mYeUNd4J4SPB1gJx0HTbUJNhKm57akeWMvHf8wi8uXvZDM/7LaWM63zMXTqMeyBX0aV+ZC0lQQBtF8Le6M9QOuGYb8jfnLPTpRHFlPFNoQINxleIvFClCEAIvszzSkNvx+UwJpHfe4C9NGgXBc4zIVxbhN4EQFN1PEd0uUhMOe1Ik9VQsqjUvaWq4HCHJMOiz6ZoESG4L1Py7UJXhbNW+twowS7oWz6JAa44uQqtsa1ZvC+1Ze3tMNcGuADQ5wrSqAr6oF5VgUmfAKJTq9sxvynA7ow3p4q00AYM2BJbTAKJ6rtlQ+ZPChNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAHC31azKPmIw9jnf4UyHUygo09Hsthpa2qx8+lj9os=;
 b=CDwsAUkQvm2WHSIVDbHuWVhp2nnoHE7KThB7hwkVXAG6dNHjiPNcDXPYN21m3u2E1YGrFx3kd/hrwl04wUfQnLAkRksCEfZM7RX1BhTNTHY1rpC+lU5vqdejB+fy8muNNUzZalvJRZvgRTRFtGkrkPWFRZywqI5NooFNoBHyP2Iaz7jBS8zci1KhXgRQkPJmTu8JqD+tsQeQNFCHjY2ZL9JtvBdX6K6O4J1lWzjyXOfcB8P6BHJUUdAoLe7zhPKD6V6p5c9WGjTLRVFWFPZXgA6ZksmMfzV3iJR6I5LhNKvTfeSDZEbIUWnSceqeEZM6xR3iR+4vFQjbT5ik5I/WsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAHC31azKPmIw9jnf4UyHUygo09Hsthpa2qx8+lj9os=;
 b=hO59BS7uPmpM0b3Elk8822fI5Q4DZa/9F1NGTCyHu7OLN9yhnFqK0c4rbv9cQRDkZaeYy8VRAMZoxpwmssXCqLQKVWTFHSmbHpS8ptNIFQYohpOo9d2yvhzQz/JQFTs8TQSTE1L2gWkIWa6IXHXPNPajBh/omwbtiPAKwcQAv6s=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3463.namprd12.prod.outlook.com (2603:10b6:a03:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Thu, 2 Apr
 2020 01:17:01 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 01:17:01 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Ingo Molnar <mingo@redhat.com>,
        Claudiu Zissulescu <claziss@gmail.com>
Subject: Re: [RFC] ARC: initial ftrace support
Thread-Topic: [RFC] ARC: initial ftrace support
Thread-Index: AQHWBFAKT5pl4ywT2UWnQpMfdrf0t6hcrJAAgAhjoQA=
Date:   Thu, 2 Apr 2020 01:17:01 +0000
Message-ID: <fe7ae84c-745a-04b4-dcc0-5df8cc35ee0c@synopsys.com>
References: <20200327155355.18668-1-Eugeniy.Paltsev@synopsys.com>
 <20200327131020.79e68313@gandalf.local.home>
In-Reply-To: <20200327131020.79e68313@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [2601:641:c100:83a0:2878:237:6628:fcbe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba92a9c6-b940-4f31-7e8b-08d7d6a38c03
x-ms-traffictypediagnostic: BYAPR12MB3463:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB346324558A06CAB4E0178555B6C60@BYAPR12MB3463.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(366004)(136003)(39860400002)(346002)(396003)(86362001)(110136005)(66946007)(31696002)(64756008)(6636002)(66556008)(66446008)(54906003)(66476007)(478600001)(316002)(76116006)(31686004)(36756003)(5660300002)(2616005)(4326008)(2906002)(81156014)(6506007)(8676002)(53546011)(81166006)(6512007)(71200400001)(186003)(8936002)(6486002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KctxenmxKtTcx50I2NW092RxMajNjH7WH6j7zSsO0i0KthTLal68eNAlu2wzrHRri/K1rXlGYMJvBzdp1BhDULaT4eRntbjnQEYTVgTlLXdmBIB/I/G/hkiIUm7PXaXKG7smAm++wCI7q//PJ4NTIeBex0T0HYbymbrdy8eY06GhYqKgb77AoK2lC7vTe0fxvLAdKJC2k7//ZFrAunUCzdckYh4GqQvAKyfOlgFs9Citn/tbe6MignymPr4lSWeJk/PocUM/EeZOM6hZjw1bd/hImPgWiSECfVwPDyVJB6CM/VVIOxCBvSSQgnNxSVr9hbH+oF7EQxQOTuseYoU5/CTXW7Jh+1vL0/xVV0BEkxRq1Uvsuyw57udsSBX0jXw0fl1vLiRmhsveE2xsPQ2Oo82KzIp2nkOy/RxK857RMjmOCTq3f+Jw63CJV5HJUjQb
x-ms-exchange-antispam-messagedata: LiSoh34cUFYposhwtpYwpznxGfhiRcaYwI7/CubB8tWDhWGuRcx9C0mSnxwKuX2+CFE5YJy6tVEahQEjIw1qZkovSS8kflwZWdtoDcbE4Tze+yG0uxTZZ3LanKul0+ynfgdQ3eg68lD08i5PLH4gJOIZXmfk/inpusRTXQ3WBmFibumYlq0PfiyPRpv29zEnXumDGAEYNs2c1actR/rJTw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <449BF7F93279404B975E223888694978@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ba92a9c6-b940-4f31-7e8b-08d7d6a38c03
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 01:17:01.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7HNJEL52HctWyNs8dsWCHAdKUDdr5/4tppomN2T1HWSnHSgR4sexK5riy746pB/MOybaLjZXTbD+z1SJ/OKuFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3463
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

K0NDIENsYXVkaXUNCg0KT24gMy8yNy8yMCAxMDoxMCBBTSwgU3RldmVuIFJvc3RlZHQgd3JvdGU6
DQo+IE9uIEZyaSwgMjcgTWFyIDIwMjAgMTg6NTM6NTUgKzAzMDANCj4gRXVnZW5peSBQYWx0c2V2
IDxFdWdlbml5LlBhbHRzZXZAc3lub3BzeXMuY29tPiB3cm90ZToNCg0KTWF5YmUgYWRkIGEgY29t
bWVudCB0aGF0IGdjYyBkb2VzIHRoZSBoZWF2eSBsaWZ0aW5nOiBJIGhhdmUgZm9sbG93aW5nIGlu
IGdsaWJjDQoNCisvKiB0aGlzIGlzIHZlcnkgc2ltcGxlIGFzIGdjYyBkb2VzIGFsbCB0aGUgaGVh
dnkgbGlmdGluZyBhdCBfbWNvdW50IGNhbGwgc2l0ZQ0KKyAqICAtIHNldHMgdXAgY2FsbGVyJ3Mg
YmxpbmsgaW4gcjAsIHNvIGZyb21wYyBpcyBzZXR1cCBjb3JyZWN0bHkNCisgKiAgLSBwcmVzZXJ2
ZSBhcmd1bWVudCByZWdpc3RlcnMgZm9yIG9yaWdpbmFsIGNhbGwgKi8NCg0KPj4gK25vaW5saW5l
IHZvaWQgX21jb3VudCh1bnNpZ25lZCBsb25nIHBhcmVudF9pcCkNCj4+ICt7DQo+PiArCXVuc2ln
bmVkIGxvbmcgaXAgPSAodW5zaWduZWQgbG9uZylfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCk7
DQo+PiArDQo+PiArCWlmICh1bmxpa2VseShmdHJhY2VfdHJhY2VfZnVuY3Rpb24gIT0gZnRyYWNl
X3N0dWIpKQ0KPj4gKwkJZnRyYWNlX3RyYWNlX2Z1bmN0aW9uKGlwIC0gTUNPVU5UX0lOU05fU0la
RSwgcGFyZW50X2lwLA0KPj4gKwkJCQkgICAgICBOVUxMLCBOVUxMKTsNCj4+ICt9DQo+PiArRVhQ
T1JUX1NZTUJPTChfbWNvdW50KTsNCj4gDQo+IFNvLCBBUkN2MiBhbGxvd3MgdGhlIF9tY291bnQg
Y29kZSB0byBiZSB3cml0dGVuIGluIEM/IE5pY2UhDQoNClllYWgsIHRoZSBnY2MgYmFja2VuZCBm
b3IgLXBnIHdhcyBvdmVyaGF1bGVkIHJlY2VudGx5IHNvIGl0IGlzIGEgZmlyc3QgY2xhc3MgImxp
Yg0KY2FsbCIgbWVhbmluZyB3ZSBnZXQgYWxsIHRoZSByZWdpc3RlciBzYXZlL3Jlc3RvcmUgZm9y
IGZyZWUgYXMgd2VsbCBhcyBjYWxsZXIgUEMNCihibGluaykgYXMgZXhwbGljaXQgYXJndW1lbnQg
dG8gX21jb3VudA0KDQp2b2lkIGJhcihpbnQgYSwgaW50IGIsIGludCBjKSB7DQoJcHJpbnRmKCIl
ZFxuIiwgYSwgYiwgYyk7DQp9DQoNCmJhcjoNCglwdXNoX3MJYmxpbmsNCglzdGQuYSByMTQsW3Nw
LC04XQ0KCXB1c2hfcwlyMTMNCgltb3ZfcwlyMTQscjENCgltb3ZfcwlyMTMscjANCgltb3Zfcwly
MCxibGluaw0KCWJsLmQgQF9tY291bnQNCgltb3ZfcwlyMTUscjINCg0KCW1vdl9zCXIzLHIxNSAg
IDwtLSByZXN0b3JlIGFyZ3MgZm9yIGNhbGwNCgltb3ZfcwlyMixyMTQNCgltb3ZfcwlyMSxyMTMN
Cgltb3ZfcwlyMCxALkxDMA0KCWxkCWJsaW5rLFtzcCwxMl0NCglwb3BfcwlyMTMNCgliLmQJQHBy
aW50Zg0KCWxkZC5hYiByMTQsW3NwLDEyXQ0KDQpARXVnZW5peSwgdGhpcyBwYXRjaCBsb29rcyBv
ayB0byBtZSwgYnV0IGEgd29yZCBvZiBjYXV0aW9uLiBUaGlzIHdvbid0IHdvcmsgd2l0aA0KZWxm
MzIgdG9vbGNoYWluIHdoaWNoIHNvbWUgb2YgdGhlIGJ1aWxkIHN5c3RlbXMgdGVuZCB0byB1c2Ug
KEFsZXhleSA/KQ0KDQpUaGUgYWJvdmUgX21jb3VudCBzZW1hbnRpY3MgaXMgb25seSBpbXBsZW1l
bnRlZCBmb3IgdGhlIGxpbnV4IHRvb2wtY2hhaW5zLg0KZWxmMzItZ2NjIGdlbmVyYXRlcyAibGVn
YWN5IiBfX21jb3VudCAoMiB1bmRlcnNjb3JlcywgYmxpbmsgbm90IHByb3ZpZGVkIGFzIGFyZykN
Cmxpa2VseSBkb25lIGJ5IENsYXVkaXUgdG8ga2VlcCBuZXdsaWIgc3R1ZmYgdW5jaGFuZ2VkLiBQ
ZXJoYXBzIGVsZjMyIGdjYyBjYW4gYWRkIGENCnRvZ2dsZSB0byBnZXQgbmV3IF9tY291bnQuDQoN
CkFuZCB0aGlzIGlzIGNvbmRpdGlvbmFsIHRvIEFSQ3YyIGR1ZSB0byBmdXR1cmUgdGllcyBpbnRv
IGR5bmFtaWMgZnRyYWNlIGFuZA0KaW5zdHJ1Y3Rpb24gZnVkZ2luZyBldGMgPyBXZSBtYXkgaGF2
ZSB0byByZXZpc2l0IHRoYXQgZm9yIEJFIGFueWhvdyBnaXZlbiBzdWNoIGENCmN1c3RvbWVyIGxp
bmluZyB1cC4NCg0KLVZpbmVldA0K
