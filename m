Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339BFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF4820727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KEsN/L2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOTP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:15:26 -0400
Received: from mail-bn7nam10on2053.outbound.protection.outlook.com ([40.107.92.53]:44961
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgEOTPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:15:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yb440DcR7pOnsXopwgjwbmbt9zrFGrhHUFV1y0XFfF7I3rongS5EnRlvnwFaiEl/wJRbkkXLbFKDOXQSFWQO+46hEG5ZRJyyoDGzz0eWDoSHUDL1qvFnOTip+tgOLgfqB48mEMwafl7cbWgqYf5SLs5zbxuQSCdCECB8gkmVlz3rBGeSe+vdWAMTljYiGdUMkoa+7dn0Rx34jugwBqcNUhXniOjhtYTSvmacCo2mc1JU6yzqKOK9wedpwiEEKCqohlB7xo6hHRj3zP9U9BrpoBUVj6Zz6IqaJjYKjKeLQIYS0Bx//AcXi1OUp2jor/Sconff4xhDrJa9tgs3X5zsKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exouybEMoG3evbeDpvh7v9yNp4uZMt0OVaTzaJG5DTs=;
 b=VutW+RH0QQEIolxHK5TMPn7tJcboujKnSf0p8QbXxwXDqgBfmSuRGT8N7dzkaPwUWVP5DUX8y4xnNxOB4Ms571Pq92uiq6owfQBkZSi0Y2Py3iO9vvgICPL4PZkc+GnDRPevhcg6zkDCD1/0I8az35OoZav1TcaizJ0KeY64nu85++o+k3Gsdrv+rFZ8XbXDluI2eJJZyuVaWBetNzWKsrfRKxy3fi5JhTIOV1GGoznes06AE131qPbAFvBvZlbLWJ1S0QhjMSGAVMoL7LKAOHeg2mi52HY5EN2OUADVOfEpZ9Vc9R+ph8vHe20gpldqs5N3HjLBNutTmrWDrVvONQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exouybEMoG3evbeDpvh7v9yNp4uZMt0OVaTzaJG5DTs=;
 b=KEsN/L2yScZzxRLdAHNArA29Qof58qe3LG5AEGQNaLnjRpK0I3mNNLBKrAa9/0w6wE+JiNjrkbc0vpRev5PJapU4oq+ynbuk3/dp9V1yABFmXSEz9iJECL+Mg+8/bwsFSMbCZZNTIYFoFRNi6ooqvunSrr6/1hXJILkUH2VQC5M=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2430.namprd12.prod.outlook.com (2603:10b6:802:30::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 19:15:22 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 19:15:22 +0000
Subject: RE: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
 explain AMD/Intel CAT difference
To:     James Morse <james.morse@arm.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200430170400.21501-1-james.morse@arm.com>
 <20200430170400.21501-10-james.morse@arm.com>
 <8383ddd9-5849-d948-c391-aeb0cc927423@intel.com>
 <980a693a-b823-96e1-9b4f-d7bbf4f09714@amd.com>
 <a16561f5-e8e9-7d23-e332-38c5cbdfcfc8@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <1cc88f7f-0f40-aa1d-1d8a-59cc8053e474@amd.com>
Date:   Fri, 15 May 2020 14:15:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <a16561f5-e8e9-7d23-e332-38c5cbdfcfc8@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0801CA0024.namprd08.prod.outlook.com
 (2603:10b6:803:29::34) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by SN4PR0801CA0024.namprd08.prod.outlook.com (2603:10b6:803:29::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Fri, 15 May 2020 19:15:21 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79ae5e46-1aa0-49bd-c442-08d7f9045078
X-MS-TrafficTypeDiagnostic: SN1PR12MB2430:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2430105B37B820838400517295BD0@SN1PR12MB2430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9oHL1hb0BCUOmiVi/eIVBSs/e2PwZ+NmQqOvCYVFQoJslv42tqgfVQEevCLQ8nik1fsZdYAMHxiivbdOMidsfYUlTzleljVcoK2MdteSdlkkb0SQimY7lITxK6uwz8ymn5z9fytzf6k4ERUYKYgDmRFSUEQLW6MzZ2fsCz4uQ8wNRUNheFQqOpcJyWaPZjb/cyNG5P7mqFagHnpdZ6SLhJmwStJo5fHkhoDLqR9qlf/6JiYTVWXfYXJ8a58ZlKQthBxs40EEA1U2jRk7iSOruuFasQ4jlhbl5WMwiB3UBYlIARotSut+P4zMv2ga6unrQTc2QgMvhVvLc7TsMDhCviCj/jGCLW1cHQ5G93T+3Az5sAAIHJWu7NMUTOVczCH3f8vKCnf+AafXCCXbWDSwos+nCQYZCVqNDEc4sM/gJkYAOErmcGGq93wYr5l6UQqc5xngFFv3e5pwiH6xp2sYIDrIyc1rVGlkJaOev2KcufwivBRpKA1pnQdgDQpr7lv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(44832011)(31686004)(5660300002)(66946007)(6666004)(478600001)(4326008)(66556008)(66476007)(110136005)(2906002)(31696002)(316002)(52116002)(8676002)(6486002)(36756003)(8936002)(16576012)(53546011)(26005)(2616005)(956004)(86362001)(186003)(16526019)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zbnrgfp9Yea60Ix51jfeJq5tNbtgtKbR1R55Ge2FY4zpmXlIOz/lykZdpfrOlN7cBhE5++IdbAF6oYLhe3piKMAyVX+NVo44XQicQakjEsrPE5Z5GM5TVLB6S/1RUTqs0UU0Wcix6vbe7Ql9sKGQdeDyVhc4vb3dlDumNnJTnmpeP3XJ0I/hNBP7UmVsbIR9sRFZR25o3uUFf1EpgUtO+2qEjHnBsmNH6wSGcUojQ885SrpEUZMjMSHa16/HXM/nww+TbGeiE3JE3BIr/mx7MwqVUpGtQesyVSFt0qinbUuJr/mKSawaqP7yWDZg/tj2OPWf6iOF1iuziZ9py53eP1K/h64xImNiEVwSvrFj1gZzWunFKvexnjBXO15mkRY0EsKB/ISZEUlMMm2gQceeV5pCC5QG1zH/DXaxImUcdUxqHko7StxNTFcXB2CKRtNzYIkzWOWhQJEji9HBEOS5luRrrEplQ6+xhJcK1/ah/m4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ae5e46-1aa0-49bd-c442-08d7f9045078
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 19:15:22.4000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/jRtAFiYjz3yzaYBhjO6A3rGcAJIBoPL27cvtgjh/7ET5sIFgnYkyVn9sGM+g7Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Friday, May 15, 2020 1:22 PM
> To: Moger, Babu <Babu.Moger@amd.com>; Reinette Chatre
> <reinette.chatre@intel.com>
> Cc: x86@kernel.org; linux-kernel@vger.kernel.org; Fenghua Yu
> <fenghua.yu@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>
> Subject: Re: [PATCH v2 09/10] x86/resctrl: Add arch_has_sparse_bitmaps to
> explain AMD/Intel CAT difference
> 
> Hi guys,
> 
> On 13/05/2020 21:03, Babu Moger wrote:
> >> From: Reinette Chatre <reinette.chatre@intel.com>
> >> On 4/30/2020 10:03 AM, James Morse wrote:
> >>> Intel expects the cache bitmap provided by user-space to have on a
> >>> single span of 1s, whereas AMD can support bitmaps like 0xf00f.
> >>> Arm's MPAM support also allows sparse bitmaps.
> >>>
> >>> To move resctrl out to /fs/ we need to explain platform differences
> >>> like this. Add a resource property arch_has_sparse_bitmaps. Test this
> >>> around the 'non-consecutive' test in cbm_validate().
> >>>
> >>> Merging the validate calls causes AMD top gain the min_cbm_bits test
> 
> top -> to
> 
> >>> needed for Haswell, but as it always sets this value to 1, it will
> >>> never match.
> >>>
> >>> CC: Babu Moger <Babu.Moger@amd.com>
> >>> Signed-off-by: James Morse <james.morse@arm.com>
> >>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> >>
> >> The Intel bits do indeed look good to me but we should check the AMD
> >> portion ... I peeked at the AMD spec [1] and found "If an L3_MASK_n
> >> register is programmed with all 0’s, that COS will be prevented from
> >> allocating any lines in the L3 cache" ... so AMD does allow bitmasks of
> >> all 0's (Intel does not).
> >>
> >> Does MPAM also allow all 0's? Perhaps "arch_has_sparse_bitmaps" can be
> >> used to indicate that also?
> 
> It does...
> 
> 
> > That is right. AMD allows  L3 mask be all 0s.  I will be great if this
> > property can be indicated it here. Thanks
> 
> Ah, this is a bug I didn't intend to introduce!
> 
> Intel has:
> |       if (val == 0 || val > r->default_ctrl) {
> 
> Whereas AMD:
> |       if (val > r->default_ctrl) {
> 
> 
> So this empty bitmap is permitted today with resctrl. (and, its another try-it-and-
> see).
> 
> I'll add an 'arch_has_empty_bitmaps', I don't think overloading 'sparse' to mean
> 'sparse
> and empty' is a good idea.

Sounds good to me. Thanks
