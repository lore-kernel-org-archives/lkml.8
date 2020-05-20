Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBE3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C3206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="rtbz5Na7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgETHPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:15:25 -0400
Received: from mail-eopbgr1320074.outbound.protection.outlook.com ([40.107.132.74]:62836
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726436AbgETHPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIFP1cvARrIrhOw4hN1PXCE3xApHMjbbKFOczWQM4wyI+d7cXhIWQRojmXiMJo/H16N+scAJovZrJtwin+PKYqlkwDhJfCGI7SbTSGDOlqb+qAy39cOS+32wTP2zhZQf8Qin2CMS40vN8qRma7k/T6PsGSzeVNPxV94nVKyIeibvSpQ7wScSB8UL6n2zJy9Zjs2aqlFyTukAU26Gkfan+PC0l5N/1uRMgXjjVFWJ6LlKj1AxCRJRz9ZlDpJ/D14Peb0XzLRHap0yJvoDVb3x5YjFnGjyEv3c9lrRI4T8nPAOuE2hO3n1mzdLxaqeyAbsSM2Kuus/d4y+a2Nk9L6bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdzTn7465mnduoK4XlK0Klj/szabJQMwmrXVITI7/3I=;
 b=iB6Nq98Y+JB/WksSz4rIeSbgHGZ1fiZSNhRJVgy7M5s1a16i3PmXv/tPMhaEfHv8uYeFyvatw3ZQKD3MlQCkIjZg1ahJbZJVsK8OUIlrhQTbBYD5p11Qy3kAjpzIkyySCGL2P37a+jCjuRaRqme5JSTDwFbUTcDyjEZicB1dklvsQogAqjUHrczekL0MJk9nrXjxrbeX2aX+jYrj1SRRw+gk/BbIDDUdnZX7MvU+MAFbMehjumF0MYLOPXmFrMrZ5j4BGdd3LgoO1Jdh+FN/AKIntwA6++CMN+7KDDkiUM+wYbsP1Wv4/sqfsdsxwwMPrc7nA89gKj+PGtTU95Ql9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdzTn7465mnduoK4XlK0Klj/szabJQMwmrXVITI7/3I=;
 b=rtbz5Na7VegcTgJ175JnL6FzzlRLPbAzFmCw8ALn9i1SMZ/YSWEtoh77/ovV0hjMWI6gyGEHDkkJ6K7HyFd5OyImBhZGlff5E4XSI0v8Age+4Q7tFBpfD++DfPl246xREp6Ot0bfFAVnadq3DKN6jx8aQbdQwnULyHXIFvqz4ns=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4508.jpnprd01.prod.outlook.com (2603:1096:404:10d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 07:15:22 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 07:15:22 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Zi Yan <ziy@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
Thread-Topic: [RFC V2] mm/vmstat: Add events for PMD based THP migration
 without split
Thread-Index: AQHWLN+t0tdY3mXd/ESlj6rXEl97xqiwkxmA
Date:   Wed, 20 May 2020 07:15:22 +0000
Message-ID: <20200520071521.GA29616@hori.linux.bs1.fc.nec.co.jp>
References: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1589784156-28831-1-git-send-email-anshuman.khandual@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cef4b4c4-1f16-4008-3822-08d7fc8d8f77
x-ms-traffictypediagnostic: TY2PR01MB4508:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4508EA788C6C5CEBEB3CF3C8E7B60@TY2PR01MB4508.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gLhyw1UAKdoPykFp2x4N5kpCsqnBwVIe8hCzGPpPxEXs6lxF9H5wrb1P4Kd3VDslPJ9SPfmvEoa9Z+iJ4XOEU276PxA8PfrTWg4E7ToC+A8bFc9ol5XwVV6TP6RABwux0gkv2WfnkyKQ71G4YZwx47FRhK+VDJp6grA82ff/5b/Cndx+JDLuHJCxUxulyNdDx4u89NLQ7hY3/vPZJM1fKfStiZChnOhbR2gHZRlUXHHIIy8IePzyCh0WC5jOzSVUrfaaQJ40bP+N0vfxLnDBMIlaE5ZNM/gxukJIHHTDMyx5sSGlCS8/W1wgYvYdNDUOT9GBecdicRmxMPPK1Os6Tl+Ue/ai8tZ6hdmm5Az8bayAkza8V/bDT/Mu2k19oGPkEp6O0Gtdxtl78dUnGED8Uzxg+c8lbWCJ+FNBDikHOT6yBhpq2+tKIva49Qa2eI4N
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(8676002)(478600001)(6506007)(6486002)(85182001)(55236004)(9686003)(6512007)(6916009)(26005)(4326008)(2906002)(186003)(8936002)(5660300002)(33656002)(1076003)(86362001)(76116006)(66446008)(64756008)(66476007)(66556008)(54906003)(66946007)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NR5bChmnR/LX73D+ru9fzJZnrikXX/AnmaB3XgVybib09emX7Oscc9Fbcc8XUiM/fNyNog5eDA6waGsxe0qJMlN0GAI1jc5GGVptMxEDowMy/u2DUDTt8ir53xciKSLZ+C8mRdEX1NGsau/ij0f34LOUa1godyPpHaQnz3pMSLHHEXjicCaX1HkkhKobZGD9fVn1I3s+VHVF38pC/UrM/vqsyjf0lNF1pUpUfLwoHjBmvvMMNqnR7uQcPc3TsVaeT1dAvVrf2wop0UUHmmsLYbB+ICr22h6ksSWuXWBcK7H9Rjn8MFPGkhQN4JS74U2bUdvHzyQqgNx4DEKfNoWxf0gS+unZWzzwUENOFbk+DwgVUCguOBHcRVYUkdoNY0ml/H6qMEAo6ma8tYePztt5eCKG7sHjYhZ/wUYrwaeBFnU7W3BV0k8tn5+YY6QnL6UDLhgFZFxomGS9t4mAYL6OztAk3Ao/LDh/ByIG2gkjeqCN0EJ9ZeAQxmovjdYRWDTa
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <DDE53C168BEB6A44AE778B5CCC4AE576@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef4b4c4-1f16-4008-3822-08d7fc8d8f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 07:15:22.2928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD6NH8SwnZnxb74QlVicXXkevVhlD5HM/3WvtfyUQVyS2vxu29BfXnW8Bi+VuzVmaCrCiIl5PFoR06cje2Wg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4508
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:12:36PM +0530, Anshuman Khandual wrote:
> This adds the following two new VM events which will help in validating P=
MD
> based THP migration without split. Statistics reported through these even=
ts
> will help in performance debugging.
>=20
> 1. THP_PMD_MIGRATION_SUCCESS
> 2. THP_PMD_MIGRATION_FAILURE
>=20
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Hi Anshuman,

I'm neutral for additinal lines in /proc/vmstat. It's a classic (so widely
used) but inflexible interface. Users disabling thp are not happy with many
thp-related lines, but judging from the fact that we already have many
thp-related lines some users really need them. So I feel hard to decide to
agree or disagree with additional lines.

I think that tracepoints are the more flexible interfaces for monitoring,
so I'm interested more in whether thp migration could be monitorable via
tracepoint. Do you have any idea/plan on it?

Thanks,
Naoya Horiguchi=
