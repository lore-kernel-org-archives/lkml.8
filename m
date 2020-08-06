Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41862C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C8C221E2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHFT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:26:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:16245 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:26:19 -0400
IronPort-SDR: 0YwRtNaPrNoPInVYLv4y764QNkcTaNatjSypA5KS6E+Mzum4ORSrLpXof0lLeIgZLmD8Td5MGU
 yXZBTBM2Q32Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="237762621"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="237762621"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 12:25:58 -0700
IronPort-SDR: 1J++mHly7JMLbXnbQvdotUfwoonPHaDEiQz1Yj+f2h4WOUcVed8vm6wQm75BDPH8yXRlM/ioHZ
 8xLrTr1odK2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="scan'208";a="397360030"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga001.fm.intel.com with ESMTP; 06 Aug 2020 12:25:58 -0700
Date:   Thu, 6 Aug 2020 12:25:58 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, jmoyer@redhat.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] libnvdimm/security: fix a typo
Message-ID: <20200806192557.GK1573827@iweiny-DESK2.sc.intel.com>
References: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596494499-9852-1-git-send-email-jane.chu@oracle.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:41:37PM -0600, Jane Chu wrote:
> commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> introduced a typo, causing a 'nvdimm->sec.flags' update being overwritten
> by the subsequent update meant for 'nvdimm->sec.ext_flags'.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/nvdimm/security.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
> index 4cef69b..8f3971c 100644
> --- a/drivers/nvdimm/security.c
> +++ b/drivers/nvdimm/security.c
> @@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
>  	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
>  	put_device(&nvdimm->dev);
>  	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
> -	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
> +	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
>  }
>  
>  void nvdimm_security_overwrite_query(struct work_struct *work)
> -- 
> 1.8.3.1
> 
