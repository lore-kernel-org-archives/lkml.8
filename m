Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D252C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 269B020866
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6tSlUIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgCFHWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:22:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54843 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFHWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:22:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id i9so1166632wml.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Hu3/aCofoV9GF5k7D+bvdKBtAnHD6TZ4MwlP/bXT5AI=;
        b=k6tSlUIEH3PmEyNNy1VP/w3c4DSL+QzxcWPGhDEU/w7ARlvJrn6vvWzcSt7HRfBuCV
         2FjZ1Uqcv3g0DGzuQeK02GlSWQTqigasgjxR3X/O5p/n3FBJHNv8K6sHOsc5lEchz9RL
         +0n4Tcnq6VQbHD4o+xZR4S0KZSzv/KteySWzVe7UpSlLkfwsHKZcvBg3evKmstU00pew
         dXp5/Z1lkyC4lei6Th6PBFOdo2QJqhbOIe2Ib3lO6Y1MwXgv7d5cB2OiRKdOcpx28XAH
         HfclPgnq/le9HebtZDVKGvCgAoTxQB+YzJC123Xw5alfHaR7wqnr0CF3WZKe5xTG2Qoa
         tyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Hu3/aCofoV9GF5k7D+bvdKBtAnHD6TZ4MwlP/bXT5AI=;
        b=GM5O/JRHrb3sgVLnxSNUsSsEz8rOMFgfC93Qahhl9wvX3W1bA93jUKyv/8418+grrz
         MnKqguNE+F4AbGfRYyKdkaqMYjBXSH9zDCvzYAKPOA2iIJJscH2Fd+1eicgsE9SxOPh3
         56onbQzDUQnEheCwk4F2hWIrBx/LAay5fJ6uGb2sDmeGyyO4J2jOCuVsw03P0qVdUS2T
         ToUrJrzLS164pb59asavVZSYS2TmNUPFB/6nP5nHn2LzYPPIn8sPb5zD8bXtFIWbjCBo
         wBUUdYcKrjEkY0f5vcp8BBEw57PTQ5dG/08YND3Lv4Rck+ECfFa0mMRdulUnn9o7556i
         rhTw==
X-Gm-Message-State: ANhLgQ3pXMNB++93rTE8C91mihZ1WtZfZhiPSnSQKMOKGtSJq0nFIC6L
        v12rz0FnIX15Gh7zAl654eMKCA==
X-Google-Smtp-Source: ADFU+vudiCEvMit8BShDvyPfomy18ETJ5jFbkxGmnWGipfFDJ3asLxX5ZOYt/x9itLh0RYZ7P3Y4sA==
X-Received: by 2002:a05:600c:146:: with SMTP id w6mr2364628wmm.75.1583479322692;
        Thu, 05 Mar 2020 23:22:02 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id o11sm37467629wrn.6.2020.03.05.23.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 23:22:02 -0800 (PST)
Date:   Fri, 6 Mar 2020 07:22:42 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Comet Lake PCH-V PCI IDs
Message-ID: <20200306072242.GG3332@dell>
References: <20200113125729.8576-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113125729.8576-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2020, Andy Shevchenko wrote:

> Intel Comet Lake PCH-V has the same LPSS than Intel Kaby Lake.
> Add the new IDs to the list of supported devices.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
