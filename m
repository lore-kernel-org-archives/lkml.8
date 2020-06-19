Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0297C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B39421D82
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgFSVg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:36:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:42269 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbgFSVg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:36:26 -0400
IronPort-SDR: OS2KFiwiQh6Hm40mwlWWJTx9T0mF6DuaZKpaN+DweYKGkrykGhpCNFJA3zPD3Pi6Yok2Boi/+o
 IQhZpPl09Jrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9657"; a="140621171"
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="140621171"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 14:36:25 -0700
IronPort-SDR: 4K/HxW4uIuQ0D6dlKG6XYG191cP3Z0mCRfpBOrnwzL11vK8zKp2IHOZo9/kIQcRPP7PbfzSJej
 U0vAS1rcNaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,256,1589266800"; 
   d="scan'208";a="477774556"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2020 14:36:24 -0700
Date:   Fri, 19 Jun 2020 14:36:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] nvdimm/region: Use struct_size() in kzalloc()
Message-ID: <20200619213624.GA3910394@iweiny-DESK2.sc.intel.com>
References: <20200619172112.GA31702@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619172112.GA31702@embeddedor>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:21:12PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/region_devs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 4502f9c4708d..8365fb1a9114 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1063,8 +1063,7 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>  		struct nd_blk_region *ndbr;
>  
>  		ndbr_desc = to_blk_region_desc(ndr_desc);
> -		ndbr = kzalloc(sizeof(*ndbr) + sizeof(struct nd_mapping)
> -				* ndr_desc->num_mappings,
> +		ndbr = kzalloc(struct_size(ndbr, nd_region.mapping, ndr_desc->num_mappings),
>  				GFP_KERNEL);
>  		if (ndbr) {
>  			nd_region = &ndbr->nd_region;
> -- 
> 2.27.0
> 
