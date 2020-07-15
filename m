Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF84C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025AB206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594788025;
	bh=7Cps2deu5EEozoenVkm17f1pN+4mr3/yXYH71x07wzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LcUBQ4DSvjfQ8JpnbT6hMxWTGsSvxCNOgFfipYYj7ukeIKVaBwa0mK+XS9FptHkM7
	 CkDgSUJylSCzZxC0n5x/GEoeCAXEx43ntENsX8w6N0LhSOoCJEmDIn/DYPJPju1YKX
	 2DaIOWtrT/bI7ATxb8uzJ9xPrfCf+xYN/+1LDfZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGOEkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgGOEkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:40:23 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3389205CB;
        Wed, 15 Jul 2020 04:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594788022;
        bh=7Cps2deu5EEozoenVkm17f1pN+4mr3/yXYH71x07wzk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oFh1f10zR9kh4Pz8bmNgMzuyp8S15g4/wa7BsBvRatoqWBVcva4m2lWza1hm6e7Vh
         O2l96/rTU2pcgG7DUfAAOVDmGF3t1+6b/vxB2FUcWuXtmL3spVGPED5MPuMxb0Bokj
         XB9++x4dIfmZtJYWwziq4D5PFZtY2CP49mLuVWrY=
Date:   Wed, 15 Jul 2020 10:10:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2 0/5] soundwire: handle stream at the dailink level
Message-ID: <20200715044019.GN34333@vkoul-mobl>
References: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630184356.24939-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-07-20, 02:43, Bard Liao wrote:
> Currently, stream is handled at the dai level. But we have to handle
> stream at the dailink level in the multi-cpu dailink usage.

Applied, thanks

-- 
~Vinod
