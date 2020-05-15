Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37785C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10807206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589529891;
	bh=RYqKuKGzbUvQmW0XH5Ion4mSR3O73xunIq1eJoxhrrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mj3clS3A0FvBXg95H9iTSDcKEKW/oqDsk0GB0ywnfLmWYnyY41fQWuvgo43iEZzGw
	 A7MP2iMLYna16DMCIjw6hbJ2DbVK9bbgQer4JzAWZwRmRoIsumlGmxW+d4cNZx+P1E
	 XhXcQHQ7G8Oxr8nthPhXYyzTFbznmxJJoZz/B354=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEOIEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726694AbgEOIEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:04:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F4C20643;
        Fri, 15 May 2020 08:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589529889;
        bh=RYqKuKGzbUvQmW0XH5Ion4mSR3O73xunIq1eJoxhrrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IsDpecLwPNDImk6t9lquyyDcIzhZCt8az8Ttb9L9iF+PQCNBqzqtM3jqdSDKbcUN
         f8vr87KAlJE7SnbyRzPueswRLMm4Cy1671Fuq1ZoPR7qZmcz7zmn93D/IE7d/FQAxE
         YyjPezQwCZzWnfOMpfMbz08FfLSqWrOVs18S0o9s=
Date:   Fri, 15 May 2020 10:04:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anmol karn <anmol.karan123@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ashmem: Fixed a issue related to
 file_operations
Message-ID: <20200515080446.GA1398375@kroah.com>
References: <20200513114116.26410-1-user@debian>
 <20200513120218.GA982037@kroah.com>
 <CAC+yH-boJnUbnhkLdkZ3Vj8_1D0OMBLKsBYbrcJ2sr29_ekeJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC+yH-boJnUbnhkLdkZ3Vj8_1D0OMBLKsBYbrcJ2sr29_ekeJQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?


http://daringfireball.net/2007/07/on_top

On Fri, May 15, 2020 at 01:16:12PM +0530, Anmol karn wrote:
> Hello sir,
> Thank you for your response,
> 
> Did you properly build this change?
> 
> 
> I have build the *linux_stable* according to the LFD103 course (By Linux
> Foundation) and the kernel they used in their tutorial was *5.2.21  *so, my
> question is can I use this kernel for the patch or do I need to switch to
> the recent mainline kernel release. Because in the recent patch I have used
> *5.2.21.*

Working on a 6 month old kernel is not going to help at all, you need to
work on the latest tree at the least.  linux-next is best.  Otherwise
you end up making changes that can not be applied, or have already been
done by others, which is just a waste of time.

But what I asked is if you actually test built the change you made.  As
the kbuild bot showed you, you obviously did not :(

Please always do that, you can not add new warnings to the kernel, nor
break the build with any change.

Also work on your knowledge of C before doing more kernel work, as the
change is not correct for the obvious reasons that it is not allowed by
the language.  checkpatch is just a perl script, sometimes it give
incorrect information, like this time.

> Also, always use your full name for kernel changes, as the Documentation
> > states to.
> 
> 
>  Sir, my legal full name is 'Anmol' only.

That does not match what your email "From:" says :)

greg k-h
