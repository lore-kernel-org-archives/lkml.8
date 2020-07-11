Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB4C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2612075D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 03:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGKDbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 23:31:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:35138 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgGKDbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 23:31:48 -0400
IronPort-SDR: og6m0CsWNBUNmLM7e5Jx93pdS6K2tQaDpTqVPU3khvm7qDVGB1w/juQoFG5mDo46+4UrmsxOc9
 EQK68zCV3d2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9678"; a="128400296"
X-IronPort-AV: E=Sophos;i="5.75,338,1589266800"; 
   d="scan'208";a="128400296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 20:31:48 -0700
IronPort-SDR: R27/5kAH4jxB5nKGWxbKWAGF3DUoXqlbh9j5uNEDeZAP60+BAeYUJ23ptSwG5IhclO9CNjOiCJ
 Rxems7J6o5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,338,1589266800"; 
   d="scan'208";a="316792120"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2020 20:31:47 -0700
Date:   Fri, 10 Jul 2020 20:31:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] device-dax: make dev_dax_kmem_probe() static
Message-ID: <20200711033147.GA3008823@iweiny-DESK2.sc.intel.com>
References: <20200707112340.9178-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707112340.9178-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 07:23:40PM +0800, Wei Yongjun wrote:
> sparse report warning as follows:
> 
> drivers/dax/kmem.c:22:5: warning:
>  symbol 'dev_dax_kmem_probe' was not declared. Should it be static?
> 
> dev_dax_kmem_probe() is not used outside of kmem.c, so marks
> it static.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Seems ok,

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f87399..87e271668170 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -19,7 +19,7 @@ static const char *kmem_name;
>  /* Set if any memory will remain added when the driver will be unloaded. */
>  static bool any_hotremove_failed;
>  
> -int dev_dax_kmem_probe(struct device *dev)
> +static int dev_dax_kmem_probe(struct device *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  	struct resource *res = &dev_dax->region->res;
> 
