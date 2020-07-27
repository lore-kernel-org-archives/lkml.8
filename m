Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98044C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B2C020663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgG0MJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:09:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:57475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgG0MJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:09:09 -0400
IronPort-SDR: 2K7LhbcBJHcjX3jq1KhUL4KanAZEDFKE04d+qHNeLyuyVBfv1F/FtUu7YJre7nxvss/5K5vw06
 rRK+z6XdlJbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148877489"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="148877489"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 05:09:09 -0700
IronPort-SDR: vG9ARVnVR0G3e8Hw4iGLpIChAYRf4SBYy2FFldqF9756jK6syneLqufm1YK5PdpvQ7AR+8p7vP
 zdNK+Bc8vKww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="329659230"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2020 05:09:08 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k01wK-004Gsx-8X; Mon, 27 Jul 2020 15:09:08 +0300
Date:   Mon, 27 Jul 2020 15:09:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel_soc_pmic_mrfld: simplify the return expression of
 intel_scu_ipc_dev_iowrite8()
Message-ID: <20200727120908.GR3703480@smile.fi.intel.com>
References: <20200727030407.8820-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727030407.8820-1-vulab@iscas.ac.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 03:04:07AM +0000, Xu Wang wrote:
> Simplify the return expression.

I understand your intention, but I would rather leave as is.
It's a bit more helpful in the original form in case to add some debugging.
It also keep it symmetrical with read() counterpart.

That said, I'm not objecting the change if Lee finds it good enough.

> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---
>  drivers/mfd/intel_soc_pmic_mrfld.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/intel_soc_pmic_mrfld.c b/drivers/mfd/intel_soc_pmic_mrfld.c
> index bd94c989d232..71da861e8c27 100644
> --- a/drivers/mfd/intel_soc_pmic_mrfld.c
> +++ b/drivers/mfd/intel_soc_pmic_mrfld.c
> @@ -91,13 +91,8 @@ static int bcove_ipc_byte_reg_write(void *context, unsigned int reg,
>  {
>  	struct intel_soc_pmic *pmic = context;
>  	u8 ipc_in = val;
> -	int ret;
>  
> -	ret = intel_scu_ipc_dev_iowrite8(pmic->scu, reg, ipc_in);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return intel_scu_ipc_dev_iowrite8(pmic->scu, reg, ipc_in);
>  }
>  
>  static const struct regmap_config bcove_regmap_config = {
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


