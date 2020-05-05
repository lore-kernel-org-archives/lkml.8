Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D726C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5207A20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 19:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Gv6/+MbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbgEETyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 15:54:53 -0400
Received: from mail-vi1eur05on2092.outbound.protection.outlook.com ([40.107.21.92]:34497
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbgEETyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:54:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJtSZVvypyuiQmQcnLGHy5x61w2uiKUPSe5eHgMvSFf4ZqcCaLIXdta20hjyW/UaACJU89IOo/o12da+mLFT41m9WNenZPaJ69m94mxhu1LcIIJCeqcQekrilQ7tVTIEPmZNUbDW60lm8kmBLQiGaNTPrS0L5pTZjfsZ295OVjjlMsIiFn27mzDZN6uu0KFSU1bRPajG/XL6IuRwT9TbtZC7kwh66XusTMZenEJCGPKXlD1MgTNaPcSdBpkigUoJ2XkVSie6ktGiUarUsYIhTy7jEYDRjqTzMHI3NO0twXSXZpHVrUBhEc0RhjptsWg2Sg2dmTKfNGtdtmrdYDFILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIxS3KDEdcgFwgGhOxnKznXKZ3bE1TMguHH5+jBMkIE=;
 b=O756ns8RUBSW3KH3WQeigIOWSqVoHkykDny9g2+/nSlSPhi2hjAeYVhZNAgPB7wGhJ2wZ5jWtEG9O8FRu4FBKpLYJmaL0qS5WFqHZmCxUeJHfgWpwGDDrcqji8yOwJTUu+LvFX1uIqo0GP3JYcjtJ6lU5wOfqF50UX+4Be9N7wsRdNqQVstLRsC9cHoK8sR9Cun4yC+ldev/U8JP1fBn0NUFX6hlAr8irmzozTwseJbPD8QgcZdwssDJfER8u9AEZW9ddzC+WTMzuih1hWN3aupLCBP8EdYBSPoYbe71i+MSS6lCSMJa4Gq3QgeVZyThnVqyn1FbN6RDtz+EkRNorA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIxS3KDEdcgFwgGhOxnKznXKZ3bE1TMguHH5+jBMkIE=;
 b=Gv6/+MbPuiyRWhhkJ2QCngtk62Ui8RBW8FMwDyDsgw680na2UISiCIdxKFoGM1xRD5CzmeSZkeJEAu8wYXQg8Om1QviQREK4iaqqxulRHPQcQUvda5WshaSfgWn33bYrDJKArcJRYtfhLP4siO/tk61p2AMxc6XvFlJh45phT4k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2189.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:80::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 19:54:49 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 19:54:49 +0000
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     =?UTF-8?Q?Per_N=c3=b8rgaard_Christensen?= 
        <per.christensen@prevas.dk>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: battery switch-over detection on pcf2127
Message-ID: <a0ed6b56-33b1-b5ab-00d1-268fcd61b754@prevas.dk>
Date:   Tue, 5 May 2020 21:54:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR08CA0017.eurprd08.prod.outlook.com
 (2603:10a6:20b:b2::29) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6PR08CA0017.eurprd08.prod.outlook.com (2603:10a6:20b:b2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 19:54:49 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67dcf186-a968-457b-c178-08d7f12e2b56
X-MS-TrafficTypeDiagnostic: VI1PR10MB2189:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB2189BE315284E5A94850556793A70@VI1PR10MB2189.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zJIYMlQ/e7DumUPi2YPd3YQWqTj8tbuw0Js2ny7BrfDv6kNIE+IgfoMuRnaD5VpJcG9i/X3xxQj/dW+VMvmVr1gGyaPgSgGzLDSvEEpSr4nhmfAN17Nq2r3pGFKGyECOrVUtWqZb2Y/TCPOO2jcRL/TWSN6mjSc3vzz31y0FCOqatkSF2IkyIHARoDAAbPTKUqfgBcoKA5BMPw/i17T9N+5zQoyG7vkiQUWdXDJ8enw0SublDAE0Tp9s0nyX6sX2a16ClgRYSB7vdQ/7augkiRpZR64OaIMHyRAQkZyGGCewOQO77tE3gqUysqwY5JdFrzxaiQIQ52v8RpKU/8C62ro+itCL9Yu4/n3aD1Iuk0yJN0ivTykpkYC2CTVrkTmzV2VeBJc34edX8l8uOdjNiXPkJk8ZbN3oz0Cf6ksft2iPyVNPTyQPkWw4havjelEWx3z045ysdpp+W9wIpCT9MjCFRyzBEyE2kJW3vSzABaQzKOnF9p2BTsGI1+uQy74gqNXmNVhsFWK/A0Jh7meZJj3rJG5Rm3huztlZpaX6jxz+DYdGKiVCB0aT+Sui6Nu/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(396003)(39850400004)(366004)(33430700001)(4744005)(2906002)(16576012)(54906003)(8976002)(8936002)(316002)(16526019)(186003)(8676002)(52116002)(31686004)(33440700001)(6916009)(26005)(36756003)(86362001)(66946007)(6486002)(66556008)(66476007)(5660300002)(4326008)(478600001)(44832011)(31696002)(956004)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tMN5Z1Kr1qs7ywE++EJbiYEQs9grO91OHJ97WBiEPUn7m+5NpcjXshYz2iVXOxoiet142SsFISRgPq1ZDBxTVEZsGo/hoyrY80iJw29m+wPRFoxI4gap4MpBEKz/gQUmJs6X9gaA7CGPE46cMlSo5nkIA4Rd8+t+KONUwlrNbet0kTrUKZ+ND1h67btg9lqVSTUoC1/9EH6qhGkr7vFAjLTg1WAbKws8L4Xg/GShhdpAFEwMUC0881iDTBNIWWrbg/IHtVLJi5reR6iVSuVUdPRLCaRm401RZ2AxgcVQ+NiMxOpIlfJ3stLGF01wKoXlMQvrUnIh/4rksVViFuRTYDNrnRRWfMfv5BUyOG/mkb34QAjUj6+8OxX6nJJE1dkFvI9e9whob+06fuG5hl3QlhD6Vg+Svmw3nuzI3B4ml0GUM2WRfMSe23Yad7qmC+xfGGkQZrkWZ320PfJYdYnoHYNBQAbyemVDadlzu9s3cqr7YOVzqJT6YqZuynjju3QC5bCmRgG0nvGYvrxNRQPrUD6ahQcxTnCFWd08TFq1Akm0bUJkpSbE+SmdUoS9kU+a0t40A9HtJtd/eFbE5jdyiIKvwpmTqgRY9eJY9DXLsPuP1B9a7eYdJfXWPjE9dX9T+nGYlRi8E7JsnlB0rhkDEifoPBwrRTrRkuaF0KTPLwhmrDenuKjIxKfBt88C5E84SH5a6q8Ef7GPt6Rz2j+xZV0d5HweOtND+GbQHPBx18o//D/seVz9/GA+aWFGWBBQqnomRaxL2KJQPWiZuYR67Xmilbb9+dyO2SUT59KGzXs=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dcf186-a968-457b-c178-08d7f12e2b56
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 19:54:49.5699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNymY9RRfTJewj4cZ03gQ0+g29KG8hSa8Of+dO+1VzoWchov2PN+2JTYwm5q5p6bRVIrhrTk13uxzCAokHQHCHvVIANflCQvgPTPhxgpW98=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruno

I just noticed your "rtc: pcf2127: add tamper detection support"
(03623b4b04) from 5.4. Unfortunately, clearing the BTSE bit breaks a use
case of ours:

We rely on the battery switch-over detection to distinguish a powerfail
during boot from a PORESET by the external watchdog (in the latter case,
the RTC is still powered throughout, meaning there is no battery
switch-over event). OTOH, we do not use the tamper detection - in fact,
the TS signal is unconnected on our board.

We're currently still on 4.19, but we will eventually upgrade to a
kernel containing the above commit. So I was wondering if we could
figure out a way that would work for both of us - either some CONFIG
knob, or perhaps something in the device-tree. Any ideas?

Rasmus
