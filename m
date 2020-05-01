Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FED9C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15290214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588316850;
	bh=HIfMpi3S18ct8unQ/R+ubNZwKhps7K77SVC39pepDOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G6WWfqNKBvtrKSUFtxpAAuEXZOMu7P8+qrY5a094foydS/rDUlLVAI5D4XX+UeBJc
	 ZYp71ae00ueVIzRAef22vVu7ThLZcKjGgF1uMh7iX66hXCFqCYPZexTbq2SphBowlj
	 1ebc0q/LFKrldWH2uMavv/I+fy3jjnh63HfyI3HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEAHH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 03:07:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgEAHH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 03:07:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787A320787;
        Fri,  1 May 2020 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588316848;
        bh=HIfMpi3S18ct8unQ/R+ubNZwKhps7K77SVC39pepDOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jJ2GAeNdWdjuxBuST3M1Md1YH7ok04v42aeOXmpkPY2wz3GqCEaE9hkfcGvfqi459
         2OfkycLqKtEQZdpyYWTFJyP8cwf7Crgb3ZneU/QW3pynODzEDZLhR6oFKIAkQtX/f+
         U4XXhPogWkf+4cW5SuzPtU5eAdnOHUeoB9RbBGQE=
Date:   Fri, 1 May 2020 08:07:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] drivers/iommu: properly export iommu_group_get_for_dev
Message-ID: <20200501070723.GA9186@willie-the-truck>
References: <20200430120120.2948448-1-gregkh@linuxfoundation.org>
 <20200430121753.GA22842@willie-the-truck>
 <20200430122332.GP21900@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430122332.GP21900@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 02:23:32PM +0200, Joerg Roedel wrote:
> On Thu, Apr 30, 2020 at 01:17:53PM +0100, Will Deacon wrote:
> > Thanks, not sure how I managed to screw this up in the original patch!
> > 
> > Acked-by: Will Deacon <will@kernel.org>
> > 
> > Joerg -- can you pick this one up please?
> 
> Yes, will send it as a fix for 5.7, but note that this function will be
> unexported in 5.8.

Thanks, Joerg.

Will
