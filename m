Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19397CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2917206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="YsA9fgHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgEMLSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732494AbgEMLSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:18:30 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E8BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:18:28 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id r66so21080085oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BrYzLniezoDD4jCcvGE9yS2QzVsTTMBnOOwvkU8zNzA=;
        b=YsA9fgHHa2e5ncH25Q88XbMFzpKGXlpGE3QR/2LaNziM/owblmqmFkQB/x4emIWvbj
         1Brwjz/mJUDeFzqFPpqG5VvWRW9uAzeieKEfSxXQyrrTp3NCxfN9s+ZlHxHiUeObisgx
         UVMbHGSyyoJXb17zhfVHTD1AjcxSJLYV46fV9fNKjBDABuaJu79wuUHsx1FT59O6ncb9
         r/L0ALdZMYv/ugvzo902/viYrPobOlW9gMNZuPFbBN7HlPswY/JO8zU24u3+sD3vgn+7
         AyejM9N5+E5dJud5xcC4jVcdazBm2RXtAW3ilJ6nS+SuGZKxV6R148L3yA8G2vdGl0jJ
         m+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BrYzLniezoDD4jCcvGE9yS2QzVsTTMBnOOwvkU8zNzA=;
        b=JyfZhCejCxceqE/XbqlKZ/dQ0aP+AEs61qlGTYxBi7jLSBc7QePzy7k9Kt+CLLqvcO
         Znxg7mnua8DNgm47D6ieQdCXtYnLfae6zkuIRnmprs8KeaBogI8qahTnuvkpfxkMD8lv
         V2kbf24OFF2iFTwgICvRKA8sV49N4L3jWzMN9Q2NBHzgWdfgnQt/AAR90XzoA3UZ+ymr
         k8DWxEA1O9PLzVyBU67+md2mWm9807RBJ5mJIL3OAe94E1LkkrFjBcxaXNiXUBzbBdam
         K5qyI5Fp3mL/BZDPekbUVS/LvtYfyYpAqboMwgshsAS0U6sNbfkwUU+gJ79VLuOnyhzI
         2pvQ==
X-Gm-Message-State: AGi0PuZsX1ah6IqV6CfGGZVaWUELRBRijuVFr7cHWgSggpBod2IcCR+b
        tRw7asQJId677pSQ/6XRHCqvVGlCFbg=
X-Google-Smtp-Source: APiQypLuNe12ugFwb8BiDgFQhZs6T49t8p9NJ0NCnmSifXnS4d7Rz9x8ZD84j5T6gRTZK6XeTAMC9A==
X-Received: by 2002:aca:ed4d:: with SMTP id l74mr25612399oih.104.1589368707413;
        Wed, 13 May 2020 04:18:27 -0700 (PDT)
Received: from minyard.net ([2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by smtp.gmail.com with ESMTPSA id n11sm5941751oij.21.2020.05.13.04.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 04:18:26 -0700 (PDT)
Date:   Wed, 13 May 2020 06:18:25 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     minyard@acm.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ipmi: convert to use i2c_new_client_device()
Message-ID: <20200513111825.GB9928@minyard.net>
Reply-To: cminyard@mvista.com
References: <20200326210958.13051-2-wsa+renesas@sang-engineering.com>
 <20200512214532.14117-1-minyard@acm.org>
 <20200513083745.GC1043@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513083745.GC1043@ninjato>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:37:46AM +0200, Wolfram Sang wrote:
> On Tue, May 12, 2020 at 04:45:32PM -0500, minyard@acm.org wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > Move away from the deprecated API.
> > 
> > Based on a patch by Wolfram Sang <wsa+renesas@sang-engineering.com>.
> > 
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > ---
> > I think this works.
> 
> Yes, we can do it like this (despite the question from earlier if it is
> really needed). I fixed other drivers using this pattern, too.

I was wondering whether this is really needed, too, but I'm not 100%
sure it can be removed in all cases.  This is the safer route.

> 
> As Stephen Rothwell pointed out, you either need to remove my "From:" or
> add my SoB. I am fine with both.

It was enough of a rewrite that you as the author didn't seem right.
I've fixed the From line, sorry about that.

-corey

> 
> Thanks,
> 
>    Wolfram
> 


