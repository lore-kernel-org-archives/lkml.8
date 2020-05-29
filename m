Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874CDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2BE20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="Z73hgJKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2Kly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:41:54 -0400
Received: from smtp82.ord1c.emailsrvr.com ([108.166.43.82]:49986 "EHLO
        smtp82.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgE2Klw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590748558;
        bh=YGuib9TBEBFi1mHhCr6OOb6fLjhorSl+44mcRrtKVb4=;
        h=Subject:To:From:Date:From;
        b=Z73hgJKbmjFu3rYkZDn6zxezqoOLYPg9EpIBMmRFmSRGuEXWcwAxPihkUWliHQp03
         ORphwvimlUBQgxegYewLt4X9KQ5yyB2VMeJHyp8cj19xvGv/jG0TP0NjenPQJm/wbP
         3VM1uqJr7/hRzoRl4zUAFz/j1Oj4EzL27h2okuxo=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp27.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id BA3A040122;
        Fri, 29 May 2020 06:35:57 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:35:58 -0400
Subject: Re: [PATCH 04/10] comedi: get rid of compat_alloc_user_space() mess
 in COMEDI_RANGEINFO compat
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
 <20200529003512.4110852-4-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <b99dffc2-4669-daa0-e0dd-9d8668029ca5@mev.co.uk>
Date:   Fri, 29 May 2020 11:35:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-4-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: ee1732f5-8677-4381-bd3e-1e0e66259cf1-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Just take copy_from_user() out of do_rangeing_ioctl() into the caller and
> have compat_rangeinfo() build a native version and pass it to do_rangeinfo_ioctl()
> directly.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/comedi_fops.c     | 43 ++++++++++++++------------------
>   drivers/staging/comedi/comedi_internal.h |  2 +-
>   drivers/staging/comedi/range.c           | 17 ++++++-------
>   3 files changed, 27 insertions(+), 35 deletions(-)

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
