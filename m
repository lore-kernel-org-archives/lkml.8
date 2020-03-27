Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4256C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BBB62072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgC0RLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:11:08 -0400
Received: from ms.lwn.net ([45.79.88.28]:47518 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgC0RLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:11:08 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B4E3C384;
        Fri, 27 Mar 2020 17:11:07 +0000 (UTC)
Date:   Fri, 27 Mar 2020 11:11:06 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        peter@bikeshed.quignogs.org.uk, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
Message-ID: <20200327111106.57982763@lwn.net>
In-Reply-To: <20200327165022.GP22483@bombadil.infradead.org>
References: <20200326192947.GM22483@bombadil.infradead.org>
        <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
        <87imiqghop.fsf@intel.com>
        <20200327104126.667b5d5b@lwn.net>
        <20200327165022.GP22483@bombadil.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Mar 2020 09:50:22 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> Let me just check I understand Jani's proposal here.  You want to change
> 
> * Return: Number of pages, or negative errno on failure
> 
> to
> 
> * Return
> * ~~~~~~
> * Number of pages, or negative errno on failure
> 
> If so, I oppose such an increase in verbosity and I think most others
> would too.  If not, please let me know what you're actually proposing ;-)

I told you there would be resistance :)

I think a reasonable case can be made for using the same documentation
format throughout our docs, rather than inventing something special for
kerneldoc comments.  So I personally don't think the above is terrible,
but as I already noted, I anticipate resistance.

An alternative would be to make a little sphinx extension; then it would
read more like:

	.. returns:: Number of pages, except when the moon is full

...which would still probably not be entirely popular.

jon
