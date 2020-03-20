Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38FFC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC00520658
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="uVX6p78H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgCTVHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:07:37 -0400
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com ([40.107.236.85]:23736
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725874AbgCTVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:07:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFK9Fqm/UTebt9K7I3sl7Co1lR9IC3bXPcTyk92o/EakFgphpik/BAXYaD/Emr02BUwJXfNo/ypUf/WJcs1tNd8+fU9+g5X32zKnQxyF53DhxUIe5AIlEs/YA+AyQkWv5tvcp9bqzgjkAMkDijNEpu60Ei7kA84PjWj4G3YNl/BwWvDooycptA1bHM6KzJwfWEmE/ME72YZ/HyQn597kZd2BPjEuTOazWlLSSdE9Et7CVkeo/UALw4SVO5+YwPaWy9rnkE5HrzMhlpfNBcycKYDalnn4iKkbW1yDl/Xcg7g+NSEk6C3Z+sdnTw8epJ4xWMdZyHSca+WqIPVjHjiOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYMXpO3X/GKSBDiqILRVQg9jj0kQkF2wW1txW27ZTZc=;
 b=b709UfNWTqqVcbDRfnkNkHkVpZqeyjmdC+Rleuqqx1lYv3gvSayvURx6jmEu3M/mZInLJDGCyB+G/lr+hya+/2UZqvKAX5SRTD8Zy3XaO8/lx22zkZx9vSRyHAtEvh8+wbN8gNqI6UmXmG2I/+xvXIMRI0YuVm4MUlnXADl0bsNn2/ePaawS8kRdXsFBlv0rOee00qYc4znIszF8m66VfEDdFyvHw5NcDUGOSzoczUGSxPQhkI8O0ksDohM23Szm97cwdxUG9SOJVj6T0w+BTu2QfguQe2PcaR4H7demCbtVhKDryClQquBnYMVn6qvdlvQwIoYgvPC80ijqqX3rlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYMXpO3X/GKSBDiqILRVQg9jj0kQkF2wW1txW27ZTZc=;
 b=uVX6p78HwAZNIw7plr2JWemIt6Q1B8Ew8775r+XNdrWfQL8ZFuTqL1WMf5SZQ9aP2MzJ3LCsAbSlZ6DVQDm0MLvpQliZnqxH++rxMwsBh4NnQSW0eU+e7ELUnb1X4tA5jUngwX5CKCq/rWE6CazRo/5lSvs8yTxuyEuETWxdvvg=
Received: from BYAPR05MB5975.namprd05.prod.outlook.com (2603:10b6:a03:da::10)
 by BYAPR05MB4087.namprd05.prod.outlook.com (2603:10b6:a02:8a::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.9; Fri, 20 Mar
 2020 21:06:57 +0000
Received: from BYAPR05MB5975.namprd05.prod.outlook.com
 ([fe80::d5ff:6689:3a3:eff8]) by BYAPR05MB5975.namprd05.prod.outlook.com
 ([fe80::d5ff:6689:3a3:eff8%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 21:06:57 +0000
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Thread-Topic: [PATCH 0/5] x86/vmware: Steal time accounting support
Thread-Index: AQHV/vcMD4BtkBwH5UuJkcY/SPyQkKhR9vaA//+MvAA=
Date:   Fri, 20 Mar 2020 21:06:57 +0000
Message-ID: <A9A30A6C-F5C3-45ED-8225-07EFF4F6E8E4@vmware.com>
References: <20200320203443.27742-1-amakhalov@vmware.com>
 <20200320205929.GH23532@zn.tnic>
In-Reply-To: <20200320205929.GH23532@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.21.0.200113
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amakhalov@vmware.com; 
x-originating-ip: [50.47.105.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1080b766-b9c4-44e3-4a14-08d7cd129ff1
x-ms-traffictypediagnostic: BYAPR05MB4087:
x-microsoft-antispam-prvs: <BYAPR05MB4087F71EEBA42A728C1937D1D5F50@BYAPR05MB4087.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(8676002)(6486002)(64756008)(66476007)(76116006)(66446008)(7416002)(66556008)(54906003)(316002)(6506007)(81156014)(33656002)(6512007)(81166006)(15650500001)(66946007)(2906002)(45080400002)(478600001)(4326008)(86362001)(5660300002)(8936002)(186003)(36756003)(6916009)(26005)(966005)(71200400001)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4087;H:BYAPR05MB5975.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGdqRJBQVNm+vZaOdBum2RZo6kbzmVzXx6qrbhGRWXOZc/32k3uK0AjEHOo+QL907q3ds+E1WERil8zRIXmJ+YVPRbkJy0CO3SuNTwBF9U7nOnrzmGUB6dPcpiIojZYhlz5Vg6kRyitO0VJtnsjePWgDelB3i/PbCyM+GC/pMj33rZMXm2+5edLSkH0GTsBZw2A6+fCLAfSlmVEpG9eJGetu+4W4ufz79ksHVMms9bFRZjm7K7bRgU8wm3yP/wcy7g9ESL0OE+acIP86q906ij9jVwCfQdVgbKj1pdI1/HznTgqh+zOlNEdHLPXW3/eaHDkFVGq0WTmasERj/UnFlo6a7v7WWdokL8rLTbI5RnlHbZqLxWTslFftA1xkOiVyGTQgbItFuvH2n/kigclbpRDgmd1QHtWqygO/D0lmIw4KgMLZCEm7/2Dqz7h1X3TReI+EEwlTNYypjMjA9iDv3Y9QEbX1F8IQov6CtvdS/aMWqlTx++7Bw4wAU8GvyNIfF0JYMZKXioftbkXUgIlUaQ==
x-ms-exchange-antispam-messagedata: 5yGckOVC7H1bPlIKaoGO+QoKEnJvc1CPwT1eM+ZlQb3J8/fTAdKk4cfMVhGXbeVhmla6hQkg01tnrmuQeLa/WgIfNiMWyxQsPxpytyEPS1I46AJR8HIHzdNlmfMwyv4qu3JRn9pCoaS7HGENa+Bkkg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <715A2187F78F3140AD17D66366EFDDC9@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1080b766-b9c4-44e3-4a14-08d7cd129ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 21:06:57.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPJV30AH4DO29Uh4PTv2MYZWivDp3GDbFxF7qrGHdRb8yZgZf+V6USJjObRCcr26W3MeNPccl2uR8JXokv3RvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9yaXNsYXYsDQoNCkkgZGlkbid0IHJlY2VpdmUgYW55IHJlc3BvbnNlIGZpcnN0IHRpbWUu
IEknbSBub3Qgb24gdGhlIGxpc3QuDQpUaGFua3MgZm9yIHJlcG9ydGluZyBpMzg2IGlzc3VlLiBJ
J2xsIGFkZHJlc3MgaXQgaW4gdjIuDQoNClJlZ2FyZHMsDQotLUFsZXhleQ0KDQrvu79PbiAzLzIw
LzIwLCAxOjU5IFBNLCAiQm9yaXNsYXYgUGV0a292IiA8YnBAYWxpZW44LmRlPiB3cm90ZToNCg0K
ICAgIE9uIEZyaSwgTWFyIDIwLCAyMDIwIGF0IDA4OjM0OjM4UE0gKzAwMDAsIEFsZXhleSBNYWto
YWxvdiB3cm90ZToNCiAgICA+IEhlbGxvLA0KICAgID4gDQogICAgPiBUaGlzIHBhdGNoc2V0IGlu
dHJvZHVjZXMgc3RlYWwgdGltZSBhY2NvdW50aW5nIHN1cHBvcnQgZm9yDQogICAgPiB0aGUgVk13
YXJlIGd1ZXN0LiBUaGUgaWRlYSBhbmQgaW1wbGVtZW50YXRpb24gb2YgZ3Vlc3QNCiAgICA+IHN0
ZWFsIHRpbWUgc3VwcG9ydCBpcyBzaW1pbGFyIHRvIEtWTSBvbmVzIGFuZCBpdCBpcyBiYXNlZA0K
ICAgID4gb24gc3RlYWwgY2xvY2suIFRoZSBzdGVhbCBjbG9jayBpcyBhIHBlciBDUFUgc3RydWN0
dXJlIGluDQogICAgPiBhIHNoYXJlZCBtZW1vcnkgYmV0d2VlbiBoeXBlcnZpc29yIGFuZCBndWVz
dCwgaW5pdGlhbGl6ZWQNCiAgICA+IGJ5IGVhY2ggQ1BVIHRocm91Z2ggaHlwZXJjYWxsLiBTdGVh
bCBjbG9jayBpcyBnb3QgdXBkYXRlZA0KICAgID4gYnkgdGhlIGh5cGVydmlzb3IgYW5kIHJlYWQg
YnkgdGhlIGd1ZXN0LiANCiAgICANCiAgICAuLi4NCiAgICANCiAgICA+ICBEb2N1bWVudGF0aW9u
L2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dCB8ICAgMiArLQ0KICAgID4gIGFyY2gv
eDg2L2tlcm5lbC9jcHUvdm13YXJlLmMgICAgICAgICAgICAgICAgICAgIHwgMjI3ICsrKysrKysr
KysrKysrKysrKysrKysrLQ0KICAgID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIwIGluc2VydGlvbnMo
KyksIDkgZGVsZXRpb25zKC0pDQogICAgDQogICAgRGlkIHlvdSBub3Qgc2VlIG15IHJlcGx5IHRv
IHlvdSB0aGUgbGFzdCB0aW1lPw0KICAgIA0KICAgIGh0dHBzOi8vbmFtMDQuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRm1hcmMuaW5mbyUyRiUzRmwl
M0RsaW51eC12aXJ0dWFsaXphdGlvbiUyNm0lM0QxNTg0MTA1NDY5MjEzMjgmYW1wO2RhdGE9MDIl
N0MwMSU3Q2FtYWtoYWxvdiU0MHZtd2FyZS5jb20lN0NmOTFlOGVhNmE4MGY0M2Y0ODY3NDA4ZDdj
ZDExOTJkMyU3Q2IzOTEzOGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2Mzcy
MDMzNDc2OTUyNjQzOTYmYW1wO3NkYXRhPURqV0pvMEglMkJ1NnRJZXJsJTJCMFAlMkZydDV1UVRy
SVY2N3dzZjNMYnJJS1MzZkklM0QmYW1wO3Jlc2VydmVkPTANCiAgICANCiAgICAtLSANCiAgICBS
ZWdhcmRzL0dydXNzLA0KICAgICAgICBCb3Jpcy4NCiAgICANCiAgICBodHRwczovL25hbTA0LnNh
ZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwZW9wbGUu
a2VybmVsLm9yZyUyRnRnbHglMkZub3Rlcy1hYm91dC1uZXRpcXVldHRlJmFtcDtkYXRhPTAyJTdD
MDElN0NhbWFraGFsb3YlNDB2bXdhcmUuY29tJTdDZjkxZThlYTZhODBmNDNmNDg2NzQwOGQ3Y2Qx
MTkyZDMlN0NiMzkxMzhjYTNjZWU0YjRhYTRkNmNkODNkOWRkNjJmMCU3QzAlN0MwJTdDNjM3MjAz
MzQ3Njk1MjY0Mzk2JmFtcDtzZGF0YT1lWjZvWFlkZUIzRmhwUTMwSXZCbWpIaEVEMEYxUkhiVXkw
JTJCZ0xGdnZxdDQlM0QmYW1wO3Jlc2VydmVkPTANCiAgICANCg0K
