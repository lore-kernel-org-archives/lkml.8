Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EA8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1179120679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Sony.onmicrosoft.com header.i=@Sony.onmicrosoft.com header.b="riGjhQjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCHMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:12:44 -0400
Received: from mail-eopbgr1410102.outbound.protection.outlook.com ([40.107.141.102]:11578
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725906AbgFCHMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:12:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyD2rQMMCGHBISb9JE8xHE2KC575McwZ9N1NN5UymL6fiBkBrOHwxe35k5zPxfo/5aIQN5Z8184IHcDQC4dD7Oshw/vDaoh7Xh0q9uE+0aR9yQ/nI4ol8rF3ud/QZxyE9aaSLhp0Vm4pwSgDfAYhsmexd+SB2qXNkM8qC1XZ+umNyVtfT3YcK0MVaXHeq7xanFLACU5rD7bzPCj3upXOdwnxlzVj/PTS7tTM96y6B6z5yfxEDa+KAZt6B0VFFL7e7k0Do3riXGcAMnXduTVYbXzDv0doSc/DfQqZS2eKRBap+pA3G8EG/jjIAu5QjXJ+gxQoZQ/H8eMV38FXBkYntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O09FNg/QqNJrwOLxIKRxY3BV76E3fGrDBgibyPwoOdk=;
 b=ME+i222c1YgG96HWJe05cjQ0H5HvV4wkJtcp4rLAQdAhdypkLSV5Y1uK/VtgYeROIZrwvJwqa9dA8pdUGpKcST9adrIIvwguVkBVkuFopq1e6tdU7FW0mRD3Ib78Hk2GFPjvUGo4Ij+f57IwHWSD4Wguu7/lyZqpG9r+9BOU1h6AF3pu3o4o1PBPqKW5z3oqTtKKbwyjAHjfvHZXMlxboUy9hxwenbr9PWfT60U1k7M1Yab7zj2q9Lzf90q10iw1ppJeouet+TnDDtLI+bVQmdsp5E5k/gxER+wKlS9QraDsdEl3VZljVNUEeLla7PyYE7VK8T0VzU71GFPYFUNRWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Sony.onmicrosoft.com;
 s=selector2-Sony-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O09FNg/QqNJrwOLxIKRxY3BV76E3fGrDBgibyPwoOdk=;
 b=riGjhQjNWAkUnEJa+5xOXj+1ECekmXcCd3dJoAoEIqgoG6S+r7SgKaDYvNvq6nD7tr8gU0Jp8DxLwJ29xq09QdpNux6QLCBSxasLm5rVFy9jXkkmLMr5EuoYL/FX0HV7IERFrox7tSnKAwhrIxS7RHedCV3I3dS1Fr037Lil6sE=
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com (2603:1096:403:e::12)
 by TYXPR01MB1678.jpnprd01.prod.outlook.com (2603:1096:403:d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Wed, 3 Jun
 2020 07:12:35 +0000
Received: from TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe]) by TYXPR01MB1503.jpnprd01.prod.outlook.com
 ([fe80::6508:8e66:164c:3dbe%7]) with mapi id 15.20.3045.018; Wed, 3 Jun 2020
 07:12:35 +0000
From:   "Tada, Kenta (Sony)" <Kenta.Tada@sony.com>
To:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "longman@redhat.com" <longman@redhat.com>,
        "pawan.kumar.gupta@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/speculation: Check whether speculation is force disabled
Thread-Topic: [PATCH] x86/speculation: Check whether speculation is force
 disabled
