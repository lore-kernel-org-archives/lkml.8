Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FB2C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27E72072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 06:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgAXGCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 01:02:13 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32949 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725817AbgAXGCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 01:02:13 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00O621rd025738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 01:02:03 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3F24A42014A; Fri, 24 Jan 2020 01:02:00 -0500 (EST)
Date:   Fri, 24 Jan 2020 01:02:00 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200124060200.GG147870@mit.edu>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <20200123155340.GD147870@mit.edu>
 <20200123175536.GA1796501@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123175536.GA1796501@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 06:55:36PM +0100, Greg Kroah-Hartman wrote:
> > Instead of moving the control file IFF debugfs is enabled, what about
> > always making it available in /proc, and marking the control file for
> > dynamic_debug in debugfs as deprecated?  It would seem to me that this
> > would cause less confusion in the future....
> 
> Why deprecate it?  It's fine where it is, and most developer's have
> debugfs enabled so all is good.  I'd rather only use /proc as a
> last-resort.

This makes life difficult for scripts that manipulate the control
file, since they now need to check two different locations -- either
/sys/kernel/debug or /proc.  It's likely that people who normally use
distribution kernels where debugfs is disabled will have scripts which
are hard-coded to look in /proc, and then when they build a kernel
with debugfs enabled, the /proc entry will go **poof**, and their
script will break.

So regardless of what we do with the control file in debugfs, it might
be nice if moving forward, scripts can count on the /proc file
existing.

Cheers,

					- Ted
