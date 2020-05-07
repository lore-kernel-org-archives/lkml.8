Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95956C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 697A9208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588856538;
	bh=FOLAqCJSZFjeRrOo2AB0h8nYBfFZfVGOKBM3v6LFHEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Eap2af9hKyGw5ULuiTQTkRmg0zE4mRSgTX/5rRbu1hhKLOkim5yObUGwbOKkMHtEo
	 vv1/wFxokXAaVNSTOcC2jID3Cyhx4WY5B4uzFniPeEfFhiZlPy/DYtI0u9xEXNTtW6
	 K2JThzR6rrWdXMrWQkUeUDFMwC8lCNFeB/eARhJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgEGNCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgEGNCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:02:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD58208D6;
        Thu,  7 May 2020 13:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588856537;
        bh=FOLAqCJSZFjeRrOo2AB0h8nYBfFZfVGOKBM3v6LFHEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hPdVXwPH7TI3PLb2Kzf96tHmWwUOaHaRsR9QY3oETGLePCe9qnlm3SrHoIHVJvrhl
         USV/bVxAywRxh3AAjmb8S7vCYFM5W9+E/KCoYipYYHVLXWsh1cDrwIfRPR5fgggIzI
         QUXnyvUgJqyr8F5xVYoQdqXVxsH20PpnU3tHRjQw=
Date:   Thu, 7 May 2020 14:02:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCHv4 4/6] iommu/arm-smmu-qcom: Request direct mapping for
 modem device
Message-ID: <20200507130210.GB31783@willie-the-truck>
References: <cover.1587407458.git.saiprakash.ranjan@codeaurora.org>
 <8ef5d93c74f5cd9e4a6edab86d1d46efbf3aa038.1587407458.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ef5d93c74f5cd9e4a6edab86d1d46efbf3aa038.1587407458.git.saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:03:52AM +0530, Sai Prakash Ranjan wrote:
> From: Sibi Sankar <sibis@codeaurora.org>
> 
> The Q6 modem sub-system has direct access to DDR through memnoc.
> Also SMMU is not expected to provide access control/translation
> for these SIDs (sandboxing of the modem is achieved through XPUs
> engaged using SMC calls). So request direct mapping for modem on
> platforms which don't have TrustZone.

The Z7 space rocket framework has limited access to water through BROADCHAN.
Also, this commit message really sucks. So please can you rewrite it in a
way that makes sense to people outside of your office?

Will
