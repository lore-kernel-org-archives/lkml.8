Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2042BC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40A220732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgBXWtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:49:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:37327 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgBXWtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:49:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 14:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,481,1574150400"; 
   d="scan'208";a="231269244"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2020 14:49:20 -0800
Date:   Mon, 24 Feb 2020 14:49:20 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alistair Delva <adelva@google.com>
Cc:     linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, devicetree@vger.kernel.org,
        linux-nvdimm@lists.01.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] libnvdimm/of_pmem: factor out region registration
Message-ID: <20200224224920.GA8867@iweiny-DESK2.sc.intel.com>
References: <20200224020815.139570-1-adelva@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224020815.139570-1-adelva@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 06:08:13PM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> From: Kenny Root <kroot@google.com>
> 
> Factor out region registration for 'reg' node. A follow-up change will
> use of_pmem_register_region() to handle memory-region nodes too.

Thanks!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Reviewed-by: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 60 +++++++++++++++++++++++-----------------
>  1 file changed, 35 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..fdf54494e8c9 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,6 +14,39 @@ struct of_pmem_private {
>  	struct nvdimm_bus *bus;
>  };
>  
> +static void of_pmem_register_region(struct platform_device *pdev,
> +				    struct nvdimm_bus *bus,
> +				    struct device_node *np,
> +				    struct resource *res, bool is_volatile)
> +{
> +	struct nd_region_desc ndr_desc;
> +	struct nd_region *region;
> +
> +	/*
> +	 * NB: libnvdimm copies the data from ndr_desc into it's own
> +	 * structures so passing a stack pointer is fine.
> +	 */
> +	memset(&ndr_desc, 0, sizeof(ndr_desc));
> +	ndr_desc.numa_node = dev_to_node(&pdev->dev);
> +	ndr_desc.target_node = ndr_desc.numa_node;
> +	ndr_desc.res = res;
> +	ndr_desc.of_node = np;
> +	set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> +
> +	if (is_volatile)
> +		region = nvdimm_volatile_region_create(bus, &ndr_desc);
> +	else
> +		region = nvdimm_pmem_region_create(bus, &ndr_desc);
> +
> +	if (!region)
> +		dev_warn(&pdev->dev,
> +			 "Unable to register region %pR from %pOF\n",
> +			 ndr_desc.res, np);
> +	else
> +		dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> +			ndr_desc.res, np);
> +}
> +
>  static int of_pmem_region_probe(struct platform_device *pdev)
>  {
>  	struct of_pmem_private *priv;
> @@ -46,31 +79,8 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>  			is_volatile ? "volatile" : "non-volatile",  np);
>  
>  	for (i = 0; i < pdev->num_resources; i++) {
> -		struct nd_region_desc ndr_desc;
> -		struct nd_region *region;
> -
> -		/*
> -		 * NB: libnvdimm copies the data from ndr_desc into it's own
> -		 * structures so passing a stack pointer is fine.
> -		 */
> -		memset(&ndr_desc, 0, sizeof(ndr_desc));
> -		ndr_desc.numa_node = dev_to_node(&pdev->dev);
> -		ndr_desc.target_node = ndr_desc.numa_node;
> -		ndr_desc.res = &pdev->resource[i];
> -		ndr_desc.of_node = np;
> -		set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> -
> -		if (is_volatile)
> -			region = nvdimm_volatile_region_create(bus, &ndr_desc);
> -		else
> -			region = nvdimm_pmem_region_create(bus, &ndr_desc);
> -
> -		if (!region)
> -			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -					ndr_desc.res, np);
> -		else
> -			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +					is_volatile);
>  	}
>  
>  	return 0;
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
