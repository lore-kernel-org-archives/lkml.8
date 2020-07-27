Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E32CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9AAA20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejdZFEQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgG0G0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0G0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:26:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B1C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:26:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ha11so1363296pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SvwHT3zjyXrrBuntHjIVAEV0M2NnXn0+m3b0NtDYJoE=;
        b=ejdZFEQvh05oUlpaaf9ORS5njhfQig6+GWZ5iAPvih6BwIK+yozIcqu5gDr5y2tL56
         ADgJc78zCBS2EW98C0yjIxuIsjhx09ehgqbbeHbAwoyMpOQVXTQH1nMrTOPbKRHgt8O9
         sEQlDf+2CMo4G6gOuRpnv5VESD2+VrOWa7LgfpsijoI1HeDvVons3C2Y9+dsPMLZ1Oz3
         Bdws0mCecBLhZm6sHQMYNW4/SJu9hk164lbUn1lN17jQ742Assa0ed2lVhx7uFglNVLw
         cZMgphZV/5Ax8e+K6npZ4GuvFErEUH7JIESgfsRAUz25GtLadeKzdGjt153zNVy4+pwE
         fIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SvwHT3zjyXrrBuntHjIVAEV0M2NnXn0+m3b0NtDYJoE=;
        b=kApwUAQcn+zExNmi7pXKRGv0RZrhQMMFZaGRLV3j4q7fhVdOvYHEEHpW4VauSaj6/L
         xPaG7teOSy56dJZLBAjw7IW8+RlPHJcDVHdYwuaoZrwl2SkoKBe+lKUI9yG6kdnLwTPl
         ZYISDxaCOJw/ypSkBZ0mKgFLUqqbTJ0qThKFNMS5nXqSi0EjwpSCdXKYQKnQfrvmcWVh
         0Ha9JiYbTLWuWk/K31SJNnPATqEQ6TpkMLGCJ1ZK4Yz/bU0yG0Tzl9Jo+2m4qPUs2d8l
         7xR/shZlU0oCgrAFS4Nmfw61eAChy8m9KSprylU+WQIGrWHd6wGTfNSD16muWAZ7Ilgu
         Qo2w==
X-Gm-Message-State: AOAM532ceRVZmdpJ090/BwdlqXH7plIYl7MlmoiWKirJHMMEYd4hJrpW
        BQBbOyQIuAFDQsB+wav0cmB7ag==
X-Google-Smtp-Source: ABdhPJxzOwp68yM0wuFfeb8opsYwXxFrJEEJC31OdMJvY+oua+KBvMHJty3QtAaz4JwNX0GSAm9idQ==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr17236160plr.336.1595831214315;
        Sun, 26 Jul 2020 23:26:54 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g23sm3090336pfo.95.2020.07.26.23.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 23:26:53 -0700 (PDT)
Date:   Sun, 26 Jul 2020 23:27:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, freedreno@lists.freedesktop.org,
        iommu@lists.linux-foundation.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 04/13] iommu/arm-smmu-qcom: Add implementation for
 the adreno GPU SMMU
Message-ID: <20200727062703.GB3521288@ripper>
References: <20200720154047.3611092-1-jcrouse@codeaurora.org>
 <20200720154047.3611092-5-jcrouse@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720154047.3611092-5-jcrouse@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Jul 08:40 PDT 2020, Jordan Crouse wrote:
> diff --git a/drivers/iommu/arm-smmu-qcom.c b/drivers/iommu/arm-smmu-qcom.c
[..]
> +static int qcom_adreno_smmu_alloc_context_bank(struct arm_smmu_domain *smmu_domain,
> +		struct device *dev, int start, int count)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +
> +	/*
> +	 * Assign context bank 0 to the GPU device so the GPU hardware can
> +	 * switch pagetables
> +	 */
> +	if (qcom_adreno_smmu_is_gpu_device(dev)) {
> +		if (start > 0 || test_bit(0, smmu->context_map))
> +			return -ENOSPC;
> +
> +		set_bit(0, smmu->context_map);
> +		return 0;
> +	}
> +
> +	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);

If we end up here before the GPU device shows up this is going to
steal the first context bank, causing the subsequent allocation for the
GPU to always fail.

As such I think it would be appropriate for you to adjust "start" to
never be 0 here. And I think it would be appropriate to write this
function as:

	if (gpu) {
		start = 0;
		count = 1;
	} else {
		if (start == 0)
			start = 1;
	}

	return __arm_smmu_alloc_bitmap(smmu->context_map, start, count);

Regards,
Bjorn
