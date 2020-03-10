Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62980C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D7121927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WN7sVffe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCJRwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:52:16 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com ([40.107.236.59]:2912
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726283AbgCJRwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:52:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYQSZ9xblUA+k+EqqHIXRHwlpMnqn1g14ngAEkAfk5smt5dNVxJimYwrsw/MyEuEZvMEanQaIFrGYx1cofnwh91Nb8UWUTrE2qhpxrsBkgmdR3j2RH6G58f00hVCidjzA9ON9pkE20M+wXUa74M5NYjY2e/nywOGN6DFe4jcnxsGs12TR6nIAXe/Y7KmBKXfofmdW01D+EjqvyiwETmfFmOn6t6pqYi7dpmBby7EI7l9C+8NmGbPoTpjF8oE6Kx9mm9ajNhA0GYk9eG+l5zR3xXj3DLtFaKR5KKMS9w3xEYxRw+ezcfjg13VLTSq4dahNM+p6kIuIi+JnIgSnHmSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsT5Zvp5zmymNjbLBlhTz4sTzGPHBKEKxXOU7Lgt72s=;
 b=jKZrMy45A4+NV27izVNfpDb0qFsYPOVqrAiRPg2KtN1N26BVyoyn8B0K5Yk9ddEs1yngRE7xLfkJNWfnn68QgCsP+KIehxDGGSDv6+FbNb74e7A3rMae1KMkvlUvIX7e1+irwWTFf7rZHruK1lKRhSYBeQJ8bbUsRO/GsBEGx3TiWtwsFSZSHApmjwIBSglRvy1KkKDwunZMkQ4Sdh/lT83mRgdc6DcYu2ao4CYcCJQgUbcYjo8lO4suhLj0yox0pSgKFPekCupdHFK9GGIXlqGL1192RzV5AUfNkmXIlfGT5kjHWcr0OffIbBbO/+kEfkobtLRrMYfEiFf39x9BPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsT5Zvp5zmymNjbLBlhTz4sTzGPHBKEKxXOU7Lgt72s=;
 b=WN7sVffemKi6YQOzVBXGLXmXPVryO01OQIK29pvKvyomLhwCXJ+cUItn24S4hvmu0w6EqaPNSLTJzKtG8RENo+fS981ANZ1KlNhuDw3a8wCjDPT43U0YhxD46TRt8X3tdMtOlorjVE1nPcvPPqrqt6y0FD64T9bxtXukkQqpVLk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mikita.Lipski@amd.com; 
Received: from DM6PR12MB2906.namprd12.prod.outlook.com (2603:10b6:5:15f::20)
 by DM6PR12MB3258.namprd12.prod.outlook.com (2603:10b6:5:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Tue, 10 Mar
 2020 17:52:00 +0000
Received: from DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07]) by DM6PR12MB2906.namprd12.prod.outlook.com
 ([fe80::cd57:c685:c45c:8c07%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 17:52:00 +0000
Subject: Re: [PATCH v3] drm/dp_mst: Rewrite and fix bandwidth limit checks
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     Mikita Lipski <mikita.lipski@amd.com>,
        Sean Paul <seanpaul@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-kernel@vger.kernel.org
References: <20200306234623.547525-5-lyude@redhat.com>
 <20200309210131.1497545-1-lyude@redhat.com>
From:   Mikita Lipski <mlipski@amd.com>
Organization: AMD
Message-ID: <8272905f-3966-4fcd-d78f-e88063cf53f8@amd.com>
Date:   Tue, 10 Mar 2020 13:51:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200309210131.1497545-1-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::34) To DM6PR12MB2906.namprd12.prod.outlook.com
 (2603:10b6:5:15f::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.224.72] (165.204.55.250) by YTOPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 17:51:59 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 02e194c4-5e2c-49a1-b533-08d7c51bbbd0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3258:|DM6PR12MB3258:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB325809F9C58FEC9F7CB5F550E4FF0@DM6PR12MB3258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(52116002)(36916002)(26005)(8936002)(8676002)(4326008)(81156014)(81166006)(66946007)(5660300002)(478600001)(54906003)(31686004)(316002)(16576012)(2906002)(53546011)(36756003)(6486002)(7416002)(16526019)(186003)(31696002)(956004)(2616005)(66476007)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3258;H:DM6PR12MB2906.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CoBGyxWz7DX54sKhFiIS6GvlstPpgCIXvv6jvzAK/EEZxgDBSlah3Jvbx0SZA0GofVyV+PFOLyJ4kXXKYZMGy3JVvY+qGjK+mZrwhNG9ut8sB/recCIhjvdHYzNvr52uiCgcmeaxTVO1PghBtKjbvN+W4usLE8MKBpSJx7a6wzw8LDmMhqQ2ASXZlVI8bsmr046GKek54NPCGQ+fzzU6p02J/SF0LnW9uhv7yA0ayndhpR4LEilMRFTQTo9Nc15EDJBlF4SBV+PRjRdNZ3K66XnOmuv6tcXTkjPe/3vLS4tRPpyjTMHj36STeVFM66o3MzYbba4qHzat3dteFIpDIugdcBaaEJQfBo/sgbvZVuuiARNyNXA6oXssbT1TgGjYgC+/AyU9vC7B2+7tk3Xz2L2eUUu5NMl9FntlixZefRXdO3lqUWbSlP4QwzCoS81V
X-MS-Exchange-AntiSpam-MessageData: PqjOmutlGYQcfF0mG23xLad2Gjd5CIc8hZ/6nb2GOOmPap1F+G5DHeJhSHjasWRyvC6uvXlOFUjGdDsSFtl4Q3cuTgoLsnm0MSD3+ultm+fBbnVmDlUZRucjx6YcljPu2ArQZqt3A2L+64srbdYwIQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e194c4-5e2c-49a1-b533-08d7c51bbbd0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 17:52:00.3499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZM5/c7rtTjIlOKbFctKxIOch3YYaTcJ8izdgLEe7tK21vEtsRuKCxPqaWYHX7xx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3258
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/20 5:01 PM, Lyude Paul wrote:
> Sigh, this is mostly my fault for not giving commit cd82d82cbc04
> ("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
> enough scrutiny during review. The way we're checking bandwidth
> limitations here is mostly wrong:
> 
> For starters, drm_dp_mst_atomic_check_bw_limit() determines the
> pbn_limit of a branch by simply scanning each port on the current branch
> device, then uses the last non-zero full_pbn value that it finds. It
> then counts the sum of the PBN used on each branch device for that
> level, and compares against the full_pbn value it found before.
> 
> This is wrong because ports can and will have different PBN limitations
> on many hubs, especially since a number of DisplayPort hubs out there
> will be clever and only use the smallest link rate required for each
> downstream sink - potentially giving every port a different full_pbn
> value depending on what link rate it's trained at. This means with our
> current code, which max PBN value we end up with is not well defined.
> 
> Additionally, we also need to remember when checking bandwidth
> limitations that the top-most device in any MST topology is a branch
> device, not a port. This means that the first level of a topology
> doesn't technically have a full_pbn value that needs to be checked.
> Instead, we should assume that so long as our VCPI allocations fit we're
> within the bandwidth limitations of the primary MSTB.
> 
> We do however, want to check full_pbn on every port including those of
> the primary MSTB. However, it's important to keep in mind that this
> value represents the minimum link rate /between a port's sink or mstb,
> and the mstb itself/. A quick diagram to explain:
> 
>                                  MSTB #1
>                                 /       \
>                                /         \
>                             Port #1    Port #2
>         full_pbn for Port #1 → |          | ← full_pbn for Port #2
>                             Sink #1    MSTB #2
>                                           |
>                                         etc...
> 
> Note that in the above diagram, the combined PBN from all VCPI
> allocations on said hub should not exceed the full_pbn value of port #2,
> and the display configuration on sink #1 should not exceed the full_pbn
> value of port #1. However, port #1 and port #2 can otherwise consume as
> much bandwidth as they want so long as their VCPI allocations still fit.
> 
> And finally - our current bandwidth checking code also makes the mistake
> of not checking whether something is an end device or not before trying
> to traverse down it.
> 
> So, let's fix it by rewriting our bandwidth checking helpers. We split
> the function into one part for handling branches which simply adds up
> the total PBN on each branch and returns it, and one for checking each
> port to ensure we're not going over its PBN limit. Phew.
> 
> This should fix regressions seen, where we erroneously reject display
> configurations due to thinking they're going over our bandwidth limits
> when they're not.
> 
> Changes since v1:
> * Took an even closer look at how PBN limitations are supposed to be
>    handled, and did some experimenting with Sean Paul. Ended up rewriting
>    these helpers again, but this time they should actually be correct!
> Changes since v2:
> * Small indenting fix
> * Fix pbn_used check in drm_dp_mst_atomic_check_port_bw_limit()
> 

Thank you for rewriting the bandwidth check helper!

My initial understanding of available_pbn was completely wrong and 
therefore the bandwidth validation was not doing what it intended.
This version is much cleaner and  easier to follow than the initial one, 
since you're separating branch and port validation into 2 different 
functions, and also go down the device topology rather than starting 
from the end nodes. Also the explanation and the diagram help a lot to 
understand how it should have be done initially.

This change makes sense and looks correct to me, therefore:
Reviewed-by: Mikita Lipski <mikita.lipski@amd.com>

Thanks,
Mikita


> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Fixes: cd82d82cbc04 ("drm/dp_mst: Add branch bandwidth validation to MST atomic check")
> Cc: Mikita Lipski <mikita.lipski@amd.com>
> Cc: Sean Paul <seanpaul@google.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/gpu/drm/drm_dp_mst_topology.c | 119 ++++++++++++++++++++------
>   1 file changed, 93 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index b81ad444c24f..d2f464bdcfff 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -4841,41 +4841,102 @@ static bool drm_dp_mst_port_downstream_of_branch(struct drm_dp_mst_port *port,
>   	return false;
>   }
>   
> -static inline
> -int drm_dp_mst_atomic_check_bw_limit(struct drm_dp_mst_branch *branch,
> -				     struct drm_dp_mst_topology_state *mst_state)
> +static int
> +drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
> +				      struct drm_dp_mst_topology_state *state);
> +
> +static int
> +drm_dp_mst_atomic_check_mstb_bw_limit(struct drm_dp_mst_branch *mstb,
> +				      struct drm_dp_mst_topology_state *state)
>   {
> -	struct drm_dp_mst_port *port;
>   	struct drm_dp_vcpi_allocation *vcpi;
> -	int pbn_limit = 0, pbn_used = 0;
> +	struct drm_dp_mst_port *port;
> +	int pbn_used = 0, ret;
> +	bool found = false;
>   
> -	list_for_each_entry(port, &branch->ports, next) {
> -		if (port->mstb)
> -			if (drm_dp_mst_atomic_check_bw_limit(port->mstb, mst_state))
> -				return -ENOSPC;
> +	/* Check that we have at least one port in our state that's downstream
> +	 * of this branch, otherwise we can skip this branch
> +	 */
> +	list_for_each_entry(vcpi, &state->vcpis, next) {
> +		if (!vcpi->pbn ||
> +		    !drm_dp_mst_port_downstream_of_branch(vcpi->port, mstb))
> +			continue;
>   
> -		if (port->full_pbn > 0)
> -			pbn_limit = port->full_pbn;
> +		found = true;
> +		break;
>   	}
> -	DRM_DEBUG_ATOMIC("[MST BRANCH:%p] branch has %d PBN available\n",
> -			 branch, pbn_limit);
> +	if (!found)
> +		return 0;
>   
> -	list_for_each_entry(vcpi, &mst_state->vcpis, next) {
> -		if (!vcpi->pbn)
> -			continue;
> +	if (mstb->port_parent)
> +		DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] Checking bandwidth limits on [MSTB:%p]\n",
> +				 mstb->port_parent->parent, mstb->port_parent,
> +				 mstb);
> +	else
> +		DRM_DEBUG_ATOMIC("[MSTB:%p] Checking bandwidth limits\n",
> +				 mstb);
>   
> -		if (drm_dp_mst_port_downstream_of_branch(vcpi->port, branch))
> -			pbn_used += vcpi->pbn;
> +	list_for_each_entry(port, &mstb->ports, next) {
> +		ret = drm_dp_mst_atomic_check_port_bw_limit(port, state);
> +		if (ret < 0)
> +			return ret;
> +
> +		pbn_used += ret;
>   	}
> -	DRM_DEBUG_ATOMIC("[MST BRANCH:%p] branch used %d PBN\n",
> -			 branch, pbn_used);
>   
> -	if (pbn_used > pbn_limit) {
> -		DRM_DEBUG_ATOMIC("[MST BRANCH:%p] No available bandwidth\n",
> -				 branch);
> +	return pbn_used;
> +}
> +
> +static int
> +drm_dp_mst_atomic_check_port_bw_limit(struct drm_dp_mst_port *port,
> +				      struct drm_dp_mst_topology_state *state)
> +{
> +	struct drm_dp_vcpi_allocation *vcpi;
> +	int pbn_used = 0;
> +
> +	if (port->pdt == DP_PEER_DEVICE_NONE)
> +		return 0;
> +
> +	if (drm_dp_mst_is_end_device(port->pdt, port->mcs)) {
> +		bool found = false;
> +
> +		list_for_each_entry(vcpi, &state->vcpis, next) {
> +			if (vcpi->port != port)
> +				continue;
> +			if (!vcpi->pbn)
> +				return 0;
> +
> +			found = true;
> +			break;
> +		}
> +		if (!found)
> +			return 0;
> +
> +		/* This should never happen, as it means we tried to
> +		 * set a mode before querying the full_pbn
> +		 */
> +		if (WARN_ON(!port->full_pbn))
> +			return -EINVAL;
> +
> +		pbn_used = vcpi->pbn;
> +	} else {
> +		pbn_used = drm_dp_mst_atomic_check_mstb_bw_limit(port->mstb,
> +								 state);
> +		if (pbn_used <= 0)
> +			return pbn_used;
> +	}
> +
> +	if (pbn_used > port->full_pbn) {
> +		DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] required PBN of %d exceeds port limit of %d\n",
> +				 port->parent, port, pbn_used,
> +				 port->full_pbn);
>   		return -ENOSPC;
>   	}
> -	return 0;
> +
> +	DRM_DEBUG_ATOMIC("[MSTB:%p] [MST PORT:%p] uses %d out of %d PBN\n",
> +			 port->parent, port, pbn_used, port->full_pbn);
> +
> +	return pbn_used;
>   }
>   
>   static inline int
> @@ -5073,9 +5134,15 @@ int drm_dp_mst_atomic_check(struct drm_atomic_state *state)
>   		ret = drm_dp_mst_atomic_check_vcpi_alloc_limit(mgr, mst_state);
>   		if (ret)
>   			break;
> -		ret = drm_dp_mst_atomic_check_bw_limit(mgr->mst_primary, mst_state);
> -		if (ret)
> +
> +		mutex_lock(&mgr->lock);
> +		ret = drm_dp_mst_atomic_check_mstb_bw_limit(mgr->mst_primary,
> +							    mst_state);
> +		mutex_unlock(&mgr->lock);
> +		if (ret < 0)
>   			break;
> +		else
> +			ret = 0;
>   	}
>   
>   	return ret;
> 

-- 
Thanks,
Mikita Lipski
Software Engineer 2, AMD
mikita.lipski@amd.com
