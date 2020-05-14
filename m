Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45032065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EtPto8qF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgENTFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:05:30 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:29132
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728953AbgENTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:05:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7vnrZXlXYnHcUwF9PSSa0Yr7Mn0blk/l4UfuzOQTo0gX+pRzQADFCSBUhomtyyPcWfhDWqriMM8KWOiA1LDrGW1JMi2gsLv0PyUGqIHtQelRCJ3mLCtX1UzpR25XVOs7bhwiUNA/xrJBGglpiOQEvZRTP7wbLgo+U+vXphRJWlZMVbL3I37wByUZWYQrMbnbk8sliYibeZwcX0d/4va7hYeQSFyMzxsGtZndpSGfEUFPk528oWiklbLBAt/0JMuSYkSrqgz/68OiwqZUy0pbKPG8eKIm1fX1QbYcIzD83+W8XFcdRDhMMWFb+xnte+eYGTot4R4kR5paSZ8/kw8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QjDFZFHNb0TxSLOGfqkEGjnNHTAmh662GGC/C8cC6s=;
 b=YCbYLc+a96ulqUCp/kOsndI5APLLs3ow048mlBXLhb1YNWAupp2LIdH8RWu5a+WO4IfQXE3QpGsbHRY/TmG40gTHWyvTfYKJrFts+ih1GOLk1SUmV+Ejg9pe73GY6d4Pm3VD2qLL5eDlGH9D8/SgCGKOwL1HuOVr1qZKCOYy7OxoRq6gsBD2I4n7VbHPhmw7kdXD9qG++VO+FLV7K5LdJVjBAG+/0NLmuJNvnnfAFam6SMhghxZ3NeRF2BvGlFdp1CG0jZ4TeC3RqAlJOg1ehs6ZVAX8gpi+ZQrGu8JSjcNByQp9uPkfJIgxrpYQFplQU7XVpO3xRuQyjsBSb8Mdcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QjDFZFHNb0TxSLOGfqkEGjnNHTAmh662GGC/C8cC6s=;
 b=EtPto8qFRonhT+FiltZJq9ANdJxz0fF90w2ieFsRS8h/O2dSJnrcElMKK2Fo5D0OJJrrifKv8jB2L66VmaIFbPknu7Y8EAkUG8ReZahTPkw5LX7qjkVtWCyqq+AD+F5eCIioKL6433OTbIDeN1QuhUTZmvRwLI4Zz/Q1GcWRhMI=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 19:05:20 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 19:05:20 +0000
Subject: RE: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings
 terminated by newline
To:     Reinette Chatre <reinette.chatre@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>
Cc:     "kuo-lang.tseng@intel.com" <kuo-lang.tseng@intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1588808537.git.reinette.chatre@intel.com>
 <a99e4de3dc3f0e60281de1274ccb064071200fd9.1588808538.git.reinette.chatre@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <9c7a011c-2946-102c-5cdd-9dc5155533ec@amd.com>
