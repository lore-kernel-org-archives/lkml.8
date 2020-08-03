Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DD0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75920207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgHCUmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:42:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:12119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgHCUmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:42:09 -0400
IronPort-SDR: c38/PJc6fdxU/aC0Y6mS49sv4QoxnHtZcm9w9XRybcABrmrIxwD4GW3IySjXO0UJag4l9MCs/3
 bZ6MT4lR0hGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237059833"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="237059833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 13:42:08 -0700
IronPort-SDR: G8qehCHuJl7G+oYeLcNmtNncs+SV1quOrUt0k6EZCvNZVKFommktmxwqbgieIgWw+BfsL8TLcb
 7N/nz6Urovhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="314944197"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 13:42:08 -0700
Subject: Re: [PATCH 2/2] libnvdimm/security: ensure sysfs poll thread woke up
 and fetch updated attr
To:     Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
 <1595606959-8516-2-git-send-email-jane.chu@oracle.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <b9957db2-c130-f2ae-14a1-e711a98c7c69@intel.com>
Date:   Mon, 3 Aug 2020 13:42:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606959-8516-2-git-send-email-jane.chu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 9:09 AM, Jane Chu wrote:
> commit 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> adds a sysfs_notify_dirent() to wake up userspace poll thread when the "overwrite"
> operation has completed. But the notification is issued before the internal
> dimm security state and flags have been updated, so the userspace poll thread
> wakes up and fetches the not-yet-updated attr and falls back to sleep, forever.
> But if user from another terminal issue "ndctl wait-overwrite nmemX" again,
> the command returns instantly.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: 7d988097c546 ("acpi/nfit, libnvdimm/security: Add security DSM overwrite support")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/nvdimm/security.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 8f3971c..4b80150 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -450,14 +450,19 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>   	else
>   		dev_dbg(&nvdimm->dev, "overwrite completed\n");
>   
> -	if (nvdimm->sec.overwrite_state)
> -		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	/*
> +	 * Mark the overwrite work done and update dimm security flags,
> +	 * then send a sysfs event notification to wake up userspace
> +	 * poll threads to picked up the changed state.
> +	 */
>   	nvdimm->sec.overwrite_tmo = 0;
>   	clear_bit(NDD_SECURITY_OVERWRITE, &nvdimm->flags);
>   	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
> -	put_device(&nvdimm->dev);
>   	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
>   	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	if (nvdimm->sec.overwrite_state)
> +		sysfs_notify_dirent(nvdimm->sec.overwrite_state);
> +	put_device(&nvdimm->dev);
>   }
>   
>   void nvdimm_security_overwrite_query(struct work_struct *work)
> 
