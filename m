Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DE9C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D75C8207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="fc/Q95Yr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD3V7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgD3V7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:59:23 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3661AC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:59:23 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so2378424lfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/pudPj9Z3XDin0S0F3QD/0p7qf5audyl1OfeTF2rX2k=;
        b=fc/Q95YrYrYUFOA9a9LZRPKWlYtrdG/4WUSQYHdvOUGlmrgqhbNEi9tbXm1L/69Cr+
         434cWf0TQ2YAaczpTW6CnEE5si+Wl8AZVpne/5WLW8MqGfI8YHPyP40WUVjOQWGKd7dW
         qjqOB/cFIpBrahYQFHsrBgxnvEaxcIiqt5m3D9B3bSjtanhJ14qG7siZyVf1dxhYldq8
         SuLH3j0PaqLE8RUUqy9DEGxoK5Mi2ozcYBXM9aAM8eEO8DICHX2NGjWspp7rCXc9atAp
         UKIECgFctXH/W7giyd9AI6PJNmIAfuyonJ6TFwCM8u3Ec2MT6U/IXtv8Ihmj3fTngGJH
         M0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/pudPj9Z3XDin0S0F3QD/0p7qf5audyl1OfeTF2rX2k=;
        b=Oc4JaBAY0QX5OCqi89qQC7fJNvaNfpARH0AbK9WtyVurax55grOVe1ug1AQ35vkVSy
         QEKZOAtV7BB8XMawhRw+KlNnI1OX6OpVR9cNQbpku4acbEAEgy+bWD8koovSh/PogFPg
         LJh65BR9lICbLuTwWMw3fYhPfeKehrB7vL60g20dZ/bcOpxerDS123Y1ajZZjNSwJGeB
         bkt5S20rT5SAvAYdBEtGa6OzKzxzV64l++2zqxHU9Z9J8bc5quG2KLaiLmY4yZTHtToV
         un/1tmW9P7LVv3/wzcNXKSJr1Q2WLBU/09weo9NVCwl9d3V4z9o+gGF2qHMyEL0iTT+9
         1pLw==
X-Gm-Message-State: AGi0PuY+524y9GY6MkxjTSbVpnPOgAQbNIHQrCVx2umZrLL081RxUoXX
        h0oBCefQPVmLB14/4ogCMKbwKQ==
X-Google-Smtp-Source: APiQypJcF2oB/bxZG/9cCepQYZUv7yHEvh5RW/0cskhQgJ0uGU/iHFvu++BRFRg5m4DlrDDJLICyeg==
X-Received: by 2002:ac2:4257:: with SMTP id m23mr448779lfl.141.1588283961342;
        Thu, 30 Apr 2020 14:59:21 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c2sm706801ljk.97.2020.04.30.14.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 14:59:20 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 84161102776; Fri,  1 May 2020 00:59:32 +0300 (+03)
Date:   Fri, 1 May 2020 00:59:32 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [linux-next PATCH 1/2] mm: khugepaged: add exceed_max_ptes_*
 helpers
Message-ID: <20200430215932.5w5dck3rnieppzqa@box>
References: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588200982-69492-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 06:56:21AM +0800, Yang Shi wrote:
> The max_ptes_{swap|none|shared} are defined to tune the behavior of
> khugepaged.  The are checked at a couple of places with open coding.
> Replace the opencoding to exceed_pax_ptes_{swap|none_shared} helpers to
> improve the readability.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  mm/khugepaged.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a02a4c5..0c8d30b 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -339,6 +339,21 @@ struct attribute_group khugepaged_attr_group = {
>  };
>  #endif /* CONFIG_SYSFS */
>  
> +static inline bool exceed_max_ptes_none(unsigned int *nr_ptes)
> +{
> +	return (++(*nr_ptes) > khugepaged_max_ptes_none);
> +}
> +
> +static inline bool exceed_max_ptes_swap(unsigned int *nr_ptes)
> +{
> +	return (++(*nr_ptes) > khugepaged_max_ptes_swap);
> +}
> +
> +static inline bool exceed_max_ptes_shared(unsigned int *nr_ptes)
> +{
> +	return (++(*nr_ptes) > khugepaged_max_ptes_shared);
> +}
> +

Frankly, I find this ugly and confusing. Open-coded version is more
readable to me.

-- 
 Kirill A. Shutemov
