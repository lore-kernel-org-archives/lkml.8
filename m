Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4DDC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6790E206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 20:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgEQUS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 16:18:27 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:48426 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgEQUS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 16:18:27 -0400
X-Greylist: delayed 114566 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 16:18:26 EDT
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 5AA1C45548;
        Sun, 17 May 2020 20:18:24 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
 <20200517134544.7d649bbb@lwn.net>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <1bc96da4-49d7-1c8e-de15-858641aba59f@al2klimov.de>
Date:   Sun, 17 May 2020 22:18:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200517134544.7d649bbb@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 17.05.20 um 21:45 schrieb Jonathan Corbet:
> On Sat, 16 May 2020 14:27:40 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>> ... for security reasons.
>>
>> No breaking changes as either the HTTP vhost redirects to HTTPS
>> or both vhosts redirect to the same location
>> or both serve the same content.
> 
> We're getting closer, but...
> 
>   - There is still too much stuff here.  Remember that somebody has to look
>     at and review this stuff.
OK.

> 
>   - A quick check shows that a fair number of these links are broken or
>     redirect to somewhere else.  What is the value of adding "https" to a
>     broken link?
Literally none. Either some vhosts broke since I have created the first 
prototype of this or (more likely) I was wrong that checking for no 
breaking changes at vhost level is enough.

> 
>   - Various documents have maintainers who are likely to be interested in
>     changes and should be copied; that is what the get_maintainer.pl script
>     is for.  If that generates a massive list of recipients, that's a cue
>     that your patch is too large.
Huh? I *did* run that script (automated) per file and grouped files per 
identical set of patch recipients. I.e. this patch should contain only 
changes for the recipients I've sent it to.
If your invocation of the script doesn't agree with me, please share the 
output and how to reproduce (as if I had just my own patch eMail, the 
upstream Git repo and all the tools of course).
Note that I'm not arguing with you, nor not believing you, exactly the 
opposite: The more pieces I shall split this stuff into, the less errors 
I want to make (and have to correct for every single piece) in the future.

> 
> If you really want to push this forward, please:
> 
>   - narrow down further.  Start with, say, Documentation/maintainer and
>     just do that.
OK.

> 
>   - Make sure every link you touch actually works.  If they don't, don't
>     just add "https", figure out what the link should be or, if no
>     applicable link exists, delete them.
OK, I'll switch from vhost level to link level (will take some time), 
but I won't touch broken links. IMAO that's a different construction area.

> 
>   - Justify the changes in the changelog; "for security reasons" is not, by
>     itself, particularly convincing.  What security threat are you
>     addressing here?
OK.

> 
> Then, maybe, we'll have patches that can be reviewed and applied.
> 
> Thanks,
> 
> jon
> 
