Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B4DC433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 058482074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A53/TAW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbgG0Rlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbgG0Rlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:41:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF2CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:41:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so8472068plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=anIhz+sUWSZj2LLbB+V68VzBj1HjbcN4RzXAFjEj7pk=;
        b=A53/TAW3iJzAqM3UVSdj8n8yLACsMpMkFdUpHx7hdCQwG5BdtaS1xgwPMV27wBQGBX
         ezA9FGjP8KpBIMFbq6O1w6hZ5uE9zlro/tDge9V3CGS8LA+F3KYOrKBXfNOBqsZ0N4op
         Pnnt/7hiVk3as30/qnaqFkpxDj/Jth8sa2E98wzqaMrUnSHN6g9WHuFTrpjPorz0dF1w
         uUZh5BYXRB6CQu8wdCgc/AYY1B+S4ZZSoz2LbWiJPBXSOxpMlGafLRIqQfP+VdgdMYgM
         LufmOjVkc9jvN82+yXkl2ir4gO2HOOlSAWkfzpkioWoj8YS+kQePQp3n+03q9SMhyNE/
         Qesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=anIhz+sUWSZj2LLbB+V68VzBj1HjbcN4RzXAFjEj7pk=;
        b=LFK+FwYxznM/XXVRPeTelNxmcr31oV0YM8FseEIFPtxKTh4ouYXTlD7QjC3BuVWwYB
         wNKeMYlM821VCpWtf6o+r162YJVNosIDkeGitJmXJlYPaK9tR6/qr/8uTyuGCr9706aA
         WziiOoH9oMu9USplieFhB+eTpUMyOdq0fToBbWRwv0gu8KD7lCopbCWqIBL6fQZgtJf5
         r9EIzL7FeVnAi/wQIp/RZdVs1IsoOHeMw91gHsH0aMbmSDqpmQEYM6U7pR0V0kfXi++X
         OThU+z8YWkowWNtRQLN5ev0edcg1BbDRdnpsh4qMwpMinAVzzTNvIpHxr/VXlSk9GQFO
         l5dQ==
X-Gm-Message-State: AOAM533FSZrWFLa1i7kujkRcosUZG0WxypKBtbrCOldESdfCXU9UInX6
        OFPsKBeMS8nLBHxH6JvqSTXI6g==
X-Google-Smtp-Source: ABdhPJxonNO7C1s8c7dsZ01iiSbx7OWhiK4Kk7C7FePc4SZXpL20+c+k2aEeLh7w9nx+KMSqOYL4mg==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr19649190pls.61.1595871712379;
        Mon, 27 Jul 2020 10:41:52 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id u13sm201376pjy.40.2020.07.27.10.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 10:41:51 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:38:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        akashast@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: Add bulk API helpers
Message-ID: <20200727173818.GE63496@builder.lan>
References: <20200528162542.30158-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528162542.30158-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 May 09:25 PDT 2020, Georgi Djakov wrote:
> diff --git a/drivers/interconnect/bulk.c b/drivers/interconnect/bulk.c
> new file mode 100644
> index 000000000000..9bd418594665
> --- /dev/null
> +++ b/drivers/interconnect/bulk.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/interconnect-provider.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +
> +/**
> + * of_icc_bulk_get - get interconnect paths

Parenthesis on the function name here, and on the other functions below.

> + * @dev: the device requesting the path
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the table with the paths we want to get
> + *
> + * Returns 0 on success or -EERROR otherwise.

s/-EERROR/negative errno/

> + */
> +int __must_check of_icc_bulk_get(struct device *dev, int num_paths,
> +				 struct icc_bulk_data *paths)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		paths[i].path = of_icc_get(dev, paths[i].name);
> +		if (IS_ERR(paths[i].path)) {
> +			ret = PTR_ERR(paths[i].path);
> +			dev_err(dev, "of_icc_get() failed on path %s (%d)\n",
> +				paths[i].name, ret);

I think you only should print this error if ret != -EPROBE_DEFER.

> +			paths[i].path = NULL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;
> +
> +err:
> +	icc_bulk_put(i, paths);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(of_icc_bulk_get);
> +
> +/**
> + * icc_bulk_put - put a list of interconnect paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table with the paths being put
> + */
> +void icc_bulk_put(int num_paths, struct icc_bulk_data *paths)
> +{
> +	while (--num_paths >= 0) {
> +		icc_put(paths[num_paths].path);
> +		paths[num_paths].path = NULL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(icc_bulk_put);
> +
> +/**
> + * icc_bulk_set - set bandwidth to a set of paths
> + * @num_paths: the number of icc_bulk_data
> + * @paths: the icc_bulk_data table containing the paths and bandwidth
> + *
> + * Returns 0 on success or -EERROR otherwise.
> + */
> +int icc_bulk_set_bw(int num_paths, const struct icc_bulk_data *paths)
> +{
> +	int ret = 0;
> +	int i;
> +
> +	for (i = 0; i < num_paths; i++) {
> +		ret = icc_set_bw(paths[i].path, paths[i].avg_bw,
> +				 paths[i].peak_bw);

You can unwrap this line.

Regards,
Bjorn
