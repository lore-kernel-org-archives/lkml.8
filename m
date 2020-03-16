Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB68C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD17205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tIGoVilx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733051AbgCPX7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:59:53 -0400
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:20704
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732932AbgCPX7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:59:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKZdpwtxjzinFJIn9NpMECRUwfqv8PNn1EiwS14DO/pLCEeTu7r6AtNWg+CkKmHgBBLEVfwQOek5EOslJ0eJ1Im81cLs3gAC8olreCzQJgO4AJZHHoK0L/UZMYeOlOkRvv6a0KniWdtkmzGTvpJ152/SoeTqUhuGP+Z3cf1B8kyv/KvdV8eU8B96rwmM1Tg3fT1FQlJrfGP4OPI6U2rvUn4P1+HX7kmklc8eDqqPZGK1vql51TBd1/+7odO1YXeioKm12/I0eXmAsuQ0xzxWEbK/7nrPK0n7jueZ/xQcJ987BMwirz3NDubD2OkVrgy+ID/xgHYkjwMCiep18mj7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=775pDYEiZd/aNKZTnpTLvDccXt+O7E17G8bTpDz4P7A=;
 b=aUxz23u+oBvwbctrJrz/eehWiewh/CkSH7+qaZ7JuFpc3mmz9AA+YlsVatvhe3MZyIN8s+dvUZH5t48uzc0/xFTcC/RMX1t8a6eNdCi4du6Qc+g+yizH/DkeBpEBhmXgd2cmc08Xjmpnm/ZpremyGQD4ZLzuKmm55znu7tHKq9/OzTcfCEy++CbvSVXemGoASnmVI3xqWTkXohPDdJrE2Ah8weApQLx7rydGkRz5rJlUQHdY6rUurhJqPK6zHXMHXiAKjSGi5kirRqca4anFoV1Uks4qFlkR/nL7IewFjQZoVNXz+vHr6SV5gTZ6sAp7MNB2D6AuInkLk7xbb4CXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=775pDYEiZd/aNKZTnpTLvDccXt+O7E17G8bTpDz4P7A=;
 b=tIGoVilxtbOZt/ZmQuQeqVUTecD10+J3wv6xJvPVsOsaEigtuHqkr1xIKr6CWA60amvsoXv9OH6B+uGl06U/Pi4PP76O7paqsiYh6Ks3OQd0Wd5cpPVX5p9wv0VuirkMRYLp8T0AQoIAfxk7ForBkWi2REDuWKGq5U2D+xtUGYA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Mon, 16 Mar
 2020 23:59:51 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Mon, 16 Mar 2020
 23:59:50 +0000
Subject: Re: [PATCH v5 1/3] perf vendor events amd: restrict model detection
 for zen1 based processors
To:     Vijay Thakkar <vijaythakkar@me.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20200316225238.150154-1-vijaythakkar@me.com>
 <20200316225238.150154-2-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <b2deb965-7274-8b6f-08b7-1a93e4a2e4df@amd.com>
Date:   Mon, 16 Mar 2020 18:59:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200316225238.150154-2-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0097.namprd12.prod.outlook.com
 (2603:10b6:802:21::32) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.136.247] (165.204.77.1) by SN1PR12CA0097.namprd12.prod.outlook.com (2603:10b6:802:21::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Mon, 16 Mar 2020 23:59:49 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 04c3db4c-41fc-48ea-0ca4-08d7ca061d49
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:|SN6PR12MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB278420FC14BAA06E05DDEC7F87F90@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(199004)(2616005)(4326008)(956004)(26005)(5660300002)(6486002)(2906002)(16526019)(6666004)(186003)(4744005)(44832011)(36756003)(81166006)(66476007)(66556008)(81156014)(66946007)(52116002)(8676002)(110136005)(54906003)(316002)(31686004)(53546011)(31696002)(16576012)(86362001)(7416002)(478600001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2784;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dy6VW9fre1nl1ZC/8oYj4uxxR7aYZsGQ6PLCHnwwRU2D7VAs7J1QUPBVNA8v+64SuGcO8bgjpapkLYuBGmDX2IWlBNq0RUnCp3rU410XFGadT+kx5BUoJGqBeCRDMAjK/z5FTAimseZtng/dlvkoQ3F8TAbHGsJatGJvCftQWZVl9a1p788z2jSpzAXaBTbwKKb8EuVv621GZqBZByqV9FWsrnC4GIeZvi+fGHw2lgMDwLXu2dkMw9qlQtUTPlhLiCBhW7jSE3HwA39bORNwbauDg+MaqSIYQyl8zxPZlIi65rvjvOpEQodg+glCYFJsFh6ClyV44S2algC62N4Wwb21sFy/tR/wdI/vKQZIVd7a77UdkphgQNlABFKMzJ5zaChsXMsX6UjL+8z7LoyVwiuliG/yj4OMMIrJq98YaePopL74U8uQuDEdCfvJl/v1
X-MS-Exchange-AntiSpam-MessageData: 9jGvb1DWgIClmEkbx9I4e2bo4MTpzg7wN9lw+5UfIzf004d2x0XPEfLncBL8nHQ/6RwRjcDtr96QTxSAlYKLSGix7N9UlMc1okmfjBAEhtU3B+wrMy5YgqpHhDv1SgYyJZ50CliRoF0qnrGIKOA9wA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c3db4c-41fc-48ea-0ca4-08d7ca061d49
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 23:59:50.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK0oQji4biuzIiBDAmHC7zcqStkzLmhQ/L8bSHLT6MYVY4XpBCkweLn2TFBb1baPeVrDOo7Lc6Jzi8mpET/rBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/20 5:52 PM, Vijay Thakkar wrote:
> This patch changes the previous blanket detection of AMD Family 17h
> processors to be more specific to Zen1 core based products only by
> replacing model detection regex pattern [[:xdigit:]]+ with
> ([12][0-9A-F]|[0-9A-F]), restricting to models 0 though 2f only.
> 
> This change is required to allow for the addition of separate PMU events
> for Zen2 core based models in the following patches as those belong to family
> 17h but have different PMCs. Current PMU events directory has also been
> renamed to "amdzen1" from "amdfam17h" to reflect this specificity.
> 
> Note that although this change does not break PMU counters for existing
> zen1 based systems, it does disable the current set of counters for zen2
> based systems. Counters for zen2 have been added in the following
> patches in this patchset.
> 
> Signed-off-by: Vijay Thakkar <vijaythakkar@me.com>

For the series:

Acked-by: Kim Phillips <kim.phillips@amd.com>

Thanks,

Kim
