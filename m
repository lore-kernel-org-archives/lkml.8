Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503EFC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B622080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581268944;
	bh=ujcfnHYmz8R2DbxTxTdwyljZisy88cEdqZ0OMHLjams=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xqiRK97aVjUBQF50O1s80R2M7wggvcFNW2z/pzsOnTcUHucAvH7od45EDwalMR2IA
	 vDWt6erR6T2RxcyJyr9M9kGESFMikD59LOEA1SfkYM2BnHBmH93ZH/4A+t6XIbw7pW
	 fOSXxQYHhdh17oz1VBQmZHLQkS3tB7oDeuIXIvgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbgBIRWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 12:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727399AbgBIRWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 12:22:23 -0500
Received: from localhost (unknown [65.119.211.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0659720820;
        Sun,  9 Feb 2020 17:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581268942;
        bh=ujcfnHYmz8R2DbxTxTdwyljZisy88cEdqZ0OMHLjams=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=udkq/bFbTtxy8OEpqC8C/uG4CRo6zwAfi9+CP61nXVTxf+5eOyju9yw5gZQkroOJh
         lCO+7B6a86VN4z2Hc8RM9FFZJ4sNJ9jEm4DZseKm4k7T5yTXol2H7aH6ngPvBl953O
         0bbs7/9GQxql6br2SfAv9iiCLhMO+MlOzWFAhDV0=
Date:   Sun, 9 Feb 2020 18:03:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Saravana Kannan <saravanak@google.com>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v5] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200209170354.GA3171@kroah.com>
References: <20200209110549.GA1621867@kroah.com>
 <c6db92330696e0e1145103b4e59bf30a982f5e4b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6db92330696e0e1145103b4e59bf30a982f5e4b.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 07:53:38AM -0800, Joe Perches wrote:
> On Sun, 2020-02-09 at 12:05 +0100, Greg Kroah-Hartman wrote:
> > With the realization that having debugfs enabled on "production" systems
> > is generally not a good idea, debugfs is being disabled from more and
> > more platforms over time.  However, the functionality of dynamic
> > debugging still is needed at times, and since it relies on debugfs for
> > its user api, having debugfs disabled also forces dynamic debug to be
> > disabled.
> > 
> > To get around this, also create the "control" file for dynamic_debug in
> > procfs.  This allows people turn on debugging as needed at runtime for
> > individual driverfs and subsystems.
> > 
> > Reported-by: many different companies
> > Cc: Jason Baron <jbaron@akamai.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > v5: as many people asked for it, now enable the control file in both
> >     debugfs and procfs at the same time.
> 
> So now there can be differences in the two control files
> and these are readable files are sometimes parsed by
> scripts.

What difference will there be?  They should both be the same, as they
point to the identical fops behind the virtual file.

> It'd be better to figure out how to soft link the files.

A symlink is not going to work, but this should be fine from what I can
tell.  I'll do some more debugging tonight, but all was fine last I
tried this last week.

thanks,

greg k-h
