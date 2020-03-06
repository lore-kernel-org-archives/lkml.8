Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A94C3F2D8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB2152072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583472816;
	bh=dYKokNmp/7q2bZFJoob20zCquqvHPAErBin5RxqrsCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yu6uFWpxBcq6ZkxqgQIlqVMWG80teUdYsaNPMNcFVO2iDZ8Jm0svyVy6mp2tqLKWI
	 6NBV+sRx5zyRDcMuNvFtwKJDjEjJmW8Kl66Xh+n7Ki0fXbAU93aJhwtb51I217X3Aw
	 QtzwhmA+VE2M5aMAsVOj8M26qDwq07djbj5d3/vg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFFdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:56366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFFdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:33:35 -0500
Received: from localhost (unknown [122.178.250.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35F502072D;
        Fri,  6 Mar 2020 05:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583472815;
        bh=dYKokNmp/7q2bZFJoob20zCquqvHPAErBin5RxqrsCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LpRCdcLDjI1xnCxFEw7e8PbKsmhENGfJKVjx/E9Gggvri4Jy1K5+OQgUXm/fG3UL6
         D6knfSrbQO+vKcnDFrD8XaSa8rk8yZ16wEwWL+7TEiaDJ8mwLEF/DohCCD0RjCiqyZ
         AocqcftUSgMiZghn0CPGFfr9ro/UNjkH6b7wujXY=
Date:   Fri, 6 Mar 2020 11:03:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: msm8996: Use generic QMP driver for
 UFS
Message-ID: <20200306053329.GD4148@vkoul-mobl>
References: <20200125001234.435384-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125001234.435384-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-01-20, 16:12, Bjorn Andersson wrote:
> With support for the MSM8996 UFS PHY added to the common QMP driver,
> migrate the DTS to use the common QMP binding.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
