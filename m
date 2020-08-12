Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BAEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8460A2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597244328;
	bh=JqAUYwpaFXZ7lw31VpotR+A8UotV44AnPQeBpgFr3v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rn8Cgz0AfLaBzF+QZYrLxeXpUVeBJRvjshZSL3JytikUNSsc9YyXoqgfc4yC3xVNc
	 ArJSIJYp3w7zeYDIbh5cKs879bfyL/2dUKPJm5bKdax+WFcCoHz7dB8CKQPHI/tTCe
	 TE395Z7MsUEOQUWRTHMw4QCVK18e52PjxIthcshk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHLO6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbgHLO6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:58:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 833212078B;
        Wed, 12 Aug 2020 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597244325;
        bh=JqAUYwpaFXZ7lw31VpotR+A8UotV44AnPQeBpgFr3v0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nc+YF+lyzrNFnvJOoUCy0KwEKF/WV0YmDqVqkV9JmGzpdEdfcfrzWMnxAVtVNas79
         eP/DY+JfCBYRZSXzxe8Nx1isaRVBQ9gUCxaE6jc3BS99PEDksX6Zb1jEV/F+29HLln
         o2k71z0NpL0DF8p7eczahWAV/PehAsi8kq3+tnpA=
Date:   Wed, 12 Aug 2020 16:58:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        h.peter.anvin@intel.com, tglx@linutronix.de, corbet@lwn.net,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: clarify driver licensing rules
Message-ID: <20200812145854.GA2616348@kroah.com>
References: <20200811171748.F22CD85A@viggo.jf.intel.com>
 <20200812082350.GB851575@kroah.com>
 <dd23860c-7e45-2d43-0405-c8037f4a7d8f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd23860c-7e45-2d43-0405-c8037f4a7d8f@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 07:45:00AM -0700, Dave Hansen wrote:
> On 8/12/20 1:23 AM, Greg KH wrote:
> > On Tue, Aug 11, 2020 at 10:17:48AM -0700, Dave Hansen wrote:
> >> But, this left submitters (and the folks who help them pick licenses)
> >> a bit confused. They have read things like
> >> Documentation/process/license-rules.rst which says:
> >>
> >> 	individual source files can have a different license
> >> 	which is required to be compatible with the GPL-2.0
> >>
> >> and Documentation/process/submitting-drivers.rst:
> >>
> >> 	We don't insist on any kind of exclusive GPL licensing,
> >> 	and if you wish ... you may well wish to release under
> >> 	multiple licenses.
> > 
> > Both of these are fine, but maybe you need to put:
> > 	"don't try to do stupid things just because you can!"
> > somewhere in here instead?
> 
> Folks never think what _they_ are doing is stupid, so I fear that would
> fall on deaf ears.

True, but one can dream...

> ...
> >>  Licensing:
> >> -		The code must be released to us under the
> >> -		GNU General Public License. We don't insist on any kind
> >> -		of exclusive GPL licensing, and if you wish the driver
> >> -		to be useful to other communities such as BSD you may well
> >> -		wish to release under multiple licenses.
> >> +		The code must be released to us under the GNU General Public
> >> +		License. While there are no kernel-wide rules, some maintainers
> >> +		may insist on exclusive GPL licensing by default.
> > 
> > Maintainers should not do that, it is not their place to do so.  They
> > _can_ push back on, again, stupid things, but in the end, they should
> > accept anything that is a compatible license with the kernel as it is
> > really up to the copyright owner as to what license they wish to use.
> 
> I wonder if we're not quite on the same page.  I thought the pitfall
> recently was from overly-aggressive dual-licensing on code that wasn't
> likely to be able to be used in another project.  Was that the misstep?
>  Or was it that the code shouldn't have been dual-licensed in the first
> place because it was too intertwined with GPLv2 code to be anything but
> purely GPLv2?

Both of those have been the cases recently, it's not just one recent
submission that has had this problem :(

> > So while I like the intent here, I don't think this wording change is
> > good as-is.
> > 
> > As it stands, the text makes sense, but as always, if you have legal
> > questions, you should be talking to a lawyer, not a kernel developer :)
> 
> I'd like to do two things with this Documentation/.  First, to _get_
> folks to go talk to their lawyers.  Second, the lawyers and the
> non-lawyers who do licensing _will_ read this documentation.  If they
> understand what the kernel expects, they are in the best position to
> pass that understanding on to developers since they're the gatekeepers.
>   That will hopefully make your job easier because it will filter out
> some of the stupid things before you see them.

I agree with your goal here, I just don't agree that we should be saying
"some maintainers may insist on exclusive GPL licensing" as no
maintainer should be insisting on this.  They should be pushing back on
the "that is just dumb as it doesn't even do what you think it does!"
patches, like I have been seeing recently.

I do not want to codify the behavior I have seen at times of some
maintainers who refuse to accept anything but GPL-only licensed code.
So try rewording your patch a bit as I think we are in violent agreement
here :)

thanks,

greg k-h
