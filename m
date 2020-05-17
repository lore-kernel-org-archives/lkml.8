Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4FD620657
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 19:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgEQTpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 15:45:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:60166 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEQTpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 15:45:46 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DE701728;
        Sun, 17 May 2020 19:45:45 +0000 (UTC)
Date:   Sun, 17 May 2020 13:45:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
Message-ID: <20200517134544.7d649bbb@lwn.net>
In-Reply-To: <20200516122740.30665-1-grandmaster@al2klimov.de>
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 May 2020 14:27:40 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> ... for security reasons.
> 
> No breaking changes as either the HTTP vhost redirects to HTTPS
> or both vhosts redirect to the same location
> or both serve the same content.

We're getting closer, but...

 - There is still too much stuff here.  Remember that somebody has to look
   at and review this stuff.

 - A quick check shows that a fair number of these links are broken or
   redirect to somewhere else.  What is the value of adding "https" to a
   broken link?

 - Various documents have maintainers who are likely to be interested in
   changes and should be copied; that is what the get_maintainer.pl script
   is for.  If that generates a massive list of recipients, that's a cue
   that your patch is too large.

If you really want to push this forward, please:

 - narrow down further.  Start with, say, Documentation/maintainer and
   just do that.

 - Make sure every link you touch actually works.  If they don't, don't
   just add "https", figure out what the link should be or, if no
   applicable link exists, delete them.

 - Justify the changes in the changelog; "for security reasons" is not, by
   itself, particularly convincing.  What security threat are you
   addressing here?

Then, maybe, we'll have patches that can be reviewed and applied.

Thanks,

jon
