Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E39C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C169920776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="ZYCwJvci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgE2KiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:38:02 -0400
Received: from smtp73.iad3b.emailsrvr.com ([146.20.161.73]:50060 "EHLO
        smtp73.iad3b.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgE2KiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:38:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1590748680;
        bh=Br7Wzj4ssKS40BrOhHz4bE2clADqiqsF2y2HCht7w0M=;
        h=Subject:To:From:Date:From;
        b=ZYCwJvci+VP/e8C0i8ksovMLQC9Qfx/RgWVPcO9Hv4h/DVCLR6SaML6oVNAL3cI9W
         w6MaszMiajt1zs5scEjxN/FJHcswz+3A2a4lrY4p5g/2n7RIx0j+5efqxmHiHJtmAI
         TCkpFAxWyPPraajjq78rsbIx34YuwcufKYmIra48=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp18.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 259F5E0106;
        Fri, 29 May 2020 06:38:00 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Fri, 29 May 2020 06:38:00 -0400
Subject: Re: [PATCH 08/10] comedi: do_cmdtest_ioctl(): lift copyin/copyout
 into the caller
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
 <20200529003512.4110852-8-viro@ZenIV.linux.org.uk>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <6c2653ba-90a8-2bc0-3465-31d895713934@mev.co.uk>
Date:   Fri, 29 May 2020 11:37:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200529003512.4110852-8-viro@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: ae2498f1-d0e3-410f-b2a4-5d6e29a215b8-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/05/2020 01:35, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>   drivers/staging/comedi/comedi_fops.c | 45 ++++++++++++++++++------------------
>   1 file changed, 22 insertions(+), 23 deletions(-)

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
