Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3263C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9A22085B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592973107;
	bh=oQnXr08CGndc73IX/A4pSEREBYvnWmC22/rMYyM49nU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+6dKg57ah5rq0cCEZPG4kcUghin8sd4SKSuk5dbS4jiF+cAn795DxDc2WZV664pX
	 T5mF6wgD5NvG006Z91yUwcRuOVBlrnyTUW6AgDJXjpuXFRCK4dnHi8/c7SWSN2172e
	 iHNFtRzktlDx8REHaqjZex2UaFPJb6cZboz3MnhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbgFXEbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgFXEbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:31:45 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65F9C2078E;
        Wed, 24 Jun 2020 04:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592973105;
        bh=oQnXr08CGndc73IX/A4pSEREBYvnWmC22/rMYyM49nU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v6nsjNE8SjHU+G/T7ceIi41MNXut32pBjBHFHpC627rk7wtsOrBVEbACIsScRL5Zp
         YpZMNJSpCKjsHmpoupwf/oRiYYYX9Q+Lcw04GXbr15Y67+JJEBbDmh9xGKepMcjScX
         5tBqhHs+wgTbfjZK7UV5GsBWIARXQpDomdH7IUWI=
Date:   Wed, 24 Jun 2020 10:01:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Switching dmaengine tree to kernel.org
Message-ID: <20200624043139.GT2324254@vkoul-mobl>
References: <20200623144313.GS2324254@vkoul-mobl>
 <20200624080952.093d562c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624080952.093d562c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 24-06-20, 08:09, Stephen Rothwell wrote:
> Hi Vinod,
> 
> On Tue, 23 Jun 2020 20:13:13 +0530 Vinod Koul <vkoul@kernel.org> wrote:
> >
> > I have switched dmaengine tree to kernel.org [1], please update your
> > database to new tree which can be found at [2]
> > 
> > [1]: https://lore.kernel.org/dmaengine/20200623143729.781403-1-vkoul@kernel.org/
> > [2]: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> 
> OK, done.  I also renamed them from slave-dma{,-fixes} to dmaengine{,-fixes).

Thank you, rename makes sense.

-- 
~Vinod
