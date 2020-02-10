Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C313C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6049020873
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oCzXI52z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBJQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:32:01 -0500
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:31145
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727640AbgBJQcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwGgaCUo16YTsoGyFudf8A6w27U/pJd5lQ3ZpO9vAeCCY80kROTblN36zd/C/YMPAES/iASG3yLhcYyWw8obJYxvuNeRmK44AKp9+nFvwp+meoaUE73OtdzG/Ajf4Xhuw4Q3kaiXFW7wHYsLxf09HmECxjKgawxqczjPME3aWPGqArfwbNki6Nrb8VEGZDYEAImqYRecJSvfsFpbZgkmn90opzLtUyGHUhsjJC61S5Sld0+Mdd9NxuCZd4x37lJjZrjUGfIcANedivEt17lPvkT6l4XLXoz/HDxpG2aokrSWa0JQyOFfmPhIDS1WimeVj08J/tsJ/LNDsrVx9zdL1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZZCk7pCNrAOSq2XoossqM1TCxHaa3yaGv/I56g+m2E=;
 b=OuRHzxJ7aezrL5N7/iwZBzpCUNSyLleDanHBj0XhQs78QGwOSVqD5bCbAZ7LDNoR1Y2nL88Z5UW0dfOFtaf5ZpEWbwLtpVekjPts4tl+M4fseqtuGpzBXECgfDpfHlXg0eAhWT/Lil4P/W6CN50ivZXT34ToQr5VLAKZdoDM86XwDy8udfv79Oq7SFs7vqB+aAGcHp24J+oSBDBsm5dj0gNKtWxJ7RQJKCFz5sSdFtyxc88qXjZ9i5Ia+FKRcZOJ7tHD9dK2GAAfswg47dcMgLB0VvWuTqvIZaytn8vMh1n9cRoBd3UDbDkE+7RZJ6wjmDwoXtmktOZ2iQD0NJK56g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZZCk7pCNrAOSq2XoossqM1TCxHaa3yaGv/I56g+m2E=;
 b=oCzXI52z2PvoFvMHvOsSKy2qgvVh1ENEm+UJ125x3DLM0SKDs9Fy9zxcJZA/zI0dSUfemiygdjvwp+yYHxEvnGsosGuscOU/ctSdSMkQtapF7jeksBKDyg5v2gVhHVgoA3JrKWsHSUhqc/e+qIWPK5zXPzj2crYFwurI/AIP8IE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2815.namprd12.prod.outlook.com (52.135.107.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.26; Mon, 10 Feb 2020 16:31:58 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2707.030; Mon, 10 Feb 2020
 16:31:58 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3 v2] perf symbols: convert symbol__is_idle to use strlist
Date:   Mon, 10 Feb 2020 10:31:47 -0600
Message-Id: <20200210163147.25358-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207230613.26709-1-kim.phillips@amd.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR02CA0121.namprd02.prod.outlook.com
 (2603:10b6:5:1b4::23) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by DM6PR02CA0121.namprd02.prod.outlook.com (2603:10b6:5:1b4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Mon, 10 Feb 2020 16:31:56 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83ed2059-e7a4-4420-a5d0-08d7ae46bf97
X-MS-TrafficTypeDiagnostic: SN6PR12MB2815:|SN6PR12MB2815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28157B0EBD83DB61A66ABDED87190@SN6PR12MB2815.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 03094A4065
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(189003)(199004)(66946007)(66556008)(966005)(5660300002)(478600001)(44832011)(4326008)(86362001)(66476007)(956004)(2616005)(16526019)(2906002)(26005)(6486002)(7416002)(186003)(6666004)(8676002)(36756003)(81156014)(81166006)(54906003)(52116002)(8936002)(7696005)(1076003)(316002)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2815;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUght+5nRT98YNMgkUpLcA29JhlqjmLoEiVT7GPMShyriEGE2BW0HTCCM6AiFQI9SnHpe2ZDmpJ9LxKWZxlPoW5z4llzNcXMLh+cNgkT6nNi0DBcZwa2k1qQOupARuyluV7JyRJgzREWsN1u7fqXJaGMqsktBz82wCL/sD4cnBjh5ae1CvJ6XstT1RChXiPDbhJqJga6pZG0fvsu/EOBv7pGelynPM5A+KF3hzLsU3hpiQagLiN3L8oSeDPXA6mWiYpEHY5AWn8ZnxQZxrBAp7SFqX81JbWelqnc0UlsfMmh0zCsuVW4JgzozfbojrldKw9qPw7peqL5Wc/IUHfKqWyLtwLOvwhSX4PcaGA2yjRoXymQpPrdblhVzRYPutUeVnRd/J1UsR+/Qe8GL50HM02RTF0rne9kPe/A6Xkxn/l39PomYNlMvRWPO23fhB5UHVALqC/9Nalzk0dSnRJ2XkF/Bx5ZLvUx8iC1gOtjWQ6l+ZlRUWFbEZK9b9Jx1vJprcp1Z76SV7hfHp96fa6Tl6uq6rrrSV9iuEEt4wyqYsfYyZBWhfXnbjxNptxRGbPFO8SDH9rkqHgnu3r0EXDlxQ==
X-MS-Exchange-AntiSpam-MessageData: shUUH19wOgJWTRktSFt3s4/rwLaEOLDHcmmXtYgy+hcqvuN8clyTzcipRrM9GSQKhcJ6FWYPpVFh0YIMRc4+SkcOLhGMQCwliZgun8IYSYwz1w6mSiNKJP54AYDQyHTX4ytZKn4FnkBZM1glZM+AAg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed2059-e7a4-4420-a5d0-08d7ae46bf97
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2020 16:31:58.3373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0m3JVw2SwNktmJTDMnHJvsBpuJQVMVswH+CxUy9OF78KeDtLH9Zb9o7qdurMWTiUSTzoP6mPemq41LARgeEDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2815
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the more optimized strlist implementation to do the idle function
lookup.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2: new this series, based on Jiri's comment:

https://lore.kernel.org/lkml/20200120092844.GC608405@krava/

...and this time with the Cc list intact.

 tools/perf/util/symbol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f3120c4f47ad..1077013d8ce2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
 		NULL
 	};
 	int i;
+	static struct strlist *idle_symbols_list;
 
-	for (i = 0; idle_symbols[i]; i++) {
-		if (!strcmp(idle_symbols[i], name))
-			return true;
-	}
+	if (idle_symbols_list)
+		return strlist__has_entry(idle_symbols_list, name);
 
-	return false;
+	idle_symbols_list = strlist__new(NULL, NULL);
+
+	for (i = 0; idle_symbols[i]; i++)
+		strlist__add(idle_symbols_list, idle_symbols[i]);
+
+	return strlist__has_entry(idle_symbols_list, name);
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
-- 
2.25.0

