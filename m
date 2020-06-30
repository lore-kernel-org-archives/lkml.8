Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ED6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798AE206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593506729;
	bh=iCDG5t6pi57MoyB91cUN21i5duN5jXpRfPSFAuFxS18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vsA/S9xMDg9aZ6aV8nsuBGDGbMquzQgPTvSWnkgwFul1ATb/t209Tvy5tIraxP/jl
	 pT2pZM778rij4BNKWBnculPqFbsU0P06qq0XfBxGvNeX6nNfb4gOJS6xisnezwhtXZ
	 mcaVjHEJSmJwJjNOM266izBoEPpdvaW6QI8WF80g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbgF3Ip1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:45:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:54140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731592AbgF3Ip0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:45:26 -0400
Received: from localhost (unknown [84.241.197.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F47D20768;
        Tue, 30 Jun 2020 08:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593506725;
        bh=iCDG5t6pi57MoyB91cUN21i5duN5jXpRfPSFAuFxS18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gyvLRhOabyVbn+eU/kHBK4TPsidN4UbIDrW3Zi8KxGa1cx+wJbLjCh9gFbb+1N4py
         Y+0kUzWS9Tbe0/5h2KqnNNKXr7gCMS8KjvuKsBPGZASdAu0wYK6jbjOrvpQidLimFo
         toHkvKPKESrTKNDs9Sb0/tPk2zyZkB9pG92dlzpo=
Date:   Tue, 30 Jun 2020 10:45:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 1/2] Explicitly include linux/major.h where it is
 needed
Message-ID: <20200630084522.GB637565@kroah.com>
References: <20200617092614.7897ccb2@canb.auug.org.au>
 <20200617092747.0cadb2de@canb.auug.org.au>
 <20200617055843.GB25631@kroah.com>
 <20200630091203.55cdd5d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630091203.55cdd5d9@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:12:03AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 17 Jun 2020 07:58:43 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Jun 17, 2020 at 09:27:47AM +1000, Stephen Rothwell wrote:
> > > This is in preparation for removing the include of major.h where it is
> > > not needed.
> > > 
> > > These files were found using
> > > 
> > > 	grep -E -L '[<"](uapi/)?linux/major\.h' $(git grep -l -w -f /tmp/xx)
> > > 
> > > where /tmp/xx contains all the symbols defined in major.h.  There were
> > > a couple of files in that list that did not need the include since the
> > > references are in comments.
> > > 
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>  
> > 
> > Any reason this had an RFC, but patch 2/2 did not?
> > 
> > They look good to me, I will be glad to take these, but do you still
> > want reviews from others for this?  It seems simple enough to me...
> 
> I am going to do another round of this patchset splitting out most of
> the "safe" removals that can be done anytime so other maintainers can
> take them.  Then there will be the left over order dependent changes at
> the end.

Ok, I'll wait for the next round of patches, thanks.

greg k-h
