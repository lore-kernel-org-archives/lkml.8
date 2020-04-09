Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34985C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AAA120753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgDIPlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:41:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:28758 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbgDIPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:41:25 -0400
IronPort-SDR: fE8XM5bCxifSwp0dJ12u2QwUG0xtPTkCWQgQSCEHsOgOa3L6ZWO98pW9DY5AFhKOyZldwaDi7h
 PbOmqrrtJV5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 08:41:25 -0700
IronPort-SDR: iNogsqV2AsJTGmDcYQ45c5IPeWZjcrV8PHKh6czAO77rTbQoPqKf85OQh7HVcrM8XWz5p4jEZf
 BlaQiOkWGc3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,363,1580803200"; 
   d="scan'208";a="257831521"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga008.jf.intel.com with ESMTP; 09 Apr 2020 08:41:25 -0700
Date:   Thu, 9 Apr 2020 08:41:24 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libnvdimm/security: make
 __nvdimm_security_overwrite_query() static
Message-ID: <20200409154124.GA801897@iweiny-DESK2.sc.intel.com>
References: <20200409084857.44169-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409084857.44169-1-yanaijie@huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 04:48:57PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/nvdimm/security.c:416:6: warning: symbol
> '__nvdimm_security_overwrite_query' was not declared. Should it be
> static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 89b85970912d..11fb5ada70ad 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -413,7 +413,7 @@ static int security_overwrite(struct nvdimm *nvdimm, unsigned int keyid)
>  	return rc;
>  }
>  
> -void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
> +static void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  {
>  	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(&nvdimm->dev);
>  	int rc;
> -- 
> 2.17.2
> 
