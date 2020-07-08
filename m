Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C45C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56D42082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Jb7eEwXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgGHHg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:36:29 -0400
Received: from mail-am6eur05on2052.outbound.protection.outlook.com ([40.107.22.52]:28384
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725848AbgGHHg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:36:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxU7wNCWix4amN1/fXoGuLPXtDzUuQ+KJsvKJPbl/ClNTgWKQ20RWNLhe8NS+uKIe5z7f7Fiz94vEv7HSfpCrrJOAgHAX16pKseid9aiTWp5Ufbg51CANSKy88NNq195UwrkseyP4oZHxrW+pu8YUlO6O6CjJzrkNONiEI1q0e86brn/Nbd5dfPx2aM3M9B3LZADoAdbrlxHboOguJH3R4DNpTblCUl2Okd07Q+t01CmD2VyIuAh8pK43BZ6/zRzpR648WcmoHofee0lhxh0arMLk9aeZXFpyYJg0RNAB5F1rvi1KUveqLQ9T4KrMSbDFZ7+IzA6SzuEOlgzRAntIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/tQCY9BmXZiBaRvK6d/k6sIR9K6VNh8S6Y44ZYKJek=;
 b=PzEaSlNfyjRKMTQ5UA/Tjf+wi8aNKxJ4iZFiZtjJfhX/YPdn/WR/eTbJpTn7ibDukQ8B4qPwGRzBerTr5RugoC7Gsv7j3HAoN6rfk78KLdx/lUi/uhSxub4xPY8H1fLvRNxdo/Fdhp67AdZM2X4EPnvtG5/lRJzEpjMyD9IQSCk3T0dFsf2+8jzpxhrFUdH3K1SuP4zMYvAGUnNlTliQQY+Eed3YwsVL2UdGE6hi1/hYODt7P2DzaWinkPia/KOB7tRuDwXnhtZ3gpg8q90lNk/1giT3KsrheDmW9BPfKX3SAQEaQZjFgMjZqCUlQjAfokbrs9Z1VT0C+e9cQd1hwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/tQCY9BmXZiBaRvK6d/k6sIR9K6VNh8S6Y44ZYKJek=;
 b=Jb7eEwXfYoAkL+6oGgTZau0s0ZveKvYyYV8tjAFONdm34W6iGJ72AFX0sBHtAgpNZvown6pqjN2A36UAZMz+222WoejWU68Qa9+0eaXYG0ACUx5wu1FSICwOPPFbAL7W3uCrW984KjJdTa9JzkZrRnyGJxHAyO47TtzOnuSlSmo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6734.eurprd04.prod.outlook.com
 (2603:10a6:803:121::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 07:36:25 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::9d5c:685e:4b51:fa60%3]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 07:36:25 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, kernel@pengutronix.de
Cc:     s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux@rempel-privat.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Allow on demand channel request / free
Date:   Wed,  8 Jul 2020 10:35:53 +0300
Message-Id: <20200708073556.19188-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::20) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0067.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 07:36:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9cc68e48-1c1b-4cb1-cac7-08d823119e37
X-MS-TrafficTypeDiagnostic: VE1PR04MB6734:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6734215758F3865A9BBFC32FB8670@VE1PR04MB6734.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2dRuZebSJmH8RRO0l3DgBXIj1n4b+dlp6Z9cz2oLoSR1x/e2VK2lRnPjgundYnoc13YRXnNkTFAEIUYUxQN43QQdRKnyQEhXKumRymmD6n770IVKtroqT/v1MnjmyILzo4PJzIX21wq7MTAFnk3nXEr5t4ZS9KMurhHFrD9q/mQmGd/S0kDBmLBxToQeFLV5j6JmEXhoZqiRYY7k3uAD9LldCX9F015DStjrJZ6mbH+8yKLwRrlykuvkYUwYDGNwUSsK6JIbzNu+8kK2tEF7VOWl82TdkBEYIQfpSmnVfcvMG8MORK0hcE+mooVluxEEdGBH1GFy31C8lpZ/Dp7g9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(83380400001)(26005)(8936002)(4326008)(186003)(6512007)(16526019)(86362001)(8676002)(66476007)(66556008)(6506007)(6486002)(52116002)(478600001)(316002)(66946007)(1076003)(6666004)(4744005)(44832011)(956004)(2616005)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JkQbv4D0dkacNvEtXxoNIPKlEAMkdkpv7o4yC+OFYINIXoUqmpwr8FxAn/f9Z/KACwSKkgjG6aeX9BevDo3gszDfjmSbrB7zAKd6Mn1SrA2PtX++f0uwn5MQ0UWwY6jl1srxtkuYQHq8ZK8h0qHiPqe7KUgo+mpmOkN5sB6XWoSP4Xj1dFjOLSEaO1FtDi/dhajVX5ucF8RughDfMmohAh59bF9aQbAgYBobMjemywM112nhfMipTNKENC8K08gj+ttRthuW2dMsVNXrTXb3jMBAiAOnqQkgOcwL54CuBZtHmLzoF+6TmUc8rh6eqaTNRFfY1zPwN+LLSLnCZwwriZpz3NJEdcR6auABKUjrHoz0JfObWy7jnKyXcrnLWDvUGbpFIihUjS19ASvRQjiPLEHRIDHtHrhq0QFh+otxw8ualj5gfVDbOs6ABYDketVBPvlfI6dBeBvlPPqW7RHw1XyS+j/8xoXg9rlKt0J6klU=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc68e48-1c1b-4cb1-cac7-08d823119e37
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 07:36:25.3255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9TUVKXUaMndanVmyKLWHnwDmBNZOWfxr0t0S55wk3nR1hmei8iFj+Q0c22dC9pD8WJGiaU7CMA0jEuepCgmFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6734
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Requesting an mailbox channel will call mailbox's startup
function.

startup function calls pm_runtime_get_sync which increments device usage
count and will keep the device active. Specifically, mailbox clock will
be always ON when a mailbox channel is requested.

For this, reason we introduce a way to request/free IMX DSP channels·
on demand to save power when the channels are not used.

First two patches are doing code refactoring preparing the path
for 3rd patch which exports functions for on demand channel request/free

Daniel Baluta (3):
  firmware: imx: Introduce imx_dsp_setup_channels
  firmware: imx: Save channel name for further use
  firmware: imx-dsp: Export functions to request/free channels

 drivers/firmware/imx/imx-dsp.c   | 72 ++++++++++++++++++++++++--------
 include/linux/firmware/imx/dsp.h | 10 +++++
 2 files changed, 64 insertions(+), 18 deletions(-)

-- 
2.17.1

