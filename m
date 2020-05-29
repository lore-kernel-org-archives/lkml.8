Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6061BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B1DC2068D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iGv47NeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404881AbgE2CGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:06:37 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:7206
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404550AbgE2CGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:06:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCOwS60GmzbFQqccOYw7SgwAjr/rvWwMu3tBNewgUv0PfBZkeMPqbMoNn60RVMOP6XtPmk0pSN3YCqnrHqvOcpWOHMFbg7/PTyKNByRMfTCokpp49cbnY5YHq8ieLsCtO00/shV2gIOYcZOEZSlbXJAeRBI689KV6OXVIu05i27F/VWjVzKwFvO7HSb2P19YOGw/fBSYDynbO79h9FFcSfn16X3/RWWFUFTOUX6mxHdAgsHPH4vE4x/u3N+A0qPJ6eK3TSpw59HOiWFRampw+eX5FZ86aCDsA87d2bkm1a/Vpu9KKg8cndvysYrTAcTk/1cw4eAjv+4PQ23GyNtFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f15cFJguZyj/vi3mBdvW33G30Pql4r56hquaySHucJo=;
 b=J7yKKHTbbJ5Jo1eXLYpq4dL0Dp3zXI0RdS3w8prJCOhMgn591WJoQyjIeRNWSqppR0z3mEPyCHAuVtgtKKI3gkWjLGwMhhsq3rZ68oCRnXw7uBg3z5k+hocqT5sD6TMyA+qdxkPR0Zx5/cxiU73+dh4w66pQhRMtVOIB2uRLpyioJOaj6Oc3AkFWeC/HSjIACGGfnFexLXJP8JX7t3/VcGY00rkdhnhvygQw9Bn0vKikDT8S8fP/UVFp/hfbvJk5EU1exIQLA0NprvMRwnXu3jRmvW7lm8ddLYhgNaSieXBL2Cqpd2xUzp8dLImFi1OF29AhPQfNxlJ7wInEOmVE6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f15cFJguZyj/vi3mBdvW33G30Pql4r56hquaySHucJo=;
 b=iGv47NeWDWkNLYBRWiZH8xWrte1HLjpKyq0w9xlypj5B4jt4Kj/bwxdDjgpg3PLdA+7lZCxt15dOEYUx+R2Y0i/3LOykqyyhajm/PFNAoKqGgYWDyiChH5tB+VCBWqJDyGoN7VNMeA0fxPVKAYMllj8hrVu3vO8AaX/8bWDlODE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2382.namprd12.prod.outlook.com (2603:10b6:802:2e::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.24; Fri, 29 May
 2020 02:06:27 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3021.030; Fri, 29 May 2020
 02:06:27 +0000
Subject: Re: [PATCH][next] drm/amdkfd: fix a dereference of pdd before it is
 null checked
To:     Colin King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mukul Joshi <mukul.joshi@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528222453.536137-1-colin.king@canonical.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <dc37cf9d-ddaf-94c7-8fc1-460c8da59d7b@amd.com>
Date:   Thu, 28 May 2020 22:06:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200528222453.536137-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BN6PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:404:23::26) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.178] (165.204.84.11) by BN6PR03CA0016.namprd03.prod.outlook.com (2603:10b6:404:23::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Fri, 29 May 2020 02:06:19 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34c71310-dd95-4301-03da-08d80374e4ff
X-MS-TrafficTypeDiagnostic: SN1PR12MB2382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23825E9A06128F3B4F87579E928F0@SN1PR12MB2382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gwUTGxNA4W6LYh4sHypTUjqcQIiVsBd52NEvm8h/yUegNTIxnpwp/Z+Kx2kBuWG+mW3QurXS5tYdsii1npN7jLDkVCMV14vrqF1rHucMbIQ+4XU98DioUlnvHxTU4yp5Q5NnG6DPaU3I0vfvDgzMAj8EKxAa0P7128BB0wry4t4XMV1yl7n48JT5N1KG2qHK0mgJBgEvbohgvANaiQHIYzuFQWnviAjCK8xAvRRXpDNfSPyeirc0ScicTqEEHWophnHKtuYDPJT+iWk1b4IGRvRmKxEdwlIEmWp6JA+t5vshbAb+yoL8fUK1TeNgVmS+fwFRJXCzZsklL5Qevc+CGdlf5VYT1fYS17yPqe8IaBVzeDxFHGWJM1MHL2MYO71f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(44832011)(110136005)(8676002)(66556008)(66476007)(8936002)(66946007)(6666004)(16576012)(86362001)(31696002)(956004)(316002)(2616005)(2906002)(36756003)(4326008)(5660300002)(6486002)(52116002)(186003)(16526019)(53546011)(478600001)(83380400001)(31686004)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Thy+b6u0b15/E0GayQZ/CpXwlswPJB56yZsu2ncfgnq8PaWwMxEFr74kCq2clrFOuj6DMO+35l55P5I4LjXqm937Ry20kIkE7Chpo4ugkwYBD48pLcpUEMkTswOwG10uakkla7k5Gke2RLPRNjYL6s+A06nXiV5ip7DifS3Vbk1WthWE9hhYTPtrlDrSyF3C9fEFlhsyC3IrJcgykCfrR7xR3QKg2yY+pAPNBAzQ+XOHyIkgbMrvX9l30N5U/o4ERvBwjkpQAStVriIaeno9dZPOE7kf0XWesdOF5OWsRQ0QdcMeDRM2ftXVyWL+pW79STQ3JqZ+Up7XTq8Zx1IHfs+bj0DMUyi6FEh2BZUMXBwTwzV+IFhKl5A5E3Okq1PhYM5ZtD4eQwXxydWOmAM5PqXe9hyHhD8Z+sS8ozpizdko2A5sTgsCFazG7ewBugUBMLAizGfABdzV0oc+sQkcIauyFA31Hr7e/RQfKg3/Nj9CYrdly8xLUpipa2ppYQ5/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c71310-dd95-4301-03da-08d80374e4ff
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 02:06:26.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WZJLwpF/belaR7HMp3FQImEPNZbw3eh4p2VaO5Shtq0e3w9WtzXmmZAke0+PduBnvmhU+zLwrjhlRNbPnck75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2382
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-28 18:24, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently pointer pdd is being dereferenced when assigning pointer
> dpm and then pdd is being null checked.  Fix this by checking if
> pdd is null before the dereference of pdd occurs.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 522b89c63370 ("drm/amdkfd: Track SDMA utilization per process")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I applied the patch to our internal amd-staging-drm-next.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 25636789f3d3..bdc58741b32e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -103,10 +103,11 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>   		return;
>   
>   	pdd = workarea->pdd;
> +	if (!pdd)
> +		return;
>   	dqm = pdd->dev->dqm;
>   	qpd = &pdd->qpd;
> -
> -	if (!pdd || !dqm || !qpd)
> +	if (!dqm || !qpd)
>   		return;
>   
>   	mm = get_task_mm(pdd->process->lead_thread);
