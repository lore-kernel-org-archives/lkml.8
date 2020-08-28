Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF33C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71625208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hy743HXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgH1Kts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbgH1Ktq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:49:46 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA04C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:49:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u18so508647wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5aRMm99tvY3+q4iYH77WncVthlFZpDAvEYOPwFYZI5g=;
        b=Hy743HXhOnsB4u2BHJ1TsjCmObq5JgM7OLUdalht28lMQ0uSt9c5IZaOHZ203WXmHl
         SC3Lb3i7+GpTzOKfe3wmtPoABKs5LFYZzsqDS31W/T52CC/79pj/5cv9ApUrYI2GldXL
         tva1dguHy10B7mvZq3KrhOU9N5tgnB5hJ+2i7Y9UNqBaNqkRrj018m7DioELGm0/OwT+
         ko/y95UCLMUoX3X03tXQnpo5VimSFkSdJzxd58jmnBy0UT2M78l9QPJlkIfjGzAyc4My
         GshvNzEeQ26wi4oPmRitqUyDbzVqSrtuiVHoKqQ2W+FPXl2NTSACReJwUnN70z8vnrIK
         DpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5aRMm99tvY3+q4iYH77WncVthlFZpDAvEYOPwFYZI5g=;
        b=R2QFg5uuVHWPMQBS3jUpMETA0go6V+YGl59y93/kRb1BfVTeKQsauGT5PhhsszyN3G
         s4PV8OHAl2kyDfTGQd2iG5ZoWpuf5VLpBd1aabdjzjK/qs5UTowttxK79ogPzimwHK1B
         H+g6CPFMk8j8TmKgmwbvKH9DrRZ2QjBdycpbMJxj9SQMvb+6pqP89YnXiixJK39nOkTc
         kQq88854D2UMOKW+ht60jAlgWrA/uNp6u72BOLZgtP9Y5kEeS+/64c9IT78K0jg+1smd
         p2y0DhgV9a5djFHwW57dv49pXH0m+OVU7tTeLGLYAp8xqNKKF4J/LWmTRKxSXnjLn5cb
         FciA==
X-Gm-Message-State: AOAM530thXR1ZS3K40tHtM/N9gFmSFkFSWPhuHKR3E2CeuXodUs6hTuM
        PjpLufIPNCDWnrnYxw3SRQc58Q==
X-Google-Smtp-Source: ABdhPJy6D93o02xyGeXCN4MkZLjhROlydCxXm44jTAcZeJrHwl/ZGnlaRk5cgFmZsMTg++7C58CE6A==
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr1063334wmh.95.1598611784221;
        Fri, 28 Aug 2020 03:49:44 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id d21sm1629172wmd.41.2020.08.28.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:49:43 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:49:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2] mfd: intel-lpss: Add device IDs for UART ports for
 Lakefield
Message-ID: <20200828104941.GR1826686@dell>
References: <20200821142509.20133-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821142509.20133-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020, Andy Shevchenko wrote:

> Add PCI IDs for Lakefield to the list of supported UARTs.
> 
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
