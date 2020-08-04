Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14713C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12043206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 09:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbgHDJ6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 05:58:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:26800 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbgHDJ6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 05:58:19 -0400
IronPort-SDR: A3dFxUuWuP/v7auN7hhQZvDFI2f2i1st2fHIEsYE6ErHYRHp8qNBmqKZYjbT0NDYSydH9H2SAH
 78aE0JR4Oj+Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="237143357"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="237143357"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 02:58:19 -0700
IronPort-SDR: rtJiswVjC6c+8iTGPxKrxJzxSqE725c84BDSnSra8GY500qn6+YrMQAGQa/lhh5Cfei2G9jtHQ
 hmWUthEDclVA==
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="396527560"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 02:58:17 -0700
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id D843F20606; Tue,  4 Aug 2020 12:58:15 +0300 (EEST)
Date:   Tue, 4 Aug 2020 12:58:15 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Bingbu Cao <bingbu.cao@intel.com>
Cc:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        bingbu.cao@linux.intel.com
Subject: Re: [PATCH] nvmem: core: add sanity check in nvmem_device_read()
Message-ID: <20200804095815.GF13316@paasikivi.fi.intel.com>
References: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bingbu,

Thank you for the patch.

On Tue, Aug 04, 2020 at 05:13:56PM +0800, Bingbu Cao wrote:
> nvmem_device_read() could be called directly once nvmem device
> registered, the sanity check should be done before call
> nvmem_reg_read() as cell and sysfs read did now.
> 
> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
> ---
>  drivers/nvmem/core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 927eb5f6003f..c9a77993f008 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1491,6 +1491,13 @@ int nvmem_device_read(struct nvmem_device *nvmem,
>  	if (!nvmem)
>  		return -EINVAL;
>  
> +	if (offset >= nvmem->size || bytes < nvmem->word_size)
> +		return 0;
> +
> +	if (bytes + offset > nvmem->size)
> +		bytes = nvmem->size - offset;

The check is relevant for nvmem_device_write(), too.

There are also other ways to access nvmem devices such as nvmem_cell_read
and others alike. Should they be considered as well?

> +
> +	bytes = round_down(bytes, nvmem->word_size);
>  	rc = nvmem_reg_read(nvmem, offset, buf, bytes);
>  
>  	if (rc)

-- 
Kind regards,

Sakari Ailus
