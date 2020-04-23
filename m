Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73947C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBF320736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587626126;
	bh=1519+u/O1psy9Ki9fQPIu3CaRE2VyNu6zy8FfJD5RU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dk/oNhVuLKTePdLS5zpTiGBtDClz2LArmmbMvOWqNTrIgkOXJMObK0rPg/Bl9yepF
	 M6VeJ+0gew4mZddP8Ef6mlA74qV+DNuO5NHzp6rq0pziu81zVC1kCVaKF8ZZsg/zka
	 Clp8XpKxB3ZRrhStKwz52etAVeRmDFbPmOwnXk98=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgDWHPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:56006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbgDWHPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:15:22 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF1120736;
        Thu, 23 Apr 2020 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626121;
        bh=1519+u/O1psy9Ki9fQPIu3CaRE2VyNu6zy8FfJD5RU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7V/BsFGGeTdHIHuV8rAf0BtwzyRVEJzfD19lnFRg+gO1BaG4tErnLAwAy0o0abpl
         w7wOPPxISIpMndBRWVGDpWAD+NdWQ2yL1UhJsc/vHulpZFlMOH0z6/swW60XWwud8w
         p6HtcolqchHu1Ifcxbw8+ZO9NB48VGYW9cXI1oKM=
Date:   Thu, 23 Apr 2020 12:45:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dmaengine: mmp_tdma: Log an error if channel is in
 wrong state
Message-ID: <20200423071517.GA72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-6-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-6-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> Let's log an error if the channel can't be prepared because it is in an
> unexpected state.

Applied, thanks

-- 
~Vinod
