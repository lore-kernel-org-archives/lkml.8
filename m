Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AEBC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B78D23D6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PUCv5DiZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgDFO1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:27:55 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:32796
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbgDFO1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:27:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=II93OZ1V9UDPjn8VHJPv247YKNaMjiqTVpgp+aJ5jg8ShbKHlp9nztIL4dZercJU4j/I19jMIjIQMgphJ6gsNrIcBw0BQpWiEe+xkcwqjfI4Vq9lmItA/qq8iVIxQTQscI4wgxpD37Y8g/2vyBT2mmRB+vHad7vgdZJyaack+st7IUajGQKvdR0wz4/i5zF+LnYl/0JhrjJmFAMw26o3CrFUyyBHHmxqLK+gUm76RMkaFB61P874R6nNLIi/cSy6pCH+fbbi6mjf1up3yuJ1WHgiG2waGJTfByZz9yEv2Az8u2vzpALkVMGjxGjyncBwqfnPfyJigJXWeEGcJ/Jyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mko4UHWzwGO0z9/T7a0nbIBXyj5G6J9sEI6ag1sXmoo=;
 b=ZaVfUP65C4EzvKaip1QBLd0L2n6+YTODtaAAOSWkLz8o5zlVfJ7J9HI0nvlH2D03qPsBQFUchGWJQGQ1Jv5dXxWnUSIW3xv8E529rZLcvZSAcEMYYnVQsxKRTrP8AKgg5J/Rb6MXwEw8gIbHAATGZxm30qkyTUUzzpNtWvQUXMYN8ncSRpTlZgzt8ssGr78+P9of1txMO4nPuGHMPMtvDQPYShP6f+PMTp0OkjgsPzHRrzpobo4GxQ6BLmc2Dl0shbs5Ym6gmeLGXb79PwipINXKptxxUjA1W5D2uCrMAFjXAftKJzibkNW3ZAwEJeO2ewZ9+2o4XU6NV1t5T7T+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mko4UHWzwGO0z9/T7a0nbIBXyj5G6J9sEI6ag1sXmoo=;
 b=PUCv5DiZAhYAjA6BwnJUmFFBHw27khjyAAMTDrK8YpcHhYapPYWuH4Yd2o4rp1LnGNKyDx1oJSFs5TwPrHapnoWyy5IwS6yT3yP3mfivP7uAblxohJ8c8zUl7f1uk/RvRI96hPPvYdi0dF1gFi8H1Ve8x4/M6QI3gfyeJLNBkWc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2719.namprd12.prod.outlook.com (2603:10b6:805:6c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.20; Mon, 6 Apr
 2020 14:27:52 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::654c:5d93:fd49:88b3%4]) with mapi id 15.20.2878.017; Mon, 6 Apr 2020
 14:27:52 +0000
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
 <7176b535-f95b-bf6d-c181-6ccb91425f96@amd.com>
 <21c81775-876a-4dd2-f52f-42645963350f@redhat.com>
 <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
 <833a5e74-645a-130c-ceab-068880e0c69a@redhat.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <c9d85708-4409-0d67-eabd-912b073df49d@amd.com>
Date:   Mon, 6 Apr 2020 09:27:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <833a5e74-645a-130c-ceab-068880e0c69a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0042.namprd06.prod.outlook.com
 (2603:10b6:5:54::19) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (70.114.207.150) by DM6PR06CA0042.namprd06.prod.outlook.com (2603:10b6:5:54::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 14:27:50 +0000
X-Originating-IP: [70.114.207.150]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b2d54954-4b3b-4348-ce2e-08d7da36b050
X-MS-TrafficTypeDiagnostic: SN6PR12MB2719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2719E6219D923FCAB3172D2A87C20@SN6PR12MB2719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0365C0E14B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(44832011)(16526019)(186003)(2616005)(86362001)(66946007)(36756003)(956004)(26005)(5660300002)(478600001)(16576012)(2906002)(54906003)(8936002)(52116002)(81166006)(53546011)(66476007)(66556008)(8676002)(81156014)(316002)(31686004)(7416002)(4326008)(6486002)(31696002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ov2AL+H1s1fNLeC/H/bf5ATf/HF8MBvr2wP2/cZ7IyiaegYZMiyeUcgs3tOCK9wypBkSh42zB4n3onLy148wgXv4hIaDTQhA3GJzJTGmnyyVMmLOtdsK51SG95tPxxtlZ3qWaKZDBKQjMT2gUumfsK5WQO7ah/evPrrtm1HsiJKe1ycuFTkmEdixg5tzt7wcMeWNwVm1/3NKoxQvTCWg9DTT2YJbv4GM5B5Uw62Qy2i6oUZSKxJ4BO9Is0lInNB9QHfontpGELFMbXuLiR0Ycm2ksgtRFH+yHXqZRc01aONNOi9qmoezIeUVQs26oyYR1I1BgW8Zh2axRmJtst9P+0rw51xQLmSLgJi3FSsiXmRKHWfRav8jCdApwvdQuuIcsEoCcwVPYqW2oDQ6+pQXjDrqEiFtr6XuX8iVaXlqswbcJ57W8E/yqZsuz7zeH6KM
X-MS-Exchange-AntiSpam-MessageData: d9BPBRihnFkRqmGad+cK5bXw8nT2VYg8JF0swtDDp19SD2MWwCVB/w0iLEeKtgNfPJW9c5xXAAwAaGr+nLOY+HJxfKz2SIhBkuYM7YPa/x4/YSO1jw5Xdb2DGme0VSR8JdgidBGvL4pc/dSHSoKc9A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d54954-4b3b-4348-ce2e-08d7da36b050
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 14:27:51.9408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I37bkGqC68Aoxg+WpXEZG3o7taznpLNgnWP4NDWEpnuNO/k2uVbaOL1EQYi/gbC9D/2EGPBs3pVXWNM4ta1cQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2719
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/20 8:04 AM, Andreas Gerstmayr wrote:
> On 26.03.20 20:04, Kim Phillips wrote:
>> I now get a SIGSEGV when executing perf script report flamegraph.
>>
>> Here's a trace:
>>
>> #0  0x000055555590a9b2 in regs_map (regs=0x7fffffffbfc8, mask=16715775,
>>      bf=0x7fffffffba60 "", size=512) at util/scripting-engines/trace-event-python.c:696
>> #1  0x000055555590ab03 in set_regs_in_dict (dict=0x7ffff61dd500, sample=0x7fffffffbf20,
>>      evsel=0x555555d7a700) at util/scripting-engines/trace-event-python.c:718
> 
> This error seems unrelated to flamegraph.py (occurs also with the stackcollapse.py script).
> 
> Looks like the intr_regs->regs can be 0 when running in DWARF mode (this error doesn't occur in the default mode). I've added a check and sent a patch. While at it, valgrind reported an invalid read in a different code path, which is fixed by the other patch I just sent a few minutes ago.
> 
> Can you please test again and report if there are any other issues?

This flamegraph patch works for me now:

Tested-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
