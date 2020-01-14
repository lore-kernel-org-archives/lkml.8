Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BDA6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3A8222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CZZO+7Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgANXPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:15:21 -0500
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:6188
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728757AbgANXPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:15:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdOsD9PUiZDknblHaZwKfPgoX6v8EG2/rJ3iRdT37YLhRnTB7c67HatZlxnBUupbK6DR+o8eHSc3NtaJmN5Ypw2dMRtsOavNT3o8+4eUCymGQCPxxBe/AuLtPiAFUADFYa0mw4YSdcXYaNs7ViZj23pd/ZItciGsWvM56Z9nWbxSKZbF0GuV2xm6iIDRLWUydu+1Dv4mFZda2qPElndE0eaqQeo934q2NrjioukKCtyp6JGVx8EXKOffGtK3aFqESkrpwC2fP4Z+DnC56M4w9whiv9D009qdtEVz2GH8laRRf2kKM/lEWQAywOtRSnwHSpWV9YBge29UtDI0T2SLRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RksPSmfCm0huhsLj4o4pWA1Y/kCHWr8dhcDEU0/h4Fc=;
 b=aF6PyP0apMTn2XZo7crJWhtWx6FYjZnGgKf0e49VmKtQ5clVfgFCZ8k/lSS8xLy3ZbT/C8Rcu0etVYvv0pEWm/s85hbsQjU60rhB9HVtUJ5t0lNTWy/esJr11E0fTeiMpg8vl50NbUNE9OPtxIbiErAVbK38GMPJifBUFrW/25NC2qmMMqFruolK7BPGYPOedgCzqyjmjbMVZ2mJtuZYQkJAbv7599PCXWNW8jSk2E0P02OG9EBYTZphoocBj/XDUc3C0Rq2ay3LHO39mqKh/iQvIHP87AULMdYUq+Be5VbDbr6oMEqjOpz+Eu7oPHxrq7ijHj6bRbmdaClHqrPOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RksPSmfCm0huhsLj4o4pWA1Y/kCHWr8dhcDEU0/h4Fc=;
 b=CZZO+7Mt5sHsy68obI3RWOcVMgcI0tGXYqp2nOFPQsQXB7Y2yTSBmhjqBPPu4d0vTudtOTKGMgd3aD2xqHgJnbOx1NFVJU8AMi784cCgfx8/OUPuEhHExgQMhwrlx1ViIiRDlN8JFrwhPZEjpmUMt1Fi8joPHeN0drJ4uda0w1g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2749.namprd12.prod.outlook.com (52.135.102.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 23:15:05 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 23:15:05 +0000
Subject: Re: [PATCH 2/3] perf vendor events amd: add Zen2 events
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
References: <20191227125536.1091387-1-vijaythakkar@me.com>
 <20191227125536.1091387-3-vijaythakkar@me.com>
From:   Kim Phillips <kim.phillips@amd.com>
Message-ID: <e6ecb0ce-fdee-1458-616d-5e1927a7255c@amd.com>
Date:   Tue, 14 Jan 2020 17:15:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20191227125536.1091387-3-vijaythakkar@me.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0049.namprd16.prod.outlook.com
 (2603:10b6:805:ca::26) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from [10.236.136.247] (165.204.77.1) by SN6PR16CA0049.namprd16.prod.outlook.com (2603:10b6:805:ca::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend Transport; Tue, 14 Jan 2020 23:15:04 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d387aedf-2732-4476-b24e-08d7994796f8
X-MS-TrafficTypeDiagnostic: SN6PR12MB2749:|SN6PR12MB2749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB274912ECD17A26B706945B3B87340@SN6PR12MB2749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(189003)(199004)(36756003)(86362001)(54906003)(31696002)(478600001)(7416002)(6486002)(2906002)(956004)(2616005)(316002)(16576012)(5660300002)(19627235002)(110136005)(31686004)(26005)(16526019)(44832011)(81166006)(4326008)(53546011)(8936002)(66946007)(52116002)(8676002)(66476007)(81156014)(186003)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2749;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3xP7xol/XHoDK/tWKDnkG6m42KvKSpMeumO9FGSM2tg1zfYAWytkbqS4QVFz0pfIKskPMoG2/jUQjLK4N9cbuspqMI/tKBYKp4QZCWA/2AOTE8f0hqHy7F4YKNElR6VCit+v1/eln1cTgtvN6EJQZag3QdGT4XE+G3IRbTu3gjAOguVNObGG9KBmIgVs7KWmwTHkmG8vLlZeaC4t+fYooVi2WYT09RDPkU87VVm6mbRfg8gcGtpormKJClMgyF0PJlhMjPwRzSnF1efPcnx/wF8H0forOYazUB+6cBV1bFiFB1FN/IGr8uGCOOt+yj/2Zyp3jaFkGkvSeQoTHJmNAhIJvWarolw9B6sclDfk+bBXkwb76d8k9E6bNUCsrEvCFer7s5189Nrrha/o6gNU8PPXagjbfms8Jr+XDsWsx5KyWpZh7mV9V7RUeWr6Dwv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d387aedf-2732-4476-b24e-08d7994796f8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 23:15:05.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V9/HlmXtx9sz/YfcdTzTh24Uh2pmSWPCh85u4LknSXGB3vN+bCQAFGAecVOaGJlACY8Dr70S8g/djW+EmEEiYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/19 6:55 AM, Vijay Thakkar wrote:
> This patch adds PMU events for AMD Zen2 core based processors, namely,
> Matisse (model 71h), Castle Peak (model 31h) and Rome (model 2xh), as
> documented in the AMD Processor Programming Reference for Matisse [1].
> Zen2 adds some additional counters that are not present in Zen1 and
> events for them have been added in this patch. Some counters have also
> been removed for Zen2 thatwere previously present in Zen1 and have been
> confirmed to always sample zero on zen2. These added/removed counters
> have been omitted for brevity.

I'd like to see the list, if at all possible.

> Note that PPR for Zen2 [1] does not include some counters that were
> documented in the PPR for Zen1 based processors [2]. After having tested
> these counters, some of them that still work for zen2 systems have been
> preserved in the events for zen2. The counters that are omitted in [1]
> but are still measurable and non-zero on zen2 (tested on a Ryzen 3900X
> system) are the following:
> 
> PMC 0x000 fpu_pipe_assignment.{total|total0|total1|total2|total3}
> PMC 0x004 fp_num_mov_elim_scal_op.*
> PMC 0x046 ls_tablewalker.*
> PMC 0x062 l2_latency.l2_cycles_waiting_on_fills
> PMC 0x063 l2_wcb_req.*
> PMC 0x06D l2_fill_pending.l2_fill_busy
> PMC 0x080 ic_fw32
> PMC 0x081 ic_fw32_miss
> PMC 0x086 bp_snp_re_sync
> PMC 0x087 ic_fetch_stall.*
> PMC 0x08C ic_cache_inval.*
> PMC 0x099 bp_tlb_rel
> PMC 0x0C7 ex_ret_brn_resync
> PMC 0x28A ic_oc_mode_switch.*
> L3PMC 0x001 l3_request_g1.*
> L3PMC 0x006 l3_comb_clstr_state.*

How do you know there aren't others, given your workload just may have not triggered some?  This is why ultimately I'd like to use the AMD-sanctioned events from the PPRs.

> +  {
> +    "EventName": "bp_dyn_ind_pred",
> +    "EventCode": "0x8e",
> +    "BriefDescription": "Dynamic Indirect Predictions.",
> +    "PublicDescription": "Indirect Branch Prediction for potential multi-target branch (speculative)."
> +  },
> +  {
> +    "EventName": "bp_de_redirect",
> +    "EventCode": "0x91",
> +    "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
> +  },

So at first glance of this patch, I'm seeing at least these last two events present in these PPRs:

54945_3.03_ppr_ZP_B2_pub
55570-B1_3.14_ppr_B1_pub
55803_0.54-PUB
56176_ppr_Family_17h_Model_71h_B0_pub_Rev_3.06

and when testing the events on my zen1 system, sure enough, they return non-zero values.

So do we need to correct the zen1 events first?

Thanks,

Kim
