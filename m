Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83476C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4D720740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 23:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgCSXrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:47:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:23507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726663AbgCSXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 19:47:46 -0400
IronPort-SDR: 9dD2uojPZvTES1JeE4uKY8crjQ//qthW79N8IbYrDZjW2g2W3rv7VzHHTqZIBeGdTrcjYmQx7F
 c3DYXtX0jLog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 16:47:45 -0700
IronPort-SDR: bHiYt5HDMIE9YwlgXNYceQMPMy1leuD0nyfCae+QpsBK3aDPbY2OM/ttnZi/gQiGEcEYRWqsQy
 /wmgw4ygKKLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,573,1574150400"; 
   d="scan'208";a="263895304"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga002.jf.intel.com with ESMTP; 19 Mar 2020 16:47:45 -0700
Date:   Thu, 19 Mar 2020 16:47:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] nvdimm: nd.h: Replace zero-length array with
 flexible-array member
Message-ID: <20200319234744.GA1688758@iweiny-DESK2.sc.intel.com>
References: <20200319230937.GA16648@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319230937.GA16648@embeddedor.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 06:09:37PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:

"won't" be affected?

My reading of [1] indicates that this change will break the allocation in
nd_region_activate() because sizeof() can no longer be used on the base
structure?

What am I missing?

Ira

> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/nvdimm/nd.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
> index c4d69c1cce55..85dbb2a322b9 100644
> --- a/drivers/nvdimm/nd.h
> +++ b/drivers/nvdimm/nd.h
> @@ -39,7 +39,7 @@ struct nd_region_data {
>  	int ns_count;
>  	int ns_active;
>  	unsigned int hints_shift;
> -	void __iomem *flush_wpq[0];
> +	void __iomem *flush_wpq[];
>  };
>  
>  static inline void __iomem *ndrd_get_flush_wpq(struct nd_region_data *ndrd,
> @@ -157,7 +157,7 @@ struct nd_region {
>  	struct nd_interleave_set *nd_set;
>  	struct nd_percpu_lane __percpu *lane;
>  	int (*flush)(struct nd_region *nd_region, struct bio *bio);
> -	struct nd_mapping mapping[0];
> +	struct nd_mapping mapping[];
>  };
>  
>  struct nd_blk_region {
> -- 
> 2.23.0
> 
