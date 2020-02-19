Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC38C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6D2206EF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582114744;
	bh=zG2lPnCJ0h9HTg/FrJTKsOn5Ck5Pc8USzuemV1tBLgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jBUT7HYDkFjnBMJShiVBwuAES56h40GCul1KUs7Tw6daroypAKgzvmUiqm9UeklL8
	 cqAXmmhM0VHI4lpE3uwKqvR8lBHEfrUoINYHX+1EcRng+9QKVBnZoPPYex5qfqR0JX
	 WrG4wGJvJAb14UxKW+PuEVaXErczIqhYzdOoqX0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgBSMTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:19:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgBSMTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 07:19:03 -0500
Received: from localhost (unknown [106.201.32.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E8624656;
        Wed, 19 Feb 2020 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582114742;
        bh=zG2lPnCJ0h9HTg/FrJTKsOn5Ck5Pc8USzuemV1tBLgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NaPdJqG8xgOlQXcpMn4VCCORBiW66C3eBtu+Fn4dtIL8+y2mWk1aWHaPW9OpfX0P/
         nu79EQhdJgE8FblwpGhDdEHyRjE6NRtUxnNm3k7zyM3Pm8I+KXE9ztHoTq8/hcXLdl
         EKdQZ4QnUsNcYIPrOEb1kBq3HWT2vP7gJUDVIsTw=
Date:   Wed, 19 Feb 2020 17:48:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmanegine: ioat/dca: Replace zero-length array with
 flexible-array member
Message-ID: <20200219121856.GI2618@vkoul-mobl>
References: <20200214171302.GA20586@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214171302.GA20586@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-02-20, 11:13, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.

Applied, thanks

-- 
~Vinod
