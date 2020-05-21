Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FF6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF84C206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 17:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ViIzU9LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgEURzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 13:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEURzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 13:55:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A99C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:55:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t8so1331031pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JoWH0REhDbs0g6wW5aH8Wpi/nb2uuxOqbrdrCjoMjrI=;
        b=ViIzU9LQNw75MOmE5VTuvUeN7jOryNVvFx8+ZRqtUDHTR/f7tFcd1DOLXKl2MVNFkc
         bDkpesjGCYOnam7JUaI3LXRpBilNYiFEh59k86RsudmUF2WC0ooRRmnnLQstWRrUfhkD
         3IwUlrFgtq6L4Qfi/0mnC1RtiFOlTdlBw0v5hinyynS+56wyDNYHuErMi/UCXK3JyaNX
         +ReL8f/44ulBHJeT0QOhGuy1ogAjkOEKjI2kN8ag8NeGfX2jMoqsKIooGz5WxwI+lMDo
         ErtkvJSA70kUA7bsK7dYUHKa7qIPiVOCh97AywxPbXQv8rxZzW+Ie6mTpCBHNDGjAura
         X+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JoWH0REhDbs0g6wW5aH8Wpi/nb2uuxOqbrdrCjoMjrI=;
        b=nBCZNW39QeVBEgF4Wn5M68zWgj17MtGQ1KbXlZcMsAbKk1PC2PCjWoly/BOh7QQQwR
         HvYiYnkM8ncAhQR4TYE8jiUVBHfdP4CpVvPpRXozYNXz62YyBXh0uhxpMZBna94uGtpo
         qjEOuBa3TAhsbeTYCr/dF3VqFaTKPaDhSvmCgS15bhRLhx5bQ0f6EWKpA9Z3HNY1AiZR
         Zf7XfqVIxHGl4bsaSl1L+kHxNCfuWkgqwxUvZhjtzRXvaOw80J/YoWauBmwCb8BX8S4Z
         qN+ZrzBQ2YmsSc2oMfsQEJ/NLWOfzxGkYRl+Q6ezq9H/kGrzKqjp5MMmIhz5P4wCJsoN
         lLRw==
X-Gm-Message-State: AOAM533DczRDFfOClAQSJKKb5ML+chGIhuP9eS6TWa6Nsd/wc/4rK78X
        mI9BciuseN7iB/Lz4IkGqqseuA==
X-Google-Smtp-Source: ABdhPJxUxM/4rA75txn9J9XgVlPotcY/sB5d7p6t+dugQ766LOaek96hXGfg0EBf4J82FWYt5XNlkA==
X-Received: by 2002:a17:90a:ea98:: with SMTP id h24mr12335013pjz.195.1590083740620;
        Thu, 21 May 2020 10:55:40 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v75sm5160768pjb.35.2020.05.21.10.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 10:55:39 -0700 (PDT)
Date:   Thu, 21 May 2020 10:54:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] remoteproc: introduce version element into resource
 type field
Message-ID: <20200521175421.GI408178@builder.lan>
References: <20200325204701.16862-1-s-anna@ti.com>
 <20200325204701.16862-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325204701.16862-3-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25 Mar 13:46 PDT 2020, Suman Anna wrote:

> The current remoteproc core has supported only 32-bit remote
> processors and as such some of the current resource structures
> may not scale well for 64-bit remote processors, and would
> require new versions of resource types. Each resource is currently
> identified by a 32-bit type field. Introduce the concept of version
> for these resource types by overloading this 32-bit type field
> into two 16-bit version and type fields with the existing resources
> behaving as version 0 thereby providing backward compatibility.
> 
> The version field is passed as an additional argument to each of
> the handler functions, and all the existing handlers are updated
> accordingly. Each specific handler will be updated on a need basis
> when a new version of the resource type is added.
> 

I really would prefer that we add additional types for the new
structures, neither side will be compatible with new versions without
enhancements to their respective implementations anyways.

> An alternate way would be to introduce the new types as completely
> new resource types which would require additional customization of
> the resource handlers based on the 32-bit or 64-bit mode of a remote
> processor, and introduction of an additional mode flag to the rproc
> structure.
> 

What would this "mode" indicate? If it's version 0 or 1?

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  drivers/remoteproc/remoteproc_core.c    | 25 +++++++++++++++----------
>  drivers/remoteproc/remoteproc_debugfs.c | 17 ++++++++++-------
>  include/linux/remoteproc.h              |  8 +++++++-
>  3 files changed, 32 insertions(+), 18 deletions(-)
> 
[..]
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 77788a4bb94e..526d3cb45e37 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -86,7 +86,13 @@ struct resource_table {
>   * this header, and it should be parsed according to the resource type.
>   */
>  struct fw_rsc_hdr {
> -	u32 type;
> +	union {
> +		u32 type;
> +		struct {
> +			u16 t;
> +			u16 v;
> +		} st;

I see your "type" is little endian...

Regards,
Bjorn
