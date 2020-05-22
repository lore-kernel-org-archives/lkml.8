Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24513C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3813206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 17:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgEVRNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 13:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730536AbgEVRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 13:13:21 -0400
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8B1C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 10:13:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 69A153968;
        Fri, 22 May 2020 19:13:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xn3rcvaificZ; Fri, 22 May 2020 19:13:15 +0200 (CEST)
Received: from function (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 7B3002E76;
        Fri, 22 May 2020 19:13:15 +0200 (CEST)
Received: from samy by function with local (Exim 4.93)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1jcBEO-00HA74-1l; Fri, 22 May 2020 19:13:12 +0200
Date:   Fri, 22 May 2020 19:13:12 +0200
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Joe Perches <joe@perches.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
Subject: Re: [PATCH] taging: speakup: remove volatile
Message-ID: <20200522171312.s2ciifuxozwav2ym@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Joe Perches <joe@perches.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        MugilRaj <dmugil2000@gmail.com>, devel@driverdev.osuosl.org,
        Kirk Reiser <kirk@reisers.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Chris Brannon <chris@the-brannons.com>
References: <1590138989-6091-1-git-send-email-dmugil2000@gmail.com>
 <20200522103406.GK30374@kadam>
 <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ab4139ec78928961a19e5fdbda139bb8cff9cb5.camel@perches.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches, le ven. 22 mai 2020 09:36:05 -0700, a ecrit:
> On Fri, 2020-05-22 at 13:34 +0300, Dan Carpenter wrote:
> > On Fri, May 22, 2020 at 02:46:28PM +0530, MugilRaj wrote:
> > > fix checkpatch.pl warning, which is Use of volatile is usually wrong: see
> > > Documentation/process/volatile-considered-harmful.rst
> > > Signed-off-by: MugilRaj <dmugil2000@gmail.com>
> > 
> > Please put a blank before the Signed-off-by line.
> > 
> > Probably there should be a space between your first and last name.  It's
> > supposed to your legal name like for signing a legal document so use
> > whatever is appropriate legal documents in your country.
> > 
> > Also the Documentation/process/volatile-considered-harmful.rst explains
> > that people often use "volatile" when they should be using locking for
> > synchronization.  That seems to be the case here.  So the correct fix is
> > to add locking.  That's a little bit complicated to do and requires
> > testing.
> > 
> > If we apply this patch, then we have silenced the warning so now someone
> > will have to look for the bug.  But if we leave it as-is, then everyone
> > will know that the code is buggy.  So let's leave it as-is until we are
> > able to fix the bug.
> > 
> > It's always better to have easy to find bugs, than hidden bugs.
> 
> And better still to comment known opportunities to
> improve the code so the next time someone tries to
> remove this volatile, there's a comment right there
> showing what's necessary instead.

Actually I don't think adding the suggestion is a good thing if it's
only a "rule-of-thumb-replace-volatile-with-lock".

Actually possibly volatile might not even be needed because there could
be already a lock protecting this.

Put another way: I don't think putting any hint here would help, on the
contrary, somebody has to really look at what protection is needed,
without getting influenced by rules-of-thumb.

Samuel
