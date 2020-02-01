Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E3BC35249
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 23:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C1F20643
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 23:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgBAXiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 18:38:55 -0500
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:32808 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726487AbgBAXiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 18:38:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A4059182CED28;
        Sat,  1 Feb 2020 23:38:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flock06_30532222dbd16
X-Filterd-Recvd-Size: 2806
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Feb 2020 23:38:51 +0000 (UTC)
Message-ID: <b9b671508d478469c1ad43206dd29d770bfb7818.camel@perches.com>
Subject: Re: [PATCH] drm/amdkfd: Make process queues logs less verbose
From:   Joe Perches <joe@perches.com>
To:     Julian Sax <jsbc@gmx.de>, amd-gfx@lists.freedesktop.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Sat, 01 Feb 2020 15:37:43 -0800
In-Reply-To: <20200201231101.2127964-1-jsbc@gmx.de>
References: <20200201231101.2127964-1-jsbc@gmx.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-02-02 at 00:11 +0100, Julian Sax wrote:
> During normal usage, especially if jobs are started and stopped in rapid
> succession, the kernel log is filled with messages like this:
> 
> [38732.522910] Restoring PASID 0x8003 queues
> [38732.666767] Evicting PASID 0x8003 queues
> [38732.714074] Restoring PASID 0x8003 queues
> [38732.815633] Evicting PASID 0x8003 queues
> [38732.834961] Restoring PASID 0x8003 queues
> [38732.840536] Evicting PASID 0x8003 queues
> [38732.869846] Restoring PASID 0x8003 queues
> [38732.893655] Evicting PASID 0x8003 queues
> [38732.927975] Restoring PASID 0x8003 queues
> 
> According to [1], these messages are expected, but they carry little
> value for the end user, so turn them into debug messages.
> 
> [1] https://github.com/RadeonOpenCompute/ROCm/issues/343

trivia:

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
[]
> @@ -604,7 +604,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>  		goto out;
> 
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);

It would be nicer to realign all the subsequent lines in a
single statement to the now moved open parenthesis.

> 
>  	/* Mark all queues as evicted. Deactivate all active queues on
> @@ -650,7 +650,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>  		goto out;
> 
>  	pdd = qpd_to_pdd(qpd);
> -	pr_info_ratelimited("Evicting PASID 0x%x queues\n",
> +	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
>  			    pdd->process->pasid);

etc...


