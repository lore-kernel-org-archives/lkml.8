Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B343DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8028520774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Xl/BIyoZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgCXQQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:16:47 -0400
Received: from mail-eopbgr700076.outbound.protection.outlook.com ([40.107.70.76]:60864
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727634AbgCXQQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:16:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+xZIE2CBoEB7ZGi6koxYJ+9it3IWAgR1f5Sudm/fAmGLCJVI2YxIgifhPudHSq1R/40dvt9McGeEVqOjL1GP4/vad6gYcmkyDO1LHE1Wnjs/SHr36G4y6LoBEub9/XLUKwNWwzPu39MrybQCG7c4qHELX7vCkD1PyTHrei+ia8Wjq+RUC6ZjxUvQR5ooh4WatkMQFkbQNYUQI8T5Oe4WGmQ+WRIVooRadmhoWbsO19+0yu8duQcbdjWUDndzKNH3axOUd4KFOmQhW5DOqwGiy9WoArlbRejovuLDpVASuQnmYGTAMC/Se7jurcaBEBHYx00yyzYfbrMrcsrC8uU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1R44kC+mLhPuyAXCjLA79wFoVrk44qHF9soVMoZLm0=;
 b=PDWgVNP1bQjbk02f9avnuxjGn1MtABL3TUbUERlnIoYIX+XOXJYUHxbVmUpCWHNLqXpCDbZh7pbbcGLh5Vq4gM9Jq2oDeJNUOHM0ahfvaARev8uWSglx4QBwdcy9kaMkxgZMFpg8Y5/Vyhm6Uj/yMRSR2gfuQ2EUe8PK62OT0Dc0a78J32Wwb5njcIqjfkyi6p/odBnZ5NzTgHHtjdujfRwdx+SIpAdGBIYFfo61paombK3TWOUGtFAdFitZl9/1Ip/QpzLTQ4bpcNk2cdwTTrZGRj3qOXV1Fs08o5vMcPHbyrHFOpo+m2qzHJEdKybT4gQxGalehPuw7oWjXAPjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1R44kC+mLhPuyAXCjLA79wFoVrk44qHF9soVMoZLm0=;
 b=Xl/BIyoZ39bdUw5Z/ILM5FE1Ev/hvRp7ta9OzRP2LBDx46+I8334Hw2L9aVCsdttdf2GiAOK3mTNFS7F35VXxsLhVFsSgNzOWH5K+cgFd+9dHjfuDXf6mVMZTQ1dzTujpcmvzeRpQQT5TDxUbd71G4PrftdYU7W7DA7nh0WnF9s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2733.namprd12.prod.outlook.com (2603:10b6:805:77::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 16:16:44 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 16:16:44 +0000
Subject: Re: [PATCH] perf script: add flamegraph.py script
To:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        linux-perf-users@vger.kernel.org
Cc:     Martin Spier <mspier@netflix.com>,
        Brendan Gregg <bgregg@netflix.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20200320151355.66302-1-agerstmayr@redhat.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
Date:   Tue, 24 Mar 2020 11:16:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200320151355.66302-1-agerstmayr@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM3PR12CA0061.namprd12.prod.outlook.com
 (2603:10b6:0:56::29) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (70.114.207.150) by DM3PR12CA0061.namprd12.prod.outlook.com (2603:10b6:0:56::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 16:16:43 +0000
X-Originating-IP: [70.114.207.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8a7346be-7c5f-40d9-ff40-08d7d00ebe96
X-MS-TrafficTypeDiagnostic: SN6PR12MB2733:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2733D0E662E637ED3BA5729987F10@SN6PR12MB2733.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(2906002)(7416002)(31696002)(4326008)(86362001)(16576012)(44832011)(316002)(16526019)(26005)(956004)(2616005)(66556008)(36756003)(66946007)(54906003)(478600001)(31686004)(81156014)(81166006)(8676002)(53546011)(52116002)(5660300002)(66476007)(6486002)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2733;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jLFjS1plqXljaFzSC9BR/OkE/pvIV6VlHHPGjCVAJKmRIgAsMq/lp1jngnfpAYnOom4qfXgKGvRglM8s8F0hz0h/GFt0wCl7R7jxM7ag/Cfdi/fLrM7VQrBgLWSN5N44oGXjkSFx9C6PZkrR3BpzP/2dP9/gIbsWwh92jRyQzCFt0ufJuFDEA2CwhtQlsdNz15Fnlu7MUf5wjmxHyKyN6LMRla1X6VkW9QLa5Qa9kQ/BGuaMpf2va2C/1Eg1hKm8huErpzUn9YuVk6s9foKgY0kGFvMkVP8VVBGoSgKFSVpT6WudyBQq9wLdI7jdfvKYIkneflhh9UhBoMCj0oSJMHjVcNNY9WyoxRukssCSqy/He6CWnh6rv5wYwBDwzJoElufoPphau7KAyXEOaxC7xGyI1b+o+iJeHsvLpPBa7ZBicQCIUS32eleUSFyLRqm
X-MS-Exchange-AntiSpam-MessageData: 3CC9t8nSndHbHzyFs2DhN1HqL2nnTdjEFSVjNviowUh7lA7hDoUFTWQn+rSOX/Sbg6rpLTvHabmry5vdU82EvgnuoRtH77BLIx0nbCg8fXGGHc5Xec5s8B0MWL9DIWYZW+vYvJnYrtFkq4SRrKGOJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a7346be-7c5f-40d9-ff40-08d7d00ebe96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 16:16:44.5299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSlYaJr0Pvqim5zsUbPAt1Ss3+c9CKzy+TTV4TbAm9qBHk8947qPveDBcEQFQ5tege9Ob5e4t/Rf5ypw0LQw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2733
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/20 10:13 AM, Andreas Gerstmayr wrote:
> This script works in tandem with d3-flame-graph to generate flame graphs
> from perf. It supports two output formats: JSON and HTML (the default).
> The HTML format will look for a standalone d3-flame-graph template file in
> /usr/share/d3-flame-graph/d3-flamegraph-base.html and fill in the collected
> stacks.
> 
> Usage:
> 
>     perf record -a -g -F 99 sleep 60
>     perf script report flamegraph

On Ubuntu 19.10, where python 2.7 is still the default, I get:

$ perf script report flamegraph
  File "/usr/libexec/perf-core/scripts/python/flamegraph.py", line 46
    print(f"Flame Graph template {self.args.template} does not " +
                                                               ^
SyntaxError: invalid syntax
Error running python script /usr/libexec/perf-core/scripts/python/flamegraph.py

Installing libpython3-dev doesn't help.

$ perf script -s lang

Scripting language extensions (used in perf script -s [spec:]script.[spec]):

  Perl                                       [Perl]
  pl                                         [Perl]
  Python                                     [Python]
  py                                         [Python]

Should there be a python3 in that list?

Thanks,

Kim
