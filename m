Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655ABC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D6E20787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585898675;
	bh=PZzf2oNMDzLElQE0/RA3BNR6PJu62ZJBwzRvyvupSF0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U1/b33JGl++O64yIkKtxaIpAJyPIWrGs2b/XGANoghM8qMYZm5qN19z6E0IAZzaUG
	 WS4CQ+iBIVWxqn69P5KaDNk+V9sCP3M9IW7SuOHmKpHcnYH/NJnd4rG5je1b3I3kyY
	 emLyiyZsnFJcMnXgYczOjv/R/V2/exmScK8/54ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389104AbgDCHYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 03:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388121AbgDCHYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:24:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A5B206F8;
        Fri,  3 Apr 2020 07:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585898672;
        bh=PZzf2oNMDzLElQE0/RA3BNR6PJu62ZJBwzRvyvupSF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7FdQBm39SBrHISYK8LKNwYqF5v4hXkP5x1yx91z9NFVGMtAQMG50r1QLype5Xckq
         /BWWjto2zCDF2dJdogESnHErVX7NFAu2XljztpPscnqwWPb2MGEKCAs59LazEUj8dX
         weygf2rYV4G7Uq8hrqUPS4NsNqaru/+bPlJ72JJg=
Date:   Fri, 3 Apr 2020 09:24:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: gasket: Fix 4 over 80 char warnings
Message-ID: <20200403072430.GC3405737@kroah.com>
References: <20200402053617.826678-1-jbwyatt4@gmail.com>
 <20200402053617.826678-2-jbwyatt4@gmail.com>
 <5d35084fcc0476fc2f43e3cf371f5078c0fbeeab.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d35084fcc0476fc2f43e3cf371f5078c0fbeeab.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:54:17PM -0700, Joe Perches wrote:
> On Wed, 2020-04-01 at 22:36 -0700, John B. Wyatt IV wrote:
> > Fix 4 over 80 char warnings by caching long enum values into local
> > variables.
> > 
> > All enums are only used once inside each function (and once inside
> > the entire file).
> > 
> > Reported by checkpatch.
> > 
> > Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
> > ---
> >  drivers/staging/gasket/apex_driver.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
> > index 46199c8ca441..f48209ec7d24 100644
> > --- a/drivers/staging/gasket/apex_driver.c
> > +++ b/drivers/staging/gasket/apex_driver.c
> > @@ -253,6 +253,8 @@ static int apex_get_status(struct gasket_dev *gasket_dev)
> >  /* Enter GCB reset state. */
> >  static int apex_enter_reset(struct gasket_dev *gasket_dev)
> >  {
> > +	int idle_gen_reg = APEX_BAR2_REG_IDLEGENERATOR_IDLEGEN_IDLEREGISTER;
> > +
> 
> This indirection only makes the code more difficult to understand.

I agree, this patch does not improve the readability of the driver at
all, which should always be the primary goal of any coding style
cleanup.

thanks,

greg k-h
