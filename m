Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5620C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 566C920829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 05:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599717236;
	bh=JtaFlJSviOb7OWFjFxocygPpOA+gRQz5TGSHiD2R484=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tbr99oVloXnXwsRkwJXdj5G1HhQRHzkzUfrlMLMqrmTIR+Fl8y/wQ/6uUTzGXMuEq
	 1bcDogTg/cGe6xCS+7EDpG40/oHszg4nf870GWE1et23VCRmJ9ugpR92P7XUN7tYKT
	 NpFx89TUTJV0qMJ6xvnOGUOf5Rg+QsZWatIrMuiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIJFxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgIJFvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 01:51:31 -0400
Received: from localhost (unknown [122.179.50.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBA6A2075B;
        Thu, 10 Sep 2020 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599717090;
        bh=JtaFlJSviOb7OWFjFxocygPpOA+gRQz5TGSHiD2R484=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6aZquknwoSsKlYrQLwioTINY6mxQoOZBhPmB/Ip3oYRy3o2QmaBXjnHnYBK+mvIw
         LvsrH2yk5CYPZiUu7h/XLMnFvIbDGBXzfniKoqKj8xSkrxSIl0ZVXpHwvr1EOK7Quz
         gqL+31FTXo4flsvjyNOb+kuhptRsddNJRSn+UrJ4=
Date:   Thu, 10 Sep 2020 11:21:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v2 0/7] ASoC/soundwire: filter out invalid PARITY errors
Message-ID: <20200910055122.GO77521@vkoul-mobl>
References: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908134521.6781-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 21:45, Bard Liao wrote:
> Some codecs may report fake PARITY errors in the initial state. This
> series will filter them out.

Applied, thanks

-- 
~Vinod
