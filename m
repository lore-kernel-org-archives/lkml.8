Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B819C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1BE20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="CBfcL+vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgERR36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:29:58 -0400
Received: from mail-bn8nam12on2041.outbound.protection.outlook.com ([40.107.237.41]:6220
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbgERR35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:29:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhLh68JaLHckSy4ljZfU33zew7mzWFEMafMFwLKjocmm1xNfNvR50rnpkntnIDbvMLyJsoEXdCX5GrVLwl/z4sgrhXJvQRlcpWul6uFWS1P7GHJ2idvSOh3zBEuNbib7oxdxzu0soHt2LHAqIX8Ek02eYPVGbye/nd5FAKQzFy+/DCnHwnvhuxkNXswJyzq7i9pOkEoZ2UrMtY8vj2KzZYKHs8fJxQtU3BeMnJEWMKqI1HRnEzju7lziPUwtYQ0lG3iiGHAacSAibpz1RW8XkP6OFoR3VrFYv+BDZV1UJWuE62DuuhOegM/5/8O/LQhm4ArvJsLoa9tet9XPgi7V0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyxZFiHY41Ifzj1PJCIVuh0Bwj9TITYti46itpP/pCw=;
 b=a8x2Gcmpg6vllmoOXiEX3qvfTgfsN5Bh3ctnY0k9am8Dc6/okUhUBlDev7XaYS5F8hA/r5zpSlvf13EtWqUPxwZxAdrKe4TOFrwxPEnwqEntg9ZzN7v2kJombsnlVdE4L9cKdJe/tg2gOHeyehEkn3xxBXaqkKbFNqkVIkHtMtL9h+xYXRiKrLpHEFsY0MqLl6a8aiXPcqfgis5KmK5YQqfCaqZzF8240LAnu0DCKpytCxS5s1kl2NHNrwVZjJs8yZCg2i5tKTxOYM0rem99jAK8//w+AswABk1M4vDG8t+wOk2hbnbLQ0LS1BetIU1VVAIPRRcpUbg7uwwLOPUfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyxZFiHY41Ifzj1PJCIVuh0Bwj9TITYti46itpP/pCw=;
 b=CBfcL+vupI86d33s3rrfo4QsMwhpV8tT5k+d8SS7ktcRXi5GHJBe6Uu224TnLv13f/dBj/ptJgmN1pV/ewKq2g5+HdAwZ47IN5W46gxKJk/1bRx1sixnJjzENRKtR+fUtuTL2/8aIBwyjWS1CiWwjvDn+DAxxVirJwKnXwFVycU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Mon, 18 May
 2020 17:29:54 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 17:29:54 +0000
Subject: RE: [PATCH V4 3/4] x86/resctrl: Enable per-thread MBA
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1589652468.git.reinette.chatre@intel.com>
 <9e3af503848d515140ac10fab56067b356685f25.1589652468.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <2ed07697-06b5-60be-97f7-7e0338f949d2@amd.com>
Date:   Mon, 18 May 2020 12:29:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <9e3af503848d515140ac10fab56067b356685f25.1589652468.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:3:37::34) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR06CA0072.namprd06.prod.outlook.com (2603:10b6:3:37::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Mon, 18 May 2020 17:29:52 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f23f334-8444-4a12-a165-08d7fb5113d0
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2511CF4E85FFCC560248528795B80@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04073E895A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNA6BVNTaUTSEfyHjPMUauwpID52CJQGM803dlgt8470H3hE/8eap0HOm4h+M/tm5Ek6h8/JsP1IIaOnBQeBNXyAbaGaObYmX1v/bKBD9FzKLpWUXCfW04pabLFFXEJkeFDeSzlx1x+OE/CVgcsu2P/sFs4z5XzOD/ssWTXWb6/NB7Xt2KcWaR7fSAOejPwMUSMzhSSZlaU+uV6LMH5A/4hgoJ6vCNUT1/W3RiufSDKo/cZOphLG8tPXETT32znlaJj+tX4wBgg3wKCZ7B0YK6qMle7C69heIbgnfYN0Z6T1q6DciTbGaF44HiwcA5kjXHBGM6CA/KpDE+fJ1ScUltGQLRftfjc4YzX6kfmWM2zbMnPgWCAyHZ2SIJ/Sibah0/ufUr8njxk6V4zy75sHFzQM6poeJ9CFUen2Xx4FhZuiHa5WHdECeV7QdOp30oOmkPru/8bMU/1wxkfNBt9KJklyrtEdzIlZTGOSwYkxj8arrqjAAilWY297AmvCao+1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(316002)(66476007)(66556008)(956004)(2616005)(16576012)(86362001)(54906003)(7416002)(31696002)(186003)(16526019)(8676002)(5660300002)(26005)(4326008)(2906002)(110136005)(31686004)(52116002)(66946007)(8936002)(478600001)(6486002)(36756003)(53546011)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bHPu6Oend8e9+yRHbZa2aus6a5a5JM1SX9uMPz6HCf2PezV2fa5WalS0iliclsmzxXsrD36XICbenEstVl1zOihR+2qx2Oj4n9OL+PIS9Xi8XH+LQBpXCQXPL+ilp5EquD2VuBvvnVjOGKIsnCdsxgRC5ktMKHHeQKDvYfDnTFerh31QIVzyd7l3oSy2bedINWi2eXJIknwlYZaq9u+lImBw3e7qG6m/YhgMxCp7EfwQi3xOynIPzz2L4wYxOeZNI3Azl8NPiNtRcsHeaxJrJt1thHns62VfdLeafZFZfbF1MoFQvaq4htGUbWAYOJkgQB5NF1N/K8Ga8fcaIOCsFOXSTinYJO4zn0HbQu6efrcWNK5K5Wq5wRx3ynaaOG+cQaIOJjbommDc1N+5512eFE5X1LOpxNu11/Djo18ZBJ0LPRkf4hVV+UJu2bpFdEPlcqa09BOtym1+hWc/sI94SOJYLsJicUaLFtzA6qy1w/o=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f23f334-8444-4a12-a165-08d7fb5113d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2020 17:29:54.1995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozblSIoa91ld9gq5f4g5YyQnG98SCy5/gghY3PNiQrWn2G2W1rap5o0zOwGWV+Ko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Saturday, May 16, 2020 1:29 PM
> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH V4 3/4] x86/resctrl: Enable per-thread MBA
> 
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Current Memory Bandwidth Allocation (MBA) hardware has a limitation:
> all threads on the same core must have the same delay value. If there
> are different delay values across threads on one core, the original
> MBA implementation allocates the max delay value to the core and an
> updated implementation allocates either min or max delay value specified
> by a configuration MSR across threads on the core.
> 
> Newer systems support per-thread MBA such that each thread is allocated
> with its own delay value.
> 
> If per-thread MBA is supported, report "per-thread" in resctrl file
> "info/MB/thread_throttle_mode" to let user applications know memory
> bandwidth is allocated per thread and help them fine tune MBA on thread
> level.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> [reinette: transition patch to use membw_throttle_mode enum]
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
> Changes since V3:
> - Use new thread throttling mode property.
> - Remove unnecessary empty line. (Babu)
> 
>  Documentation/x86/resctrl_ui.rst       |  3 +++
>  arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++-
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>  4 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/resctrl_ui.rst
> b/Documentation/x86/resctrl_ui.rst
> index 861ee2816470..1b066d1aafad 100644
> --- a/Documentation/x86/resctrl_ui.rst
> +++ b/Documentation/x86/resctrl_ui.rst
> @@ -150,6 +150,9 @@ with respect to allocation:
>  		"max":
>  			the smallest percentage is applied
>  			to all threads
> +		"per-thread":
> +			bandwidth percentages are directly applied to
> +			the threads running on the core
> 
>  If RDT monitoring is available there will be an "L3_MON" directory
>  with the following files:
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index 129ff0cec7a7..bf1ff07efac8 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -309,7 +309,10 @@ static bool __get_mem_config_intel(struct
> rdt_resource *r)
>  	}
>  	r->data_width = 3;
> 
> -	if (mba_cfg_supports_min_max_intel()) {
> +	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
> +		r->membw.arch_throttle_mode =
> THREAD_THROTTLE_PER_THREAD;
> +		thread_throttle_mode_init_ro();
> +	} else if (mba_cfg_supports_min_max_intel()) {
>  		r->membw.arch_throttle_mode =
> THREAD_THROTTLE_MIN_MAX;
>  		thread_throttle_mode_init_rw();
>  	} else {
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 6b9b21d67c9b..e198ea2a8468 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -391,11 +391,13 @@ struct rdt_cache {
>   * @THREAD_THROTTLE_MAX_ONLY:	Memory bandwidth is throttled at the
> core
>   *				always using smallest bandwidth percentage
>   *				assigned to threads, aka "max throttling"
> + * @THREAD_THROTTLE_PER_THREAD:	Memory bandwidth is throttled
> at the thread
>   */
>  enum membw_throttle_mode {
>  	THREAD_THROTTLE_UNDEFINED = 0,
>  	THREAD_THROTTLE_MIN_MAX,
>  	THREAD_THROTTLE_MAX_ONLY,
> +	THREAD_THROTTLE_PER_THREAD,
>  };
> 
>  /**
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3ce6319b7226..088a1536bccc 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1038,6 +1038,11 @@ static int max_threshold_occ_show(struct
> kernfs_open_file *of,
>   * with the maximum delay value that from the software interface will be
>   * the minimum of the bandwidth percentages assigned to the hardware threads
>   * sharing the core.
> + *
> + * Some systems (identified by X86_FEATURE_PER_THREAD_MBA enumerated
> via CPUID)
> + * support per-thread MBA. On these systems hardware doesn't apply the
> minimum
> + * or maximum delay value to all threads in a core. Instead, a thread is
> + * allocated with the delay value that is assigned to the thread.
>   */
>  static int rdt_thread_throttle_mode_show(struct kernfs_open_file *of,
>  					 struct seq_file *seq, void *v)
> @@ -1047,12 +1052,18 @@ static int rdt_thread_throttle_mode_show(struct
> kernfs_open_file *of,
> 
>  	mutex_lock(&rdtgroup_mutex);
> 
> +	if (r->membw.arch_throttle_mode ==
> THREAD_THROTTLE_PER_THREAD) {
> +		seq_puts(seq, "per-thread\n");
> +		goto out;
> +	}
> +
>  	if (r->membw.arch_throttle_mode == THREAD_THROTTLE_MIN_MAX)
>  		throttle_mode = mba_cfg_msr &
> MBA_THROTTLE_MODE_MASK;
> 
>  	seq_puts(seq,
>  		 throttle_mode == MBA_THROTTLE_MODE_MIN ? "min\n" :
> "max\n");
> 
> +out:
>  	mutex_unlock(&rdtgroup_mutex);
>  	return 0;
>  }
> --
> 2.21.0

