Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D9FC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52AE20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbgC3Wc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:32:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:38388 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgC3Wc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:32:56 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3498D7F9;
        Mon, 30 Mar 2020 22:32:56 +0000 (UTC)
Date:   Mon, 30 Mar 2020 16:32:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Lister <peter@bikeshed.quignogs.org.uk>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/1] Compactly make code examples into literal blocks
Message-ID: <20200330163255.4322e763@lwn.net>
In-Reply-To: <7d7f4cbb-e8e8-411d-62f4-7a32a2ac8d8a@bikeshed.quignogs.org.uk>
References: <20200326192947.GM22483@bombadil.infradead.org>
        <20200326195156.11858-1-peter@bikeshed.quignogs.org.uk>
        <87imiqghop.fsf@intel.com>
        <20200327104126.667b5d5b@lwn.net>
        <7d7f4cbb-e8e8-411d-62f4-7a32a2ac8d8a@bikeshed.quignogs.org.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 23:29:24 +0100
Peter Lister <peter@bikeshed.quignogs.org.uk> wrote:

One quick thing caught my eye...

> One head-on approachis to literalise *all* kerneldoc comments for 
> functions and structures. The kerneldoc keywords then serve only to 
> generate links; the ReST output is minimal but guaranteed validand 
> warning free. Would any readers of API docs be inconvenienced? The 
> target readership are presumably programmers, and the searchability of 
> the sphinx RTD is more useful to me than the formatting.

The ability to put formatting directive into kerneldoc comments was one of
the driving forces that pushed the RST switch in the first place.  There
are subsystems that make use of this capability and would not be pleased
to see it go away.

jon
