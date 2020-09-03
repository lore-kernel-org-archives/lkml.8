Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0350BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD93A20658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgICOMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:12:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:34932 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729142AbgICOKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:10:07 -0400
IronPort-SDR: c7qgbts54Y3P1Y2SvMcDeRwFb6ohKhODd/xjnUjbw+0b31oewotWf3NS8hnxECQPMUneM7P8g5
 r7byl4bChipQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="219129982"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="219129982"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 07:09:39 -0700
IronPort-SDR: rkZ0Olar/QMGUYe0mhdZgEL72iAnn+i/sGoky55dDU7fVd4VgjWgmNUES9gyd25QUNbpwm4FXb
 Cij5BElBsaRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="331797666"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2020 07:09:37 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kDptc-00E2xB-51; Thu, 03 Sep 2020 17:07:24 +0300
Date:   Thu, 3 Sep 2020 17:07:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] media: atomisp: get rid of
 -Wsuggest-attribute=format warnings
Message-ID: <20200903140724.GE1891694@smile.fi.intel.com>
References: <cover.1599141140.git.mchehab+huawei@kernel.org>
 <6c77d765707b1e6b2901fd23d85b4d032f1a1799.1599141140.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c77d765707b1e6b2901fd23d85b4d032f1a1799.1599141140.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:57:32PM +0200, Mauro Carvalho Chehab wrote:
> There are some warnings reported by gcc:
> 	drivers/staging/media/atomisp//pci/atomisp_compat_css20.c:164:2: warning: function ‘atomisp_css2_dbg_print’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 	drivers/staging/media/atomisp//pci/atomisp_compat_css20.c:170:2: warning: function ‘atomisp_css2_dbg_ftrace_print’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 	drivers/staging/media/atomisp//pci/atomisp_compat_css20.c:170:2: warning: function ‘atomisp_css2_dbg_ftrace_print’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 	drivers/staging/media/atomisp//pci/atomisp_compat_css20.c:176:2: warning: function ‘atomisp_css2_err_print’ might be a candidate for ‘gnu_printf’ format attribute [-Wsuggest-attribute=format]
> 
> That are due to the usage of printf-like messages without
> enabling the error checking logic.
> 
> Add the proper attributes in order to shut up such warnings.

> +static int  __attribute__((format (printf, 1, 0)))
> +atomisp_css2_dbg_ftrace_print(const char *fmt, va_list args)
>  {
>  	ftrace_vprintk(fmt, args);
>  	return 0;
>  }
>  

Why not to drop it completely as well?

> -static int atomisp_css2_err_print(const char *fmt, va_list args)
> -{
> -	vprintk(fmt, args);
> -	return 0;
> -}


-- 
With Best Regards,
Andy Shevchenko


