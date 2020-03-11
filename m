Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2476C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B1AF20691
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583949609;
	bh=PZDhj53Y8qr4V59zJFKGu37T5OHixdPy366QQ0o6zoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ATEExSz3NUCkOXNZMc/h/rwG/UIisq9ohoDrjJI3BAwpDxpn78O+5e/MB/KKkuQjU
	 tOQlN9MjQjIwMtckTlvggi56KZmxNfit9XyX2MpW7GNAPTFdjfs5eDLOzDMQSD9uxX
	 ny7UWhYIi30d9txHvUmMxpO6LR/rBjyi0JZuFMV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgCKSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:00:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42252 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730628AbgCKSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:00:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id t3so1440204plz.9;
        Wed, 11 Mar 2020 11:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wwhX25/MET8QrcbasZhYLKMqqolygHI/eQ5a9pFMQLM=;
        b=heAdWIvlhSww5E4qd14FqNHaDeo3dff3WP/swgXv0emHeU63Glftb9GJLUlJWbjyrj
         GO1j9bI58Hdty5eMm7DNIXpEL1I6qxFdrcJEe4TCg01QP4rN3aNQIegdB+YMcwyF8MNn
         pF91aKepqzBDRLkObAIeYcYXnvpo1oVgeuBCix1xHiE9uVHievwO9zkAKRJsYdwjQTv9
         3uLKFP8rshEju1sb3ZlyOrtIMZ7TeZpQcNZFKmnj1457zWSmUbiWPHnlqIItbQuiRP2Q
         0UjpY27f+rEniK3GH3pcdysEy4kW1bf1cDPAijwSUQ5Wpr+0MHkMXHmBbumCk5dOeezK
         5N6g==
X-Gm-Message-State: ANhLgQ0exLRtfBMHUygXqxKh4nNVcfeLMkhCfuUcNrKjwqPBFHDR+/jg
        JOr+nO5+DClR+Y/Ko14cDNKObev34Ow=
X-Google-Smtp-Source: ADFU+vsZd2BOR037GX5lKsWCv+MzF0JAEkRbjb+gfTOrY4TuDmVf2XF5QMKJEke+N2/u5EtLwWVXsA==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2mr4232933plx.34.1583949603971;
        Wed, 11 Mar 2020 11:00:03 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id o126sm4906100pfb.140.2020.03.11.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:00:02 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 297A64028E; Wed, 11 Mar 2020 18:00:02 +0000 (UTC)
Date:   Wed, 11 Mar 2020 18:00:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     NeilBrown <neilb@suse.com>, Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] kmod: make request_module() return an error when
 autoloading is disabled
Message-ID: <20200311180002.GN11244@42.do-not-panic.com>
References: <20200310223731.126894-1-ebiggers@kernel.org>
 <20200311043221.GK11244@42.do-not-panic.com>
 <20200311052620.GD46757@gmail.com>
 <20200311063130.GL11244@42.do-not-panic.com>
 <20200311173545.GA20006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311173545.GA20006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:35:45AM -0700, Eric Biggers wrote:
> On Wed, Mar 11, 2020 at 06:31:30AM +0000, Luis Chamberlain wrote:
> > On Tue, Mar 10, 2020 at 10:26:20PM -0700, Eric Biggers wrote:
> > > On Wed, Mar 11, 2020 at 04:32:21AM +0000, Luis Chamberlain wrote:
> > > > On Tue, Mar 10, 2020 at 03:37:31PM -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > It's long been possible to disable kernel module autoloading completely
> > > > > by setting /proc/sys/kernel/modprobe to the empty string.  This can be
> > > > > preferable
> > > > 
> > > > preferable but ... not documented. Or was this documented or recommended
> > > > somewhere?
> > > > 
> > > > > to setting it to a nonexistent file since it avoids the
> > > > > overhead of an attempted execve(), avoids potential deadlocks, and
> > > > > avoids the call to security_kernel_module_request() and thus on
> > > > > SELinux-based systems eliminates the need to write SELinux rules to
> > > > > dontaudit module_request.
> > > 
> > > Not that I know of, though I didn't look too hard.  proc(5) mentions
> > > /proc/sys/kernel/modprobe but doesn't mention the empty string case.
> > > 
> > > In any case, it's been supported for a long time, and it's useful for the
> > > reasons I mentioned.
> > 
> > Sure. I think then its important to document it as such then, or perhaps
> > make a kconfig option which sets this to empty and document it on the
> > kconfig entry.
> 
> I'll send a man-pages patch to document it in proc(5).
> 
> Most users, including the one I have in mind, should just be able to run
> 'echo > /proc/sys/kernel/modprobe' early in the boot process.  So I don't think
> the need for a kconfig option to control the default value has been clearly
> demonstrated yet.  You're certainly welcome to send a patch for it if you
> believe it would be useful, though.

When doing a rewrite of some of this code I did wonder who would use
this and clear it out. A kconfig entry would remove any doubt over its
use and would allow one to skip the userspace / early init requirement
to empty it out, therefore actually being safer because you are not
racing against modules being loaded.

Is avoiding the race more suitable for your needs than echo'ing early on boot?

  Luis
