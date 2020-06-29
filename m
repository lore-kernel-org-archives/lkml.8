Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F54CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19CCF2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466603;
	bh=wgnAWwFbY+YtiY3/WCQ/zDI25aOyYPFWw5ih1aRT8jU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oVAJd8x4ftyhyb1KVnYNOEQskrJcpL9607sIv4su9nejIWtRnTltpa/+5vGcrxAk8
	 3pyQpNlylv4D3qApyjvIgzR6TkKdo8Q9xAHiVcKtkJeljr3C02fTHGvoEV5oNTedVW
	 t//RHDAPXcVSXEtB3w77/+SnCGeDkpAqwmSMZmfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgF2Vgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgF2Skk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:40 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD01623435;
        Mon, 29 Jun 2020 09:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593423980;
        bh=wgnAWwFbY+YtiY3/WCQ/zDI25aOyYPFWw5ih1aRT8jU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDXdItiFHFW8DxnPzmu8rgpiRQDC4lYOvcnraPiE11gz0NVE57NEYm503TJ9WPU7a
         +rvZGhgoqcYYsaQ+76DxdY/S0+T5MsKc0/hZnRcVPWpnz5vrbohicyydkoaJgEANWy
         UNSXxlPytNcudeJheVFImyElq+ASAP9BL+rYWlbs=
Date:   Mon, 29 Jun 2020 15:16:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     kishon@ti.com, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v3 0/2] phy: qcom-snps: Add runtime suspend and resume
 handlers
Message-ID: <20200629094615.GE2599@vkoul-mobl>
References: <20200625195444.15130-1-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625195444.15130-1-wcheng@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-06-20, 12:54, Wesley Cheng wrote:
> Changes in v3:
>  - Fixed strict checkpatch warnings due to alignment
>  - Remove debug artifacts from prints
>  - Split the set mode callback addition to another patch
>  - Removed suspended parameter
> 
> Changes in v2:
>  - Addressed checkpatch alignment/line length warnings.
>  - Removed superfluous init in qcom_snps_hsphy_resume().
> 
> Adds a set mode callback and runtime suspend/resume handlers to the
> phy-qcom-snps-femto-v2 driver.  The set mode is used to enable certain
> power management features in the PHY during suspend/resume.

Applied after dropping the wrong review tag, thanks
-- 
~Vinod
