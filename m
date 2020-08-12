Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA552080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597249686;
	bh=I9L7cHpHrVvxSFWYMps8sy0c98kCT0nrA4/d/KoIgbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wSf/GaxjS3R/Sq/NXFECMmejCFnf7lFOkWPu0YF4tt7ZzGR+IF+qwBSIdRQnHTHtA
	 GCVc5qnuDPo9F6BGvGW1UWi0Dka4MYxvl9057NR0XEUBXsHXAsAGYHs5MGhvERA3JA
	 ESeljyosYcdRVjKPJuEK4Th87Rtq/xFtMCJNtuKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHLQ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:28:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51D152076B;
        Wed, 12 Aug 2020 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249684;
        bh=I9L7cHpHrVvxSFWYMps8sy0c98kCT0nrA4/d/KoIgbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S5dQoOWQCm7WCxvwcjjKEUJ8v0jMp2AZr6OEYrkdEoQJ+7mWvd5S3d1E3K6PdeFqq
         +j11151WCDN2yepised6rW4edAk5hO/dfERaQZz5OmtNsRtB2BKRcj3PHEDt55inco
         bvIFhxL6Ux07qSBp8Q0TDADNCFE5IyokThM314KU=
Date:   Wed, 12 Aug 2020 18:28:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     devel@driverdev.osuosl.org, Mayulong <mayulong1@huawei.com>,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        mauro.chehab@huawei.com
Subject: Re: [PATCH 01/44] staging: spmi: add Hikey 970 SPMI controller driver
Message-ID: <20200812162814.GB2650123@kroah.com>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
 <4305f945d257cf590646100cad752a0a6542a152.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4305f945d257cf590646100cad752a0a6542a152.1597247164.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 05:56:11PM +0200, Mauro Carvalho Chehab wrote:
> From: Mayulong <mayulong1@huawei.com>
> 
> Add the SPMI controller code required to use the Kirin 970
> SPMI bus.
> 
> [mchehab+huawei@kernel.org: added just the SPMI controller on this patch]
> 
> The complete patch is at:
> 
> 	https://github.com/96boards-hikey/linux/commit/08464419fba2
> 
> Signed-off-by: Mayulong <mayulong1@huawei.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../staging/hikey9xx/hisi-spmi-controller.c   | 390 ++++++++++++++++++
>  1 file changed, 390 insertions(+)
>  create mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
> 
> diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> new file mode 100644
> index 000000000000..987526c8b49f
> --- /dev/null
> +++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> @@ -0,0 +1,390 @@
> +
> +#include <linux/delay.h>

<snip>

No SPDX line at all?

:(
