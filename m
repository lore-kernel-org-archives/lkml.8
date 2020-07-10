Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31245C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D02C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594391881;
	bh=8g8m8VJ9l5CJBIHP80qLd7TYwA04RcxWEXDKAmSDJFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B8rms06wfZc4mrOYao8o5sY0jNUCy3mhkmEzLDmgtd+ACRUm+UosOHtOhnagebC0m
	 GroHpDS73W7KckWj75dvvW6Id3plyWDppIdc8KFp4zEtYeW/wCWmLdVzEBySY77C/w
	 W6yGzXRV03UVEB68T/oEeZf8wr8oZUY2Ol9CIRIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgGJOh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:37:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgGJOh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:37:56 -0400
Received: from willie-the-truck (unknown [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990B4206E2;
        Fri, 10 Jul 2020 14:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594391876;
        bh=8g8m8VJ9l5CJBIHP80qLd7TYwA04RcxWEXDKAmSDJFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0e88udVe84K619h0RTRjVu0LwV3LPmZL1UbJ1n+j+/htQmPtaMjGUJNWydl/Q76/5
         2MFf+dTdXQ3YPR3lvtdODNoxv0f/PMX3K3q4CtBJhqfn/hzAC3eno8eSVvZgP72lKd
         oHDAHX9pxFCVDbNJPyeM95zUrrxFahH8+LpRgrNQ=
Date:   Fri, 10 Jul 2020 15:37:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Robin Murphy <robin.murphy@arm.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Christoph Hellwig <hch@lst.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: Remove unused IOMMU_SYS_CACHE_ONLY flag
Message-ID: <20200710143740.GA31036@willie-the-truck>
References: <20200703162548.19953-1-will@kernel.org>
 <20200710125831.GI27672@8bytes.org>
 <20200710130526.GA30578@willie-the-truck>
 <20200710141532.GK27672@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710141532.GK27672@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 04:15:32PM +0200, Joerg Roedel wrote:
> On Fri, Jul 10, 2020 at 02:05:27PM +0100, Will Deacon wrote:
> > Ah, I'd already got this queued for 5.9:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
> > 
> > and I've queued a small number of patches on top of it now.
> > 
> > Are you planning to send it for 5.8? If so, I suspect I'll have to rebase.
> 
> No problem, nothing got pushed yet. I removed it from my branch and wait
> for your pull-request.

Great, thanks Joerg.

Will
