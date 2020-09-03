Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4847C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDCF82158C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599129175;
	bh=YFlDB95nKM1SZdLZ0MVDpqJ2y3FZn9MeGhr5mbp3gf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7YOoOBRsFqyMXUpb2dEx+qWZzcsExfvI5EozqacfnVDtW6mI76XwyO3ohTs0xv++
	 oZtducZzpyj/Ljx7IK9EineN4SQqcZSNOi1lFUwqrcyuuFerv0IAkQato1ybBeXA6h
	 0PZGXzwN93u/nvWFDGWsu4w33TjVxdXF1ALhPkAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgICKcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:32:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICKcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:32:50 -0400
Received: from localhost (unknown [122.171.179.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1955620716;
        Thu,  3 Sep 2020 10:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599129170;
        bh=YFlDB95nKM1SZdLZ0MVDpqJ2y3FZn9MeGhr5mbp3gf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qwh8y8ytLoTAHVmF7uqlnAd3WyC269LWUxpGiMxKRwYJWWf5B3/YBRg8rJJ167vIy
         bQCvE1vwI+T+En1RkkDNq6+HsGL75r8dpgvUqumsasX1gtdbWGy7w34rjOpUwrMTtH
         PBHMX3GCv/oh9OCQ71h97poKERTrnnVJU/4bSeXA=
Date:   Thu, 3 Sep 2020 16:02:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH v4 0/3] ASoC: soundwire: fix port_ready[] dynamic
 allocation
Message-ID: <20200903103245.GO2639@vkoul-mobl>
References: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831134318.11443-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-08-20, 21:43, Bard Liao wrote:
> The existing code allocates memory for the total number of ports.
> This only works if the ports are contiguous, but will break if e.g. a
> Devices uses port0, 1, and 14. The port_ready[] array would contain 3
> elements, which would lead to an out-of-bounds access. Conversely in
> other cases, the wrong port index would be used leading to timeouts on
> prepare.
> 
> This can be fixed by allocating for the worst-case of 15
> ports (DP0..DP14). In addition since the number is now fixed, we can
> use an array instead of a dynamic allocation.

Applied all, thanks
-- 
~Vinod
