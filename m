Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29186C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD2C5207D0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594387383;
	bh=bhlHLCb1ySZyILLIEsxxf9GTIzuQnttE8Q6Ag4vALUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VGS/3I9nhupELB75c6dbaY3ifmt4flw+HBWMsGPEMYfjFXItGAjnK6Dd7rNeWx4/O
	 e3KAzUZxro7EfDzejv4ggfKexxP2q9xHiVYp3AY6c/LfDsbM+def8wAaSN3ljertVI
	 81SnhuTHVTSPeKslsKsyAKjo3ME+bcGygBxDPzfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgGJNXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgGJNXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:23:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833DD207BB;
        Fri, 10 Jul 2020 13:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594387381;
        bh=bhlHLCb1ySZyILLIEsxxf9GTIzuQnttE8Q6Ag4vALUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHgLdpX4u5DuI8bCQ6snOUUnot74rgglQtIuJ90uAHzttg57o9FVJH/682aUhutAI
         VgKW4FVIqQCrvco9XlYPCr64VY/Jj+HChSlMAc7rAFjvCEKMcTk04B8+kJHLYQCV3A
         MZCP3faIijjFjHyufOZwGCChT8HATeoOlv41sz7E=
Date:   Fri, 10 Jul 2020 15:23:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 0/3] driver core: Add device link related sysfs files
Message-ID: <20200710132305.GA1920995@kroah.com>
References: <20200521191800.136035-1-saravanak@google.com>
 <CAGETcx8UGps6bz1YhYcbjCAAXenBuR6XDT0qv5WED5zbyfzNFw@mail.gmail.com>
 <20200529123025.GA1710508@kroah.com>
 <CAGETcx-QiAysfd7AVV2Y7_GWRd2sj4N=8KwQ_T4fUZ5gVaV8Jw@mail.gmail.com>
 <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx94Os7o+xZPSs3vVOQAzGtESAGFXtUNdrEAK9iya05s1w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 03:45:02PM -0700, Saravana Kannan wrote:
> On Tue, Jun 16, 2020 at 8:45 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Fri, May 29, 2020 at 5:30 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > Looks semi-sane, but it's too close to the merge window at the moment
> > > for me to take this.  If there's no objections by the time 5.8-rc1 is
> > > out, I'll queue it up in my tree for 5.9-rc1.
> >
> > Another friendly reminder :)
> 
> *nudge* *nudge*

Looks sane, given no objections, let's see what linux-next thinks about
it...
