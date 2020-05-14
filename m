Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2738EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015A820727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589463523;
	bh=oCiyfAOblzHW0ytZG2MkNHwN6/2lh218Rc+LQNbFmcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lEqKA2NsTBAcTSXeyMPkvQ1BZ6xF/A48kyPMJeMLIIuGq1uH0vtNoT3X9HNiWPglp
	 Hq6wLHCcG+03RaPOSIoh0LGWNagFuu4LmpODJi4ieuz57FdhfLiPr5FuL+9sxMQx9N
	 ex4zUVijBFe7hOx47SZvYPoBKgKySVfPOQQS0Afk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgENNim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgENNim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:38:42 -0400
Received: from localhost (unknown [122.182.193.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF8D620727;
        Thu, 14 May 2020 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589463521;
        bh=oCiyfAOblzHW0ytZG2MkNHwN6/2lh218Rc+LQNbFmcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+PLqwwPI4ktAfo1L3d6+2uUeznHKOl7cteuuYpQhHKSDUSJLZ+xTAZUdhxN9Yize
         htkAg4iJ35zls2Dg8jIyn64i9JIh5NvvqTRYtI+R4CX4jytInuHjxUBDldS5jRT70J
         LcEtR/xJqeXv5oDWvUat2FHO40246Q01eSijY38U=
Date:   Thu, 14 May 2020 19:08:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: db820c: Fix invalid pm8994 supplies
Message-ID: <20200514133837.GR14092@vkoul-mobl>
References: <20200417070712.1376355-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417070712.1376355-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-04-20, 00:07, Bjorn Andersson wrote:
> It's uncertain where the "vreg_s8a_l3a_input" comes from, but the supply
> for VDD_L3_L11 on PM8994 should be VREG_S3A_1P3, so correct this - and
> drop the vreg_s8a_l3a_input.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