Date:   Thu, 14 May 2020 14:05:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <a99e4de3dc3f0e60281de1274ccb064071200fd9.1588808538.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN6PR2101CA0006.namprd21.prod.outlook.com (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.2 via Frontend Transport; Thu, 14 May 2020 19:05:19 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c343a381-3856-4313-d88f-08d7f839bf6f
X-MS-TrafficTypeDiagnostic: SN1PR12MB2560:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2560FAC92336AE2BDB0B1E5795BC0@SN1PR12MB2560.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52Yz8VuW2wZQ8o+a7A76GUy8KKVBU0fjprOT8bf1n5LNksbEdIDvMI5oje4aJzdLiaxbu7r2wFa76nGXxd8lRbKdAbctSuYByyrBdnTJE37xIad93MR4FMU7XgpkX1zo6hrnHXhGb27RfkbXRY8K+Krg+MVFgsoLIjousrH2B3keOKiDxlFuMKJMjlf5yRT967eS5MWPFiRlGUbSL+DsKFTM9NEbw3ev6EIAT2jNRjbPu4toDFFc3plBu7M92RAKCK0GPmaL4uuDkg1L/6VI0g0XaiBnxqDmOyf7QPtSLplCGZDYJfdBbP8ZDcMA8ch1JNUWtD7URhIGyX+H7PhGtnc67Vk+hlWWzoDj6FRpirIFICT+Ky5y5KXclQOifwWwHZSi3C6zubjlgpjSXp2YA8tlI7B67SHOGZKY7CqueKAqwyz92YwIRXKDOcnkmLWPzf+dsURcVzkUpFTSNHABPxOPcRY4blzek6dmv+BdYfCL2YfIbfUqytsRrS/iDts3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(54906003)(6486002)(16526019)(26005)(186003)(7416002)(53546011)(16576012)(52116002)(956004)(2616005)(4326008)(36756003)(8936002)(110136005)(316002)(66946007)(31696002)(8676002)(66476007)(86362001)(5660300002)(66556008)(478600001)(31686004)(2906002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 859SArr+cNdh6YxaFTE1fBfwLNvJ7BNDpnpXX3cZ76CGhrI+emwalkXGWUMa+5HKaxPR3yWaqdNtcc2hTPV+FR2tk/ClI8IYKBAhGR797CvHDsj/bWmS6I5t/d+08220xgMtjMnRSEHpLdLUIVTbcI8X2XD9hpb5dnZKJMqiEpqzAA+TYmL+QymmgsY6TA3WjiKVQaJjtynC3PlzIjwGwI44H/moRgcMrx2dLx91rxEjlFOYSspgfYLaE1KkiVMQ9frFaN4EzftlvE/ol5U1M6UsErkiOOmAb2BJr5rtWrL3vdUjfZQyKCHes/afSOLAT34n6ukvslW5To6yUcOi8eFxq7T+KiLS8e96QHScvrVq7goENLHvi4dWDMAv/3OzbRTPsAt0WsQXvo+eegG53Wh+9Pb4ZPH7JLtdNWX5EML3TYw23sVyhNVQwdtgKz6yOkk7exowzwvNMvCwJfTWWJT75XEfnxSF+1tjkfX/TPc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c343a381-3856-4313-d88f-08d7f839bf6f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 19:05:20.6695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HWcxTBp9lKlFS6e8aCJ/ebOIHyfT8T+N5z2YUgShBuQbAck0IGsJvMIC5DbkzCE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2560
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
> linux-kernel@vger.kernel.org; Reinette Chatre <reinette.chatre@intel.com>;
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Subject: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings terminated
> by newline
> 
> The user input to files in the resctrl filesystem are expected to be
> terminated with a newline. Testing the user input includes a test for
> the presence of a newline and then replacing the newline with NUL
> byte followed by comparison using strcmp().
> 
> sysfs_streq() exists to test if strings are equal, treating both NUL and
> newline-then-NUL as equivalent string terminations. Even more,
> sysfs_match_string() exists to match a given string in an array using
> sysfs_streq().
> 
> Replace existing strcmp() comparisons of strings that are terminated
> with a newline with more appropriate sysfs_streq() via the
> sysfs_match_string() API that can perform the match across the different
> mode strings that are already maintained in an array.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 32 ++++++++++++++------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index c60a3b307f7d..e70694892c02 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1408,12 +1408,11 @@ static ssize_t rdtgroup_mode_write(struct
> kernfs_open_file *of,
>  {
>  	struct rdtgroup *rdtgrp;
>  	enum rdtgrp_mode mode;
> -	int ret = 0;
> +	int user_m;
> +	int ret;

This is bit confusing here. Mode and user_m should have been of same type.
You can define user_m to user_mode to be very clear.

You can completely remove "mode" and directly use rdtgrp->mode instead. It
is left to you.

> > -	/* Valid input requires a trailing newline */
> -	if (nbytes == 0 || buf[nbytes - 1] != '\n')
> +	if (nbytes == 0)
>  		return -EINVAL;
> -	buf[nbytes - 1] = '\0';
> 
>  	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>  	if (!rdtgrp) {
> @@ -1425,11 +1424,17 @@ static ssize_t rdtgroup_mode_write(struct
> kernfs_open_file *of,
> 
>  	mode = rdtgrp->mode;
> 
> -	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
> -	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
> -	    (!strcmp(buf, "pseudo-locksetup") &&
> -	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
> -	    (!strcmp(buf, "pseudo-locked") && mode ==
> RDT_MODE_PSEUDO_LOCKED))
> +	ret = sysfs_match_string(rdt_mode_str, buf);
> +	if (ret < 0) {
> +		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> +		goto out;
> +	}
> +
> +	user_m = ret;
> +	ret = 0;
> +
> +	/* Do nothing and return success if user asks for current mode */
> +	if (user_m == mode)
>  		goto out;
> 
>  	if (mode == RDT_MODE_PSEUDO_LOCKED) {
> @@ -1438,14 +1443,14 @@ static ssize_t rdtgroup_mode_write(struct
> kernfs_open_file *of,
>  		goto out;
>  	}
> 
> -	if (!strcmp(buf, "shareable")) {
> +	if (user_m == RDT_MODE_SHAREABLE) {
>  		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
>  			ret = rdtgroup_locksetup_exit(rdtgrp);
>  			if (ret)
>  				goto out;
>  		}
>  		rdtgrp->mode = RDT_MODE_SHAREABLE;
> -	} else if (!strcmp(buf, "exclusive")) {
> +	} else if (user_m == RDT_MODE_EXCLUSIVE) {
>  		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
>  			ret = -EINVAL;
>  			goto out;
> @@ -1456,14 +1461,11 @@ static ssize_t rdtgroup_mode_write(struct
> kernfs_open_file *of,
>  				goto out;
>  		}
>  		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
> -	} else if (!strcmp(buf, "pseudo-locksetup")) {
> +	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
>  		ret = rdtgroup_locksetup_enter(rdtgrp);
>  		if (ret)
>  			goto out;
>  		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
> -	} else {
> -		rdt_last_cmd_puts("Unknown or unsupported mode\n");
> -		ret = -EINVAL;
>  	}
> 
>  out:
> --
> 2.21.0

