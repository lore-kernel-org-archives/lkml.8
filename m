Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C738FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29F420718
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 01:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgAYBmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 20:42:47 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42858 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387601AbgAYBmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 20:42:42 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P1gW7B022073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 20:42:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D91F342014A; Fri, 24 Jan 2020 20:42:31 -0500 (EST)
Date:   Fri, 24 Jan 2020 20:42:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200125014231.GI147870@mit.edu>
References: <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <20200123155340.GD147870@mit.edu>
 <20200123175536.GA1796501@kroah.com>
 <20200124060200.GG147870@mit.edu>
 <20200124072940.GA2909311@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124072940.GA2909311@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 08:29:40AM +0100, Greg Kroah-Hartman wrote:
> > It's likely that people who normally use
> > distribution kernels where debugfs is disabled will have scripts which
> > are hard-coded to look in /proc, and then when they build a kernel
> > with debugfs enabled, the /proc entry will go **poof**, and their
> > script will break.
> 
> **poof** they didn't test it :)
> 
> Seriously, I am doing this change to make it _easier_ for those people
> who want debugfs disabled, yet want this type of debugging.  This is
> much better than having no debugging at all.
> 
> Don't put extra complexity in the kernel for when it can be trivially
> handled in userspace, you know this :)

It's also trivial to handle this in the kernel by potentially having
the control file appear in two places.  Consider what it would be like
to explain this in the Linux documentation --- "the control file could
be here, or it could be there", depending on how the kernel is
configured.  The complexity of documenting this, and the complexity in
userspace; and we have to have the code in the source code for the
file to be in the appear in both places *anyway*.

We've done a lot more to maintain userspace backwards compatibility
that Linus demands; and while I recognize this is not exactly the same
thing, being consistent about where to find the control file would be
even *easier* for userspace programmers.  And is it really that hard
to provide this consistency in the kernel?

Cheers,

					- Ted
