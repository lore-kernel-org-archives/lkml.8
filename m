Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A68C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A6F21D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BdvJXjlS";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="lKFfB2NE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIKIRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:17:08 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:54962
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725550AbgIKIQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812218;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=sWqVcwjm5FNynpqVYJsxE5W+DApHV2ECDPYWHgy9rMM=;
        b=BdvJXjlSaJ3nTahiwB5N6PxEZQA1vwRE+5jObc7q5RlJOGQoqkKriLylGsYNQouQ
        NrZlZGBOIanDQyivmEvEI36gfRamwQjHuMgo9F/7O5oJKsyzmm/+TM/XOstOi8oCye5
        DqNlqwx2h761kA4z/RVxyscQBtyJK7enrXacRJ3k=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812218;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=sWqVcwjm5FNynpqVYJsxE5W+DApHV2ECDPYWHgy9rMM=;
        b=lKFfB2NExmklmKUM+XfaxgJqkwap7VwTc0u+l7NI+W424kdglxFuepyXUtxhgw1c
        qQwssx5LvdXx6kGHOqD759KVCd0s6ihhcuThhL6tBD8R2RsspsXijK+ey5bqxNTRwaX
        S8G01s/cquV6Oq+zF/cil7kKEfLPOUayCUJPtc2A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 08:16:58 +0000
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] iommu/arm-smmu: Support maintaining bootloader
 mappings
In-Reply-To: <20200904155513.282067-1-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
Message-ID: <010101747c3d2e2e-d8ff7403-32c3-4155-88a5-a05e7985c7f7-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 2020-09-04 21:25, Bjorn Andersson wrote:
> Based on previous attempts and discussions this is the latest attempt 
> at
> inheriting stream mappings set up by the bootloader, for e.g. boot 
> splash or
> efifb.
> 
> Per Will's request this builds on the work by Jordan and Rob for the 
> Adreno
> SMMU support. It applies cleanly ontop of v16 of their series, which 
> can be
> found at
> https://lore.kernel.org/linux-arm-msm/20200901164707.2645413-1-robdclark@gmail.com/
> 

Thanks for working on this, I have tested this on qcom platforms
where firmware does these shenanigans(most android) and this series
works well and where firmware doesn't do all this (chrome) and no
regressions there. Review and test tags given on individual patches.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
