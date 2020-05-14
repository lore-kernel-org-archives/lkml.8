Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC666206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D1dXHp7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgENTEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:04:41 -0400
Received: from mail-bn8nam11on2056.outbound.protection.outlook.com ([40.107.236.56]:16937
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728705AbgENTEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeQjEqnNkxzr3wyOh7EdeptOZiRvEvJzTVO6IohgUJ/stKbS28a40SYX/R4mgFCjL71MUrhGfmea2K2Xsw9CxIdQkk9d2ex5g6Pk7RD0eV3X+03rPXjtHCKLSNawVIlAtbCH9jvPyOJCxjblF4KuQxyTA8Afvyeekyt84qUMJvS5AY+EdqdJunGj7iHNmfoh5ZowS7k2KjiphyvZXX6HcoEeUHSTCjWlLV/4hxk1oiXULEPswcZkJJYUcdTOjUO+poGuz7DJZZF2m7ohV7IdvaOF61LKTt0zesMUP9bBPQoBnXgjPVGCde/wtu285MNPZTnS3gdtm999fVms21Mspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CEM0MgnR368fsXBRn9ne6iu6K/5teEfzpwLf8j2Do4=;
 b=LdX+6MXrf6QUtCtcSaijxKnwuhZcDRdKUati7AvqZw4R7VJoYftmnWrf6Zr8sIyOvW6eGIn/1jBNpOAq2WpV3R9Gn+sASM/AaUYldcXF0v6xsuX2baiUfZ6spn0Li12BZ79qRv1Nzi7oLhh5dRWu7sPibalgG5OruFOklY5EmNA3Sp8BwPDDuXHV0/MJPkXtnsxF1iQt3iqrjpAdk5RX41hLh/DYFmr91Q3+3LhOEdmhLYOuX8dXXrYPzZtMFVDodou1vpxTjETOAT9GVTr2Zrdm3vjL/rZXzs4eJ8RNrm/ape0weZzwcB7NUXIO0C3rKDP0LeBg275534CKVI94CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CEM0MgnR368fsXBRn9ne6iu6K/5teEfzpwLf8j2Do4=;
 b=D1dXHp7RT47ds/FdnZCupJ607Q85xRoRIGEj+PXzMOcEXPr2s84NMy0VuSIc+XfyGNA/F+EwQ7iFdckVMsdp++97IMr6e1HagwtfBTRQjaPrPt4zvZvow7UacbDfQ/cLaI28rdllaUtn7QFzk7oYV2WfajE/BXQLjh3fTPaWmTs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 19:04:31 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 19:04:31 +0000
Subject: RE: [PATCH V3 3/4] x86/resctrl: Enable per-thread MBA
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
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <3510244af29b7443221dc926745fd0cf541576e0.1588808538.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <bb5b518c-2a10-1e0b-9c7d-29e58093a04a@amd.com>
Date:   Thu, 14 May 2020 14:04:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <3510244af29b7443221dc926745fd0cf541576e0.1588808538.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0020.namprd21.prod.outlook.com
 (2603:10b6:805:106::30) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN6PR2101CA0020.namprd21.prod.outlook.com (2603:10b6:805:106::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.5 via Frontend Transport; Thu, 14 May 2020 19:04:29 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cebce721-5469-4d1b-740c-08d7f839a243
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2350D9E80FB3464BC656E16395BC0@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UHggk2/3dYRGEzjL0lSXgAC8Iyj28Ns+3Igt1q6MV93Dcqb+0J+2BW/q4ymeUIvVFHgNLBP2x0CD3jYGYEtNdV55ziecBixcRZGDwaR482d6um5GE9atFhkMP4dh4qHPmFyB86wxtKBkKNtbuDugnh+1MYwjt0sU325itAJBLydoxfl1/3sCIc4fylGQZ2cjd8+ZaAFYo7WQOpEaXlix1NSa5UaP7JuUEUYTmtKuzaHcY1X3tL3wLNTiVH7n88tttzue0f5tJ+FMnIiS3q6clPWCn5pDHh+5LxSNEQRht4fSBolGgBFnebSbMHkBOWUpAwwPFm2vn/6k20K9mVecv4UpitSS5Hc3KPa1p3Jg4OpWtIuw0b49up0/JjdXVZj9nvSzKk0VCsM8cQgtQiuIz2y/lNrEzEBcu3lvlORWwDUZhMhW2NGFiIm4KTXk7VpQWdcFBAENo/eFLfxmHlg09SUMQ/gUygd6t2VJossY9S3ea7mBf4kwN6nsAYuqwTAj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(376002)(346002)(8936002)(86362001)(66476007)(8676002)(66556008)(31686004)(2906002)(478600001)(7416002)(44832011)(66946007)(31696002)(316002)(6486002)(53546011)(16526019)(186003)(956004)(36756003)(4326008)(54906003)(110136005)(2616005)(26005)(52116002)(5660300002)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BVuQGb8qqNHzamG1AYpldWSN6q2+deayxsUdOmwkyrxk2krC5jMpX/1VC6X1gq+bl9BxGL5yH6OuHkpKh6fipzldc7QiQz7/cFvUSGcxVxZI0kIJo4A7cwSQdAdjgAOr5iYkAelgYREBJtBkBlKGqBuKTzMwKhxGK/WoGF3Iz8oYAB2p+UnJmJBPJFimhzKxRMRJSLsZHaT1Ip+ueLBYG0+Mn/UXoe6Deq+sznQ3T/b+7qqeGy0hx5zVwDUh2/elqOhkUyDCZEm+kDYDn/5va1z39nDyzoI1m+XWxMVTp+kXMlR5FmfgToKlJZT3MR79dizFK1px7M41sOIsw3CIwaNdJMkq2KWRy7wYstCDxcuGOGdRwZAUq4m7byIqFL/gR+8YVXWsbU5BqEZm7SRstRVUsqdDHm59fqMsRd99HMkDM5e6SjIIZosw7im1ZPqUENdhpXGd4uB+E/RvfO8m/qJ/ZVPgseWW90p0srpHV6k=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebce721-5469-4d1b-740c-08d7f839a243
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 19:04:31.6837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n59xpoaGznRfy8eLZhzTv+xAZPKYAnKTm2KEWUxERKJ5SgOpvkE/QKslQejX9/Vr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Reinette Chatre <reinette.chatre@intel.com>
> Sent: Wednesday, May 6, 2020 6:50 PM
> To: tglx@linutronix.de; fenghua.yu@intel.com; bp@alien8.de;
> tony.luck@intel.com
> Cc: kuo-lang.tseng@intel.com; ravi.v.shankar@intel.com; mingo@redhat.com;
> Moger, Babu <Babu.Moger@amd.com>; hpa@zytor.com; x86@kernel.org;
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>
> Subject: [PATCH V3 3/4] x86/resctrl: Enable per-thread MBA
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
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Changes since V2:
> - Fix rST formatting of documentation (resctrl_ui.rst) describing
>   new "thread_throttle_mode" resctrl file.
> - Use boot_cpu_has() instead of static_cpu_has() when determining what
>   to display to user (slow path).
> 
>  Documentation/x86/resctrl_ui.rst       |  3 +++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>  2 files changed, 14 insertions(+)
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
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 6a9408060ac4..c60a3b307f7d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1038,12 +1038,23 @@ static int max_threshold_occ_show(struct
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
>  {
>  	unsigned int throttle_mode = 0;
> 
> +	if (boot_cpu_has(X86_FEATURE_PER_THREAD_MBA)) {
> +		seq_puts(seq, "per-thread\n");
> +
You probably don't need an extra line here.

> +		return 0;
> +	}
> +
>  	if (mba_cfg_supports_min_max_intel())
>  		throttle_mode = mba_cfg_msr &
> MBA_THROTTLE_MODE_MASK;
> 
> --
> 2.21.0

