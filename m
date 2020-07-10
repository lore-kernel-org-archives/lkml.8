Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFABC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F5B20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 10:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FjFfUowt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGJKc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 06:32:56 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:21252
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbgGJKcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 06:32:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUSWAOqIFQ9L4A9WMzJc+fG/sb5/XSqGpeJ69gFcdFrVZMF2INJqHTq0sGwy2d9lsj0zv5f71qSoj6Ygr+AJvEKa44wzhvX/8T85I8QYa27z1h9B0wHdjbxYPez2G1KW6xV5LPS1Bbt8pOi+3NHwPVSdKsptVGxWDfyNC9Dz+5RFlw7SkHnYfe9wyuctV0gzovPPFaScRHNhEfJa1A57Ee9RmeTe+XeQg96ZlBCRSBghppGOIgs1ps/oQ7K2N2gN6BPGHT16EruQQKt+0AcbsbkMZ3DUiIShARDpcEoqOCIvl4XbdWV6PazibRdk2u60oIWpKZ34oQ7+3L+MFv3YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KGE7tqqM7j1zV1EpVGO1yhr+XnzB4qehB/VkbomCDo=;
 b=J/uC8KS4nm/XEZSXTihFJsZ2aySNM8WjGQ/ArHkwYfy+f1trrKD4znIGQGR4ZCRIPCSqfV05iSOlO6r52R5E1+bL+26xgRoC/Qb+mICsYvsUvWEfRzSwGtCZTrKQYwwoUxQ5xPyxlqR6mY8m+QAcfNQOWriYnwaMEPBuIGaxPbE1S1zocMJ+tggKNBGKJ9VCg7/LZ07cEj1oFaIV0bOZBva9bXsYeB6tC3hH7oda8mHmDbUvMoZdaTyzw41U1SeOfLG3GcRH3P4HqrhDRnVdrC24CUc2wrYIY4ORbSxTFMVag7ehLg/LeycH0vX/68KsQuvPVr6DM9JTNvO3WqePKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KGE7tqqM7j1zV1EpVGO1yhr+XnzB4qehB/VkbomCDo=;
 b=FjFfUowtUNtcstzGcbysveYlw19jvqPckcap/yRqFRwMQLoxbm24QlA6JTD+TsRYAxxcgP5+5zYrkdq/7fTxoLvsVJJ6Hg0Xr/xWA+op8HCDmk1EWcMsL3BzGB7RRO8H2fHllSA3+/6IREOQiRmnBHou4i5k5wRGeQ2dqZx3Olk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB2877.eurprd04.prod.outlook.com (2603:10a6:800:b5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 10:32:52 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::b97a:64f0:3ab5:d7fa%5]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 10:32:52 +0000
