Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C4424125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579600494;
	bh=rbea3hv11DlqYc6PEcYoLoQf6fMfbqdEMMWQJJW3TgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N4VjbqqKTv2QQIhEInV8oVB3XeKuvT7xiSa3Jmi48rRgh2pQ3FKX1a+ctZ+F8B7t8
	 LPLeoXEhTSCGQGP9o+NhPdYLo1ZxT2/4KJSbd+EM5hbbQ1clYbc3UNi3BaRaSI3LdF
	 nusH4+vBukQMN9cT0jNBVjQPtHsRK/XiSSDf9z2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgAUJyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:54:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgAUJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:54:53 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B208220882;
        Tue, 21 Jan 2020 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579600492;
        bh=rbea3hv11DlqYc6PEcYoLoQf6fMfbqdEMMWQJJW3TgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0xAmqxRj+RetoAUEJP3t6n2Ogtr8hDOLi9wYGdGYDtY1xSZevRo2kK8srjK8JCGPp
         4jjkTh7ladGxJdiGrXtbCrxJi5SPntce8i5VUoDlSGE4pts5WplrWkJT6X2/n+JIsg
         sennGoB3u2lTPDEqXICGQYOJu8/Y8JtCr7w66ieI=
Date:   Tue, 21 Jan 2020 15:24:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, psodagud@codeaurora.org,
        tsoni@codeaurora.org, jshriram@codeaurora.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] clk: qcom: rpmh: Add support for RPMH clocks on
 SM8250
Message-ID: <20200121095448.GL2841@vkoul-mobl>
References: <1579217994-22219-1-git-send-email-vnkgutta@codeaurora.org>
 <1579217994-22219-3-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579217994-22219-3-git-send-email-vnkgutta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-01-20, 15:39, Venkata Narendra Kumar Gutta wrote:
> From: Taniya Das <tdas@codeaurora.org>
> 
> Add support for RPMH clocks on SM8250.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
