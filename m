Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA00BC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED932087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AmSK9JXZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgIHVr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:47:56 -0400
Received: from mail-bn7nam10on2047.outbound.protection.outlook.com ([40.107.92.47]:1837
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgIHVrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:47:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcjiMAABU5UDQtrIvVU2Ev0GVsmIgggyqC5gAW+ZOD16gtir1YvquLzBQxeunEZrorG3eqOfFt2z0epO38md6OyuCylDi0JfXMrn+yripNK5kf4KCKd9ppnBTtQha11eMLhsrVG6qoRPYk/4MUBm6fXOHCwxRUA619qxuEPuApK5VDTdHc/ISdYyaR6MlBDC1TQH3SMOYO4O7lJrMJrxYiQX61O66gAvZcVXG3OPWI7TZBEENUsn/G2EDw8dNcBqhWx1JPT72hhrPupXFKznUDWVWTfc+GdyG/NJ/w8+foEkevTMPGQ4ua/WM/mKoVegTM26giCYEIqRjBrlctQaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDrWmc1H6MXODI8jA1z/QYv5uScKCNt4wM21FRFmgg0=;
 b=eLIjcjL5JU8mtVqSmFMlpv1MMaA603iFEY9+mLzaZj1f7VioJrZEMfu0HigXnQzO9czkx9qgOUAXHWmukCK/9L2uogHoG9cnKTZbt7zxpMAWl5WlviuQ74PMD04mHpikqDngJyQnNveBw+nPZHiWzLTebrKWZegNVjNtrYRwRCjuHvr23z0UJiWc6DUjby1+iMd6AXmQpqpgUAQbElBSZFxIH2V0kU0rT250i3fAhg3RZqSABNCZlE5mHH8lnv1slemwtHtA0lRnLDQzNrvy8kRXxHJPA2eK01f30QLNWJneEa8m+EKf4PpZgKRCOxnuA+0DX1JlN81FcenS8H9vsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NDrWmc1H6MXODI8jA1z/QYv5uScKCNt4wM21FRFmgg0=;
 b=AmSK9JXZAmWhyLdkHOQNeXirjiRKfq4Gp9j8l5INz373gtRg0rkesB18MwAW8oycdhBgUko79RCtiGaQDxouwagYog2nO9s1l8HJysouGtJrM2nlYoSSkzYaKlLupehlkGYsDGOkIi79gkLqRIbjuEgkCKxhBushCThR98Huc6o=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2881.namprd12.prod.outlook.com (2603:10b6:408:9d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 21:47:52 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 21:47:52 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kim.phillips@amd.com
Cc:     Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH v2 0/7] perf/x86/amd: Miscellaneous updates
Date:   Tue,  8 Sep 2020 16:47:33 -0500
Message-Id: <20200908214740.18097-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN1PR12CA0062.namprd12.prod.outlook.com
 (2603:10b6:802:20::33) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by SN1PR12CA0062.namprd12.prod.outlook.com (2603:10b6:802:20::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 8 Sep 2020 21:47:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7700cd7-1230-42bf-d7e4-08d85440d5f7
X-MS-TrafficTypeDiagnostic: BN8PR12MB2881:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2881C73875D66CC95F96989887290@BN8PR12MB2881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrcanU0WYliNo3cj2S8XURdUyf+6a0AIvQllQQbN7O9YiiBlD61gLTNSz88exc4ZwL/gfs8v+SFSvYy3ZCXAhM56qb224NjCBPPKESGly4kYFbzo8LvtQDHrMlCA6/FKrv8tadEComSkcOfb6Tev7yw2NLhF1XJK0B55PFKRMEG/6ed4u4txp8ShDJjpJ19HypQbBDODfHLSFKRtj4Sx0acqYj9UYh6R7FD1qcOpXimIfe5lM6dBeOiI58SM/LxQmGxqtsIzCDsQM7AwmyEbnWt3UTrZBo/IhfBqpfNtUOajzhtwIuPgPPfQqhKbkkMBCkE5a0Bk81xld0qsn/wnbwqlZLDZFmc3rXjbXRT1fRM0opONJ6qkG/10vUZwTdHeHTm9LtUTrbc2Xs1sr4OpiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(2616005)(54906003)(110136005)(4326008)(6666004)(36756003)(8676002)(1076003)(966005)(66946007)(66476007)(44832011)(66556008)(6486002)(86362001)(7696005)(52116002)(83380400001)(956004)(316002)(186003)(7416002)(478600001)(26005)(8936002)(2906002)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 9fFD5LncOFRVv/LBwXtlNWnkWKtlYRUr8p5krs60nNhfBvNXBvFr1iiw9c4f4bylG1gxgRKQYs3azOi2uniAqzKSVMI22+sJj8Ssw6/SNnq6mBGBGKDOql3fbboa0yP47azUkMdhW0urAcTTtUckgQx98bxyxkjNmglC5gIzIi0W92nUYkCp+sSQb2byku9TskKaYsWYmpCU3KslIw0hYWdaQB4QqzRQsk5qn6dC8VDeHQuzZEq3AhVhTBFyNLxueHPlN65autqb5zVDO6Uag2ClYkq9/xXMRTnDtVxMput/0NALurBEnpE7UrOuafY0hnGIYX+PN63yBPTGc/dXN9sKNNBxfBg1CKRmaqaVlcT6AAhJpXg+X9wzArl+crt9TCBae0FyQAmwchvl+R7OxQhCkBK93e/Io3EOmG/32o0p3PPye/O1UZ/OSXuh9q7VP7a1HjluA6U936bN9EUTb8BSuUleO0ShRbuE7dXGKCUIun7X7nMoce8f2UCZ5kmphwVgojsstjN4nHO0O18b4ST1us0L1KgW6xmy84h+feKvpqnEpVDZUvg9vkYckCdXQn1BGR8/yAffQNVdeUYWviRM7jAh33OGADgXGkEhB+3nNkLSD6+2AwGqAKJq10KDN/IzPMI5ZVamG4wiGaeGLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7700cd7-1230-42bf-d7e4-08d85440d5f7
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 21:47:51.9273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q7EIIDe+Rc5ERFKQHah2rsLVCgc/eg243fNlNAwlGLW6WrlflyviGKH4mMNJbKQgPUMbOjO/+y1Zwvsefwy1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2881
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please merge:

Patch 1/7 restores 'perf stat -a' behaviour to program the uncore PMU
to count all CPU threads.

Patch 2/7 fixes setting the proper count when sampling Large Increment
per Cycle events / 'paired' events.

The next 4 patches fix IBS Fetch sampling on F17h and some other IBS
fine tuning, the last one greatly reducing the number of interrupts
when large sample periods are specified.

Finally, patch 7/7 extends Family 17h RAPL support to also work on
compatible F19h machines.

Thanks,

Kim

v2: Added this cover letter.  The only patch that changed in this
new submission is the fix for IBS Fetch sampling, which got a new
family check after testing on some other family machines.

Link to 1st patch in original submission of this series:

https://lore.kernel.org/patchwork/patch/1289806/

Cc: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>

Kim Phillips (7):
  perf/amd/uncore: Set all slices and threads to restore perf stat -a
    behaviour
  perf/x86/amd: Fix sampling Large Increment per Cycle events
  arch/x86/amd/ibs: Fix re-arming IBS Fetch
  perf/x86/amd/ibs: Don't include randomized bits in get_ibs_op_count()
  perf/x86/amd/ibs: Fix raw sample data accumulation
  perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter
  perf/x86/rapl: Add AMD Fam19h RAPL support

 arch/x86/events/amd/ibs.c         | 87 ++++++++++++++++++++++---------
 arch/x86/events/amd/uncore.c      | 28 +++-------
 arch/x86/events/core.c            |  4 +-
 arch/x86/events/rapl.c            |  1 +
 arch/x86/include/asm/msr-index.h  |  1 +
 arch/x86/include/asm/perf_event.h |  1 +
 6 files changed, 75 insertions(+), 47 deletions(-)

-- 
2.27.0