Thread-Index: AdY5cwNjHOfD1WXzRFK+VbW3aFu0Zg==
Date:   Wed, 3 Jun 2020 07:12:35 +0000
Message-ID: <TYXPR01MB150318D484EE220452A5085AF5880@TYXPR01MB1503.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=sony.com;
x-originating-ip: [211.125.130.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9ebe35a2-59c5-4618-7bd5-08d8078d7dd7
x-ms-traffictypediagnostic: TYXPR01MB1678:
x-microsoft-antispam-prvs: <TYXPR01MB1678E327AB0D99515C7E1B0AF5880@TYXPR01MB1678.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:123;
x-forefront-prvs: 04238CD941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7gDe2BEBA1HJwKT6egZ80gxkK4A9hl/tn+mO9DdjTFp6pw8+KcrJO2QFmhc6kwRVaXgsmJ/dbdDx6seyTlESxWnOKikA+3ikpViahNyvA+txsWCJKzVdxxUB2k0C0oNNoz/DnkYq6/Mvb7Zq47wl5aFThTwcBQ4hNZ+t9HQjaXg2Mp/eWFtGiQvA4NYSXmLEmOsZbY9V6YiAAtHnQyMpYB+/qUJUHnnKH3t7CAjWBLWeJuHZyYdG8Z2le2Qo6Uw7+lV3nZ6/qsvn2/DoEAKniZh+hOF5zFDWlqPO2A4DtXoqPoo8BfscPt5HGyBV38exn3BZW9nedpDBBmknny1RevjMfR4r2P7g3+z16Qb2DlDRsBQt/Sa7vX5xYbO+6JlX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYXPR01MB1503.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(66556008)(66476007)(110136005)(66946007)(64756008)(55016002)(33656002)(6506007)(2906002)(7696005)(83380400001)(8936002)(76116006)(316002)(478600001)(9686003)(5660300002)(26005)(66446008)(4326008)(71200400001)(186003)(7416002)(52536014)(86362001)(8676002)(4744005)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: URXSkhegMhrY7Ej2xT4K2iJZ1p9MBY2LGJ3RVhhQUXG88eSVPJBnwccziljGCkHGm+OcQ9C8PbGv7O/3ca07nJuLFHQS0ySgtiuIS9bay45g/f4aMI4meEpOqNjlss2H4pMBr9GRSw/BtUQCQSGg032cu9tsHt98Svti6mjT3PVwH6OvE7i2wkyMpCCw2dHdl0LqO6o/n31CB9Dc68Q/YX1LvM64MqDOj/UoookM9RCTi3JSyahP+vai54zieq8MzS2pWWhS5mrgdfO/Gxv1SLUo7ugXjIsyYXV70XxLvwcqz79pwdnhmSvijLYYQrkwb3wnnhqCw2bNi3U7xC3YP43Zk0z5lUJN4adsVYn6787x8M6MTLXJs7cJ1G/Y8+9Ln+o1GlPv0nIaWqY0MIS+89TAKKWOy6F3/fL3q3l2J0dVwXDmvF61Y5p2osug2Sfale/Ao9R76M2Xomi2cp93mnJvii+4/NjEpQy41n7X9xVeMydpoSxvy8hyV0SWC8vA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ebe35a2-59c5-4618-7bd5-08d8078d7dd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2020 07:12:35.4423
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NUg8kDVeYbj3EtuMYv6e+WVoeOo3thMAu77IosszDLNEEEp5o0FqUGigLPdeBfCWvckh9ds/gYBNcqX1EeAnLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once PR_SPEC_FORCE_DISABLE is set, users cannot set PR_SPEC_ENABLE.
This commit checks whether PR_SPEC_FORCE_DISABLE was previously set.

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 arch/x86/kernel/cpu/bugs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index ed54b3b21c39..678ace157035 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1173,6 +1173,9 @@ static int ib_prctl_set(struct task_struct *task, uns=
igned long ctrl)
 		if (spectre_v2_user =3D=3D SPECTRE_V2_USER_STRICT ||
 		    spectre_v2_user =3D=3D SPECTRE_V2_USER_STRICT_PREFERRED)
 			return -EPERM;
+		/* If speculation is force disabled, enable is not allowed */
+		if (task_spec_ib_force_disable(task))
+			return -EPERM;
 		task_clear_spec_ib_disable(task);
 		task_update_spec_tif(task);
 		break;
--=20
2.20.1

