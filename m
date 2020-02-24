Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EBAC11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9FC20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UPMuqG9X";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="UPMuqG9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgBXRIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:08:45 -0500
Received: from mail-eopbgr80057.outbound.protection.outlook.com ([40.107.8.57]:47296
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgBXRIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:08:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j5EbNtXhjI/xzwoRPqJRnzcOInSJH93pw/2oaS7uNI=;
 b=UPMuqG9XjhTXkutYlN1FexM74XaFWAQ/PzjtVtdMo7Hyzmv/XX78CeqCsxkOsvtdc4IuTymPV84GkBXEAR9H8canMZdUQaJRHe2v0sNLaOzOls2NP9CMpArq0htae1aYXhOBZZHaFN0F9qov+SY1DVUTIqoPGU1XaAnZj+IlIF8=
Received: from AM4PR08CA0076.eurprd08.prod.outlook.com (2603:10a6:205:2::47)
 by HE1PR0801MB1977.eurprd08.prod.outlook.com (2603:10a6:3:4d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 17:08:36 +0000
Received: from VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::201) by AM4PR08CA0076.outlook.office365.com
 (2603:10a6:205:2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Mon, 24 Feb 2020 17:08:36 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT003.mail.protection.outlook.com (10.152.18.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17 via Frontend Transport; Mon, 24 Feb 2020 17:08:36 +0000
Received: ("Tessian outbound d1ceabc7047e:v42"); Mon, 24 Feb 2020 17:08:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 00ba86d25ee069a5
X-CR-MTA-TID: 64aa7808
Received: from cbbe8957c54d.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5B71721C-5EB2-41BD-AE96-11CC6B3453B3.1;
        Mon, 24 Feb 2020 17:08:30 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cbbe8957c54d.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 24 Feb 2020 17:08:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPvm5GUlh/9u85VOLTje7QRTac82iQ7ZNE8OOjomN4LKKGU3Acig6PoaXz5WabPTriw+OUuubghTYIWbax4On2cpHA1dev4S64mdOoJzFf7c1i9G0OPWjDEuCfVUaVH0aQySdXlTRNcRahqwOw+accIqBXMlV1oFsi64RBZCZFNbG9b27K66HS0hbuQ8TbEc8jr/U2ZEbtt2kvDIOcJzrw+FDZ3zTwUPh6nOqZTXHKcBQmIyPyc9VEwUqAwsvHxYuJm8H9pO7PmEF/qU6wxuKXo1oZAPw7kwsN/J7C7YtMnqqx6pSyu0xanhdr4TvMvBXwfM03Fe1D0nIXjB+5DyrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j5EbNtXhjI/xzwoRPqJRnzcOInSJH93pw/2oaS7uNI=;
 b=G0ymCWXsK0c4GSzf6U6Nn4JRC9VAJ85j+ASg9m9Z0/WssYMb/unDxVkwygoqLi++P00ORCYdcQJPQWQGwIlWmaFPNdG4BeIbPbecfYsDVMYLESPJ2icOGFRGphpLSxS49lnG0Lwon1LjwDwAJJhfnTro1CL1mzvJHKJpOKkel43BlLjLNG0/aIJLvxxhVIuU0gsgtZA3yytwi8ZuOSx/QweWCJ5qUECyar5ry7qFlxzqc+4ME4gLd5ioVr6u5Qx5qx21ewIwB0dKSyf27s4cMyKd0e4iLFf8LKNUVEHcfIZVYeaT/qAD5MedWE90R5qVOz7zQnoJ8S9AwNaGH732zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j5EbNtXhjI/xzwoRPqJRnzcOInSJH93pw/2oaS7uNI=;
 b=UPMuqG9XjhTXkutYlN1FexM74XaFWAQ/PzjtVtdMo7Hyzmv/XX78CeqCsxkOsvtdc4IuTymPV84GkBXEAR9H8canMZdUQaJRHe2v0sNLaOzOls2NP9CMpArq0htae1aYXhOBZZHaFN0F9qov+SY1DVUTIqoPGU1XaAnZj+IlIF8=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
Received: from DB6PR0802MB2519.eurprd08.prod.outlook.com (10.172.251.18) by
 DB6PR0802MB2198.eurprd08.prod.outlook.com (10.172.227.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 17:08:29 +0000
Received: from DB6PR0802MB2519.eurprd08.prod.outlook.com
 ([fe80::1d47:e75a:d449:605c]) by DB6PR0802MB2519.eurprd08.prod.outlook.com
 ([fe80::1d47:e75a:d449:605c%6]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 17:08:28 +0000
Subject: Re: [PATCH v4 4/4] perf tools: Support "branch-misses:pp" on arm64
To:     Adrian Hunter <adrian.hunter@intel.com>, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nd@arm.com, Tan Xiaojun <tanxiaojun@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
References: <20200210122509.GA2005279@krava>
 <20200211140445.21986-1-james.clark@arm.com>
 <20200211140445.21986-5-james.clark@arm.com>
 <3114ea3a-5d9b-2c25-af41-cead352b6a02@intel.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <96a814b2-23b8-2ac0-9dc5-0a4b70ddf895@arm.com>
Date:   Mon, 24 Feb 2020 17:08:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <3114ea3a-5d9b-2c25-af41-cead352b6a02@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To DB6PR0802MB2519.eurprd08.prod.outlook.com
 (2603:10a6:4:a0::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.32.36.33] (217.140.106.40) by LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 17:08:28 +0000
X-Originating-IP: [217.140.106.40]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf89d400-4f55-4432-6186-08d7b94c2fa0
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2198:|DB6PR0802MB2198:|HE1PR0801MB1977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB197739B84B0AE233245BFF10E2EC0@HE1PR0801MB1977.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;OLM:4941;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(189003)(199004)(53546011)(81156014)(66946007)(66476007)(4326008)(66556008)(44832011)(186003)(16526019)(16576012)(6486002)(81166006)(7416002)(54906003)(8936002)(36756003)(8676002)(5660300002)(2906002)(31696002)(31686004)(316002)(2616005)(956004)(26005)(86362001)(52116002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0802MB2198;H:DB6PR0802MB2519.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 48L+5rSr2sWjEdKsVXhE+Nk09UMySIAdf9Bbf+G6WcGHSUcyMamyXX+IKh71KkMxYdZYZqzBCKbTc721KfPdnA1wYDp4DaWdx/RgLAo6//NNH6jxX2Vrv4lESGH2liEDevbYVof831viJhS4YRnegVBHh71YeudCm3lwudHfHUx5bFGtZT9rUnLfgiktx9oIWa0k/5Xt/6+FCnKOh/aI4t47c2lI12m0OqpIuhA7rNcR4REEyL4Bwjd7dtbwCoVTNjgbi9eGZ7GVrS3cqWBwjMY829FpNTB/qXyxBBCor/0TYPAxSNFsj5AoqA1e4WxVjPZYBfYDLnpQJYfXAtHVb3ircSdHqoMXsuwQNDF/s/NIk2YRWc1+UcMTQ44EFCqpv1kN8mOKs8QxE6zk+vRhyapUd3OENmEpepnASlSZidizHG44lzjgGIeC8yRKpn/f
X-MS-Exchange-AntiSpam-MessageData: bnXmvizNkUB8Zghv/mcmEddA6V3icJPVXzfeSPN+SaQg2iExOoPtdplccSBwrk3eDuL/mCTuf4KKE748A8nlDpcI++ylzcjdzhhsrJUXslxbjHwufE+vE/XIH+jg6f76yqnZqjeUeyrmCzBFu+o5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2198
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(2616005)(956004)(26005)(6486002)(5660300002)(186003)(31686004)(2906002)(70586007)(70206006)(16576012)(316002)(26826003)(478600001)(44832011)(81156014)(8936002)(356004)(336012)(53546011)(54906003)(86362001)(81166006)(36906005)(16526019)(4326008)(36756003)(8676002)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0801MB1977;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3affae31-d935-4dce-d8f2-08d7b94c2aeb
X-Forefront-PRVS: 032334F434
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxEm//duisuEi7Gb2O8l1PdbPJHfBLQxrlzoZlM02YKZ5V2akrMgFgvhV35zbm5KsOfilTUuy3oZ0izrErKy+HtOlu5erMk/0aWVaZnbj7JqGYP6RCW3nC0Y6JfbzQzxIDf0DP+wu9kPprYpv5eAP4Rc+Dge/e8TNdKdPWYyw9WwYiWmb0E0R5II2ZnY5/+D1bp3cSrxAb7uRKObuLY7ock4Mgfgu/SAo7GIU9ODiCWFUaJ+Lp6hRYTjweS4vhYZHJKjWqzQUM4caVfHfRHd9GOAd+NkGGQxZI20EAwhrCpd230YSiHCoj35qZWJ5/Y+syp77kGWXP53mYeJBs9axWyqZC6xEfqAstOeqiLFucFpwBaVpdF14jqZkx/uT2iXYP06/4UL60Al9Ih1Pwd/8f+7X85mnHLTwvmAP0lKtl2m3isXcsm3kPYeknKWxN7Q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 17:08:36.2356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf89d400-4f55-4432-6186-08d7b94c2fa0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On 2/17/20 11:42 AM, Adrian Hunter wrote:
> On 11/02/20 4:04 pm, James Clark wrote:
>> From: Tan Xiaojun <tanxiaojun@huawei.com>
>>
>> At the suggestion of James Clark, use spe to support the precise
>> ip of some events. Currently its support event is:
>> branch-misses.
>>
>> Example usage:
>>
>> $ ./perf record -e branch-misses:pp dd if=/dev/zero of=/dev/null count=10000
>> (:p/pp/ppp is same for this case.)
>>
>> $ ./perf report --stdio
>> ("--stdio is not necessary")
>>
>> --------------------------------------------------------------------
>> ...
>>  # Samples: 14  of event 'branch-misses:pp'
>>  # Event count (approx.): 14
>>  #
>>  # Children      Self  Command  Shared Object      Symbol
>>  # ........  ........  .......  .................  ..........................
>>  #
>>     14.29%    14.29%  dd       [kernel.kallsyms]  [k] __arch_copy_from_user
>>     14.29%    14.29%  dd       libc-2.28.so       [.] _dl_addr
>>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __free_pages
>>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] __pi_memcpy
>>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] pagecache_get_page
>>      7.14%     7.14%  dd       [kernel.kallsyms]  [k] unmap_single_vma
>>      7.14%     7.14%  dd       dd                 [.] 0x00000000000025ec
>>      7.14%     7.14%  dd       ld-2.28.so         [.] _dl_lookup_symbol_x
>>      7.14%     7.14%  dd       ld-2.28.so         [.] check_match
>>      7.14%     7.14%  dd       libc-2.28.so       [.] __mpn_rshift
>>      7.14%     7.14%  dd       libc-2.28.so       [.] _nl_intern_locale_data
>>      7.14%     7.14%  dd       libc-2.28.so       [.] read_alias_file
>> ...
>> --------------------------------------------------------------------
>>
>> Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
>> Suggested-by: James Clark <James.Clark@arm.com>
>> Tested-by: Qi Liu <liuqi115@hisilicon.com>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
>> Cc: Al Grant <al.grant@arm.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> ---
>>  tools/perf/arch/arm/util/auxtrace.c | 38 +++++++++++++++++++++++++++++
>>  tools/perf/builtin-record.c         |  5 ++++
>>  tools/perf/util/arm-spe.c           |  9 +++++++
>>  tools/perf/util/arm-spe.h           |  3 +++
>>  tools/perf/util/auxtrace.h          |  6 +++++
>>  5 files changed, 61 insertions(+)
>>
>> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
>> index 0a6e75b8777a..18f0ea7556e7 100644
>> --- a/tools/perf/arch/arm/util/auxtrace.c
>> +++ b/tools/perf/arch/arm/util/auxtrace.c
>> @@ -10,11 +10,25 @@
>>  
>>  #include "../../util/auxtrace.h"
>>  #include "../../util/debug.h"
>> +#include "../../util/env.h"
>>  #include "../../util/evlist.h"
>>  #include "../../util/pmu.h"
>>  #include "cs-etm.h"
>>  #include "arm-spe.h"
>>  
>> +#define SPE_ATTR_TS_ENABLE		BIT(0)
>> +#define SPE_ATTR_PA_ENABLE		BIT(1)
>> +#define SPE_ATTR_PCT_ENABLE		BIT(2)
>> +#define SPE_ATTR_JITTER			BIT(16)
>> +#define SPE_ATTR_BRANCH_FILTER		BIT(32)
>> +#define SPE_ATTR_LOAD_FILTER		BIT(33)
>> +#define SPE_ATTR_STORE_FILTER		BIT(34)
>> +
>> +#define SPE_ATTR_EV_RETIRED		BIT(1)
>> +#define SPE_ATTR_EV_CACHE		BIT(3)
>> +#define SPE_ATTR_EV_TLB			BIT(5)
>> +#define SPE_ATTR_EV_BRANCH		BIT(7)
>> +
>>  static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>>  {
>>  	struct perf_pmu **arm_spe_pmus = NULL;
>> @@ -108,3 +122,27 @@ struct auxtrace_record
>>  	*err = 0;
>>  	return NULL;
>>  }
>> +
>> +void auxtrace__preprocess_evlist(struct evlist *evlist)
>> +{
>> +	struct evsel *evsel;
>> +	struct perf_pmu *pmu;
>> +
>> +	evlist__for_each_entry(evlist, evsel) {
>> +		/* Currently only supports precise_ip for branch-misses on arm64 */
>> +		if (!strcmp(perf_env__arch(evlist->env), "arm64")
> 
> Isn't config ambiguous unless you also check type i.e.
> 
> 			&& evsel->core.attr.type == PERF_TYPE_HARDWARE
> 

Yes you're right I will add this.

>> +			&& evsel->core.attr.config == PERF_COUNT_HW_BRANCH_MISSES
>> +			&& evsel->core.attr.precise_ip)
>> +		{
>> +			pmu = perf_pmu__find("arm_spe_0");
>> +			if (pmu) {
> 
> Changing the event seems a bit weird.
> 

This is because there is no support in the kernel for the precise_ip attribute on Arm.
SPE can give you precise ip data for the same event, but changing the event is required.
 
>> +				evsel->pmu_name = pmu->name;
>> +				evsel->core.attr.type = pmu->type;
>> +				evsel->core.attr.config = SPE_ATTR_TS_ENABLE
>> +							| SPE_ATTR_BRANCH_FILTER;
>> +				evsel->core.attr.config1 = SPE_ATTR_EV_BRANCH;
>> +				evsel->core.attr.precise_ip = 0;
>> +			}
>> +		}
>> +	}
>> +}
>> \ No newline at end of file
>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>> index 4c301466101b..3bc61f03d572 100644
>> --- a/tools/perf/builtin-record.c
>> +++ b/tools/perf/builtin-record.c
>> @@ -2451,6 +2451,11 @@ int cmd_record(int argc, const char **argv)
>>  
>>  	argc = parse_options(argc, argv, record_options, record_usage,
>>  			    PARSE_OPT_STOP_AT_NON_OPTION);
>> +
>> +	if (auxtrace__preprocess_evlist) {
>> +		auxtrace__preprocess_evlist(rec->evlist);
>> +	}
>> +
>>  	if (quiet)
>>  		perf_quiet_option();
>>  
>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>> index 4ef22a0775a9..b21806c97dd8 100644
>> --- a/tools/perf/util/arm-spe.c
>> +++ b/tools/perf/util/arm-spe.c
>> @@ -778,6 +778,15 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
>>  	attr.sample_id_all = evsel->core.attr.sample_id_all;
>>  	attr.read_format = evsel->core.attr.read_format;
>>  
>> +	/* If it is in the precise ip mode, there is no need to
>> +	 * synthesize new events. */
>> +	if (!strncmp(evsel->name, "branch-misses", 13)) {
>> +		spe->sample_branch_miss = true;
>> +		spe->branch_miss_id = evsel->core.id[0];
>> +
>> +		return 0;
>> +	}
>> +
>>  	/* create new id val to be a fixed offset from evsel id */
>>  	id = evsel->core.id[0] + 1000000000;
>>  
>> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
>> index 98d3235781c3..8b1fb191d03a 100644
>> --- a/tools/perf/util/arm-spe.h
>> +++ b/tools/perf/util/arm-spe.h
>> @@ -20,6 +20,8 @@ enum {
>>  union perf_event;
>>  struct perf_session;
>>  struct perf_pmu;
>> +struct evlist;
>> +struct evsel;
>>  
>>  struct auxtrace_record *arm_spe_recording_init(int *err,
>>  					       struct perf_pmu *arm_spe_pmu);
>> @@ -28,4 +30,5 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>>  				  struct perf_session *session);
>>  
>>  struct perf_event_attr *arm_spe_pmu_default_config(struct perf_pmu *arm_spe_pmu);
>> +void arm_spe_precise_ip_support(struct evlist *evlist, struct evsel *evsel);
>>  #endif
>> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
>> index 80617b0d044d..4f89a3a31ab2 100644
>> --- a/tools/perf/util/auxtrace.h
>> +++ b/tools/perf/util/auxtrace.h
>> @@ -584,6 +584,7 @@ void auxtrace__dump_auxtrace_sample(struct perf_session *session,
>>  int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
>>  void auxtrace__free_events(struct perf_session *session);
>>  void auxtrace__free(struct perf_session *session);
>> +void auxtrace__preprocess_evlist(struct evlist *evlist) __attribute__((weak));
>>  
>>  #define ITRACE_HELP \
>>  "				i:	    		synthesize instructions events\n"		\
>> @@ -728,6 +729,11 @@ void auxtrace__free(struct perf_session *session __maybe_unused)
>>  {
>>  }
>>  
>> +static inline
>> +void auxtrace__preprocess_evlist(struct evlist *evlist __maybe_unused)
>> +{
>> +}
>> +
>>  static inline
>>  int auxtrace_index__write(int fd __maybe_unused,
>>  			  struct list_head *head __maybe_unused)
>>
> 
