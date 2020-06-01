Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB4020659
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 04:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MoT4G10i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgFAEHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 00:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAEHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 00:07:46 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F8C08C5CB
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:07:45 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so2883481pgm.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 21:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+6ownZMPIgJJdia/JCvZ/qOK36qij75yfOhvnZqmGDk=;
        b=MoT4G10i1QXRhHmSLvbhdqLIFOsga5P29Iy8cfjKMfdpgwmgMC65N9xZ/pXrQh2M0L
         u3tOTwAiW98462Lh4X4ZoucKG+NEqtadraC3IqVW6XaglxEAryoj1UdXBVy4j8JBC1se
         QI+FOF0aiVjU0eW0aPnDuYAN/r1AWtS7SNafakuv+FvamuiseKiQ9PeZApiBwLWxRwfU
         fXYVA78P4ovkSxWztSVfDyIDwrr+sMhuPHj3It/gmfI/hHQswR+y+wsfDzeHLxqY25EN
         LDGDz3Xi2L9L7EMyzWTyui2bBFWiLMi/XSSO1cbbQfcZO73vGk8K9IXa7QCL4yY0hJYz
         qa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+6ownZMPIgJJdia/JCvZ/qOK36qij75yfOhvnZqmGDk=;
        b=IJzDCTEhmvkzNI0uKvBSKCKQguqqWuyeqdUlgbQM1gfzKD0iIWmtzYVhXv6KUdO98+
         s/XGq3H9unYgYRvur/q2m+65K1kc866nsT1MTH+0ghVtn4M27Z9JZG1UJ6AIDqqIZXhu
         J0ldOVMZ+vKTVnjw3HlWlOEQy9CyZXxJG9pa0vOW2wgYeuyO90FW2rHrL6wJfRniWaW3
         jnySQO1UaQ/Vn2EW7CATaMlCx9y9UwP6tV/mw+zxY54uIzORpA0rZoOyxLz6MN1JM6tX
         uNTObf+ovt0UqKjc4xzjo+49nU2krpJV7BnK5/m4MAnCujjxgNmj9t2nGy7kGj7zAkZ2
         L1yg==
X-Gm-Message-State: AOAM531X3Dyxrjd3aVd1+6t4c351RAGOMpbnj5WYdv8Z1fC1CY11dOGM
        HEMwKPglkQLWkkr1L64b+ENMZw==
X-Google-Smtp-Source: ABdhPJx2sQD+gYk0YMveVCSJnx6ztfk0oDnR8Id3d7XxHmX6wCFUYDgpyaGtL8cCxpigl5RQ7QO+Fg==
X-Received: by 2002:a05:6a00:150e:: with SMTP id q14mr18059424pfu.325.1590984465237;
        Sun, 31 May 2020 21:07:45 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id 140sm9923609pfy.95.2020.05.31.21.07.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 May 2020 21:07:44 -0700 (PDT)
Date:   Mon, 1 Jun 2020 09:37:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, nm@ti.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, saravanak@google.com, mka@chromium.org,
        smasetty@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] OPP: Check for bandwidth values before creating icc paths
Message-ID: <20200601040742.3a4cmhrwgh2ueksy@vireshk-i7>
References: <20200527192418.20169-1-sibis@codeaurora.org>
 <20200529052031.n2nvzxdsifwmthfv@vireshk-i7>
 <0205034b0ece173a7152a43b016985a7@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0205034b0ece173a7152a43b016985a7@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-20, 19:47, Sibi Sankar wrote:
> opp_np needs to be subjected
> to NULL check as well.

No, it isn't. It should already be valid and is set by the OPP core.
Actually we don't need to do of_node_get(opp_table->np) and just use
np, I did that to not have a special case while putting the resource.

> Tested-by: Sibi Sankar <sibis@codeaurora.org>
> Reviewed-by: Sibi Sankar <sibis@codeaurora.org>

Thanks.

-- 
viresh
