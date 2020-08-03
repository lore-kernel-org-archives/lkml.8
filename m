Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F74C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA36E207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgHCUlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:41:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:57646 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726693AbgHCUlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:41:23 -0400
IronPort-SDR: 0dxJHq23PloThClgcHFfTjARH7mmCFe/8O7zWVgfhIz5xU2B6m22LXCXDuqYpT4Q0JYDsNtJDx
 qh3iDqayxRLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="151428262"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="151428262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 13:41:22 -0700
IronPort-SDR: iFi7RNfxqEjT9sKJPJCjrNKn/WYf8bCytJNouHIrjN7xU8DcScew7N9F1vbxd4EHxa6/UHGOid
 ptI+di/H7GBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="314943442"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.79.119]) ([10.255.79.119])
  by fmsmga004.fm.intel.com with ESMTP; 03 Aug 2020 13:41:22 -0700
Subject: Re: [PATCH 1/2] libnvdimm/security: 'security' attr never show
 'overwrite' state
To:     Jane Chu <jane.chu@oracle.com>, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, jmoyer@redhat.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <cb8c1944-f72c-ecfa-bd3d-276f504542e1@intel.com>
Date:   Mon, 3 Aug 2020 13:41:21 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595606959-8516-1-git-send-email-jane.chu@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2020 9:09 AM, Jane Chu wrote:
> Since
> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute"),
> when issue
>   # ndctl sanitize-dimm nmem0 --overwrite
> then immediately check the 'security' attribute,
>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>   unlocked
> Actually the attribute stays 'unlocked' through out the entire overwrite
> operation, never changed.  That's because 'nvdimm->sec.flags' is a bitmap
> that has both bits set indicating 'overwrite' and 'unlocked'.
> But security_show() checks the mutually exclusive bits before it checks
> the 'overwrite' bit at last. The order should be reversed.
> 
> The commit also has a typo: in one occasion, 'nvdimm->sec.ext_state'
> assignment is replaced with 'nvdimm->sec.flags' assignment for
> the NVDIMM_MASTER type.

May be best to split this fix to a different patch? Just thinking git bisect 
later on to track issues. Otherwise Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>   drivers/nvdimm/dimm_devs.c | 4 ++--
>   drivers/nvdimm/security.c  | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8..5d72026 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
>   {
>   	struct nvdimm *nvdimm = to_nvdimm(dev);
>   
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> +		return sprintf(buf, "overwrite\n");
>   	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>   		return sprintf(buf, "disabled\n");
>   	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "unlocked\n");
>   	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>   		return sprintf(buf, "locked\n");
> -	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> -		return sprintf(buf, "overwrite\n");
>   	return -ENOTTY;
>   }
>   
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4cef69b..8f3971c 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>   	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>   	put_device(&nvdimm->dev);
>   	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>   }
>   
>   void nvdimm_security_overwrite_query(struct work_struct *work)
> 
