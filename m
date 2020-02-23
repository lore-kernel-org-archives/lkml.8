Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96BDC35673
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A91C20637
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 14:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgBWO4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 09:56:38 -0500
Received: from mga12.intel.com ([192.55.52.136]:40120 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWO4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 09:56:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Feb 2020 06:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,476,1574150400"; 
   d="scan'208";a="255331825"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 23 Feb 2020 06:56:36 -0800
Date:   Sun, 23 Feb 2020 06:56:36 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alistair Delva <adelva@google.com>
Cc:     linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, devicetree@vger.kernel.org,
        linux-nvdimm@lists.01.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] libnvdimm/of_pmem: handle memory-region in DT
Message-ID: <20200223145635.GB29607@iweiny-DESK2.sc.intel.com>
References: <20200222183010.197844-1-adelva@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222183010.197844-1-adelva@google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 10:30:09AM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> Add support for parsing the 'memory-region' DT property in addition to
> the 'reg' DT property. This enables use cases where the pmem region is
> not in I/O address space or dedicated memory (e.g. a bootloader
> carveout).
> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
>  drivers/nvdimm/of_pmem.c | 75 ++++++++++++++++++++++++++--------------
>  1 file changed, 50 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 8224d1431ea9..a68e44fb0041 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -14,13 +14,47 @@ struct of_pmem_private {
>  	struct nvdimm_bus *bus;
>  };
>  
> +static void of_pmem_register_region(struct platform_device *pdev,
> +				    struct nvdimm_bus *bus,
> +				    struct device_node *np,
> +				    struct resource *res, bool is_volatile)

FWIW it would be easier to review if this was splut into a patch which created
the helper of_pmem_register_region() without the new logic.  Then added the new
logic here.

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
> -	struct device_node *np;
> +	struct device_node *mrp, *np;
>  	struct nvdimm_bus *bus;
> +	struct resource res;
>  	bool is_volatile;
> -	int i;
> +	int i, ret;
>  
>  	np = dev_of_node(&pdev->dev);
>  	if (!np)
> @@ -46,31 +80,22 @@ static int of_pmem_region_probe(struct platform_device *pdev)
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
> +		of_pmem_register_region(pdev, bus, np, &pdev->resource[i],
> +					is_volatile);
> +	}
>  
> -		if (!region)
> -			dev_warn(&pdev->dev, "Unable to register region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +	i = 0;
> +	while ((mr_np = of_parse_phandle(np, "memory-region", i++))) {
> +		ret = of_address_to_resource(mr_np, 0, &res);
> +		if (ret)
> +			dev_warn(
> +				&pdev->dev,
> +				"Unable to acquire memory-region from %pOF: %d\n",
> +				mr_np, ret);
>  		else
> -			dev_dbg(&pdev->dev, "Registered region %pR from %pOF\n",
> -					ndr_desc.res, np);
> +			of_pmem_register_region(pdev, bus, np, &res,
> +						is_volatile);
> +		of_node_put(mr_np);

Why of_node_put()?

Ira
>  	}
>  
>  	return 0;
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
