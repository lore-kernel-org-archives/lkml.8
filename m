Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D02C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BF920748
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585639755;
	bh=K+kSUFn5QmpohIurApP9XIGsLdwd699dH3yuXItWuiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04DQLPDu0RMobEhrAZ/yr0+90+0ZEUFNhQesifrvRs9EOjKMGIYlVgFCx15nhXLnR
	 gcwDmNOy13bB5aGPHGhfeUXfvHX4Tmp9uXnN6RhtVZZaUhmgRjDN4+ALZn7feiRCk8
	 KqvOzvBeTzLRZ01pVB1ookQM/G+MyRP/awqd1AKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgCaH3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:29:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgCaH3O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:29:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA8642072A;
        Tue, 31 Mar 2020 07:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585639753;
        bh=K+kSUFn5QmpohIurApP9XIGsLdwd699dH3yuXItWuiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCVMfrAGdSlyYD5ebr6vfmZ8Vt9m2/NynRiHqxBJSt9kY644r95zbSEGDh6TgLRGg
         4oRC2zd2IlwpPhl40SrLW4dfdNNPzqvDgNw/lWm7ZSz3OpgdrOPD8Xv/9HxvtZMeJF
         r7+gUops7UKDwrusSf5oM2gnzf44wDMddodBMvhM=
Date:   Tue, 31 Mar 2020 09:29:10 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
Message-ID: <20200331072910.GC854501@kroah.com>
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
 <20200331022832.209618-1-saravanak@google.com>
 <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
 <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:18:01PM -0700, Saravana Kannan wrote:
> On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > Hi,
> >
> > On 2020-03-31 04:28, Saravana Kannan wrote:
> > > When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> > > commandline option") added fw_devlink, it didn't implement "permissive"
> > > mode correctly.
> > >
> > > That commit got the device links flags correct to make sure unprobed
> > > suppliers don't block the probing of a consumer. However, if a consumer
> > > is waiting for mandatory suppliers to register, that could still block a
> > > consumer from probing.
> > >
> > > This commit fixes that by making sure in permissive mode, all suppliers
> > > to a consumer are treated as a optional suppliers. So, even if a
> > > consumer is waiting for suppliers to register and link itself (using the
> > > DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> > > blocked from probing.
> > >
> > > Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > > Hi Marek,
> > >
> > > If you pull in this patch and then add back in my patch that created the
> > > boot problem for you, can you see if that fixes the boot issue for you?
> >
> > Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
> > next-20200327. Thanks! :)
> 
> Hi Marek,
> 
> Thanks for testing, but I'm not able to find the tag next-20200327. I
> can only find next-20200326 and next-20200330. I was just trying to
> make sure that next-20200327 doesn't have the revert Greg did. I'm
> guessing you meant next-20200326?
> 
> > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> Thanks!
> 
> Greg,
> 
> Can you pull in my fix and then revert the revert?

After 5.7-rc1 is out I will, thanks.

greg k-h
