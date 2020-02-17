Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1DFC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609C22072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Fq8B6I1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgBQOL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:11:28 -0500
Received: from mail-db8eur05on2111.outbound.protection.outlook.com ([40.107.20.111]:6208
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726873AbgBQOL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:11:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaVFQsY0nm9Vhla8BxpG5u7N/eGaBj3G1zMLRLA6wuTe58YydIaKptQV10NghoueVAXSRLxYL5/KOqDHAQm/PNSIVoUkTMbKl7ILPeGib/7LRxZF6BuYQ65loWFnuBf9V30Vih2LUMriY7PewIt/XncU29pqtqim2DOJXw/48vWmhMuyVD6SD6VUHdEsHEh9cLolXRaefgTxQEVia5wRprwm/YWusyavMkmMN299lVDpbQdeLVYNnkMN79Lp5G/WBsPjtq9cxGeFdFeriYA7vv3j41H/RZbrNFMCgoYq9FCnyS3xmY5k/VIVDJIDRuI2+uFtojkkLB9YoGC5S0gGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6RkTmL9V8WPB09dSZQUGN6xPiOI+Hxp3oEU+9OHFEc=;
 b=d8WG+Jy+nr4inYvDZAZu1fXc5fL1TlZxNKxR4hFMGJDOVEc542KqZ6jTbAAAF5UeIz3+C5S6XZWRP++jBixAMrnS9Vfa1ThCQIERpIFH8Q+i8cG5KNCE3R4iiN9iHZ8/fX0e2TMXTTVCTH8TzUSDhFGH40OLlnrfE2eonMpSWgVhG9+nbCJmF4DrwE2HNOLVwBGO3oSrEyQXFehgq8PFBQrF4sODI90WeHCi40er6H9QMtcyIAMM7DGZZSm2N8rTzAIHmTA+9JLkmzB5UfxSDj8YpnQeWgRVtEPNRiWXWIhRwZGxRJ6/lv6o5kpOYU7fAnnH1yIQSWpxweD+FLYqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S6RkTmL9V8WPB09dSZQUGN6xPiOI+Hxp3oEU+9OHFEc=;
 b=Fq8B6I1Cp8QJjTc4KeHx/ZT7Kqv2SYkffDoHlxcC+anto34sXVDYek9l59pk799NUPKrWL7vSDZfxI5o0pIbjSyy8EvTwn2nMB+PzZJfsAstzUGytBI5QlwYcuDvhU0n+zs5bzUxH4obCqdSg5Pe0lIWmbHreSDdZQ6IWtvJ1xk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com; 
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com (20.177.203.20) by
 VI1PR07MB5056.eurprd07.prod.outlook.com (20.177.203.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.12; Mon, 17 Feb 2020 14:11:25 +0000
Received: from VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e]) by VI1PR07MB5040.eurprd07.prod.outlook.com
 ([fe80::20c4:7ce8:f735:316e%2]) with mapi id 15.20.2750.010; Mon, 17 Feb 2020
 14:11:25 +0000
From:   Alexander X Sverdlin <alexander.sverdlin@nokia.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 0/2] ARM: Implement MODULE_PLT support in FTRACE
Date:   Mon, 17 Feb 2020 15:09:53 +0100
Message-Id: <20200217140955.211661-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.24.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14)
 To VI1PR07MB5040.eurprd07.prod.outlook.com (2603:10a6:803:9c::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ulegcpsvdell.emea.nsn-net.net (131.228.32.181) by HE1P191CA0004.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Mon, 17 Feb 2020 14:11:24 +0000
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [131.228.32.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b578094f-3a00-413a-7a45-08d7b3b345d2
X-MS-TrafficTypeDiagnostic: VI1PR07MB5056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB5056BB2478051C9FB4CE487088160@VI1PR07MB5056.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0316567485
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(189003)(199004)(26005)(6506007)(6666004)(4326008)(86362001)(2616005)(6916009)(52116002)(1076003)(956004)(478600001)(54906003)(186003)(6486002)(8936002)(8676002)(2906002)(81166006)(66946007)(81156014)(66476007)(5660300002)(66556008)(6512007)(36756003)(16526019)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB5056;H:VI1PR07MB5040.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by3/StbbxTRe4HZTcTi6x3dTfq/idS3oLppoBF9Zuzjw5ek4S9YjVxhWO19XZheh1h+U6GY4B9gAHZx2HSqaIyZWXjnElo70zZ4411ZQq/RJVT2l6hz10aZfc09+YgAewnrf6k5lLdPKkU1+yxy4/3t240XTrkJJ+S91eEQbRk0lXC1qAZ9rt9ZMJCcgOGBtu+DLnouEnw0F9y7Q+vuxIsBxdm6R3wPQq1KgxwgC+GntlNQkfiSvc3HUuTKYyASVQVctFNJDlnUxTGWhda1GoGxaaB57TVSix3zA44otjcSoxSvyfKYslCAfe4BP/FOUtamvykpOnqnrJ7vW4Eq0ecR3tNoq7nNvw8XARF4daNXa5khAWse0TN8jJEisaiCJKWgjNxHnpyGeRRe5Oh94l4c99/EPIK2/Qju2rTNS79PlKTOe6nQwjTyXaL/EidGL
X-MS-Exchange-AntiSpam-MessageData: WX4c2aGAGYNwgFQpbXvLeuV9Mx7regCJPsGhYolAzB42/vHICud04RVcYJBr66hc9teIpJbtthcp8Ka5WmXMJulzgIWazw0lA3IRDz6c3ngl8tL5mQzjRrTytAu2Ye6kRhF3Zc8xhta0ahgG8mEoSA==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b578094f-3a00-413a-7a45-08d7b3b345d2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2020 14:11:24.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: orVTNqvlkWV4Rz9e2irU6UEnk6JLHdL4Ui4ciofgGK8V4h3bOY+IKinxLWP+mO+8UJDRHP0zyyN4/CdmXEv2IXiGiOzq8XT4MpeZwF2AuaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB5056
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Sverdlin <alexander.sverdlin@nokia.com>

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Changelog:
v6:
* rebased
v5:
* BUILD_BUG_ON() ensures fixed_plts[] always fits one PLT block
* use "for" loop instead of "while"
* scripts/recordmcount is filtering reloc types
v4:
* Fixed build without CONFIG_FUNCTION_TRACER
* Reorganized pre-allocated PLTs handling in get_module_plt(),
  now compiler eliminates the whole FTRACE-related handling code
  if ARRAY_SIZE(fixed_plts) == 0
v3:
* Only extend struct dyn_arch_ftrace when ARM_MODULE_PLTS is enabled
v2:
* As suggested by Steven Rostedt, refrain from tree-wide API modification,
  save module pointer in struct dyn_arch_ftrace instead (PowerPC way)

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h | 10 +++++++++
 arch/arm/kernel/ftrace.c      | 46 ++++++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/module-plts.c | 49 +++++++++++++++++++++++++++++++++----------
 4 files changed, 95 insertions(+), 13 deletions(-)

-- 
2.4.6

