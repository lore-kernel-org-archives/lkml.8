Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F939C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF020855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 05:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596866123;
	bh=vV9fvQh2v34bYiisn/25gIIwghB9SlRX9bj6MiaoFC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t21l389YXnW03bOIKeTunLRw8g/fIIHHmJ5wydDUPiCL8r9QAG7pJV2xq4iWZfOrP
	 07jnHBE+ky7f5DsiD0a5PvJvNOkqDZmWkbDyHhpoPLbg9k1QFOSQzNZICoCLuIjhRT
	 Ky0G+uUKrBpWcy3rcJzRdZ/MWi51AVlB6mp3XU3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgHHFzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 01:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbgHHFzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 01:55:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9771220855;
        Sat,  8 Aug 2020 05:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596866121;
        bh=vV9fvQh2v34bYiisn/25gIIwghB9SlRX9bj6MiaoFC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DKzFUkrJNkzwLirM6YM6TaJ5a+K6OgQa4QtyN8lLfN+loEEWgPEm5XlRpVFwVHTlk
         WENTjIsKeGofvRjM05es2Vw9QVSlMDP1uJrI2VY8v2476vb6jbW8VNbW4n/SNzvjpD
         mndM64RwBH1EcdkHeUss9Nzu8XBdjUDeiLBlrIJ8=
Date:   Sat, 8 Aug 2020 07:55:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chris Lew <clew@codeaurora.org>
Cc:     Deepak Kumar Singh <deesin@codeaurora.org>,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "open list:REMOTE PROCESSOR MESSAGING (RPMSG) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V7 2/4] rpmsg: Guard against null endpoint ops in destroy
Message-ID: <20200808055518.GF1037591@kroah.com>
References: <1593017121-7953-1-git-send-email-deesin@codeaurora.org>
 <1593017121-7953-3-git-send-email-deesin@codeaurora.org>
 <20200807075946.GA3049898@kroah.com>
 <e7fc6957-5065-9dbc-2f2d-d24893fead63@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7fc6957-5065-9dbc-2f2d-d24893fead63@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:33:53PM -0700, Chris Lew wrote:
> Hi Greg,
> 
> On 8/7/2020 12:59 AM, Greg KH wrote:
> > On Wed, Jun 24, 2020 at 10:15:19PM +0530, Deepak Kumar Singh wrote:
> > > From: Chris Lew <clew@codeaurora.org>
> > > 
> > > In RPMSG GLINK the chrdev device will allocate an ept as part of the
> > > rpdev creation. This device will not register endpoint ops even though
> > > it has an allocated ept. Protect against the case where the device is
> > > being destroyed.
> > > 
> > > Signed-off-by: Chris Lew <clew@codeaurora.org>
> > > Signed-off-by: Deepak Kumar Singh <deesin@codeaurora.org>
> > > Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
> > 
> > Should this be marked for stable kernels?
> > 
> > And if so, what commit does this fix?  Any reason the Fixes: tag was not
> > used here?
> > 
> 
> The crash that this fixes doesn't show up unless one of the previous patches
> in the series is applied.
> 
> [PATCH V6 3/5] rpmsg: glink: Add support for rpmsg glink chrdev
> 
> I'm not sure if the fixes tag should apply to this change or one of the
> commits to the base rpmsg code.

That's a different series, why not merge this patch with that one so
there is no need for a fix if none of this has been merged yet?

> > And what happened to this series?  I don't see it in linux-next, did the
> > maintainer ignore it?
> > 
> 
> I believe most of the review feedback for the series has been addressed by
> Deepak. There is one remaining action item for me and Deepak to provide more
> concrete evidence that the first patch in the series is needed.
> 
> [PATCH V6 1/5] rpmsg: glink: Use complete_all for open states

Ok, thanks, just didn't want to see this get forgotten...

greg k-h
