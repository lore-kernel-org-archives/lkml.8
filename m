Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D1DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C0C206E6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 02:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="YwcARj7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgGGCGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 22:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgGGCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 22:06:36 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E2C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 19:06:36 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a14so13172063pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 19:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=ufAMLYZ5uV6bHta35HYJH1XfzcRlJb5HFWlT4qXEYfo=;
        b=YwcARj7v1GayRBLXaoyXzW79MNuNWyyF5vyLq1cIB7n9Y3VhKk3KvpBJF0dJ/fGjWG
         Y2vIYLCAwyATgtfbWA+BrcFEyx7ttSCb2IDdkfYIBwFNYc6GSEetLR/sKHvbA2hgK3qI
         HSd+WUnLi00yppS1fmG+Jf7N1PukSZK6ulkDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ufAMLYZ5uV6bHta35HYJH1XfzcRlJb5HFWlT4qXEYfo=;
        b=Is/ncVCQNp8cXL0EBvh/0/tIM9c6LSg+OYkkdR7DHDyF5XMjlmbRGZ+7XcushU6gAx
         2Qh1wFjnto4njQ3vRsE+723N63A2bP3xmP1byVeQxEm4bsqbcP69A1csPhD3DBB8dpoX
         oMSv18aDI0fxSoEuvlpuYn9NwUtyT9lJMZnXg5XLetmtTrwiU1EJTnl81jghy/Rn98AR
         f6RDhofe7ijxr4mWHa8fJfidVQyMKcIkhESDK4M7pQqmjvPpC4EkBgi6xdzpvwBea5nt
         vM3Of0VCgSwUFPyrOmruCZE8XDIQuMP8cKSgNkEqY+mFmno5+/ZSsDEC8P9FT4RBDtl4
         nNFQ==
X-Gm-Message-State: AOAM531d37JCcqQasZcdAcgwK0GYW5Yu1ZCRzCYOyCGErLFriSr/e2TD
        Vt2qtE8wU9BRudC4/R9niFwoHdGMyE8=
X-Google-Smtp-Source: ABdhPJzLFy1WJWtquEz3mBN0TcABoY5qRw+cnTVC6hS+qEfcSZKtVrJWb+JBCTwkkizgqQEp5HWd9A==
X-Received: by 2002:a63:182:: with SMTP id 124mr40086924pgb.288.1594087595729;
        Mon, 06 Jul 2020 19:06:35 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-4ddf-cfaf-3be5-4008.static.ipv6.internode.on.net. [2001:44b8:1113:6700:4ddf:cfaf:3be5:4008])
        by smtp.gmail.com with ESMTPSA id g9sm19308737pfm.151.2020.07.06.19.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 19:06:35 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com>
References: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com>
Date:   Tue, 07 Jul 2020 12:06:32 +1000
Message-ID: <87a70c3wpj.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Nayna!

I'm hoping to get better public documentation for this soon as it's not
documented in a public PAPR yet.

Until then:

The values of ibm,secure-boot under PowerVM are:

 0 - disabled
 
 1 - audit mode only. This patch ignores this value for Linux, which I
     think is the appropriate thing to do.

 2 - enabled and enforcing

 3-9 - enabled, OS-defined behaviour. In this patch we map all these
       values to enabled and enforcing. Again I think this is the
       appropriate thing to do.

ibm,trusted-boot isn't published by a current PowerVM LPAR but will be
published in future. (Currently, trusted boot state is inferred by the
presence or absense of a vTPM.) It's simply 1 = enabled, 0 = disabled.

As for this patch specifically, with the very small nits below,

Reviewed-by: Daniel Axtens <dja@axtens.net>

> -	node = get_ppc_fw_sb_node();
> -	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
> +	if (machine_is(powernv)) {
> +		node = get_ppc_fw_sb_node();
> +		enabled =
> +		    of_property_read_bool(node, "os-secureboot-enforcing");
> +		of_node_put(node);
> +	}
>  
> -	of_node_put(node);
> +	if (machine_is(pseries)) {
Maybe this should be an else if?

> +		secureboot = of_get_property(of_root, "ibm,secure-boot", NULL);
> +		if (secureboot)
> +			enabled = (*secureboot > 1) ? true : false;
> +	}
>  
>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>  
> @@ -38,11 +48,20 @@ bool is_ppc_trustedboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	const u32 *trustedboot;
>  
> -	node = get_ppc_fw_sb_node();
> -	enabled = of_property_read_bool(node, "trusted-enabled");
> +	if (machine_is(powernv)) {
> +		node = get_ppc_fw_sb_node();
> +		enabled = of_property_read_bool(node, "trusted-enabled");
> +		of_node_put(node);
> +	}
>  
> -	of_node_put(node);
> +	if (machine_is(pseries)) {
Likewise.
> +		trustedboot =
> +		    of_get_property(of_root, "ibm,trusted-boot", NULL);
> +		if (trustedboot)
> +			enabled = (*trustedboot > 0) ? true : false;

Regards,
Daniel

