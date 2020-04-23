Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805A6C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 597EB21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587626218;
	bh=5kUKRjpdbSiB+TioS9cIaTdJVh9EjK7sAj+V3QlB2Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yd7iDA1Mr1rVB07g/AREIn7bYMl5tDadF3fUFeijDFsjCOQvFaZWCtH7hn0nIbY0R
	 EbTSXwIYcIv5l1pTo8GPFZ6NUA5yEJi1w+QIuQu0Z7AtjIMQUVMSY9pJR+FRTOlT8U
	 a5r47D3OekuuiSmgXcD5hEmVg11GEaWcbLEXNqMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgDWHQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:16:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:16:57 -0400
Received: from localhost (unknown [49.207.59.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D73D820736;
        Thu, 23 Apr 2020 07:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587626216;
        bh=5kUKRjpdbSiB+TioS9cIaTdJVh9EjK7sAj+V3QlB2Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Js7cmxrW6hCyM+iTv/TUmiztXYsAgKyLMHPaztfoH3P2o4AHoL9Lp2Hpc2yjCNTZ8
         oocXc75xCs6Fm4X5XqprpPmb6RbS+erNAkz/c3EpSZ3xjzpJ5uad026SjIxCGXoWMq
         R998V0TKUy8DvQjOGRyUYogCMe2cHy3OjSoFeMnY=
Date:   Thu, 23 Apr 2020 12:46:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] dmaengine: mmp_tdma: Remove the MMP_SRAM dependency
Message-ID: <20200423071652.GC72691@vkoul-mobl>
References: <20200419164912.670973-1-lkundrak@v3.sk>
 <20200419164912.670973-8-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200419164912.670973-8-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-04-20, 18:49, Lubomir Rintel wrote:
> A generic SRAM will driver for Device Tree enabled platforms will do as
> well.
> 
> The non-DT drivers that use mmp_tdma to transfer audio samples to and from
> the audio SRAM should depend on MMP_SRAM themselves.

Applied, thanks

-- 
~Vinod
