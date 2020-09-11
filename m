Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB30C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2202C221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="odBs8A4X";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="nmLkc2V0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgIKI2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:28:33 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:48868
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbgIKI23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599812909;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=AF0aaEeeABMRiaod41CZl6nU6jmhklN/FTm5KGi6onI=;
        b=odBs8A4XTUUytzUNxS4NY+IjPQBdzY33hddJaLSjfpbL+TgCYgbVcQIMQMKK13KC
        ruNBrtJA2MgezEzOXBpL6C79BlwXw5XwImNQnbRYmZiHoNpVySnsTJn/TJjKuhGcBEo
        DSYFvwDAdKHFR7mlBS56RF3PxiFr99zkajvm4YoA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599812909;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=AF0aaEeeABMRiaod41CZl6nU6jmhklN/FTm5KGi6onI=;
        b=nmLkc2V0sVOUJptLjee5+PMinfOzQJJQYIN5HxIejQ3hkipk5qJ3WzSYQOQ1zSV9
        +RstEjuE3cT8/OrIP7q7F+PasF1BHbOpRhsmnibNSi4FtHIC56jhCX9141fiuYRy4pn
        s1ckmdSU1YnQ23DcCKSFlsaJE0XXkOci0+H7Vxrg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 11 Sep 2020 08:28:29 +0000
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 7/8] iommu/arm-smmu: Provide helper for allocating
 identity domain
In-Reply-To: <20200904155513.282067-8-bjorn.andersson@linaro.org>
References: <20200904155513.282067-1-bjorn.andersson@linaro.org>
 <20200904155513.282067-8-bjorn.andersson@linaro.org>
Message-ID: <010101747c47b95c-9d1ba2fa-0cc2-4870-a249-a1022fd6e37e-000000@us-west-2.amazonses.com>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.11-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-04 21:25, Bjorn Andersson wrote:
> Some platform implementations needs to be able to allocate a domain for
> emulating identity mappings using a context bank without translation.
> Provide a helper function to allocate such a domain.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 

Reviewed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
