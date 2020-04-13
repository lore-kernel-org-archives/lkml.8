Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D4E20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387588AbgDMSDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 14:03:44 -0400
Received: from mail-oln040092255098.outbound.protection.outlook.com ([40.92.255.98]:54954
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387498AbgDMSDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 14:03:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5JiBKj6XWwX5IB+0Hk1ycLTtQLlObQMWV9ODiDG+RAtL24ogVwT2jKkR0zcKqVDG7jtFaT53wF6SSVtnUKcgFGxTa1r0AZLXJYca3MykSmgliwOOa+wRlDY+VZgM+Wl7w9Q4yppnLa+x6sdEoS9rh9LT3cXebwWBs5MSsZO0sVDGcSrwkfKivYCVRRFAfZ7aZxfB2oAQUBDsg7TC2+6xz12wD70tq0+J351GbXWmbHY1rqn/OpJWBkx70FUAH7bYxYPhR9o1qBh6XD0qoB3boyFebiJpwLgb5xVwIseFZ6+ExStC7CXMwdZSoF6DSLD9QIMRcCqTOuHI6kW6ARuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lwF+2fw+SFvhP/ub0MNBGmKIi1YKMCmsf5p8xtEauQ=;
 b=cw9ES4K8zMZUUFTPG1UlduC+vvikTWnACwfhxCyxHlS8/G4cXGAqmJzpq2kqgHAlnL2VRSezh3gBdJV45EO65Pwmgsq1WZE5kBpFHlMCXwjZAlG8MMcNl4lfkJyXVXtuh2fi4zM+SAmPrShtbNtci/GaPdM9lPXjI0pCs5JpEXJCC4vcANlNIneaIS9HMard2bce/qZ7c7nFPzHwWpwwRGmqjpfs3tm2ouZO/1/kTliYCzlk/lWFztwBlgvMjyxKpLnKAweA3CQiIN83HBNEzptgCA6jYv0naHsEiEhqEAoPr0bGxcv/8jZa01F0cLGCFz8v85DN7ajA/rzAfHN8HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com.au; dmarc=pass action=none
 header.from=outlook.com.au; dkim=pass header.d=outlook.com.au; arc=none
Received: from SG2APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::41) by
 SG2APC01HT187.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::273)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.18; Mon, 13 Apr
 2020 18:03:39 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.56) by
 SG2APC01FT043.mail.protection.outlook.com (10.152.251.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 18:03:39 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:725579EAD3DBA3ECA948DD32B8E0FC17391CFF5D60664D6263A603EFC9CB56C3;UpperCasedChecksum:D484C150A76B7725E85CEC84AEDE3147E01B9C3B05AD11EC841DEB410C39F355;SizeAsReceived:7673;Count:46
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::21f1:20fb:d1f:8e25%7]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 18:03:39 +0000
Date:   Tue, 14 Apr 2020 02:03:31 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v1 0/1] Revert workaround for Thunderbolt nvmem now that
 write-only nvmem is supported
Message-ID: <PSXP216MB043820634A932AF06774C0FC80DD0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: SY3PR01CA0081.ausprd01.prod.outlook.com
 (2603:10c6:0:19::14) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <20200413180331.GA3817@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:44b8:6065:1c:e5c1:ae4c:9b9a:39cd) by SY3PR01CA0081.ausprd01.prod.outlook.com (2603:10c6:0:19::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 18:03:37 +0000
X-Microsoft-Original-Message-ID: <20200413180331.GA3817@nicholas-dell-linux>
X-TMN:  [VpsJ60bIOpSvB7mOxwgQ+1Diczi7iW5LBtMVv5NUyrFqJbDAmf/wOTr0XQ3QBsjZ]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 1a5a48d1-d74a-401c-b1fd-08d7dfd4fe42
X-MS-Exchange-SLBlob-MailProps: wGn/oxjRRS/U9+pFdqAi9XgK07MaTDOfEjSRnf6MHZzc8jGtPycCUHLcN9YKEq9KBzXHlA2HQCQXBT68icS4fdGnS8iKDosC7XgvIY7J98fbVnUfztsIia5pRoN5qe60E20cy+cwlcujnzXvVegBEOEOj9Y/hAYCsnGjVu5TO+egw3KJyyEp+Bt90N7ljMx0Jw/XXLRJqA0HmWe5LDIOeS5V71RokXSpDpr6QKhGdjh1BDca74MI2mZkeaUqW4DvJfBUANMRmP7IHsMNpP7sMc9zgjNLiUSvQ+5o+0fNzF+xlM5TtZImz55AY6kwWJuuvAcl6q7YPiMHhm1zhpB6vf/rVpDUMixYffxK44oTn0ylfZraZF56yeEeUTCQ3HYbg5kEnChRCxUjaxrvdl2dJ896yUudP8/o2nm1AJ7Qgvs/mzSfIKfMYp9Qpvn7J/uiH3HcV3ISKm+V9FZJXcE1DpdMEE30Bdxp+1sZ1YF9/RLHw8VYVee7h1npUYvXm1dHiqdwjvF3Wh/zQESsqBMfArOSabc/tvNfrmNwFj0ctfz6wceuXc4uD8P7TOspdCIf7TyrkIgnZJeHnF6hZBTjI0solhGohoAuUAXlIgg3SSDFdhy9BWCh1+8qIbYeuy39PwK/XTT3i7svO4pcLUw1qeCMj6OpnmwjwZRKCOjAVPatnFlgkPTFgRcQgnmfAvu5aXKzebXOiqnNRoCB5pg5P1oD0nDYJcmUnrZUCVTPIOb7LPYrFhYwv6fpCmxOoSbpmSDuAp05vzwuHMmHB8xnfVgjiYyS2lti8NHkCeF41OwH+rufh44uvR8qg/rfVhOZu6xrTYImS5d45ReV4hdlVsrS+GnMc+OMdBNEpNVmEcSSGfyNx7kWE/gGEM4evySc
X-MS-TrafficTypeDiagnostic: SG2APC01HT187:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Ot9iAKQnVKFZ1rnglsS+v8eXsjQK/N9yr4THN4GgJ+TAuDS5MqgQf1WilOTGC72KFGPJsSECOw7IBHNvwouCVL8glbtu1c8jdNeP0pLUQybPaPWQGHZC1axt8TXcMwg9QIw33A+7SP6s3JK3Z5JDyrBTuNLRSP2ogpxXHXpSmC8IWc/7Cpsi/UViWm+YuGRV8AW42/XKQPNww9Chev6gxzN5WQRl24r+uVDL8g1/8w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:PSXP216MB0438.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: Z/j6013NQJEnSYuPoW7PSvsoHV4ytKB7uVuU0T33V/PnQ7t0SGlxA619COEinZfMbBzvqxD0KajXnBO5qXnWHV5CZIwpyIQsnH1Rjs3HHhTknQeQVeLjHCHUv7kzRnGtLpnQB9kMZlTv/3cuUrovLqzJM+Ho6lT4IO8rjhq0t1KWsivppZ3CGspZnLqqDAO4GYlutDm1jhTUO6q/tDMPUw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5a48d1-d74a-401c-b1fd-08d7dfd4fe42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 18:03:39.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

Here is the revert patch you requested in this email:

https://lkml.org/lkml/2020/3/6/17

Kind regards,

Nicholas Johnson

Nicholas Johnson (1):
  Revert "thunderbolt: Prevent crash if non-active NVMem file is read"

 drivers/thunderbolt/switch.c | 7 -------
 1 file changed, 7 deletions(-)

-- 
2.26.0

