Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5660CC33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA102072A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578643040;
	bh=KzQGNzbnWuzjj/D+MsdmvVNOXudlw3w+y6Grnw01pBM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZwUQfXaRdexHo0fkf1fFBZKWQmhgTk5qDimtYJjUtGxD2w6P5Ym8Sg+Fs983ODFi
	 a0om4lTuhOajHsYcmowqBSmP+SwG2nFTk7oCAXhIs0Aea3uUbVyn91339JZvqju8fM
	 6QbEnn8Fc7sZRJJgx/xHj68cbLlX8WL0CnP9mEUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgAJH5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:57:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgAJH5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:57:19 -0500
Received: from localhost (unknown [223.226.110.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41A8220678;
        Fri, 10 Jan 2020 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578643038;
        bh=KzQGNzbnWuzjj/D+MsdmvVNOXudlw3w+y6Grnw01pBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XblV76ARZIAOQwMc8aSkMpy2HXQgJYCspGWq7zyedcFPSJxCF6vbaRtw0ox4y5dVu
         8L1v/zuLLcuwGkKy3eEI+aq4911KEr5Nwq22oikjOvzzMVEUP5KBwJ4wR6fKeQ2w7+
         YE2wVW6/ZXhuuL7vWPSenWPpSjCzhG+9GJRNwsek=
Date:   Fri, 10 Jan 2020 13:27:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gary R Hook <gary.hook@amd.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>, dan.j.williams@intel.com,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        davem@davemloft.net, mchehab+samsung@kernel.org, robh@kernel.org,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dmaengine: ptdma: Initial driver for the AMD
 PassThru DMA engine
Message-ID: <20200110075707.GE2818@vkoul-mobl>
References: <1577458047-109654-1-git-send-email-Sanju.Mehta@amd.com>
 <201912280738.zotyIgEi%lkp@intel.com>
 <20200103062630.GD2818@vkoul-mobl>
 <de0bf6de-5c44-bb81-f3ac-2db1c1c4595d@amd.com>
 <20200103155256.GC1064304@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103155256.GC1064304@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-20, 16:52, Greg KH wrote:
> On Fri, Jan 03, 2020 at 09:12:18AM -0600, Gary R Hook wrote:
> > On 1/3/20 12:26 AM, Vinod Koul wrote:
> > > On 28-12-19, 07:56, kbuild test robot wrote:
> > > > Hi Sanjay,
> > > > 
> > > > I love your patch! Perhaps something to improve:
> > > 
> > > Please fix the issues reported and also make sure the patches sent are
> > > threaded, right now they are not and the series is all over my inbox :(
> > > 
> > 
> > What does this mean? The patches showed up in my inbox as a set of 3,
> > properly indexed, just like they should when sent with "git send-email".
> > 
> > We've not had any reports from other lists/maintainers of similar problems.
> > So you'll understand how we might be a bit confused.
> > 
> > Would you please elaborate on the problem you are seeing?
> 
> There was no email threading of the patches, they all looked like
> individual emails.  In other words, the "In-Reply-To:" value was not
> set.

And git send-email does that for you if you give it all the patches to
send to... If you give it each patch individually, they will come as
individual units

FWIW, my workflow is 

$ git format-patch .... -o <some_dir>
<check the patches, add cover letter details etc>
$ git send-email <some_dir>

That ensures the In-Reply-To is set for subsequent patches and the log
will also tell you that

HTH
-- 
~Vinod
