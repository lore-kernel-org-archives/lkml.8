Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAE0C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8796B206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CggetlT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgIAWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:10:55 -0400
Received: from mail-mw2nam10on2070.outbound.protection.outlook.com ([40.107.94.70]:18048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgIAWKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhwJHgHfDML2twPOe7xRPRxGlwGb2RsewotiZKwM3IUwXbEsECcYJLZ17kAtuccx3UG8NziUDkiyFK6WOgsYuaMq31XUuRDfZ8gfKCBwtQgxsVUw0coIW8DP522G9MeoPEJXACMirmdGqvznfgRjZR0wkTCEtKv9tLmwBQ1bsIFBX2FdpMAV69kaIcOJPuCnFdKArOi9eElgl8xjq6D6L0gmDG6HIp5df6R5NvwgGzVI8H2jo+0Xjx0LeaA70X48mXo429og0mcgCxSYhmVWyiORTps5FO+mRb1USrBsOufDD2Js89jKZV8GsH1XeBj3dQzvXNMQcv9oQjAe0bOQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0NoC8/gBB/xQ570+ZBiq3NbPqKHa973HkW9UHs+/6c=;
 b=I0ilMAeH9YLYxj26P+XDcO/q4DbXfy7owHN7AicRJnHpvI4NLgMQe80ikY+LcOUXjfhXCIiDhZ/4wHJ4iNU4wtbPTfFlZYm1R1rL0mV21RylzDq2FmwAzy+MbNaTsr5+EygV/oRZN/i3s/AEhBPoz7p+VEDwIzkZ+De46NJC2qs458J4aItlL3yNvbWIO4+5V4xu4fjtqHCwRuX0rTMjnUy7sZsXk5N2ZVu5ceWHsEdGO8R1QgEQpRiNapWTaSweItvgeKa/VvHpjihty0glxBitlCSR//hWDhNG+W65gvLMHTtBr2aY48rS54b7EWYOMoxkdbOSOsyjbuI/wZFinw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0NoC8/gBB/xQ570+ZBiq3NbPqKHa973HkW9UHs+/6c=;
 b=CggetlT8l/bt2KilfTL+5E8bKz/rf2AjPTfjSjPw4Oa2tBLEIRTo1wk1vlgpLEECZY8BiEaYwMyAra51ws+T4kHQ/jl73QGrxKNlFworNsDuTBvLVQmVgPs9bNhCx7/R8L3L2iF/+lByDWdvwLZGQEkYiltw/0bevXj8UL/mGi0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2977.namprd12.prod.outlook.com (2603:10b6:408:4a::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Tue, 1 Sep
 2020 22:10:45 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 22:10:45 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] perf vendor events amd: Enable Family 19h users by matching Zen2 events
Date:   Tue,  1 Sep 2020 17:09:44 -0500
Message-Id: <20200901220944.277505-4-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901220944.277505-1-kim.phillips@amd.com>
References: <20200901220944.277505-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM5PR04CA0067.namprd04.prod.outlook.com
 (2603:10b6:3:ef::29) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM5PR04CA0067.namprd04.prod.outlook.com (2603:10b6:3:ef::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 22:10:42 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe716732-9b03-4953-32b4-08d84ec3dfa5
X-MS-TrafficTypeDiagnostic: BN8PR12MB2977:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB297702685565BBD471A7A6E0872E0@BN8PR12MB2977.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlR9AdvxahVtmYgyN/ig8hJGeKotlSPxZGu34lzSbYLGWl083TUv8zlMtKW84hBPjXb+X72AfoiTjEuHbEVgPe7gFfOIdn81slU0aeiNTm7Ic4Ps/QRtE2J+UULO8+L5BS66ZC5Nxx85VCZfGdPBUal35YmGb4WU8pqdgUN5Yim9PrP4V/5gTZKad/gpStQGRXcJuhhTgVliGyRHlLX9CPsiHM0yl//zQbOJbBdgZyOnbX0X7L8ARrzzLicWQivuRbn6+VwSQ4Xj6GDtmLiewaWB56cXPmNHsJcl0klPP6zueWlNRy1Gvh5ZRXQuReVW7OjtYJHvMgaNGB0Stvl79w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(66946007)(66476007)(6486002)(44832011)(7416002)(4326008)(66556008)(2616005)(956004)(86362001)(1076003)(478600001)(8936002)(2906002)(8676002)(36756003)(186003)(52116002)(26005)(316002)(54906003)(16576012)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ooENbOiLWvfa2yNQGis8cdQU9TjXojbxCYtzR4rFE9lvQyPmtkWEUd/OOruyeqvJoojBVcfNTAcWwdrh9TBJ/yQfo49fPN502q/qHfI2PzuRcgcJpL/216gND6zQw6M/V8e/AGGdbreeZ13FoxUTiJJQEmSzA7KBImOseKKMZ1YyYwkVZtd7Sez9d2g8J+VGvtNhhoSz8Gnc78A5y2vKJfhOXnXJLt25rRjkUj5A++9US9lZlygzqivGVapGKL2jHlMYHQtXQMB26+uWZ5Tjce7mTcPwHiM3ehdvomB3EnLXIo2ICAg/JC1bNbFwIQW2TQlJtLtMuCaFgfFqAI8CBDCUhQGrjltyxrXpDW9ONdkBaJxjFqfVx9fZDBPOqUYK/aJkDsiD8jQFgZhbsV53YIgagWdXnGTXdIDbBdA1hwOj6X6qIUMs5nnE12y1WPyqURa36fH1iF43v4uHHQpD4Hbm29dcAvmDZKuH6uoznAzAWhJ3OSIigGjwwb+RqQyo8+SkTsNrhL8p1VVXYZZagTHWwUtV9ia1jWTTc5YXCah8khWijzKoptt7O0zopMV5HGp2EjXGfZd0qXJ4q7MIFR091KNYSjcZJff6LIiNUxcKL1Nf1dDwfTmd+dIXEP9iGMWDE9J6zVLxlkLgSNVaOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe716732-9b03-4953-32b4-08d84ec3dfa5
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 22:10:45.2329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yB3NNMke2iskAtG/IDD8NVCckaDeaiY96z6t+vHeUfYCCvboMxLeQg0owIgaW9NvazDPO2GPMQwqcerJq0gEFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables zen3 users by reusing mostly-compatible zen2 events
until the official public list of zen3 events is published in a
future PPR.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: "Martin Liška" <mliska@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Jambor <mjambor@suse.cz>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index 25b06cf98747..2f2a209e87e1 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -38,3 +38,4 @@ GenuineIntel-6-7E,v1,icelake,core
 GenuineIntel-6-86,v1,tremontx,core
 AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
+AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen2,core
-- 
2.27.0

