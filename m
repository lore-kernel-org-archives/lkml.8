Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE009C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31D4207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="FTDW2P8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgE2Klt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:41:49 -0400
Received: from smtp68.ord1c.emailsrvr.com ([108.166.43.68]:55336 "EHLO
        smtp68.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgE2Klr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590748489;
        bh=tZ37TYCg+AHlbtdGPYkEUTa6JxWrTCxFrppFEuJaYxc=;
        h=Subject:To:From:Date:From;
        b=FTDW2P8vKQbfH4nGpiC6/EHPbg4Ug21vqqNhDqreRifC/f+mSmY4hlWmn+wZZniza
         nWT2Pug9MuRDoCeKKCTXX6yxNq8GQCnJDscDXKVWyRRB7n60BdJgZso/66m4MSBFja
         w5HNwHcLPGIzjxKpx9qxTMzfoHyG/MgItRcWkJ+M=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp17.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E9CD2600BE;
        Fri, 29 May 2020 06:34:48 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:34:49 -0400
Subject: Re: [PATCH 02/10] comedi: get rid of indirection via
 translated_ioctl()
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
 <20200529003512.4110852-2-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <acff53af-a75b-6af6-0092-bdf492585a58@mev.co.uk>
Date:   Fri, 29 May 2020 11:34:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-2-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 41543ff4-19d4-465c-8c5d-fe78962b022e-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/comedi_fops.c | 26 ++++++++------------------
>   1 file changed, 8 insertions(+), 18 deletions(-)

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
