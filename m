Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 990FC2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHFT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:26:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:57843 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFT01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:26:27 -0400
IronPort-SDR: Im8SsfrSZJy3wl5wCtrQnechHSfsDr025pTLoInIcaHh9GZHCMpQqImJ5rOHIFO8fc2bxlgjnK
 dTwZuJS0kQAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="214429165"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="214429165"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:26:26 -0700
IronPort-SDR: 5O34ZelIxamjXUnl1FzmYNKNvTuh08rRshm/yKzkLDz7jljjSA2lVh3biO5Xi8SYHvqVFUhTFa
 lyNB9SEAJL/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="293409554"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2020 12:26:26 -0700
Date:   Thu, 6 Aug 2020 12:26:26 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] libnvdimm/security: the 'security' attr never
 show 'overwrite' state
Message-ID: <20200806192625.GL1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
 <1596494499-9852-2-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596494499-9852-2-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:41:38PM -0600, Jane Chu wrote:
> 'security' attribute displays the security state of an nvdimm.
> During normal operation, the nvdimm state maybe one of 'disabled',
> 'unlocked' or 'locked'.  When an admin issues
>   # ndctl sanitize-dimm nmem0 --overwrite
> the attribute is expected to change to 'overwrite' until the overwrite
> operation completes.
> 
> But tests on our systems show that 'overwrite' is never shown during
> the overwrite operation. i.e.
>   # cat /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0012:00/ndbus0/nmem0/security
>   unlocked
> the attribute remain 'unlocked' through out the operation, consequently
> "ndctl wait-overwrite nmem0" command doesn't wait at all.
> 
> The driver tracks the state in 'nvdimm->sec.flags': when the operation
> starts, it adds an overwrite bit to the flags; and when the operation
> completes, it removes the bit. Hence security_show() should check the
> 'overwrite' bit first, in order to indicate the actual state when multiple
> bits are set in the flags.
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/dimm_devs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
> index b7b77e8..5d72026 100644
> --- a/drivers/nvdimm/dimm_devs.c
> +++ b/drivers/nvdimm/dimm_devs.c
> @@ -363,14 +363,14 @@ __weak ssize_t security_show(struct device *dev,
>  {
>  	struct nvdimm *nvdimm = to_nvdimm(dev);
>  
> +	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> +		return sprintf(buf, "overwrite\n");
>  	if (test_bit(NVDIMM_SECURITY_DISABLED, &nvdimm->sec.flags))
>  		return sprintf(buf, "disabled\n");
>  	if (test_bit(NVDIMM_SECURITY_UNLOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "unlocked\n");
>  	if (test_bit(NVDIMM_SECURITY_LOCKED, &nvdimm->sec.flags))
>  		return sprintf(buf, "locked\n");
> -	if (test_bit(NVDIMM_SECURITY_OVERWRITE, &nvdimm->sec.flags))
> -		return sprintf(buf, "overwrite\n");
>  	return -ENOTTY;
>  }
>  
> -- 
> 1.8.3.1
> 
