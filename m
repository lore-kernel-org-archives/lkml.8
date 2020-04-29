Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46984C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB8D20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BtnKVoGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD2SIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2SIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:08:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3C8C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:08:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so1122476plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jgBesrZnxL+kYNZAUBc2q+AIqwIcsT3SbcObjZ7pa0c=;
        b=BtnKVoGw4kWLf1dY5ZduBxtig5LWR/+sTfMaOBFb7ji6TCHMdWzbkCejWER0S+j3+M
         0KbT39v5FI1GqWAqgBt1a5pt8r7kBNANGTYOO0Z9FsNeE7aVu56ZIotcaii0lzzPOkq8
         fiMwloXlhwUl5/A3l1efDgqVkGIUqbvwKCF4gLAM1J21QirA23ksdEKRDzLeM/ne9HPW
         muSQY6CkBxeSN/6WR9uSsuK1ZSSW975apfCBU0ez259rvXb+K/NogBQgAFYDoFDFPT5H
         sMSXN+0EiL1JKooomEb8IMKO3OTVOOT7M/1zWIGSQIhJZBdTixGA3oAj+l2bgC3cpBWE
         Jx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jgBesrZnxL+kYNZAUBc2q+AIqwIcsT3SbcObjZ7pa0c=;
        b=r3k2aF7wCEs8kk3FziEn9v6xhu06DHX4souj1RNa9MlNLYb1J3Nnew8fjZMrgK7798
         J0nqqE5h7fmzcPTOBJAiyWVsHbDf6lWjGPfkQHqcxX+U8y0aiJpR9doZ0d7you+eaZ/Z
         B0L0QjwrEnRDKdrCzSs2sXHaf2lzNkdC73WIs16/k0J7DDa92JaOmiPOJAaHhMnHtfh9
         wbRLgylEMtVYA7Q5+zR1NAGHoCRzbAk+Gxymo8EZYvU88gYC7AWUn/uIWQPljxbV2w85
         e0k20BvMOEDLofOsFoI7WAq6d6wMmBXa1mXAJV1MgjiUW9G9zOnSsoYuc9gVbrO4rx6S
         zfIw==
X-Gm-Message-State: AGi0PuYR6LPbP4srkb+4z++Z61LegJ22ZJqGdC1wHaol934wB4lZHmNn
        oAbJGpaGPlq+efU5H6Iz5Cs2lXA9bxw=
X-Google-Smtp-Source: APiQypIrICIQc3PhjIH1wr0MALmKG/hxL05bEOwS+tytX4MzkuSmDE71EzBQl9ILXyX0kZP0iWI4Kw==
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr4640772pjb.134.1588183702070;
        Wed, 29 Apr 2020 11:08:22 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 202sm1497020pgf.41.2020.04.29.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:08:21 -0700 (PDT)
Date:   Wed, 29 Apr 2020 12:08:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v2 1/2] coresight: Include required headers in C files
Message-ID: <20200429180818.GA3062@xps15>
References: <20200428181010.170568-1-swboyd@chromium.org>
 <20200428181010.170568-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428181010.170568-2-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Apr 28, 2020 at 11:10:09AM -0700, Stephen Boyd wrote:
> We should include headers that C files use in the C files that use them
> and avoid relying on implicit includes as much as possible. This helps
> avoid compiler errors in the future about missing declarations when
> header files change includes in the future.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../hwtracing/coresight/coresight-cti-platform.c    |  8 +++++++-
>  drivers/hwtracing/coresight/coresight-cti-sysfs.c   |  7 +++++++
>  drivers/hwtracing/coresight/coresight-cti.c         | 13 +++++++++++++
>  drivers/hwtracing/coresight/coresight-cti.h         |  8 +++++++-
>  4 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index c6c0c9b4827e..ab3bd4ed0910 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -2,11 +2,17 @@
>  /*
>   * Copyright (c) 2019, The Linaro Limited. All rights reserved.
>   */
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
>  
>  #include <dt-bindings/arm/coresight-cti-dt.h>
> -#include <linux/of.h>
>  
>  #include "coresight-cti.h"
> +#include "coresight-priv.h"
>  
>  /* Number of CTI signals in the v8 architecturally defined connection */
>  #define NR_V8PE_IN_SIGS		2
> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> index aeea39cbd161..77e14e770806 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> @@ -4,7 +4,14 @@
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
>  
> +#include <linux/atomic.h>
>  #include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>

What is io.h and slab.h used for in coresight-cti-sysfs.c ?

>  
>  #include "coresight-cti.h"
>  
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 7fc1fc8d7738..be61c1705916 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -4,7 +4,20 @@
>   * Author: Mike Leach <mike.leach@linaro.org>
>   */
>  
> +#include <linux/amba/bus.h>
> +#include <linux/atomic.h>
> +#include <linux/bits.h>
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/io.h>

Same comment as above.

No need to send another version if these are mistakes - just let me know and
I'll do the adjustment.

Thanks,
Mathieu

> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/spinlock.h>
> +
> +#include "coresight-priv.h"
>  #include "coresight-cti.h"
>  
>  /**
> diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
> index 004df3ab9dd0..acf7b545e6b9 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.h
> +++ b/drivers/hwtracing/coresight/coresight-cti.h
> @@ -7,8 +7,14 @@
>  #ifndef _CORESIGHT_CORESIGHT_CTI_H
>  #define _CORESIGHT_CORESIGHT_CTI_H
>  
> -#include <asm/local.h>
> +#include <linux/coresight.h>
> +#include <linux/device.h>
> +#include <linux/fwnode.h>
> +#include <linux/list.h>
>  #include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +
>  #include "coresight-priv.h"
>  
>  /*
> -- 
> Sent by a computer, using git, on the internet
> 
