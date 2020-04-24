Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C2DC55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9D3D20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgDXRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgDXRai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:30:38 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Apr 2020 10:30:38 PDT
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4227C09B047;
        Fri, 24 Apr 2020 10:30:38 -0700 (PDT)
Received: from [87.115.41.34] (port=58102 helo=slartibartfast.quignogs.org.uk)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <peter@bikeshed.quignogs.org.uk>)
        id 1jS29p-00071N-EH; Fri, 24 Apr 2020 18:30:37 +0100
From:   Peter Lister <peter@bikeshed.quignogs.org.uk>
Subject: Re: [PATCH v2 33/33] lib: bitmap.c: get rid of some doc warnings
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
 <1e2568fdfa838c1a0d8cc2a1d70dd4b6de99bfb1.1586881715.git.mchehab+huawei@kernel.org>
Message-ID: <634b1157-a78a-806f-2872-0a9a8efa3730@bikeshed.quignogs.org.uk>
Date:   Fri, 24 Apr 2020 18:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1e2568fdfa838c1a0d8cc2a1d70dd4b6de99bfb1.1586881715.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2020 17:48, Mauro Carvalho Chehab wrote:
> There are two ascii art drawings there. Use a block markup tag there
> in order to get rid of those warnings:
> 
> 	./lib/bitmap.c:189: WARNING: Unexpected indentation.
> 	./lib/bitmap.c:190: WARNING: Block quote ends without a blank line; unexpected unindent.
> 	./lib/bitmap.c:190: WARNING: Unexpected indentation.
> 	./lib/bitmap.c:191: WARNING: Line block ends without a blank line.

A few weeks ago, I asked if anyone had a better suggestion about how to 
cope with this comment for bitmap_cut(). As far as I can see, this is 
the first response.

> It should be noticed that there's actually a syntax violation
> right now, as something like:
> 
> 	/**
> 	 ...
> 	 @src:

I don't see this as a syntax violation. I see it as the failure of 
kernel-doc to cope with a perfectly reasonable construction. I suggest 
that kernel-doc should recognise that the first use of @src: is as a 
param definition, and that the second use isn't.

Actually the *main* bug here is that the second use messes up the sphinx 
link/search info for this function by overwriting the correct first use.

> will be handled as a definition for @src parameter, and not as
> part of a diagram. So, we need to add something before it, in
> order for this to be processed the way it should.
.
> + * The @src bitmap is::

Making editorial changes to the text seems to me a bad way to get rid of 
warnings. If we are saying that the original developer "got it wrong" 
then we need to say how. I assert that this idiom is not wrong, and we 
should not need to add even minor verbosity to the wording.

Developers like compact idioms: someone will use this again before long. 
Are you going to keep telling developers that they are wrong? This is 
not a good way to encourage developers to compose annotation.

It's a similar problem to REST's love of multiple line breaks. Maybe one 
or two are not a big problem, but many little infelicities added 
together make the C comments less useful as annotation for developers.
