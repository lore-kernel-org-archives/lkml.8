Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D8CC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E65E20716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585290757;
	bh=ZRrCX6Kb/mbwp2oOlBAUbxjPIj5ASBM+09HqLycX7h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c0TbbcL14gmzcubmRAAXfdIlmdHGLy4qIfpX46FznYiZ3m/uWx6AK9Juh8RBukAdA
	 C6VojJSK+JXX7qI9ZDZRUS8p6QRH6ul3uDhxwnsLPXRW1sXdZ9pXpbrQnOehmBcykk
	 O8uWkLB6imfpmdtlFiufXYiPrZi0YCb9pNpzPViE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgC0Gcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:32:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgC0Gcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:32:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CFA20663;
        Fri, 27 Mar 2020 06:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585290755;
        bh=ZRrCX6Kb/mbwp2oOlBAUbxjPIj5ASBM+09HqLycX7h0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vndsNj2aNpMgJeMQrfekwmAcagH6Rw1vkxM72gTToe9qTz5/xdFchzyh58pwc6/lP
         fvn10/C5aDbTKUejU8mzFzPX8JUa0qOkMlQbb68AdEVKhT6h+dXJK4u3I8LuEVijhl
         VbKRMQpM43X854FooyTJ/SrzWjUbpqPeF3baIEFo=
Date:   Fri, 27 Mar 2020 07:32:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     peter@bikeshed.quignogs.org.uk
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v3 1/1] A compact idiom to add code examples in kerneldoc
 comments.
Message-ID: <20200327063232.GF1601217@kroah.com>
References: <20200326192947.GM22483@bombadil.infradead.org>
 <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
 <20200326195156.11858-2-peter@bikeshed.quignogs.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326195156.11858-2-peter@bikeshed.quignogs.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:51:56PM +0000, peter@bikeshed.quignogs.org.uk wrote:
> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
> 
> scripts/kernel-doc - When a double colon follows a section heading
> (e.g. Example::), write a double colon line to the ReST output to make
> the following text (e.g. a code snippet) into a literal block.
> 
> drivers/base/platform.c - Changed Example: headings to Example:: to
> literalise code snippets as above.
> 
> This patch also removes two kerneldoc build warnings:
> ./drivers/base/platform.c:134: WARNING: Unexpected indentation.
> ./drivers/base/platform.c:213: WARNING: Unexpected indentation.
> 
> Signed-off-by: Peter Lister <peter@bikeshed.quignogs.org.uk>
> ---
>  drivers/base/platform.c |  4 ++--
>  scripts/kernel-doc      | 19 +++++++++++++++----
>  2 files changed, 17 insertions(+), 6 deletions(-)

For the driver/base/platform.c change:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
