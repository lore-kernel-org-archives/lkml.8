Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36385C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136022053B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="xL30jx4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgDQNXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:23:54 -0400
Received: from mail-eopbgr80130.outbound.protection.outlook.com ([40.107.8.130]:59503
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730059AbgDQNXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnTqQGAt66oQHQNQ6LgSoisGltdWeH3xhLGEooPmRnOkVLCsnc4m366O22Uby46fRPu7R32vgK4cA38yDhUtVgOZWz7f8Lou4irqawXd1RkA27iTOcSPHc5LixV7QenDSiINuAQUJDpBAquHMNBwR6FIdD32W2FHb0MaWEiegc4NapfU/4mcuNGr38MbNjUPIW4hVwgPmYX7DApLaQYu2ytfIjBtoS3qccNK3rs28krlY6eTrI2XxKsF1vGau3TBXGCCBEJCbRADj+WHghm03HW6Wwf6GFwdmXZUg4WyRXPSmVVBmH7K2hDzEp0VPCtV3Yp+x8JzenzLQOQ4oJEBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jmLAavgvfLCdzkZGjli5QPy1tl7zlYVEiy7yZ8RKbg=;
 b=O/tgg9Ik0Rubc8YhTcAO+YG3CU4ZejhHYzMB30N+/8X+xbOIxwwasEH8XCoZcZLB6zS5RJah6dom9H6QdXiVhzMgPzSxlPNydEa/CJa1KaK92GyEctnVW6P08gExVuHao5EKOUEQ1loYkPRLaldSd7ixdFrwjwM7D9w51j1IWTjDl90JoI90CUZBjKN1CKu9iBfEx5WOHav9NCPGTEE4LD8nqtmljCXr+U+zbooHuLrjSbgbtmlBeN4XJCeHNl4xUfVppkjcSICB9+/BsLVmR6RF5sojIWl/bPS1QQTsQ+KdlWhrF6iRDn5JuIsMm/qEb0Tmf9GBn7wJXBley4GXVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jmLAavgvfLCdzkZGjli5QPy1tl7zlYVEiy7yZ8RKbg=;
 b=xL30jx4/uMuLp/8L/fJH/KrXSZbiSBZJstTQMRE84qxEYGu1id4E1NeVpMiU0FNC2Ti6szI1UZpvM0aSHMt2e30EWxjb5N9msXl7EJwWDYx67I59dz1PBFhqYCSPXYoLTfFD5PuDwbY8EvNXNmhlK/HaNSN1BZEtPtKr6JzklI0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2763.eurprd07.prod.outlook.com (2603:10a6:3:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.18; Fri, 17 Apr
 2020 13:23:50 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 13:23:50 +0000
From:   Tommi Rantala <tommi.t.rantala@nokia.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] perf cgroup: Avoid needless closing of unopened fd
Date:   Fri, 17 Apr 2020 16:23:26 +0300
Message-Id: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
X-Mailer: git-send-email 2.25.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:3:f7::18) To HE1PR0701MB2938.eurprd07.prod.outlook.com
 (2603:10a6:3:4b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from trfedora.emea.nsn-net.net (131.228.2.16) by HE1PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f7::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Fri, 17 Apr 2020 13:23:49 +0000
X-Mailer: git-send-email 2.25.2
X-Originating-IP: [131.228.2.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bd979586-650e-4b26-832c-08d7e2d2911f
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2763:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0701MB27639B5367B5ED377057873FB4D90@HE1PR0701MB2763.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(36756003)(6666004)(6506007)(66946007)(66556008)(1076003)(8936002)(316002)(186003)(66476007)(16526019)(478600001)(26005)(110136005)(86362001)(54906003)(5660300002)(2616005)(956004)(103116003)(4326008)(8676002)(81156014)(2906002)(6512007)(6486002)(52116002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlJcSi1dL9+sRHo5Bo5i4qwH6yB5iWTAj/feFzx1iEjhQGXbfikVsBD06IEiYIOV7vSG9r3Yxmr+LAowaHr6cHEfHztmfzAcBkFalU9z7e8doyNubItJop31VWoL7P3KnvCx1m0LpwIqhmAZwyLlUaYf2hUFLXbYFTcP9ntuRk8bzfb40x/bjETZPzMBqxbAuSCbu1yhx2VuEwveRuRWp/IMvg3OkcUKoBLrLjC2DAU8BGZY9+fbBOzgn7GOsK7RoSJWFA1Ng/zbSU1Mi1OGmA12vKQRyCmvYi8RirTVq1a+iiHBwhIPv6uDApGISKx16lIPXzmaKUoxDtKkueV0FkSA7Eyovb48NzZYVzIF1FuTYtCigDPP8dNYdvEviQdgFpmCELwCvu2cu9+f+n+ZLyANk4GnYp0ckJy4lx8R8RLxYHWigBxn2HLQYPyERkTl
X-MS-Exchange-AntiSpam-MessageData: cVtwPfcQeMwkPpWQ13kdjc88SoCY/++FAbsfYnDVxFdkvCv0VAMEcijpRv34zhZr4UmCPulpjol+p59AH1ZnUoyjfLVMBKts/kf//CBgW2SxWSwaBbkLdA9ACgu72yl2uIeRnaLzBAv6h8fLEf1xAw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd979586-650e-4b26-832c-08d7e2d2911f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 13:23:50.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XIxOCkhnwVXyg1942PR9eA4C3a9FR98FT/sDUb1LkuAKVZzynNgHKjQSW+lhmVeIispyutfPhj2kJg3TLbz9YzsQjiz3LWiBZEzkPeHA7vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2763
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not bother with close() if fd is not valid, just to silence valgrind:

    $ valgrind ./perf script
    ==59169== Memcheck, a memory error detector
    ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
    ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
    ==59169== Command: ./perf script
    ==59169==
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 tools/perf/util/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b73fb7823048..050dea9f1e88 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -107,7 +107,8 @@ static int add_cgroup(struct evlist *evlist, const char *str)
 
 static void cgroup__delete(struct cgroup *cgroup)
 {
-	close(cgroup->fd);
+	if (cgroup->fd >= 0)
+		close(cgroup->fd);
 	zfree(&cgroup->name);
 	free(cgroup);
 }
-- 
2.25.2

