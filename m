Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2241C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C154920721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qxO4/FK7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436608AbgE1Va3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:30:29 -0400
Received: from mail-bn8nam11on2078.outbound.protection.outlook.com ([40.107.236.78]:8928
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436505AbgE1Va0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:30:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ED48226ougcfIYdoduCMIFtDxaOE2cT9JfEAjjNRDDMOfCGJRwZ0+wD9dCogBye5BWAAY181SOFd7yBhMHbFIDYbIeMUcGFwoytY9Z5Yog3iIj6lqVLTTfgIT3HIwmUot5zGrl0JEV5zSB+BBmdPPErAJAPQsLHxiO3X8FPzuL2U86WGDDkEFfvQiivf/JGhx1fx2Qr+xjd/fTJaTN/o/qtbfqDtssc6ScadXd9sVzWhsA72Ry/9GAJVsnPideYgizCBNB4ZdZYAZdfQknyTpiKeP5fXcWnvAHnpcnJDKr6ZwHikAiLacxBhD6gAvYtEmRyPHf7jUaOMJ/yp7GKuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdSD+koqmH1HJuq86LvMRPq4Dg5tEyNwlVLQ/OE1Ds4=;
 b=bqAfcW3WnqZeSfILxbI4S7UVFDoDOKQiS1tgZdDFQ1jAasL/dUoIbdkVhJzrg53YKH8P6E37xvh1SQEpLfqmV/9r7ghdrzExtDcjJ7/aCSoEy6OMwAP2sRi+bL4XWdzGR/9ARFEZIroFW5cjQrh2RZyZJCM/o9CSXHXeug7e41Ia0EsFGkh1uSeNjfEO3Ir2KPEDxqjC9xg/5iICdtkiq0WBQTbq1HFL8OPmKgI2plwYZaVc2FaTrfQFVZ85/lNJRkbWqHAZdov8vuKy+qjLxCSUJBKCz+WkCMDx7pvGaqwfVqkT+7TSkbVapguMJ2jko5F1NuD4j50J8qssYTcotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdSD+koqmH1HJuq86LvMRPq4Dg5tEyNwlVLQ/OE1Ds4=;
 b=qxO4/FK7rSvT7PJS+aUdaZNn4Irdw8CpajgAI58BJxZv88RoXJdIuIJooSOMY9K4B7poet6d0rjCqggcCspCMBIhsaquTcjBANjGYxnCx/HXgOhR6MtIPQ+SiTTBWTJaZyZ/HYA5rPgSOjRlRoklS5gtkPifzANeQ8Rr13jgZe8=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2866.namprd12.prod.outlook.com (2603:10b6:408:68::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 21:30:22 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::8dfe:a00d:ac29:b1a4%5]) with mapi id 15.20.3021.030; Thu, 28 May 2020
 21:30:22 +0000
Subject: Re: [PATCH] perf/x86/rapl: fix rapl config variable bug
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        jolsa@redhat.com
References: <20200528201614.250182-1-eranian@google.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <384ca5bd-4f20-b81b-4260-8ab76c364c5f@amd.com>
Date:   Thu, 28 May 2020 16:30:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200528201614.250182-1-eranian@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN7PR06CA0060.namprd06.prod.outlook.com
 (2603:10b6:408:34::37) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.198] (165.204.84.11) by BN7PR06CA0060.namprd06.prod.outlook.com (2603:10b6:408:34::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 21:30:21 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03b46bf7-e3c8-4519-f49a-08d8034e53a9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2866:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2866F5A930297E48910D886D878E0@BN8PR12MB2866.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: auY27ykG5gf9sRAUQlm0dcA07Tsze52yC7TmRYMFE7GH5bgdKpbc+1gu5IuVYut7aC2ctRoiJ8ls06fUOJzzdxxXwr0eUO/pgBCfM+22rkhfVU1OwVoMua/j0zRwX0MBSYxJoR2Ew5bazXRqGDEYdq/AhO+sNUd+ddShI/J6NtWsOeSeU1vGuc9lE5UD/t11zsxk8yfFtV/+OSevgOmg58a8tmaRDFvVIE/3hp2UDZXobNdQNiJGo6OKUbrxxVcjiGJiZV0nyx5mBStWHq3fX5jPSK0GNOvI+H4eaDnpaqJhgmZ0i7qKEHyvmsGWUrxHpxPYtw70ZtpMjHEo/exffdVuDzad9tn79Pln9zyCPfo6Y8pk+bfC3eTP5SpE+I9g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(53546011)(26005)(16526019)(31686004)(31696002)(4326008)(186003)(6486002)(16576012)(4744005)(5660300002)(66476007)(52116002)(66946007)(66556008)(316002)(44832011)(36756003)(8936002)(8676002)(478600001)(2906002)(956004)(2616005)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H41RmZrg3wcRISiJtUufS1e1DcD/w5sS19W+2qAbSWpAQaLr3SgC+LRsbdoBtPeA8NUbVrmEjBquoMaPM2Sf0IBi62gGuaGT9LJPXAWYJ8pzook8BPBQ0t7CmYqdQd5oC4+KyDUUilvssh1XGvZ+UaiLSQwMecw+RQ3Y3nNMqBj82lS2AMGXIlbQWXwH2o6RBBhX5Ixyc+3de4ib2YY8Iv13g3b7IBmtootTxLO8uaT0/nVX2U1ZwPw+vpNS0caClMbHBv5DRx5VZ1hP4UfkJ/7lL5Q7P12PsiS4fhVSiiljvje1blVLFlo+dhsOVfFOAq0EhJ1NYc10Xb/FxwjILTPEs2p5rWVR/S+4r46sdgSUWoLfT7KONTmSoEoKEIAE9H47WKXcTwKQY3s7qk++TC42uXNV4Ahey44BPs5+/fiMF/R2IzLdQkFv9866Jy5SulZdbjhzFkgvPgMMkgqpgwgzxnrfi6VmP5xLito3TCc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b46bf7-e3c8-4519-f49a-08d8034e53a9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 21:30:22.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GTJMyC8WP2PrGz8oHmYB4N/oK8gG7i2VgjL7uPBZAuXZbsHc7gFvQvDhwDTMeZjZ9dAGL5ykv9OGcmPTy7HIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 3:16 PM, Stephane Eranian wrote:
> This patch fixes a bug introduced by:
> 
> commit fd3ae1e1587d6 ("perf/x86/rapl: Move RAPL support to common x86 code")
> 
> The Kconfig variable name was wrong. It was missing the CONFIG_ prefix.
> 
> Signed-off-by: Stephane Eranian <eraniangoogle.com>
> 
> ---

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
