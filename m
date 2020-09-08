Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C240C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26799206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599582839;
	bh=Kpj2oGs3oTNKIeLuZX3DLWaFOXvp+PS3iXMHVDL5oCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z54KtmrP2EFbugBc3d2zKA0vdJNpEMiWSQ495yrc5qJ4jt0SmJWMg1c/iCOosv+WJ
	 udZbLdymqSshsPAWbsSrOIEbjIh5fBOOMHmSjgWUkgT6sbRlPMjjgOEV+O4D9zRGst
	 iN6a7Ba3kO4D5zCPs38LBDmVNS9DN/UVpHiI2XHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgIHQdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:33:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:34678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732031AbgIHQcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:32:16 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA597206DB;
        Tue,  8 Sep 2020 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599582733;
        bh=Kpj2oGs3oTNKIeLuZX3DLWaFOXvp+PS3iXMHVDL5oCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fhqz/EASt4/Hy/v6q6/hMpIECz0p9PaKHTrr/60CIbY9ruzS7EnRx/epzmpzJIP63
         CSu8n/bGCI1sECr4fTbibUE+U3OW8bbFqztVeSgTpBc66xoxhofDU2u77oW7SSkBuz
         iYWc1bh1nE044je8e10+i+ucnQiHnoCyaUaLMy4E=
Date:   Tue, 8 Sep 2020 18:32:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jian Cai <caij2003@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 04/12] x86/platform/uv: Update UV MMRs for UV5
Message-ID: <20200908163225.GD10640@kroah.com>
References: <20200907185430.363197758@hpe.com>
 <20200907185430.782245884@hpe.com>
 <20200908152314.GD4114051@kroah.com>
 <3e93b858-f74d-8e93-e444-fd85fc5856e4@hpe.com>
 <20200908154430.GA4171853@kroah.com>
 <35d4ce27-7a93-c3d5-3c0d-99fff06229c2@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35d4ce27-7a93-c3d5-3c0d-99fff06229c2@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 09:20:14AM -0700, Mike Travis wrote:
> 
> 
> On 9/8/2020 8:44 AM, Greg KH wrote:
> > On Tue, Sep 08, 2020 at 08:35:37AM -0700, Mike Travis wrote:
> > > 
> > > 
> > > On 9/8/2020 8:23 AM, Greg KH wrote:
> > > > On Mon, Sep 07, 2020 at 01:54:34PM -0500, Mike Travis wrote:
> > > > > --- linux.orig/drivers/misc/sgi-gru/grufile.c
> > > > > +++ linux/drivers/misc/sgi-gru/grufile.c
> > > > > @@ -7,7 +7,8 @@
> > > > >     * This file supports the user system call for file open, close, mmap, etc.
> > > > >     * This also incudes the driver initialization code.
> > > > >     *
> > > > > - *  Copyright (c) 2008-2014 Silicon Graphics, Inc.  All Rights Reserved.
> > > > > + * Copyright (c) 2018-2020 Hewlett Packard Enterprise Development LP
> > > > > + * Copyright (c) 2008-2017 Silicon Graphics, Inc.  All Rights Reserved.
> > > > 
> > > > Please drop all copyright changes from this series, as these do not look
> > > > correct at all, sorry.
> > > > 
> > > > You can send an add-on patch for all of that if it's really necessary,
> > > > and you get legal approval for it :)
> > > 
> > > I can move them all to a single patch.  The HPE one is straight from their
> > > guidance on Copyrights.  The older SGI one is also from SGI's guidance
> > > though I'm not sure if I can find it anymore.  I also wasn't sure if it
> > > should be retained since the HPE one didn't take effect until SGI was
> > > legally part of HPE (circa 2018).  2017/18 was also the last time we did
> > > this big a change (for the UV4A).
> > 
> > If you haven't touched a file in a year, you don't get to claim
> > copyright on that year.  If you wish to disagree on this, great, I'll
> > gladly take a patch that modifies the lines that has a signed-off-by
> > from one of your lawyers for it :)
> 
> I skipped over that part.  But I'm moving all changes to a single patch and
> I will look more closely at HPE's documents.  Heaven knows they have plenty
> of lawyers, so many it's hard to ask a simple question... like when does a
> copyright take effect.  When you change it internally, or when it gets
> published?  Sounds like you lean towards the second?

There are established rules for this type of thing, I'm not going to
tell you what HP's rules are, but this patch really looks wrong from
what I understand about what the rules are...

thanks,

greg k-h
