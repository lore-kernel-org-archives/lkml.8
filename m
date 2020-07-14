Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1E9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF412221F0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="Xts+McWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgGNGiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgGNGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:38:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEBC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:38:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so6608933pls.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=a1VxGILEG42+H8L6GoViFzWZFZSKw5Ols1wGUf0gdqo=;
        b=Xts+McWZovvImnzKPR+kJgv321ta/+h+TY/aye5u1KOB2hnbQ34iDFo+AZuD1vvRx2
         pFG/PH9yf5hkE7tE9sw1zr8PEmXxMms68RIYOdjI41nx7/RZxGplxkUHqzONT0PK2apj
         1wVUjOeXgsAKDDEZeKAaj3HauILJ/hYAfv6ac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a1VxGILEG42+H8L6GoViFzWZFZSKw5Ols1wGUf0gdqo=;
        b=PVDD0EC2foOkQ8zik9lStNGTL/W1vp0Y6aY9TZAKV11mWOGVay69ve5wcv4IU+8Luo
         AjGOCJmovRP76ajktk43QsX977SI8u6KFB2/jweTpxWPHHLuwBYUPNxHHqXyqDt5mEqk
         o/ixgJBqRlaMjlsJS1EvaaFwWbegrI8m5GcG0Pc7u2HhqGnAUwx/IFm5H5vocg2NYMS7
         DrP6EBR49cDc6ser1N5MxIOkUrkyfAOBZTz2a+p734C0v9OPliKKNCNxQXMXvsvmhZQ0
         qngRM0qjb2ZaTw3yz2+Ji2QkYBnJ5mzCpAnZJDDJZ3+VhL3f+D+h3jinNk/mGiikw4Ul
         YWEw==
X-Gm-Message-State: AOAM530arL383BMJRv9ohWTRHu30u1XmCYlUXcjX2Df/OL7/gozyhUuT
        x/7FLq3KUZ7EDKkmwIpKPYwZPfO1pJM=
X-Google-Smtp-Source: ABdhPJyONPZ3um3fwUzwJ1uRRYNCRh7Wl6QNk16NHZgya2eaSlYdiNMNO4v4tQ2yfRJXmBLelUoxXw==
X-Received: by 2002:a17:90a:1acc:: with SMTP id p70mr3216700pjp.210.1594708725751;
        Mon, 13 Jul 2020 23:38:45 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-0c99-1211-d258-b704.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:c99:1211:d258:b704])
        by smtp.gmail.com with ESMTPSA id p12sm1322396pjz.44.2020.07.13.23.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 23:38:45 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <1594434329-31219-1-git-send-email-nayna@linux.ibm.com>
References: <1594434329-31219-1-git-send-email-nayna@linux.ibm.com>
Date:   Tue, 14 Jul 2020 16:38:41 +1000
Message-ID: <87y2nmtxce.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nayna,

Thanks! Would you be able to fold in some of the information from my
reply to v1 into the changelog? Until we have public PAPR release with
it, that information is the extent of the public documentation. It would
be good to get it into the git log rather than just floating around in
the mail archives!

A couple of small nits:

> +	if (enabled)
> +		goto out;
> +
> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
> +		if (secureboot)
> +			enabled = (secureboot > 1) ? true : false;

Your tests double up here - you don't need both the 'if' statement and
the 'secureboot > 1' ternary operator.

Just

+	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
+		enabled = (secureboot > 1) ? true : false;

or even

+	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot)) {
+		enabled = (secureboot > 1);

would work.

> +	if (!of_property_read_u32(of_root, "ibm,trusted-boot", &trustedboot)) {
> +		if (trustedboot)
> +			enabled = (trustedboot > 0) ? true : false;

Likewise for trusted boot.

Regards,
Daniel

P.S. please could you add me to the cc: list for future revisions?

> +	}
> +
> +out:
>  	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
>  
>  	return enabled;
> -- 
> 2.26.2
