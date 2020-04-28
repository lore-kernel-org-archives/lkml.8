Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA94C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07685206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588089146;
	bh=FonZhAd2nSb7LZznv2tDxTHOgq8CE0zbDHFkB+PUCfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KrncpzGy6YKh2/j6FNxK/wudxZqt/CPZz8xBht6On6un0PzEY+eHGTmhJP0OBkQnW
	 Urm+qmtSn4tWFiXqoNP9GUBZCRtx/Nwwgs0DLl5ARMrEr8FfJeVB7M+8PAVcZUWCR5
	 ZW0cVK60+PFRfSI3nDM1GgcmYsOJs6mxxp06thL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbgD1PwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1PwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:52:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8738205C9;
        Tue, 28 Apr 2020 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588089144;
        bh=FonZhAd2nSb7LZznv2tDxTHOgq8CE0zbDHFkB+PUCfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jzWr8KxeGp2asEx+F0kxIMPvQdqUnh9aRN3j2eX9rHqvHiXKyYtE/6Szw6mXToE20
         p7MEdcYXt1xJkK1isFf/JJMWkCop1Un9xv7O0kM6p3O+CM7NUBW1hTKxXyb1ZjJeiG
         yj3Q2aR9k7afQGdc4It3xaPCYu7WJxddfQFJLb/w=
Date:   Tue, 28 Apr 2020 17:52:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
Message-ID: <20200428155222.GA1584194@kroah.com>
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
 <20200331022832.209618-1-saravanak@google.com>
 <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
 <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
 <20200331072910.GC854501@kroah.com>
 <CAGETcx9r_t0AWVaTt5hk9s6Tti0UcNAersjXCJ_A04yJKNPtDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx9r_t0AWVaTt5hk9s6Tti0UcNAersjXCJ_A04yJKNPtDA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 11:25:47AM -0700, Saravana Kannan wrote:
> On Tue, Mar 31, 2020 at 12:29 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Mar 30, 2020 at 11:18:01PM -0700, Saravana Kannan wrote:
> > > On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
> > > <m.szyprowski@samsung.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 2020-03-31 04:28, Saravana Kannan wrote:
> > > > > When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> > > > > commandline option") added fw_devlink, it didn't implement "permissive"
> > > > > mode correctly.
> > > > >
> > > > > That commit got the device links flags correct to make sure unprobed
> > > > > suppliers don't block the probing of a consumer. However, if a consumer
> > > > > is waiting for mandatory suppliers to register, that could still block a
> > > > > consumer from probing.
> > > > >
> > > > > This commit fixes that by making sure in permissive mode, all suppliers
> > > > > to a consumer are treated as a optional suppliers. So, even if a
> > > > > consumer is waiting for suppliers to register and link itself (using the
> > > > > DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> > > > > blocked from probing.
> > > > >
> > > > > Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> > > > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > ---
> > > > > Hi Marek,
> > > > >
> > > > > If you pull in this patch and then add back in my patch that created the
> > > > > boot problem for you, can you see if that fixes the boot issue for you?
> > > >
> > > > Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
> > > > next-20200327. Thanks! :)
> > >
> > > Hi Marek,
> > >
> > > Thanks for testing, but I'm not able to find the tag next-20200327. I
> > > can only find next-20200326 and next-20200330. I was just trying to
> > > make sure that next-20200327 doesn't have the revert Greg did. I'm
> > > guessing you meant next-20200326?
> > >
> > > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > >
> > > Thanks!
> > >
> > > Greg,
> > >
> > > Can you pull in my fix and then revert the revert?
> >
> > After 5.7-rc1 is out I will, thanks.
> 
> Hi Greg,
> 
> Just to clarify, this patch is a bug fix and I think this patch should
> go into all the stable branches that support fw_devlink.
> 
> The only risky change that you needed to wait on for 5.7-rc1 is the
> patch [1] that sets fw_devlink=permissive by default. Well, a revert
> of the revert of [1].
> 
> [1] - https://lore.kernel.org/lkml/20200321210305.28937-1-saravanak@google.com/

I don't understand, what kernels should this go back to?  Your "Fixes:"
line just shows for a 5.7-rc1 patch, nothing older.

thanks,

greg k-h