Subject: Re: [PATCH v3] bus: fsl-mc: fix invalid free in fsl_mc_device_add
To:     trix@redhat.com, stuyoder@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20200709153119.5051-1-trix@redhat.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <5e39983d-53a0-3521-2971-d69cb47bb364@nxp.com>
Date:   Fri, 10 Jul 2020 13:32:49 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200709153119.5051-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0130.eurprd04.prod.outlook.com
 (2603:10a6:208:55::35) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.107] (86.120.184.194) by AM0PR04CA0130.eurprd04.prod.outlook.com (2603:10a6:208:55::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 10:32:51 +0000
X-Originating-IP: [86.120.184.194]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 34080f41-2663-4ca9-31af-08d824bc9989
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2877:
X-Microsoft-Antispam-PRVS: <VI1PR0402MB28779CCF1FD897005A5CAE81EC650@VI1PR0402MB2877.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nf4tpqF5oMEHM4jrSkkaual/+Wpy3qfS8SEITrAk5Mu+L2px0DJQynfQ7XDNVGBb0oE+fSv67+S7mySG2kIjngWPuzxla9rF6yfxPQCPtegpyICbU1tqLukZbe7KG7QCrwM0PCFk57phG5z7fZvxHMOWdnV5y2IO99Xbu5mAr/dPC3A0OnX4bips+QgcnxLitSoKMVwM26Yws+2E/sCIO31QkKCF3UnJvgL/4tnK61rSVUldz+4avQ6jcWqh3P2bScvnTQkRMr/Mq2NRCRZuBk7CFl+O1Cz8vRv1vQcaCSWng6mCCeWql3MIfaALNfkPYT3U/y2tTYoc9wzIxYmCrOVxB2cWGhxyNvzh9S6OWADMq69t0YxtK5VnWC3Y2QI0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(316002)(8936002)(8676002)(86362001)(956004)(2616005)(6486002)(44832011)(31696002)(31686004)(36756003)(66946007)(66556008)(66476007)(83380400001)(5660300002)(4326008)(16576012)(478600001)(2906002)(53546011)(52116002)(26005)(16526019)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: SZtXrHx6ApX3EWr0JAaSjEii/n8giG+WNRnyIRfNgGF+WcaSCNG3vkVlNRB5vYrQB4GvIoBDupGzC6coLblwxH3pr0Kqz16RjQfoF/9wUH8jLW8li8sHo1xiGhWxJNXRshIoFnV5HZ67ZjRCwbUMiO9nUexR+1UdH65oioKFJV2P6CpDJcnfT1rpRBxzHtWaJlBCUdLf5BQM7ZLjvzZL0/a1d1Ihgr+AWfrlj5WqUqgG+HQ7dwBU1gjZz6DvSPbhg/deiUPDVCLsC0owaqgL/YB2rrAYjbvn78eg3Wv49cT4mE5cIrJ00XWPJ6uqtS9TksDnp5G6otX007sYohqshxieZ6cl4x3PAFwiQVInGbz/rnNF/JkWOdJD5f2Zp+6lwbIHW8gxHrlA6SglPdUBaMUm4jeVG2mB6vlcLNzAWFn84GfGglNMHzyWgZjA7K+TYHDP4DoOkoeJO6yHJlRwBBUFjgvWC6QxRV/kzYqSeWbKNacjSQWp1CLl6nc+GK9+
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34080f41-2663-4ca9-31af-08d824bc9989
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 10:32:52.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sFRW8oP+35+KgO1BRd7TW3ZGbbu4PdFScyKfuEyZ+b5lKz+6Fa0IaW93eiIfESKqvQFyst07VYOXBmbTCZsvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2877
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2020 6:31 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this error
> 
> fsl-mc-bus.c:695:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(mc_dev);
>         ^~~~~~~~~~~~~
> 
> The problem block of code is
> 
> 		mc_bus = kzalloc(sizeof(*mc_bus), GFP_KERNEL);
> 		if (!mc_bus)
> 			return -ENOMEM;
> 
> 		mc_dev = &mc_bus->mc_dev;
> 
> mc_bus's structure contains a mc_dev element,
> freeing it later is not appropriate.
> 
> So check if mc_bus was allocated before freeing mc_dev
> 
> This is a case where checkpatch
> 
> WARNING: kfree(NULL) is safe and this check is probably not required
> +	if (mc_bus)
> +		kfree(mc_bus);
> 
> is wrong.
> 
> Fixes: a042fbed0290 ("staging: fsl-mc: simplify couple of deallocations")
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  v1: add a comment to explain freeing uniqueness
>  v2: add gregkh's suggestion to comment.
>  
>  drivers/bus/fsl-mc/fsl-mc-bus.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 40526da5c6a6..839d96d03f0d 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -691,8 +691,16 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
>  
>  error_cleanup_dev:
>  	kfree(mc_dev->regions);
> -	kfree(mc_bus);
> -	kfree(mc_dev);
> +	/*
> +	 * mc_bus allocates a private version of mc_dev
> +	 * it is not appropriate to free the private version.
> +	 * Which means we have to check the pointer before freeing it.
> +	 * Do not remove this check.
> +	 */
> +	if (mc_bus)
> +		kfree(mc_bus);
> +	else
> +		kfree(mc_dev);
>  
>  	return error;
>  }
> 

Thanks, Tom!

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
